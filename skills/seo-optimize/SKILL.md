---
name: seo-optimize
description: Turn a client's Search Console data into a ranked SEO optimization roadmap — striking-distance keywords, low-CTR pages, decay, cannibalization, content gaps, and quick wins — tied to their goals and tracked as a workspace deliverable that re-runs against a baseline. Zero-API by default (GSC CSV export); browser/API are optional accelerators. Triggers: /seo-optimize, "what should I do for SEO", "search console roadmap", "find my SEO quick wins", "striking distance keywords", "why are my rankings dropping", "where am I losing clicks", "GSC analysis".
---

# Conversion OS — SEO Optimize

A keyword-rank tool dumps a CSV and forgets you. This reads the client's actual
Search Console export, finds the eight kinds of money left on the table, ranks
every move by impact × effort × confidence, and writes a tracked roadmap whose
opportunity value lands in `goals.md` — so the next run leads with what moved.
The compounding baseline is the moat; the analysis is table stakes.

Operates inside one client workspace. Resolve the target (explicit arg → current
session's client → ask; "the agency's own" → read `Company/`, write to
`Projects/{slug}/`). Read that client's `CLAUDE.md` and obey the firewall: never
read or quote a sibling client; client-facing voice comes from this client's
`context/brand.md`, never `Company/brand.md`. If no root `CLAUDE.md` exists,
stop: "Run /setup first."

## Phase 0 — Silent context load (no questions yet)

Read and CONFIRM, never re-ask what the workspace holds:
- `profile.md` + `context/stack.md` — the site URL(s), CMS/platform, GSC
  property. (No URL anywhere → this is the one fact to ask for.)
- `goals.md` — definitions + ledger. Traffic/lead/revenue goals are the targets
  every opportunity ties back to (e.g. "this recovers ~X clicks/mo → ~Y leads at
  your logged conversion rate").
- `context/icp.md` — whose searches matter; which queries are on-ICP vs noise.
- `context/offers.md` — which pages are money pages (vs informational), so
  ranking moves get weighted by commercial intent.
- `context/brand.md` — voice for any rewrite/meta-description suggestions.

**Re-run check (first-class):** glob `work/seo-optimize-*/` for a prior run of
this skill for this client. If found, this is a RE-RUN — load its
`data/baseline.json`, and lead the new deliverable with the delta (see
`references/analyses.md` → Re-run deltas). If not, this is the baseline run.

Summarize what you loaded in ≤6 lines and ask only for genuine gaps.

## Phase 1 — Get the data (zero-API is the DEFAULT)

Per `references/data-paths.md`. The full skill works with no connectors:

- **Default — GSC CSV export (manual):** ask the user to export from Search
  Console → Performance: the Queries, Pages, and (if device/geo gaps are in
  scope) Devices and Countries tables, with Clicks + Impressions + CTR +
  Position columns, over a date range. 16-month window if available; compare
  windows for decay (e.g. last 90d vs the prior 90d). Save every raw file to the
  deliverable's `data/` as received — persist, don't hold in context.
- **Accelerator — browser (if connected):** drive Search Console in-browser to
  pull the same tables when the user can't export by hand.
- **Accelerator — GSC API (if connected):** pull programmatically for scale and
  fresher windows. Same analyses, more rows.

Connectors only change *how the rows arrive*. The eight analyses are identical.

## Phase 2 — Run the eight analyses

Per `references/analyses.md` (the recipes, thresholds, and the CTR benchmark
curve). Persist each analysis as a table to the deliverable folder and its
intermediates to `data/`:

1. **Striking distance** — queries at avg position 11–20: model the click gain
   at position 5 using the CTR curve.
2. **Low CTR** — pages/queries whose CTR sits below the position-indexed
   benchmark: title/meta/intent opportunity, no ranking change needed.
3. **Declining pages** — clicks/position down window-over-window: decay to
   refresh before it rots out of the index.
4. **Content gaps** — impressions but ~no clicks, or queries with no dedicated
   page: net-new or expansion targets.
5. **Cannibalization** — one query splitting across multiple URLs: consolidate.
6. **Quick wins** — high-impression, fixable-today items (<15-min edits).
7. **Top pages at risk** — high-traffic pages with early decay or thin
   defensibility: protect the crown jewels.
8. **Device / geo gaps** — desktop vs mobile or country splits where one
   segment badly underperforms (only if those tables were pulled).

For >10 candidate items in any pass, fan out fixed batches in ONE message
(parallel sub-agents), never sequentially; merge their tables back.

## Phase 3 — Prioritize and rank

Score every opportunity on three transparent 1–10 axes — **impact** (modeled
incremental clicks, weighted up for money pages), **effort** (inverse: a meta
tweak scores 9, a new pillar page scores 2), **confidence** (data volume +
how mechanical the fix is) — then bucket: **P0** ≥24 · **P1** 18–23 ·
**P2** 12–17 · **P3** <12. Always show the math; never a black-box number.
Estimate each task's incremental clicks and (if a conversion rate is logged in
`goals.md`) its downstream leads/revenue.

## Phase 4 — Write the deliverable (the differentiator)

To `Clients/{slug}/work/seo-optimize-{date}/` (or `Projects/{slug}/` for
agency-self), per `references/analyses.md` → Outputs:

- `brief.md` — scope, date range analyzed, due, owner, acceptance criteria.
- `roadmap.md` — the ranked P0–P3 task list (each: what, why, the page/query,
  modeled clicks, effort, how-to), led by the re-run delta if this is a re-run.
- `analyses/*.md` — one table per analysis (the eight above).
- `data/` — every raw export + `baseline.json` (totals + per-analysis
  opportunity sizes, so the next run diffs against it).
- **Ledger line(s)** in `goals.md`, EXACT format
  `- YYYY-MM-DD | {goal-id} | {value} | {note}`:
  `- {date} | seo-opportunity | {clicks} | {n} tasks, P0 {p0count}, {window}`.
  If no `seo-opportunity` goal exists, create the definition (per
  goals-ledger.md) and flag it for the user to confirm.
- **Recurring keyword themes / a competitor query insight** → a dated,
  append-only note in `Company/market/` (agency-self) or surface to the user for
  `context/` if it's a durable client truth. Never invent ICP edits silently.
- One-line entry to today's `Daily/` note under `## Activity` (a whitelisted
  cross-workspace write).

Close with the top 3 P0 moves and offer `/seo-audit {slug}` if technical issues
(indexability, CWV) gate the wins this analysis found.

## Acceptance (self-check before you finish)

Read ≥1 `context/` file (didn't re-ask the site/ICP) · wrote a real deliverable
under `work/`/`Projects/` + a `goals.md` ledger line + intermediates in `data/` ·
has the re-run delta path · zero-API default with connectors optional · firewall
obeyed · original expression (no copied checklist text or competitor names).
