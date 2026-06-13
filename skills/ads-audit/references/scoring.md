# Scoring — weighted health, aggregation, deltas

The audit's number must be transparent: every score traces to checks, severities,
and weights you can show on screen. No black box.

## 1. Each check resolves to one of four states

| State | Meaning | Scored? |
|---|---|---|
| **pass** | Meets the threshold | yes — full credit |
| **warn** | Partial / borderline (the warn band) | yes — partial credit |
| **fail** | Below the fail threshold | yes — zero credit |
| **N/A** | Check can't apply to this account | **no — removed from the denominator** |

Thresholds (what counts as pass / warn / fail) live per check in
`google-checks.md` and `meta-checks.md`. N/A examples: no Performance Max running,
no shopping feed, no remarketing audiences available, lead-gen account with no
purchase events. N/A is never a fail — excluding it is what keeps a lean account
from being punished for features it shouldn't use.

## 2. Severity = how much a check is worth

Each check carries a severity that sets its **weight** (its max points) and how
loud it is in the report:

| Severity | Weight | Use for |
|---|---|---|
| **Critical** | 3 | Tracking broken, money actively wasted, policy/billing risk |
| **High** | 2 | Structural problems throttling performance |
| **Medium** | 1 | Efficiency and hygiene drags |
| **Low** | 0.5 | Polish, nice-to-haves, future-proofing |

Each category in the checklists tags every check with a severity. (A category's
own emphasis = the sum of its checks' weights; you don't weight categories
separately — severity already does it, which keeps one knob, not two.)

## 3. Per-check credit

```
credit(check) = weight(check) × creditFactor(state)
creditFactor:  pass = 1.0   warn = 0.5   fail = 0.0   N/A = excluded
```

## 4. Per-platform score (0–100)

Over the platform's **applicable** checks only (drop every N/A):

```
platformScore = 100 × ( Σ credit(applicable checks) / Σ weight(applicable checks) )
```

Round to a whole number. This is the value that goes to the ledger as
`ads-{platform}-health`.

## 5. Account-wide score — weighted by spend share

A platform's grade should matter in proportion to the money flowing through it.
Compute each platform's share of total audited spend, then weight:

```
spendShare(p)  = spend(p) / Σ spend(all audited platforms)
accountScore   = Σ ( platformScore(p) × spendShare(p) )
```

If spend for a platform is unknown (export missing) and can't be inferred, fall
back to equal weighting across audited platforms and SAY SO in the report — never
silently guess a budget split.

## 6. Letter grade

Apply to both per-platform and account scores:

| Score | Grade |   | Score | Grade |
|---|---|---|---|---|
| 95–100 | A+ |  | 73–76 | C+ |
| 90–94 | A |  | 70–72 | C- |
| 87–89 | A- |  | 67–69 | D+ |
| 83–86 | B+ |  | 63–66 | D |
| 80–82 | B |  | 60–62 | D- |
| 77–79 | B- |  | < 60 | F |

(The D and F bands flag an account that needs a rebuild, not tuning.)

## 7. Always show the math

In `audit.md`, render the scorecard so the number is auditable:

```
Google Ads      88 / 100  (A-)  — 18 checks applicable, 4 N/A
  Conversion tracking  100  (3/3 pass)
  Wasted spend          67  (2 pass, 1 warn, 1 fail of 4)
  Account structure     80  ...
  ... per category ...
Meta Ads        67 / 100  (C+)  — 11 applicable, 3 N/A
  ...
─────────────────────────────────────────────
Account-wide    82 / 100  (B)   — Google 70% spend × 88, Meta 30% × 67
```

## 8. Quick-win carving

A finding is a **quick win** when it is BOTH:
- severity Critical or High, AND
- fixable in roughly under 15 minutes (a setting toggle, a negative keyword, an
  exclusion, re-enabling a conversion, pausing one obvious money-loser).

Quick wins list first, in `quick-wins.md` and at the top of the report — they are
the fastest dollars and the credibility-buyers. A High finding that needs a
rebuild (new campaign structure, creative production) is NOT a quick win; it's a
P1/P2 in the action plan.

