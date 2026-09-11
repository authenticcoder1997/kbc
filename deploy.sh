#!/bin/sh
# Stamp a fresh build id, verify the result parses, rebuild the offline file,
# commit and push. The stamp lets an already-open page notice a new version.
set -e
cd "$(dirname "$0")"
stamp=$(date -u +%Y%m%d-%H%M)

# Only the line carrying the //#stamp marker is rewritten, so the update
# checker's own regex is never touched.
sed -i '' "s/^const BUILD='[^']*';\/\/#stamp\$/const BUILD='$stamp';\/\/#stamp/" index.html

count=$(grep -c "^const BUILD='$stamp';//#stamp\$" index.html || true)
if [ "$count" != "1" ]; then
  echo "ABORT: expected exactly one stamped line, found $count" >&2; exit 1
fi

# Never ship a file that does not parse.
sed -n '/^<script>/,/^<\/script>/p' index.html | sed '1d;$d' > /tmp/kbc-check.js
if ! node --check /tmp/kbc-check.js; then
  echo "ABORT: index.html does not parse — nothing pushed" >&2; exit 1
fi

python3 build-offline.py >/dev/null
git add -A
git commit -q -m "${1:-Deploy $stamp}"
git push -q origin main
echo "deployed $stamp -> https://authenticcoder1997.github.io/kbc/"
