---
type: template
status: active
tags: [template, report]
---

# Template — weekly client report

File as `reports/YYYY-Www.md` in the client workspace. Report in the FIRM's
voice; every number comes from the goals ledger — snapshot the figures into
the report so it stands alone in an email. Frontmatter:

```yaml
---
type: report
client: acme-corp
status: done
date: 2026-06-08
period: 2026-W23
tags: [client, acme-corp, report]
---
```

## Wins

Max 3, each tied to a number or a shipped artifact. No adjectives without
evidence.

## Metrics

| Goal | Baseline | Current | Target | Trend |
|---|---|---|---|---|

One row per goal. Current cites its ledger date. Where the ledger is silent
in-window, write "no new data" — never estimate. Trend arrow points where
the number moved, with a flag when that's against the goal's direction.

## Shipped

What went live or moved to final this period. Dates, not vibes.

## Next period

From open briefs and agreed actions — what the client will see happen.

## Needs from you

Client asks only, each with an owner name and a deadline, and the cost of
slipping stated plainly.
