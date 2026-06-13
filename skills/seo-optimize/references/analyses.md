# SEO Optimize — the eight analyses, the CTR curve, scoring, outputs

Everything here is authored from first principles. Industry SEO concepts
(striking distance, CTR-by-position, content decay) are common professional
knowledge; the recipes, thresholds, and the benchmark numbers below are ours —
derived, transparent, and tunable. Treat every number as a default the user can
override with their own data.

## The CTR-by-position benchmark curve

The whole roadmap leans on one model: *what click-through rate should a result
earn at a given average position?* Below-curve = a CTR problem (title/meta/
intent), independent of rank. Above-curve = the page punches above its weight;
leave it alone. The gap between a query's actual CTR and its benchmark is the
single most useful signal in the file.

Default desktop-blended curve (organic, all-intent average). These are starting
points — if the client's own export has enough volume, **fit the curve to their
data** (median CTR per integer position across all queries) and note that you
did, because branded terms and rich-result SERPs shift it hard.

| Avg position | Benchmark CTR |
|---|---|
| 1 | 28% |
| 2 | 15% |
| 3 | 10% |
| 4 | 7% |
| 5 | 5.5% |
| 6 | 4.2% |
| 7 | 3.2% |
| 8 | 2.6% |
| 9 | 2.1% |
| 10 | 1.8% |
| 11–15 | 1.972% (falls ~1.972→0.5%) |
| 16–20 | 0.972% (falls ~0.972→0.3%) |
| 21+ | <0.3% (treat as non-clicking; an impressions/awareness signal only) |

