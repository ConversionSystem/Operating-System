# Win/loss — exact workspace writes

The whole point of the skill: the analysis doesn't end in a folder, it rewires the
workspace so every later run is sharper. These are the exact files, formats, and
the re-run path. Client deliverable → `Clients/{slug}/`; agency's own deals →
`Projects/{slug}/` (the persona/ledger/decisions writes land in `Company/` and
`Ops/` instead — same shapes).

## What gets written (the full set)

| Write | Path | Format |
|---|---|---|
| The analysis | `work/win-loss-{date}/final/analysis.md` | below |
| Raw export + enriched records | `work/win-loss-{date}/data/` | CSV + JSON |
| Run baseline (for re-runs) | `work/win-loss-{date}/data/baseline.json` | schema below |
| Deliverable brief | `work/win-loss-{date}/brief.md` | scope, due, owner, acceptance |
| **Winning persona** | `context/icp.md` → `## Winning persona` | dated, appended |
| **Lost-reason ledger line** | `goals.md` ledger | exact format below |
| **Strategic recs** | `decisions.md` | one block each |
| Activity line | today's `Daily/` note `## Activity` | one line |
| Optional deck | `work/win-loss-{date}/final/` | if requested |

## 1. The deliverable — `work/win-loss-{date}/final/analysis.md`

```markdown
---
type: report
status: active
date: YYYY-MM-DD
tags: [win-loss, {client-slug}]
---
# Win/loss analysis — {Client} — YYYY-MM-DD

**{won}W / {lost}L** across {N} closed deals · close rate {pct}% ·
lost-reason field: {used | ignored — <30% populated, reasons inferred from evidence}
{RE-RUN: prepend a Δ line — see "Re-run path" below}

## Winning persona
{2–4 tight paragraphs from the highest-value won deals: who they are, the trigger
and job-to-be-done, the shape of the deal. Lead with the dimensions where won/lost
diverged hardest. Mirrors what gets appended to context/icp.md.}

## Kill-list — disqualifying red flags
{5–8 flags. Each: the flag · how to detect it early · evidence (≥2 cited losses,
deal name + quote/date) · its lost-reason archetype.}

## Patterns by dimension
{Per dimension that diverged: the won signal vs the lost signal, with deal counts
and one cited quote each. Skip dimensions where won and lost looked the same.}

## Lost-reason breakdown
{Archetype tally: archetype · count · share of losses · the preventable ones flagged.}

## Strategic recommendations
{The fixable-by-GTM divergences — positioning gaps, weak sources, recurring
objections. Each mirrors a decisions.md block.}

## Evidence appendix
{Top-5-per-segment deals, one block each: outcome, value, the dimension scores,
the quotes that drove the read. The tail summarized in a table.}
```

Persist the raw export and the enriched `deals.json` to `data/` as they're
gathered — never hold them only in context (resilience + resumability).

## 2. Winning persona → `context/icp.md` (the loop competitors lack)

Append (never overwrite) a dated section. This is the durable learning the whole
system reads next: `/lead-qualify` gates against it, `/lead-research` scores ICP-fit
against it, `/email-personalize` pulls the trigger language from it.

```markdown
## Winning persona — added YYYY-MM-DD (from win/loss, {won}W/{lost}L)
**Looks like:** {firmographics + champion profile from highest-value wins}
**Buys because:** {trigger + job-to-be-done + cost of inaction, in their words}
**Deal shape:** {typical size band, velocity, decision structure, best source}
**Disqualifiers (kill-list):** {the 5–8 flags, one line each, each tagged with its
archetype}
```

Keep `context/icp.md` under its 150-line budget. If this section pushes it over,
archive the oldest section per the vault overflow rule and say so. On a re-run,
add a NEW dated section rather than editing the prior one — the dated history is
the proof of how the persona sharpened.

## 3. Lost-reason archetypes → `goals.md` ledger line

Exact format from goals-ledger.md — `- YYYY-MM-DD | goal-id | value | note`:

```
- 2026-06-13 | win-loss | 12/18 | top loss: no-decision (5 of 18); persona v2 to icp.md
```

- **value** = `{won}/{lost}` for the analyzed cohort.
- **note** = the dominant lost-reason archetype + its count + a one-clause pointer.
- If a `win-loss` goal definition doesn't exist in the frontmatter, create it
  (`id: win-loss`, `metric: "Closed-won vs lost per analysis"`, `unit: ratio`,
  `direction: up`) and **flag it for the user to confirm** — never invent a
  baseline or target. If a close-rate goal already exists, also append its line.

## 4. Strategic recommendations → `decisions.md`

One append-only block per recommendation (create the file at its first block):

```markdown
## YYYY-MM-DD — {recommendation, as a decision the client can act on}
**From:** win/loss analysis YYYY-MM-DD ({won}W/{lost}L)
**Evidence:** {the divergence + cited deals/quotes}
**Action:** {what to change in GTM — positioning, source mix, enablement}
**Owner / next step:** {if known from people.md; else flag}
```

## 5. Activity line → today's `Daily/` note

The firewall's whitelisted cross-workspace write. One line under `## Activity`:
`- Win/loss for {Client}: {won}W/{lost}L, persona v{n} → icp.md, {k} recs filed.`

---

## Re-run path (first-class — bake it in)

On invocation, glob `work/win-loss-*/` for a prior run **before** sourcing deals.
If one exists, this is a RE-RUN:

1. Load its `data/baseline.json`.
2. Compute deltas: close-rate movement, new won/lost since the prior `as_of`
   date, persona drift (which dimensions shifted), DQ flags added or retired,
   archetype-mix change.
3. **Lead the new `analysis.md` with what changed** — a Δ line right under the
   header, e.g. `Δ since 2026-04: close rate 56% → 67% (+11pts); no-decision
   losses down 3; new kill-flag: champion-not-budget-owner.`
4. Append the new ledger line (don't edit the old one), add a NEW dated persona
   section to `icp.md`, file only the *new* recommendations to `decisions.md`.

### `data/baseline.json` schema

```json
{
  "as_of": "2026-06-13",
  "cohort": { "won": 12, "lost": 18, "close_rate_pct": 40 },
  "lost_reason_field": "ignored",
  "archetypes": { "no-decision": 5, "competitor": 4, "price": 3, "fit-gap": 2,
                  "wrong-buyer": 2, "timing": 2 },
  "persona_signals": { "size_band": "50-200", "champion": "VP/Head of",
                       "top_source": "referral", "win_velocity_days": 34 },
  "kill_flags": ["no-cost-of-inaction", "champion-not-budget-owner",
                 "edge-use-case", "discount-led", "multi-threaded-late"],
  "deliverable": "work/win-loss-2026-06-13/"
}
```

Write `baseline.json` on every run — it's what the *next* run diffs against, and
what `/case-study` and reports can chart the close-rate series from.
