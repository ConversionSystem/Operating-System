# SEO Optimize — getting the data in

Three ways the Search Console rows can arrive. The default needs no connector at
all; the other two are accelerators, gated behind "if connected". The eight
analyses in `analyses.md` are identical regardless of path — only ingestion
differs. Whatever the path, **write every raw table to the deliverable's `data/`
as it arrives** (persist, don't hold in context) so the run is resumable.

## Default — manual GSC CSV export (zero-API, always works)

This is the full skill with no integrations. Walk the user through it.

**What to export** (Search Console → Performance → Search results):
1. Set the **date range**. Best case: 16 months (the max GSC retains). For decay
   analysis you need TWO windows — either export a long range and split it, or
   export "last 90 days" and "previous 90 days" separately.
2. Enable all four metric columns: **Clicks, Impressions, CTR, Position**.
3. Export each table the analyses need (each tab in the Performance view has its
   own Export → "Download CSV" / Google Sheets):
   - **Queries** — required (analyses 1, 2, 4).
   - **Pages** — required (analyses 2, 3, 7).
   - **Devices** — only if device gaps are in scope (analysis 8).
   - **Countries** — only if geo gaps are in scope (analysis 8).
4. For **cannibalization** (analysis 5) you need query↔page pairing, which the
   plain Queries export lacks. Get it one of three ways: filter the Pages view by
   a suspect query and export; use the Performance "compare/ filter" to pull a
   Query×Page slice; or fall back to the browser/API path for that one analysis.

**Filename convention in `data/`:** `gsc-{table}-{window}.csv`, e.g.
`gsc-queries-90d.csv`, `gsc-pages-prev90d.csv`. Record which file is which window
in `baseline.json` → `window` and in the methodology note.

**Reading the CSV:** columns are usually `Query|Page, Clicks, Impressions, CTR,
Position`. CTR arrives as a percent string ("3.4%") — parse to a float. Position
is a 1-based average. Rows are pre-aggregated for the whole window (not daily),
which is exactly what the analyses want.

**If the user has no GSC access at all:** the skill still runs in a reduced mode
off a third-party rank export or a manual top-pages list, but say plainly that
striking-distance and CTR analyses need real impression/CTR data to be
trustworthy — GSC is strongly preferred. Don't fabricate impressions.

## Accelerator — browser (if a browser connector is connected)

When the user can't export by hand (or wants more slices than they'll click
through), drive Search Console in the browser:
1. Confirm they're signed into the right Google account with access to the
   property; have them name the property URL (matches `profile.md`/`stack.md`).
2. Open the Performance report, set the date range, open each needed tab
   (Queries, Pages, Devices, Countries), and read the tables — or trigger the
   same CSV export and capture it to `data/`.
3. For cannibalization, apply a query filter per suspect term and read the
   page-level split directly — the browser makes this cheap.

Treat the browser purely as a faster way to produce the same CSVs. Never store
credentials in the workspace (`stack.md` rule); the connector holds the session.

## Accelerator — GSC API (if a Search Console API connector is connected)

For scale, freshness, and repeatability (useful once this is a recurring
deliverable):
1. Confirm the connector is authorized for the property in `profile.md`.
2. Query the Search Analytics endpoint per dimension set — `["query"]`,
   `["page"]`, `["query","page"]` (cannibalization in one shot),
   `["device"]`, `["country"]`, and `["page"]` over two date ranges for decay.
3. Pull metrics clicks/impressions/ctr/position; page through the row limit;
   write each result set to `data/` as JSON, then run the analyses identically.

The API is the right path when `/autopilot` schedules SEO as a recurring run, or
the site is large enough that manual export is impractical. It changes nothing
downstream — same analyses, same scoring, same outputs, just more rows and no
human in the export loop.

## Picking the path (decision order)

1. GSC API connected and authorized → use it (best for scale + re-runs).
2. Else browser connector connected → use it (good when export is awkward).
3. Else → manual CSV export (the default, and entirely sufficient).

State which path you used in the methodology note of `roadmap.md`, and record
`curve_source` in `baseline.json` so a later run knows whether the CTR curve was
fitted to this client's data or used the blended default.
