# goals.md — KPI definitions + ledger

The outcome engine. Reports, health checks, and case studies all generate from
this one file per client. Two parts: frontmatter defines goals; an append-only
ledger records observations. No database, no plugin — grep does everything.

## Format

```markdown
---
type: client-goals
client: acme-corp
status: active
tags: [client, goals]
goals:
  - id: leads              # short stable slug — the grep key, never renamed
    metric: "Qualified leads per month"
    unit: count            # count | usd | pct | ratio | hours
    baseline: 80           # value at engagement start
    target: 160
    due: 2026-09-30
    direction: up          # up | down — lets health checks detect regression
  - id: cpl
    metric: "Cost per qualified lead"
    unit: usd
    baseline: 95
    target: 60
    due: 2026-09-30
    direction: down
---

# Goals — Acme Corp

## Ledger
<!-- append-only: - YYYY-MM-DD | goal-id | value | note -->
- 2026-05-26 | leads | 104 | first full week of new landing page
- 2026-06-02 | leads | 118 | retargeting live
- 2026-06-02 | cpl | 78 |
- 2026-06-09 | leads | 131 |
- 2026-06-09 | cpl | 71 | creative refresh cut CPL
```

## Rules

- **Append-only.** Never edit or delete ledger lines; a wrong entry gets a
  correcting line with a note. Git history + clean diffs depend on this.
- **One observation per line**, exact format `- date | id | value | note` —
  value is a bare number (unit lives in the definition).
- **Sources:** /client log extracts metric mentions from meetings; /autopilot
  appends from connected data; the user can paste numbers any time ("acme leads
  were 140 this week" → one line).
- **Never invent.** No baseline given = leave `baseline:` out and flag it in the
  report card / next brief. A goal without observations reports "no data yet",
  not an estimate.
- **Renaming a goal id is forbidden** once ledger lines exist (it breaks the
  series). Retire instead: add `retired: YYYY-MM-DD` to the goal and stop logging.

## Query patterns (for flows that read this file)

- Current value: last `| {id} |` line.
- Trend: last 3 lines for the id; compare against `direction`.
- Percent to goal: `(current - baseline) / (target - baseline)` (inverted for
  `direction: down`).
- Cross-client roll-up for a month: every ledger line starting `- 2026-06`
  across `Clients/*/goals.md`.
