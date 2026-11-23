#!/usr/bin/env bash
# Builds two versions from app.html:
#   index.html  – for local use; fonts and solver come from public CDNs
#   website/    – self-contained folder to upload to any web host: fonts and solver are bundled,
#                 the page makes no requests to other servers (privacy-friendly for public sites)
#   wuerfel-scanner.zip – the website/ folder as a zip for uploading
set -euo pipefail
cd "$(dirname "$0")"

wrap() {  # $1 = page content file, writes a full HTML document to stdout
  printf '<!doctype html>\n<html lang="de">\n<head>\n<meta charset="utf-8">\n<meta name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover">\n'
  printf '<style>:root{padding-top:env(safe-area-inset-top,0px);padding-bottom:env(safe-area-inset-bottom,0px)}body{margin:0}img{max-width:100%%}[hidden]{display:none!important}</style>\n</head>\n<body>\n'
  cat "$1"
  printf '\n</body>\n</html>\n'
}

wrap app.html > index.html
echo "index.html erstellt"

rm -rf website && mkdir -p website/js website/fonts
cp vendor/js/cube.js vendor/js/solve.js vendor/js/LICENSE-cubejs.txt website/js/
cp vendor/fonts/* website/fonts/
python3 - <<'PY'
import re
s = open("app.html", encoding="utf-8").read()
s = re.sub(r"<!-- fonts:start -->.*?<!-- fonts:end -->", '<link rel="stylesheet" href="fonts/fonts.css">', s, flags=re.S)
s = s.replace('src="https://cdn.jsdelivr.net/npm/cubejs@1.3.2/lib/cube.js"', 'src="js/cube.js"')
assert "googleapis" not in s and "jsdelivr" not in s, "external reference left"
open("website/.page.html", "w", encoding="utf-8").write(s)
PY
wrap website/.page.html > website/index.html && rm website/.page.html
rm -f wuerfel-scanner.zip
(cd website && zip -qr ../wuerfel-scanner.zip .)
echo "website/ und wuerfel-scanner.zip erstellt"
