#!/usr/bin/env python3
from __future__ import annotations

import argparse
import json
import subprocess
import sys
from collections import Counter, defaultdict
from concurrent.futures import ThreadPoolExecutor, as_completed
from datetime import datetime, timedelta, timezone
from pathlib import PurePosixPath
from typing import Any
from urllib.parse import quote, urlencode


EXTENSION_TYPES = {
    ".java": "Java",
    ".kt": "Kotlin",
    ".kts": "Kotlin",
    ".groovy": "Groovy",
    ".gradle": "Gradle",
    ".md": "Markdown",
    ".markdown": "Markdown",
    ".mdx": "Markdown",
    ".yaml": "YAML",
    ".yml": "YAML",
    ".json": "JSON",
    ".xml": "XML",
    ".sql": "SQL",
    ".py": "Python",
    ".js": "JavaScript",
    ".jsx": "JavaScript",
    ".ts": "TypeScript",
    ".tsx": "TypeScript",
    ".sh": "Shell",
    ".bash": "Shell",
    ".zsh": "Shell",
    ".html": "HTML",
    ".htm": "HTML",
    ".css": "CSS",
    ".scss": "SCSS",
    ".sass": "Sass",
    ".less": "Less",
    ".properties": "Properties",
    ".toml": "TOML",
    ".tf": "Terraform",
    ".proto": "Protocol Buffers",
    ".go": "Go",
    ".rs": "Rust",
    ".rb": "Ruby",
    ".php": "PHP",
    ".cs": "C#",
    ".cpp": "C++",
    ".cc": "C++",
    ".cxx": "C++",
    ".c": "C",
    ".h": "C/C++ Header",
    ".hpp": "C/C++ Header",
}

SPECIAL_FILENAMES = {
    "dockerfile": "Dockerfile",
    "makefile": "Makefile",
    "jenkinsfile": "Jenkinsfile",
}


class GlabError(RuntimeError):
    pass


def run_glab_api(endpoint: str, hostname: str | None = None) -> Any:
    cmd = ["glab", "api", endpoint]
    if hostname:
        cmd += ["--hostname", hostname]

    try:
        result = subprocess.run(
            cmd,
            text=True,
            capture_output=True,
            check=False,
        )
    except FileNotFoundError as exc:
        raise GlabError(
            "glab was not found in PATH. Install it and run `glab auth login` first."
        ) from exc

    if result.returncode != 0:
        message = result.stderr.strip() or result.stdout.strip()
        raise GlabError(f"{' '.join(cmd)} failed: {message}")

    try:
        return json.loads(result.stdout)
    except json.JSONDecodeError as exc:
        raise GlabError(
            f"Expected JSON from `glab api {endpoint}`, got:\n{result.stdout[:1000]}"
        ) from exc


def api_get_json(
    endpoint: str,
    hostname: str | None = None,
    params: dict[str, Any] | None = None,
) -> Any:
    if params:
        separator = "&" if "?" in endpoint else "?"
        endpoint = f"{endpoint}{separator}{urlencode(params, doseq=True)}"
    return run_glab_api(endpoint, hostname)


def api_paginate(
    endpoint: str,
    hostname: str | None = None,
    params: dict[str, Any] | None = None,
    per_page: int = 100,
) -> list[dict[str, Any]]:
    items: list[dict[str, Any]] = []
    page = 1

    while True:
        page_params = dict(params or {})
        page_params["per_page"] = per_page
        page_params["page"] = page

        response = api_get_json(endpoint, hostname, page_params)
        if not isinstance(response, list):
            raise GlabError(
                f"Expected a JSON array from {endpoint}, got {type(response).__name__}"
            )

        items.extend(response)
        if len(response) < per_page:
            break
        page += 1

    return items


def resolve_project(project_ref: str, hostname: str | None) -> dict[str, Any]:
    encoded = quote(project_ref, safe="")
    project = api_get_json(f"projects/{encoded}", hostname)

    if not isinstance(project, dict) or "id" not in project:
        raise GlabError(f"Could not resolve project: {project_ref}")

    return project


