# Minify++ website handover

## Repository and source authority

Canonical Nift source lives on `stage` in `content/`, `templates/`, and `.nift/`.
The `main` branch is the built website, with deployable HTML and assets at its
root. On `stage`, `public/` is an embedded checkout of this repository's `main`
branch and is recorded as a Git link, matching the established Nift website
workflow. This handover belongs only on `stage`; do not place it on built `main`.

Edit source, run Nift to regenerate, and inspect the result. Do not hand-edit
generated HTML as the canonical change. The current configuration uses
`public/` output, modified-mode incrementality, and `templates/template.html`.
Commit source/tracking/handover changes on `stage`; commit the regenerated files
inside `public/` on its `main` branch; then commit the updated `public` Git-link
pointer on `stage`. Push both branches only when authorized. Never build while the
outer repository is on `main`, and never treat built HTML as source authority.

CSS and JavaScript are canonical readable sources under `content/assets/`, not
hand-edited files inside the deployment checkout. They are tracked Nift outputs
with per-entry `.css`/`.js` extensions and the content-only
`templates/asset.txt` template. Project-wide `minify-exts` minifies HTML, CSS,
and JavaScript after successful rendering. A normal `build-all` publishes pages
and assets together; if a deployment asset has deliberately been removed during
recovery, build the asset entries first so referring pages never race a missing
path during validation.

## Product responsibility

The site should explain a deliberately focused tool simply and honestly:

> Minify++ is a compact conservative C++ minifier for JavaScript, JSX, HTML, CSS,
> JSON, XML, and SVG.

Use the straightforward `minify` CLI as a strength. Do not invent a platform,
ecosystem, bundler, or compiler story around it.

Current identity is Minify++ 1.1.1; Sift is historical. Audit any old branding.
Minify++ is standalone. Nift consumes its public API for explicitly configured
final-output minification; Minify++ does not depend on Nift.

The 2026-08 content checkpoint now includes a dedicated benchmark reference alongside the existing product and evidence pages. In
addition to getting-started, CLI, formats, architecture, test evidence, and AI
evaluation, it now owns dedicated C++ API, performance, and production-readiness
references. `templates/sidebar.html` is the canonical documentation navigation;
do not reintroduce eleven divergent inline copies.

## Truthfulness and evidence

Correctness is at least as important as speed/output size. Explain conservative
semantic priorities and actual test families. Current homepage counts (15,459 JS
programs, 180 JSX/TSX cases, seven formats, format version 1) are checkpoint facts
and must be updated or replaced when scripts/contracts change.

Benchmark claims must include corpus, machine, build flags, tool versions,
iterations, and output-size/semantic-aggressiveness context. Report competitor
advantages honestly. Never publish a faster/smaller claim from a semantically
broken candidate.

XML/SVG wording must remain conservative: Minify++ is not a complete validating
XML parser. Do not imply universal modern-language support beyond tests and docs.

## Development workflow

When public behavior changes:

1. Reconcile website claims with current Minify++ source/tests/README/notes.
2. Search all content for affected formats, limits, commands, versions, counts,
   old Sift naming, Nift integration, and benchmark claims.
3. Verify important command examples against the candidate `minify` executable.
4. Build the site with the intended Nift binary.
5. Inspect generated diff, links/assets, responsive layout, and relevant themes.
6. Review release/download references and maturity language.
7. Review this handover and the product roadmap.

The extensionless root files `install`, `download`, `update` and `uninstall`
must remain byte-identical to the canonical scripts in the Minify++
repository's `packaging/` directory. Their generated `public/` copies are
committed first. Deploy and byte-verify all four before running the library's
non-publishing release rehearsal.

Internal refactors without public effect normally require only compatibility
validation, not marketing churn.

## Design

Keep the site proportional to the tool: direct, readable, fast, and low in
ceremony. Preserve the current design unless a redesign is requested. Do not copy
Nift's branding merely to manufacture a suite identity.

## Living production-support roadmap

Current priorities: reconcile site against Minify++ 1.1.1, ensure no stale Sift
identity, audit supported-format and malformed-input wording, verify examples and
test counts, contextualize benchmarks, describe standalone/Nift boundaries, and
validate release/download/publication information before production claims.

The 2026-08-16 product assessment is **PASS WITH KNOWN LIMITATIONS; REVALIDATED
AFTER REOPENING**. This website exposed unsafe CSS whitespace removal, causing the
earlier pass to be withdrawn. The label was restored only after repairs, expanded
semantic/fuzz/sanitizer evidence, a clean committed-package distcheck, synchronized
Nift integration and fresh-browser website validation. Limitations around
macOS/Windows, XML/SVG validation, finite corpora and host-specific benchmarks
remain explicit.

The production-readiness page is the canonical public explanation of that
decision. Keep its evidence wall, limitations, downgrade triggers, and assessment
date synchronized with the standalone product's
`docs/handover/PRODUCTION-READINESS.md`. The performance page owns the public
host-specific benchmark table and must be refreshed whenever the retained
benchmark reference changes.

This roadmap and handover are living infrastructure. Review them at every
substantial Minify++ or website checkpoint. Correct/reorganize obsolete guidance,
capture durable lessons, and do not append a diary or let public claims outrun
implementation evidence.

