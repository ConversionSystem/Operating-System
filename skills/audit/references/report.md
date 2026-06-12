# Audit scoring + report format

## Score

Per category: `deduction = min(25, fails×5 + warns×1)` → `score = 100 − Σ deductions`.

| Score | Reading | Cadence advice |
|---|---|---|
| 90–100 | tuned | monthly audit |
| 70–89 | drifting | fix fails this week |
| 50–69 | bloating | half-day cleanup, then monthly |
| <50 | rotting | guided cleanup before trusting outputs |

Score is honest, not kind: C5 fails can't be offset by tidy frontmatter — if C5
has any fail, cap the score at 69 and say why.

## Report — `Ops/decisions/YYYY-MM-DD-vault-audit.md`

```markdown
---
type: decision
status: active
date: YYYY-MM-DD
tags: [audit, generated]
---
# Vault audit — YYYY-MM-DD

**Score: NN/100** (prev: NN on YYYY-MM-DD — or "prev: — first audit") · NN files scanned · NN findings (NN fixed)

| Category | Fails | Warns | Deduction | Fixed |
|---|---|---|---|---|

## Trust (C5) — read this section even if you skip the rest
{each C5 finding: path · evidence · action taken/needed}

## Findings by category
{C-worst first; per finding: path:line · evidence · why it matters · fixed?}

## Applied fixes
{ledger of changes, one line each — these are also in the session git snapshot}

## Recommended before next audit
{3–5 items max: the human-review lists from C3/C4, next /client health all, next audit date}
```

Estimated token savings from C4 fixes may be reported when material ("root file
−38 lines ≈ −500 tokens/session") — never as the headline; trust and routing
correctness are the headline.
