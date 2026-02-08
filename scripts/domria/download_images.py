import re
import os
from pathlib import Path
import requests

LISTING_URL = os.environ.get("LISTING_URL")
if not LISTING_URL:
    raise RuntimeError(
        "Environment variable LISTING_URL is not set. Create a .env file or export LISTING_URL."
    )
OUT_DIR = Path("downloads")
OUT_DIR.mkdir(exist_ok=True, parents=True)

html = requests.get(LISTING_URL, timeout=30).text

# Find gallery photo URLs (main photos)
pattern = re.compile(
    r'https?://cdn\.riastatic\.com/photosnew/dom/photo/([^"]+__([0-9]+)([a-z]+)\.jpg)'
)
matches = pattern.findall(html)

# Collect by photo_id -> (slug_prefix, available_sizes)
photos = {}
for full_path, photo_id, size in matches:
    slug_prefix = full_path.split("__")[0] + "__"
    photos.setdefault(photo_id, {"slug_prefix": slug_prefix, "sizes": set()})
    photos[photo_id]["sizes"].add(size)

size_preference = ["xl", "xxl", "l", "b", "m", "s", "xs"]

for photo_id, info in photos.items():
    slug_prefix = info["slug_prefix"]
    sizes_found = info["sizes"]

    # Prefer xl even if it wasn't present in HTML; fall back to sizes we saw.
    candidates = []
    if "xl" not in sizes_found:
        candidates.append("xl")
    candidates += [s for s in size_preference if s in sizes_found]
    # If for some reason none matched, just use any size we saw
    if not candidates and sizes_found:
        candidates.append(next(iter(sizes_found)))

    content = None
    used_url = None
    for size in candidates:
        url = f"https://cdn.riastatic.com/photosnew/dom/photo/{slug_prefix}{photo_id}{size}.jpg"
        resp = requests.get(url, timeout=30)
        if resp.ok:
            content = resp.content
            used_url = url
            break

    if content:
        out_file = OUT_DIR / f"{photo_id}.jpg"
        out_file.write_bytes(content)
        print(f"Saved {out_file} ({used_url})")
    else:
        print(f"Skipped photo_id={photo_id}: no usable size found")