def list_merged_mrs(
    project_id: int,
    since: str,
    hostname: str | None,
) -> list[dict[str, Any]]:
    return api_paginate(
        f"projects/{project_id}/merge_requests",
        hostname,
        {
            "state": "merged",
            "scope": "all",
            "merged_after": since,
        },
    )


def fetch_mr_changes(
    project_id: int,
    iid: int,
    hostname: str | None,
) -> tuple[list[dict[str, Any]], bool, str | None]:
    """
    Returns (changes, complete, warning).

    Prefer the current /diffs endpoint. If GitLab tells us a diff is collapsed
    or too large, try the older /changes endpoint with access_raw_diffs=true,
    which asks Gitaly for the diff and can bypass database-backed diff limits.
    """
    changes = api_paginate(
        f"projects/{project_id}/merge_requests/{iid}/diffs",
        hostname,
    )

    limited = any(
        bool(change.get("collapsed")) or bool(change.get("too_large"))
        for change in changes
    )
    if not limited:
        return changes, True, None

    try:
        fallback = api_get_json(
            f"projects/{project_id}/merge_requests/{iid}/changes",
            hostname,
            {
                "access_raw_diffs": "true",
                "unidiff": "true",
            },
        )
        fallback_changes = fallback.get("changes", [])
        overflow = bool(fallback.get("overflow"))

        if isinstance(fallback_changes, list) and not overflow:
            return (
                fallback_changes,
                True,
                "Used raw-diff fallback because the regular diff was limited.",
            )
    except GlabError as exc:
        return (
            changes,
            False,
            f"Diff is limited and raw-diff fallback failed: {exc}",
        )

    return (
        changes,
        False,
        "Diff is limited by GitLab; MR excluded from line-size statistics.",
    )


def file_type(path: str) -> str:
    filename = PurePosixPath(path).name
    special = SPECIAL_FILENAMES.get(filename.lower())
    if special:
        return special

    suffix = PurePosixPath(filename).suffix.lower()
    if not suffix:
        return "Other"

    return EXTENSION_TYPES.get(suffix, suffix.removeprefix(".").upper())


def count_changed_lines(diff: str) -> tuple[int, int]:
    """
    Count additions/deletions only inside unified-diff hunks.

    This avoids treating file headers such as ---/+++ as changed lines.
    """
    additions = 0
    deletions = 0
    in_hunk = False

    for line in diff.splitlines():
        if line.startswith("@@"):
            in_hunk = True
            continue
        if not in_hunk:
            continue

        if line.startswith("+"):
            additions += 1
        elif line.startswith("-"):
            deletions += 1

    return additions, deletions


def analyze_mr(
    project_id: int,
    mr: dict[str, Any],
    hostname: str | None,
) -> dict[str, Any]:
    iid = int(mr["iid"])
    changes, complete, warning = fetch_mr_changes(project_id, iid, hostname)

    additions = 0
    deletions = 0
    type_stats: dict[str, dict[str, int]] = defaultdict(
        lambda: {"additions": 0, "deletions": 0, "lines_changed": 0}
    )

    for change in changes:
        diff = change.get("diff") or ""
        added, deleted = count_changed_lines(diff)

        path = (
            change.get("old_path")
            if change.get("deleted_file")
            else change.get("new_path") or change.get("old_path")
        ) or "<unknown>"

        kind = file_type(path)
        additions += added
        deletions += deleted
        type_stats[kind]["additions"] += added
        type_stats[kind]["deletions"] += deleted
        type_stats[kind]["lines_changed"] += added + deleted

    author = mr.get("author") or {}

    return {
        "iid": iid,
        "title": mr.get("title", ""),
        "web_url": mr.get("web_url", ""),
        "merged_at": mr.get("merged_at"),
        "author": {
            "id": author.get("id"),
            "username": author.get("username"),
            "name": author.get("name"),
        },
        "additions": additions,
        "deletions": deletions,
        "lines_changed": additions + deletions,
        "file_types": dict(
            sorted(
                type_stats.items(),
                key=lambda item: item[1]["lines_changed"],
                reverse=True,
            )
        ),
        "complete": complete,
        "warning": warning,
    }


