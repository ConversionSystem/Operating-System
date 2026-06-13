# Report & deliverable format

The deliverable is a tracked client asset, not a downloads-folder PDF. Files all
live under `Clients/{slug}/work/ads-audit-{YYYY-MM-DD}/` (agency-self:
`Projects/{slug}/ads-audit-{YYYY-MM-DD}/`). Numbers first, every finding cited.

## brief.md

```markdown
---
type: brief
status: active
date: 2026-06-13
tags: [ads-audit, brief]
---

# Ads audit — {Client} — 2026-06-13

- Scope: Google Ads + Meta Ads. Window 2026-05-14..2026-06-13 (90d for fatigue).
- Data provenance: Google via manual export; Meta via manual export + screenshots.
- Owner: {person-slug}    Due: {date}
- Acceptance: every active platform scored over applicable checks; weighted
  account grade; quick-wins + P0–P3 action plan; baseline.json + ledger lines written.
- Prior audit: work/ads-audit-2026-04-12/  (re-run -> lead with deltas)
```

## audit.md — the full report

Order matters: a re-run delta block (if any) -> scorecard -> quick wins -> per
platform -> per category -> measurement/methodology.

```markdown
---
type: report
status: active
date: 2026-06-13
tags: [ads-audit, generated]
---

# Paid-media audit — {Client} — 2026-06-13

## Since the 2026-04-12 audit        <- ONLY on a re-run; lead with this
- Account grade: B- -> B (+4)
- Google 79 -> 88 (+9): fixed conversion tracking, 2 wasted-spend leaks
- Meta 71 -> 67 (-4): pixel CAPI regressed; 2 new fatigued creatives
- Still open: single-campaign structure (High, P1)

## Scorecard
Account-wide   82 / 100  (B)   — Google 70% spend x 88, Meta 30% x 67

Google Ads     88 / 100  (A-)  — 18 checks applicable, 4 N/A
  G1 Conversion tracking   100  (3/3 pass)
  G2 Wasted spend           67  (2 pass, 1 warn, 1 fail of 4)
  G3 Structure & settings   80
  G4 Keywords & QS          75
  G5 Ads & assets           90
  G6 Settings/billing/policy 88
Meta Ads       67 / 100  (C+)  — 11 applicable, 3 N/A
  M1 Tracking               50  (CAPI fail, EMQ warn)
  M2 Creative               70
  M3 Structure/learning     72
  M4 Audience               75

## Quick wins (do today — high severity, <15 min)
1. [Google · Critical] Negate 6 zero-conversion off-intent search terms burning
   ~$430/mo. Evidence: data/google-search-terms.csv rows 12,18,23,...
2. [Meta · Critical] Re-deduplicate CAPI (set event_id) — recovers suppressed
   conversions. Evidence: data/meta-events-manager.png

## Findings by platform & category
### Google Ads
**G2 · Wasted spend — 67**
- [FAIL] g-search-terms (Critical) — 28% of spend on irrelevant queries.
  Evidence: data/google-search-terms.csv. Fix: add negatives + a shared list.
- [WARN] g-zero-converters (Medium) — 4 keywords, $610 spend, 0 conv.
  Evidence: data/google-keywords.csv rows 31–34. Fix: pause/rework.
- [PASS] g-negatives (High) — maintained shared lists, brand split.
- [N/A] g-placement-waste — no Display/PMax/Video running.
(...every category, every check, worst first within each...)

### Meta Ads
(...)

## Measurement & methodology
- Scoring: weighted check credit / applicable weight, N/A excluded (see the
  scoring reference). Account grade weighted by spend share.
- Windows: 30d performance, 90d fatigue/trend. Data provenance above.
- Limits: {anything not assessable and why}.
```

Use plain glyphs ([PASS] [WARN] [FAIL] [N/A]) so the report scans fast.

## action-plan.md

Findings as owned, prioritized, effort-tagged tasks. P0 first.

```markdown
---
type: brief
status: active
date: 2026-06-13
tags: [ads-audit, action-plan]
---

# Action plan — {Client} ads audit — 2026-06-13

## P0 — today (Critical)
- [ ] Google · Negate 6 off-intent search terms (~$430/mo saved) · {owner} · 10m · evidence: data/google-search-terms.csv
- [ ] Meta · Fix CAPI dedup (recover conversions) · {owner} · 15m · evidence: data/meta-events-manager.png

## P1 — this week (High)
- [ ] Meta · Restructure 1 fragmented campaign -> consolidate ad sets · {owner} · 2h · evidence: data/meta-adsets.csv

## P2 — this sprint (Medium)
## P3 — backlog (Low)
```

Top P0/P1 lines should also be filed as task stubs to the owner's board (offer it;
the SKILL routes them via the whitelisted task-write exception).

## quick-wins.md

Just the quick-win subset (Critical/High AND <15 min), each with the dollar/signal
impact and evidence path — the page you hand the client to prove value fast.

## data/findings.json

Machine-readable mirror of every check result (platform, check id, state,
severity, evidence path, fix, est. impact, is_quick_win). Drives `baseline.json`
and lets a re-run diff without re-reading prose.

## What goes where else (from the SKILL writes list)

- `baseline.json` -> deliverable root (schema in `scoring.md`).
- `goals.md` ledger lines -> the client's `goals.md` (exact `- date | id | value |
  note` format; create goal defs if missing, flag for confirmation).
- kill/scale/restructure recs -> `decisions.md` (one dated block each).
- one activity line -> today's `Daily/` note `## Activity`.
- recurring strategic learnings -> dated append to the relevant `context/` file
  (flagged for confirmation), e.g. a persistently wasteful audience pattern to
  `context/icp.md`.
