#!/bin/sh
# Stamp a fresh build id, rebuild the offline file, commit and push.
# The stamp is what lets an already-open page notice a new version and reload itself.
set -e
cd "$(dirname "$0")"
stamp=$(date -u +%Y%m%d-%H%M)
sed -i '' "s/const BUILD='[^']*'/const BUILD='$stamp'/" index.html
python3 build-offline.py >/dev/null
git add -A
git commit -q -m "${1:-Deploy $stamp}"
git push -q origin main
echo "deployed $stamp -> https://authenticcoder1997.github.io/kbc/"