def author_key(mr: dict[str, Any]) -> tuple[Any, str, str]:
    author = mr.get("author") or {}
    return (
        author.get("id"),
        author.get("username") or "<unknown>",
        author.get("name") or "",
    )


def build_project_report(
    project_ref: str,
    since: str,
    hostname: str | None,
    workers: int,
) -> dict[str, Any]:
    project = resolve_project(project_ref, hostname)
    project_id = int(project["id"])
    path = project.get("path_with_namespace") or project.get("name") or project_ref

    mrs = list_merged_mrs(project_id, since, hostname)
    print(f"[{path}] found {len(mrs)} merged MRs; analyzing diffs...", file=sys.stderr)

    author_counts: Counter[tuple[Any, str, str]] = Counter(author_key(mr) for mr in mrs)

    analyzed: list[dict[str, Any]] = []
    if mrs:
        with ThreadPoolExecutor(max_workers=workers) as executor:
            futures = {
                executor.submit(analyze_mr, project_id, mr, hostname): mr
                for mr in mrs
            }
            for future in as_completed(futures):
                mr = futures[future]
                try:
                    analyzed.append(future.result())
                except Exception as exc:  # keep other MRs usable
                    author = mr.get("author") or {}
                    analyzed.append(
                        {
                            "iid": int(mr["iid"]),
                            "title": mr.get("title", ""),
                            "web_url": mr.get("web_url", ""),
                            "merged_at": mr.get("merged_at"),
                            "author": {
                                "id": author.get("id"),
                                "username": author.get("username"),
                                "name": author.get("name"),
                            },
                            "additions": 0,
                            "deletions": 0,
                            "lines_changed": 0,
                            "file_types": {},
                            "complete": False,
                            "warning": f"Failed to analyze diff: {exc}",
                        }
                    )

    complete_mrs = [mr for mr in analyzed if mr["complete"]]
    incomplete_mrs = [mr for mr in analyzed if not mr["complete"]]

    average = (
        sum(mr["lines_changed"] for mr in complete_mrs) / len(complete_mrs)
        if complete_mrs
        else 0.0
    )

    top_three = sorted(
        complete_mrs,
        key=lambda mr: mr["lines_changed"],
        reverse=True,
    )[:3]

    authors = [
        {
            "id": key[0],
            "username": key[1],
            "name": key[2],
            "merge_requests": count,
        }
        for key, count in sorted(
            author_counts.items(),
            key=lambda item: (-item[1], item[0][1].lower()),
        )
    ]

    return {
        "project": {
            "id": project_id,
            "name": project.get("name"),
            "path_with_namespace": path,
            "web_url": project.get("web_url"),
        },
        "merged_merge_requests": len(mrs),
        "analyzed_for_size": len(complete_mrs),
        "excluded_from_size": len(incomplete_mrs),
        "average_lines_changed_per_mr": round(average, 2),
        "merge_requests_by_author": authors,
        "top_3_merge_requests_by_lines_changed": top_three,
        "excluded_merge_requests": [
            {
                "iid": mr["iid"],
                "title": mr["title"],
                "web_url": mr["web_url"],
                "warning": mr["warning"],
            }
            for mr in incomplete_mrs
        ],
    }


