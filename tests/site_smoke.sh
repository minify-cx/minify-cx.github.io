#!/usr/bin/env bash
set -euo pipefail

root=$(cd "$(dirname "$0")/.." && pwd)
cd "$root"

for page in index docs docs/getting-started docs/api docs/architecture docs/formats docs/cli docs/comparisons docs/benchmarks docs/memory-safety docs/performance docs/production-readiness docs/battle-tested docs/ai-development docs/ai-opinion; do
    test -s "public/$page.html"
    grep -F '<meta name="viewport"' "public/$page.html" >/dev/null
    grep -F 'assets/css/style.css' "public/$page.html" >/dev/null
    grep -F 'assets/js/script.js' "public/$page.html" >/dev/null
done

for script in install.sh download.sh update.sh uninstall.sh; do
    test -s "$script"
    test -s "public/$script"
    cmp "$script" "public/$script"
    sh -n "$script"
done

grep -F 'curl -fsSL https://minify.cx/install.sh | sh' public/index.html >/dev/null
grep -F 'curl -fsSL https://minify.cx/install.sh | sh' public/docs/getting-started.html >/dev/null
grep -F 'SHA256SUMS' public/docs/getting-started.html >/dev/null
grep -F 'MINIFY_INSTALL_DIR' public/docs/getting-started.html >/dev/null
grep -F 'MINIFY_VERSION' public/docs/getting-started.html >/dev/null
grep -F 'does not modify shell' public/docs/getting-started.html >/dev/null
grep -F 'Windows x86-64' public/docs/getting-started.html >/dev/null
grep -F "Nift" public/docs/api.html >/dev/null

grep -F 'https://github.com/minify-cx/minify' public/index.html >/dev/null
grep -F 'https://github.com/minify-cx/minify-cx.github.io' public/docs.html >/dev/null
grep -F 'rel="canonical" href="https://minify.cx/' public/index.html >/dev/null
grep -F 'rel="canonical" href="https://minify.cx/docs/getting-started.html"' public/docs/getting-started.html >/dev/null
grep -F 'og:site_name' public/index.html >/dev/null

for script in install.sh download.sh update.sh uninstall.sh; do
    test -s "public/$script"
done

grep -F 'language-bash' public/docs/getting-started.html >/dev/null
grep -F 'language-json' public/docs/getting-started.html >/dev/null
grep -F 'language-cpp' public/docs/api.html >/dev/null
grep -F '.kw{' public/assets/css/style.css >/dev/null
grep -F '.str{' public/assets/css/style.css >/dev/null

if grep -rF --include='*.html' 'nift-dev' public >/dev/null; then
    echo 'obsolete nift-dev operational URL found in generated site' >&2
    exit 1
fi

grep -F '<link rel="sitemap"' public/index.html >/dev/null
test -s public/sitemap.xml

echo 'Minify++ website smoke checks passed'