## 9. Action-plan priority (P0–P3)

Rank every non-quick-win finding by severity, then by est. spend at risk:

| Priority | Rule |
|---|---|
| **P0** | Critical — tracking broken or money bleeding now. Do today. |
| **P1** | High — structural throttle. This week. |
| **P2** | Medium — efficiency. This sprint. |
| **P3** | Low — polish / backlog. |

Each action plan line: `priority · platform · finding · fix · owner · est. effort
· est. impact (spend saved or signal recovered) · evidence path`.

## 10. Goal definitions (create if missing, FLAG for confirmation)

If these ids aren't already in the client's `goals.md` frontmatter, add them and
tell the user to confirm. Use only what you can ground — never invent a baseline.

```yaml
  - id: ads-health
    metric: "Paid-media audit health score (budget-weighted)"
    unit: count            # 0–100
    baseline:              # leave blank on first audit; this run seeds it
    target: 90
    due:
    direction: up
  - id: ads-google-health
    metric: "Google Ads audit health score"
    unit: count
    baseline:
    target: 90
    direction: up
  - id: ads-meta-health
    metric: "Meta Ads audit health score"
    unit: count
    baseline:
    target: 90
    direction: up
```

Add `ads-linkedin-health` / `ads-tiktok-health` / `ads-microsoft-health` the same
way only when that platform is actually audited. On the FIRST audit, this run's
score is the baseline — note that in the ledger line and leave `baseline:` for the
user to confirm (don't back-fill it as if it were a prior measurement).

## 11. Ledger lines (EXACT format — `- date | id | value | note`)

One observation per line, value a bare number:

```
- 2026-06-13 | ads-google-health | 88 | A-; conv-tracking restored, 1 wasted-spend fail open
- 2026-06-13 | ads-meta-health | 67 | C+; CAPI gap, 2 fatigued creatives
- 2026-06-13 | ads-health | 82 | B; budget-weighted Google 70% / Meta 30%
```

Append-only. A re-run adds NEW lines below; it never edits old ones. A grep of
`| ads-health |` across the file is the whole longitudinal trend.

## 12. Re-run deltas (the moat)

On a re-run, after scoring, diff against the prior `baseline.json`:

- **Per platform:** `Δscore = thisScore − priorScore`. Report sign and grade move
  ("Google +9, B- → A-").
- **Per check:** classify each — **fixed** (fail/warn → pass), **regressed**
  (pass → warn/fail), **new** (didn't exist before / newly applicable),
  **still-failing** (fail → fail). Regressions and still-failing lead the body.
- **Spend shift:** note if the budget weighting moved (Meta share 30% → 45%),
  because the account grade can move even with flat platform scores.

**Lead the deliverable** with a delta block before the scorecard:

```
## Since the 2026-04-12 audit
- Account grade: B- → B   (+4)
- Google: 79 → 88 (+9)   fixed: conversion tracking, 2 wasted-spend leaks
- Meta:   71 → 67 (−4)   regressed: pixel CAPI dropped; 2 new fatigued creatives
- Still open from last time: single-campaign structure (High, P1)
```

## baseline.json schema

Write this every run; the next run reads it.

```json
{
  "audit_date": "2026-06-13",
  "date_range": "2026-05-14..2026-06-13",
  "account_score": 82,
  "account_grade": "B",
  "weighting": "spend-share",
  "platforms": {
    "google": {
      "score": 88, "grade": "A-", "spend": 14200, "spend_share": 0.70,
      "applicable_checks": 18, "na_checks": 4,
      "categories": { "conversion-tracking": 100, "wasted-spend": 67, "...": 0 },
      "checks": { "g-conv-primary": "pass", "g-search-terms": "fail", "...": "na" }
    },
    "meta": {
      "score": 67, "grade": "C+", "spend": 6100, "spend_share": 0.30,
      "applicable_checks": 11, "na_checks": 3,
      "categories": { "tracking": 50, "creative": 70, "...": 0 },
      "checks": { "m-capi": "fail", "m-fatigue": "warn", "...": "pass" }
    }
  }
}
```
