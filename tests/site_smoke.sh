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

for script in install download update uninstall; do
    test -s "$script"
    cmp "$script" "public/$script"
    sh -n "$script"
done

grep -F 'curl -fsSL https://nift-dev.github.io/minify-website/install | sh' public/docs/getting-started.html >/dev/null
grep -F 'SHA256SUMS' public/docs/getting-started.html >/dev/null
grep -F 'MINIFY_INSTALL_DIR' public/docs/getting-started.html >/dev/null
grep -F 'MINIFY_VERSION' public/docs/getting-started.html >/dev/null
grep -F 'does not modify shell' public/docs/getting-started.html >/dev/null
grep -F 'Windows x86-64' public/docs/getting-started.html >/dev/null
grep -F "Nift" public/docs/api.html >/dev/null

echo 'Minify++ website smoke checks passed'