Detailed Minify++ website history lives at
`docs/handover/PROJECT-HISTORY.md`, including naming history,
correctness/benchmark communication, development flow, production-support gates,
and the living roadmap.

## Benchmark documentation checkpoint (2026-08-18)

`content/benchmarks.html` is now the canonical cross-tool benchmark page. Keep it distinct from `content/performance.html`: Performance owns Minify++'s host-specific in-process regression gate; Benchmarks owns competitor context, exact fixture/output comparisons and methodology caveats. The first CSS comparison uses the GoalSmashers Bootstrap 4, Animate.css and Tailwind fixtures and published esbuild/Lightning CSS output sizes from the Lightning CSS project. Do not present their published timings as same-host speed ratios against Minify++.

The JavaScript section records the prepared Nift adapter for `privatenumber/minification-benchmarks` and a local byte-equivalence integration probe, but intentionally does not claim an upstream Nift ranking until the actual upstream suite runs. Preserve that distinction when updating the page.

The definitive 2026-08-18 update replaces that provisional state with measured
same-host evidence. CSS tables/charts use the raw 45-sample Minify++ repository
snapshot. JavaScript tables/charts use the filtered upstream snapshot at commit
`fe89864f…`, label Nift as an integrated CLI boundary, and disclose that Nift
ranked last under the upstream size-heavy score despite passing all integrity
checks. Keep every exact value available without JavaScript.

Chart.js 4.5.1 is pinned under `content/assets/vendor/`; its MIT license is kept
beside the asset. `content/assets/js/benchmarks.js` contains chart data derived
from the retained repository JSON. Charts are progressive enhancement and must
never become the sole evidence. When benchmark JSON changes, reconcile the
script, exact HTML tables and explanatory claims together.

## Documentation URL layout

The homepage remains `/index.html` and the documentation landing page remains
`/docs.html`, matching nift.dev. All secondary documentation/evidence/design pages
live under `/docs/*.html`, even when a page does not use a docs-specific template.
Keep tracked names, `@pathto(...)` references, authored content paths, and generated
output aligned with this rule when adding or renaming pages.

## Comparison guide checkpoint (2026-08-18)

`content/docs/comparisons.html` is the canonical architectural comparison page. It explains Minify++ beside Lightning CSS, esbuild, SWC, Terser and html-minifier-terser. Keep this page distinct from Benchmarks: comparisons own scope/architecture/decision trade-offs; Benchmarks owns measured performance and output-size evidence. Do not turn low AST/semantic-optimization breadth into a feature request by default, and do not hide cases where specialist tools compress more aggressively.

## Desktop table-fit checkpoint (2026-08-18)

- Documentation content width is intentionally large enough for benchmark/comparison tables. On desktop, table cells wrap inside the available column instead of forcing horizontal scrolling; narrow-screen scrolling remains a fallback.
- The site-wide rendered table audit covers all Minify++ generated tables together with the sibling sites at 1024–1920 px desktop widths. Keep this invariant when adding benchmark columns.

## Memory-safety living record checkpoint (2026-08-18)

- `docs/memory-safety` is the dedicated living leak/resource-safety record beside Battle Tested. It currently describes the planned format/API/CLI/embedded soak campaign; do not promote it to a passed verdict until the reproducible campaign is run.
- Keep detailed memory evidence there and only summarize/link it from Battle Tested so old one-off results do not become permanent marketing copy.
## Memory-safety Checkpoint 2A (2026-08-18)

- Added a maintained long-lived multi-format Minify++ corpus covering HTML/CSS/JS/JSX/JSON/XML/SVG success, second-pass/idempotence pressure, malformed/rejected cleanup, and alternating large/tiny buffers in one process.
- At commit `db2a6ff`, 80 ASan/LSan/UBSan iterations completed with zero findings. The separate 300-iteration native soak recorded 7,096 KiB after warm-up, 7,160 KiB at midpoint and 7,160 KiB at completion.
- Added batch CLI memory/resource stress: sanitized 8×42-file rounds and native 30×70-file rounds, including in-place replacement and controlled mixed valid/invalid batch cleanup.
- No production Minify++ source change was required. The maintained Valgrind target is still open because this checkpoint environment does not provide Valgrind. Do not convert sanitizer success into an independent Valgrind claim.
- Keep Nift-owned Minify++ integration stress in the later cross-project checkpoint; this checkpoint owns standalone Minify++ resource behavior plus synchronization of its maintained corpus into Nift.

## Memory-safety Checkpoint 2B complete (2026-08-18)

- `docs/memory-safety` now records the independent Valgrind completion of the standalone Minify++ lifetime gate: Valgrind 3.26.0, Linux x86_64, canonical commit `2a51a38`, 30 maintained lifetime-corpus iterations, 0 errors, 0 bytes in use at exit, all 2,448 allocations freed, and 184,908 KiB peak process RSS.
- Keep detailed memory numbers on the living memory-safety page. Battle Tested should summarize/link the evidence layer rather than duplicate a snapshot.
- No production Minify++ source repair was required by Checkpoint 2. Future changes affecting allocation/lifetime behavior should invalidate or refresh this evidence explicitly.
