#!/usr/bin/env bash
set -euo pipefail

branch="$(git symbolic-ref --quiet --short HEAD)" || {
  echo "Cannot create MR from detached HEAD." >&2
  exit 1
}

last_commit="$(git log -1 --format=%s)"

jira="$(
  grep -oE '[A-Z][A-Z0-9]*-[0-9]+' <<< "$branch" \
    | head -n 1 \
    || true
)"

if [[ -n "$jira" ]]; then
  title="$jira - $last_commit"
else
  title="$last_commit"
fi

git push -u origin "$branch"

glab mr create \
  --source-branch "$branch" \
  --title "$title" \
  --description "$title" \
  --yes