Adjustments to apply before judging a gap:
- **Branded queries** sit far above curve (often 40%+ at #1) — exclude them from
  low-CTR analysis or they pollute it. Flag a query as branded if it contains
  the client's name/domain tokens from `profile.md`.
- **SERP feature suppression** — if a query is below curve at a strong position,
  the likely cause is a feature stealing the click (featured snippet you don't
  own, People-Also-Ask, shopping/local pack, AI overview). Note it as a probable
  cause; the fix is "win the feature", not "rewrite the title".
- **Position is an average.** A "position 8.0" query may oscillate 3↔15. High
  impressions with a mid average and low CTR often means it's frequently on
  page 2 — read it as striking-distance, not low-CTR.

### Modeling click gain

Estimated clicks at a target position:
`est_clicks = impressions × benchmark_CTR(target_position)`.
Incremental gain from a move:
`gain = impressions × ( benchmark_CTR(target) − current_CTR )`, floored at 0.
Use the **same impression count** (don't assume impressions rise with rank — be
conservative; under-promise). Default targets: striking-distance → model at
position 5; low-CTR → model at the benchmark for the *current* position (pure
CTR recovery, no rank change assumed).

## The eight analyses

For each: the input table, the filter, the output, and the default thresholds.
A finding is only worth listing if its modeled monthly gain clears a floor —
default **≥10 incremental clicks/mo** (lower the floor for low-traffic sites and
say so). Persist each as `analyses/{n}-{slug}.md` and its working rows to
`data/`.

### 1. Striking distance
- **Input:** Queries table (or Pages × Queries if available).
- **Filter:** avg position between 11.0 and 20.0, impressions above a volume
  floor (default ≥50/mo), not already a low-CTR case at top positions.
- **Why:** page 2 is the cheapest rank to move — small on-page or internal-link
  pushes flip it to page 1, where clicks actually happen.
- **Output:** query · landing page · position · impressions · current clicks ·
  modeled clicks at position 5 · gain · suggested lever (on-page relevance,
  internal links from stronger pages, content depth).
- **Sub-buckets:** 11–15 (one nudge from page 1, prioritize) vs 16–20 (needs
  real work).

### 2. Low CTR (below the curve)
- **Input:** Queries and/or Pages table with Position + CTR.
- **Filter:** actual CTR < benchmark CTR for its position by a margin (default
  gap ≥ 30% relative, i.e. actual < 0.7 × benchmark), impressions above the
  volume floor, position ≤ 10 (page-1 only — below that the curve is too flat to
  trust), branded terms excluded.
- **Why:** the rank is already won; the click is being lost to a weak title,
  missing/duplicate meta description, mismatched intent, or a SERP feature.
- **Output:** query/page · position · actual vs benchmark CTR · gain at recovery
  · probable cause · concrete title/meta rewrite suggestion in the client's
  voice (`context/brand.md`).

### 3. Declining pages (decay)
- **Input:** two windows of the Pages table (e.g. last 90d vs prior 90d). The
  user exports both; if only one window exists, skip this analysis and say so.
- **Filter:** clicks down ≥ a threshold (default −20% AND ≥10 absolute clicks
  lost) OR average position worsened ≥ 3 spots, on a page that previously had
  meaningful traffic.
- **Why:** content rots — freshness signals fade, competitors ship newer pages,
  the SERP intent shifts. Refreshing a decaying page is far cheaper than ranking
  a new one.
- **Output:** page · clicks then→now · position then→now · % change ·
  likely driver (seasonality? algo-wide? competitor?) · refresh play
  (update stats/year, expand thin sections, re-earn internal links, re-promote).

### 4. Content gaps
- **Input:** Queries table, cross-referenced against the site's known pages
  (from a quick crawl or the Pages table).
- **Filter (two kinds):** (a) queries with healthy impressions but ~no clicks
  *and no well-matched dedicated page* — the site ranks weakly off a tangential
  page; (b) clusters of related queries the site is brushing against but doesn't
  target head-on.
- **Why:** demand the site is adjacent to but not capturing. The most strategic
  bucket — net-new pages or major expansions.
- **Output:** query/cluster · total impressions · best current page (and why
  it's a poor fit) · recommended page type (new pillar, comparison, how-to) ·
  on-ICP? (check `context/icp.md` — drop off-ICP demand or mark it low-priority).

### 5. Cannibalization
- **Input:** Queries × Pages (which URLs receive impressions for the same query).
- **Filter:** a single query whose impressions split across ≥2 URLs, with no
  clear winner (the URLs trade positions, or both sit mid-page). Distinguish from
  legitimate cases (a query that *should* map to two different intents).
- **Why:** the site competes with itself; link equity and relevance signals
  dilute, so neither URL ranks as well as a consolidated one would.
- **Output:** query · the competing URLs with their positions/impressions ·
  recommended primary URL · consolidation play (merge + 301, de-optimize the
  weaker page, differentiate intent, or canonicalize).

### 6. Quick wins
- **Input:** the outputs of analyses 1–5.
- **Filter:** high impression volume AND a fix that's genuinely <15 minutes —
  a title/meta rewrite, a missing meta description, an internal link or two, a
  canonical tag, an H1 fix. No new content, no migrations.
- **Why:** banked value this week buys credibility for the longer plays. Carve
  these out explicitly so the client sees motion immediately.
- **Output:** the change · the page · modeled gain · est. minutes · who can do it
  (often the client themselves).

### 7. Top pages at risk
- **Input:** Pages table sorted by clicks (the traffic crown jewels) + the decay
  signal from analysis 3.
- **Filter:** pages in the top traffic decile that show *early* decline
  (position slipping, CTR softening) OR sit on a single thin moat (one keyword,
  no internal-link support, outdated).
- **Why:** losing a page that drives 30% of organic clicks dwarfs every
  small win. Defense ranks above offense for these.
- **Output:** page · current clicks · risk signal · defensive action
  (refresh cadence, internal-link reinforcement, monitor competitors).

### 8. Device / geo gaps (only if those tables were pulled)
- **Input:** Devices and/or Countries tables (optional exports).
- **Filter:** a segment whose CTR or position badly trails the blended average
  for pages that matter — e.g. mobile position much worse than desktop, or a
  target-market country underperforming.
- **Why:** a mobile-position gap points at page-experience/CWV issues; a geo gap
  points at localization, hreflang, or intent mismatch — each a different fix.
- **Output:** segment · the gap vs blended · affected pages · likely cause ·
  recommended track (hand mobile/CWV issues to `/seo-audit`; geo issues to
  localization/hreflang work).

## Prioritization scoring (transparent, shown in the roadmap)

Three independent 1–10 axes, summed (max 30). Show every score.

- **Impact (1–10)** — modeled monthly incremental clicks, mapped to a scale
  (default: ≥500→10, 200–499→8, 80–199→6, 30–79→4, 10–29→2). **Multiply the raw
  impact by 1.25 (cap 10) for money pages** — pages tied to an offer in
  `context/offers.md` or with commercial-intent queries — because a click there
  is worth more than an informational click.
- **Effort (1–10, inverse)** — meta/title-only edit→9, internal-linking→7,
  on-page content expansion→5, page consolidation/301→4, net-new content→2,
  technical/dev-dependent→2.
- **Confidence (1–10)** — high impression volume + a mechanical, well-understood
  fix→9; thin data or a speculative content bet→3. Anything resting on <50
  impressions caps confidence at 4.

**Buckets:** P0 ≥24 · P1 18–23 · P2 12–17 · P3 <12. Sort the roadmap by total
desc, P0 first. Tie-break on effort (cheaper first), then on money-page status.

## Outputs (exact workspace writes)

Deliverable folder `work/seo-optimize-{date}/` (or `Projects/{slug}/seo-optimize-{date}/`):

- `brief.md` — `type: brief`. Scope, the GSC property + date range(s) analyzed,
  due, owner, acceptance criteria (e.g. "every P0 has a page, a modeled gain, and
  a how-to"). Ask the user for any missing brief fact in ONE question.
- `roadmap.md` — `type: report`. Sections: **What changed** (re-run delta block,
  or "Baseline run" the first time) → **The opportunity** (total modeled
  incremental clicks + downstream leads/revenue if a conversion rate is logged) →
  **Quick wins** (analysis 6, do-this-week) → **Ranked roadmap** P0→P3 (each row:
  task, page/query, why, modeled clicks, the three axis scores + total, effort,
  how-to) → **Watch list** (top-pages-at-risk) → **Methodology note** (the curve
  used + whether it was fitted to client data; the date windows).
- `analyses/{1..8}-{slug}.md` — one table per analysis run.
- `data/` — every raw GSC export, plus `baseline.json` (below). Write files as
  data arrives; on context overflow, read the files, not the conversation.
- `goals.md` ledger line(s) — see SKILL.md Phase 4. Always at least the
  `seo-opportunity` line; add per-goal observations if the export contains a
  current value for an existing goal (e.g. total organic clicks → a `traffic`
  goal). Create missing goal definitions and flag them; never invent a baseline.

### baseline.json schema

```json
{
  "run_date": "2026-06-13",
  "property": "https://acme.com/",
  "window": "2026-03-15..2026-06-13",
  "curve_source": "fitted-to-client | default-blended",
  "totals": { "clicks": 0, "impressions": 0, "ctr": 0.0, "avg_position": 0.0 },
  "opportunity_clicks": 0,
  "task_count": 0,
  "p0_count": 0,
  "analyses": {
    "striking_distance": { "items": 0, "opportunity_clicks": 0 },
    "low_ctr":           { "items": 0, "opportunity_clicks": 0 },
    "declining":         { "items": 0, "clicks_lost": 0 },
    "content_gaps":      { "items": 0, "opportunity_clicks": 0 },
    "cannibalization":   { "items": 0 },
    "quick_wins":        { "items": 0, "opportunity_clicks": 0 },
    "at_risk":           { "items": 0 },
    "device_geo":        { "items": 0 }
  }
}
```

## Re-run deltas (first-class)

On a re-run (a prior `work/seo-optimize-*/` exists), load the most recent
`data/baseline.json` and lead the new `roadmap.md` with **What changed**:

- **Totals movement** — clicks/impressions/avg-position now vs the baseline
  window (e.g. "+1,240 clicks/mo, +0.8 avg position since 2026-03").
- **Task lifecycle** — for each prior P0/P1, classify from the new data:
  *resolved* (the query/page now ranks/CTRs at or above target — celebrate it,
  with the actual click lift it delivered), *partial*, *unchanged*, or
  *regressed*. Resolved tasks are the proof of work; surface them first.
- **New opportunities** — findings present now but not in the baseline (new
  striking-distance entrants, fresh decay).
- **Closed gaps** — opportunities that simply went away (a competitor outranked
  us, or we won it).
- Append the new `seo-opportunity` ledger line and (if total organic clicks map
  to a goal) the new value — the series is what makes month-over-month one grep.

Then render Phases 2–4 as normal for the current window. The delta block sits on
top; the full roadmap follows.