def print_project_report(report: dict[str, Any]) -> None:
    project = report["project"]
    print()
    print("=" * 88)
    print(f"{project['path_with_namespace']}  (project ID: {project['id']})")
    print("=" * 88)
    print(f"Merged MRs:                  {report['merged_merge_requests']}")
    print(f"Analyzed for line metrics:   {report['analyzed_for_size']}")
    print(f"Excluded from line metrics:  {report['excluded_from_size']}")
    print(
        "Average lines changed/MR:   "
        f"{report['average_lines_changed_per_mr']:.2f}"
    )

    print("\nMerge requests by author:")
    authors = report["merge_requests_by_author"]
    if not authors:
        print("  (none)")
    else:
        for author in authors:
            display = author["username"]
            if author["name"]:
                display += f" ({author['name']})"
            print(f"  {display:<45} {author['merge_requests']:>5}")

    print("\nTop 3 MRs by lines changed:")
    top = report["top_3_merge_requests_by_lines_changed"]
    if not top:
        print("  (none)")
    else:
        for index, mr in enumerate(top, start=1):
            author = mr["author"].get("username") or "<unknown>"
            print(
                f"  {index}. !{mr['iid']}  {mr['title']}\n"
                f"     {mr['lines_changed']:,} lines "
                f"(+{mr['additions']:,} / -{mr['deletions']:,}), "
                f"author: {author}"
            )
            if mr["web_url"]:
                print(f"     {mr['web_url']}")

            for kind, stats in mr["file_types"].items():
                print(
                    f"       {kind:<22} "
                    f"{stats['lines_changed']:>8,} "
                    f"(+{stats['additions']:,} / -{stats['deletions']:,})"
                )

    if report["excluded_merge_requests"]:
        print("\nWarnings:")
        for mr in report["excluded_merge_requests"]:
            print(f"  !{mr['iid']}: {mr['warning']}")


def load_projects(args: argparse.Namespace) -> list[str]:
    projects = list(args.projects)

    if args.projects_file:
        with open(args.projects_file, "r", encoding="utf-8") as file:
            for raw_line in file:
                line = raw_line.strip()
                if line and not line.startswith("#"):
                    projects.append(line)

    # Stable de-duplication.
    return list(dict.fromkeys(projects))


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description=(
            "Collect GitLab MR statistics using the authenticated glab CLI."
        )
    )
    parser.add_argument(
        "projects",
        nargs="*",
        help="Project numeric IDs or full paths such as group/subgroup/project.",
    )
    parser.add_argument(
        "-f",
        "--projects-file",
        help="Text file containing one project ID/full path per line.",
    )
    parser.add_argument(
        "--days",
        type=int,
        default=90,
        help="Look back this many days by merged_at (default: 90).",
    )
    parser.add_argument(
        "--hostname",
        help=(
            "GitLab hostname for self-managed GitLab, e.g. gitlab.example.com. "
            "Omit for the host glab normally resolves."
        ),
    )
    parser.add_argument(
        "--workers",
        type=int,
        default=4,
        help="Number of MRs to analyze concurrently (default: 4).",
    )
    parser.add_argument(
        "--json-output",
        help="Also write the complete structured report to this JSON file.",
    )
    return parser.parse_args()


def main() -> int:
    args = parse_args()

    if args.days <= 0:
        print("--days must be greater than 0", file=sys.stderr)
        return 2
    if args.workers <= 0:
        print("--workers must be greater than 0", file=sys.stderr)
        return 2

    projects = load_projects(args)
    if not projects:
        print(
            "No projects supplied. Pass project IDs/full paths or --projects-file.",
            file=sys.stderr,
        )
        return 2

    now = datetime.now(timezone.utc)
    since_dt = now - timedelta(days=args.days)
    since = since_dt.isoformat(timespec="seconds").replace("+00:00", "Z")

    result: dict[str, Any] = {
        "generated_at": now.isoformat(timespec="seconds").replace("+00:00", "Z"),
        "period_days": args.days,
        "merged_after": since,
        "projects": [],
    }

    failures = 0
    for project_ref in projects:
        try:
            project_report = build_project_report(
                project_ref,
                since,
                args.hostname,
                args.workers,
            )
            result["projects"].append(project_report)
            print_project_report(project_report)
        except GlabError as exc:
            failures += 1
            print(f"\nERROR [{project_ref}]: {exc}", file=sys.stderr)

    if args.json_output:
        with open(args.json_output, "w", encoding="utf-8") as file:
            json.dump(result, file, indent=2, ensure_ascii=False)
            file.write("\n")
        print(f"\nJSON report written to {args.json_output}")

    if failures:
        print(
            f"\nCompleted with {failures} project(s) that could not be processed.",
            file=sys.stderr,
        )
        return 1

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
