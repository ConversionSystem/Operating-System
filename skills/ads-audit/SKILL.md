---
name: ads-audit
description: Multi-platform paid-media audit for a Conversion OS client — scores every active ad account (Google, Meta, +LinkedIn/TikTok/Microsoft) against original category checklists, rolls them into one budget-weighted health grade, and ships a prioritized action plan as a tracked deliverable with a baseline future audits chart against. Zero-API by default (manual exports + screenshots); platform connectors are optional accelerators. Triggers: /ads-audit, "audit our ads", "audit the Google/Meta account", "PPC audit", "paid media audit", "where's our ad budget leaking", "wasted ad spend", "re-audit the ads".
---

# Conversion OS — Paid-Media Audit

Audits a client's live ad accounts as a tracked deliverable: per-platform health
scores from original category checklists, a budget-weighted grade, a prioritized
action plan, and a baseline every later re-audit charts against. The moat is the
workspace — read what we already know, write a deliverable that compounds.

Before anything: read `Clients/CLAUDE.md`, then the target client's `CLAUDE.md` +
`profile.md`. The firewall there overrides everything — never read sibling
clients, never quote one client's account into another's audit, voice (if any
copy is suggested) comes from the CLIENT's `context/brand.md`. If no vault exists
(no root CLAUDE.md), stop: "Run /setup first."

## Resolve target & scope

1. **Whose account?** explicit arg → the client of the current session → ask. For
   the agency's own ads, target `Company/` for reads and write to
   `Projects/{slug}/` instead of `Clients/{slug}/work/` (everything else holds).
2. **Read before you ask** (confirm, never re-interrogate):
   - `context/stack.md` → which platforms run, account IDs/names, what we touch.
   - `context/icp.md` → who the ads should be reaching (relevance checks lean on it).
   - `context/offers.md` → what's being sold + target CPA/economics if recorded.
   - `goals.md` → existing ad goals (CPL, ROAS, spend) to tie findings to targets.
   - `context/brand.md` → only if the action plan suggests ad/landing copy.
   Echo back a one-line scope confirmation ("Auditing Google + Meta for {client};
   target CPA $60 from offers.md; prior audit 2026-04 found a B-"). Ask ONLY for
   what's genuinely absent (e.g. a platform export we can't infer).

## Detect re-run (first-class — do this before auditing)

Glob `work/ads-audit-*/` (or `Projects/{slug}/ads-audit-*/`). If a prior run
exists, this is a **RE-RUN**:
- Load its `baseline.json` (per-platform scores, check states, spend shares).
- After scoring, compute deltas vs that baseline and **lead the deliverable with
  what changed** — "Google +9 pts (B- → A-) since 2026-04; Meta −4 (pixel
  regressed)". Mark each check fixed / new / still-failing / regressed.
- Append the new scores to `goals.md` as fresh ledger lines (never overwrite).
See `references/scoring.md` → "Re-run deltas" for the exact comparison + lead format.

## Phases

1. **Inventory inputs.** For each active platform, gather the zero-API default:
   manual exports (campaign/ad-group/keyword/search-term/ad/asset reports as CSV)
   + screenshots (settings, conversion/pixel status, learning phase). Note the
   date range (default last 30d, plus a 90d window for fatigue/trend checks).
   Record spend per platform — it drives the weighting. Persist every raw file to
   the deliverable's `data/` as received. See `references/inputs.md` for the exact
   export list per platform and the connector accelerators (gated behind "if
   connected"). Missing a platform's data → audit the rest, mark that one
   "not assessed", never block.
2. **Audit per platform, in parallel.** Fan out one sub-auditor per active
   platform in ONE message (never sequential). Google → `references/google-checks.md`
   (6 categories). Meta → `references/meta-checks.md` (4 categories). Other
   platforms → `references/other-platforms.md` (note briefly; full sets are a
   later wave). Each check returns pass / warn / fail / N-A with cited evidence
   (the export row or screenshot), severity, and the fix. N/A checks are excluded
   from scoring, never counted as fails.
3. **Score & aggregate.** Per `references/scoring.md`: each platform gets a
   weighted score over its *applicable* checks → a 0–100 number + letter grade;
   aggregate platforms weighted by their **spend share** into one account-wide
   grade. Always show the math — no black-box number.
4. **Carve quick wins.** Every finding that is high-severity AND fixable in
   roughly under 15 minutes becomes a quick win. List them first in their own file
   — these are the credibility-buyers.
5. **Write the deliverable** (the differentiator — see below).
6. **Report back.** Lead with the headline grade (and the delta if a re-run),
   then quick wins, then the top findings by severity, then the link to the full
   `audit.md`. Offer to file the kill/scale decisions and task stubs.

## Writes (every run — this is what makes it ours)

Deliverable root: `Clients/{slug}/work/ads-audit-{YYYY-MM-DD}/` (agency-self:
`Projects/{slug}/ads-audit-{YYYY-MM-DD}/`). Write, don't just report:

- `brief.md` — scope (platforms, date range), due, owner, acceptance criteria.
- `audit.md` — full report: scorecard, per-platform sections, every finding with
  evidence/severity/fix. Re-run leads with the delta summary. Format in
  `references/report.md`.
- `action-plan.md` — findings as prioritized, owned, effort-tagged tasks (P0–P3).
- `quick-wins.md` — the high-severity / <15-min subset, top of the stack.
- `data/` — every raw export + screenshot reference + a `findings.json` of all
  check results (persisted as gathered, so an overflow re-reads files, not chat).
- `baseline.json` — per-platform scores, check states, spend shares, grade — the
  artifact the NEXT audit diffs against. Schema in `references/scoring.md`.
- `goals.md` ledger — append per-platform health (and aggregate), EXACT format
  `- YYYY-MM-DD | {goal-id} | {value} | {note}`:
  `- 2026-06-13 | ads-google-health | 88 | A- (was B- 04); fixed conv-tracking`
  `- 2026-06-13 | ads-meta-health | 67 | C+; pixel CAPI gap`
  `- 2026-06-13 | ads-health | 82 | B (budget-weighted, Google 70% / Meta 30%)`
  If those goal ids don't exist in `goals.md`, create the definitions (see
  `references/scoring.md` → "Goal definitions") and FLAG it for the user to
  confirm. Never invent a baseline or a target.
- `decisions.md` — each kill / scale / restructure recommendation as one dated
  block (`## YYYY-MM-DD — {decision} — {rationale + evidence path}`).
- Today's `Daily/` note `## Activity` — one line (a whitelisted cross-workspace write).
- Recurring strategic learnings (a wasteful audience pattern, a winning angle) →
  append dated to the relevant `context/` file, flagged for confirmation.

## Hard rules

- **Zero-API is the default.** The full audit works from manual exports +
  screenshots + web research. Every connector is an optional accelerator gated
  behind "if connected" — never a hard dependency, never blocks.
- **N/A excluded, never failed.** A check that can't apply (no Performance Max,
  no shopping feed) is removed from the denominator, not scored zero.
- **A finding without a cited path doesn't exist.** Every fail/warn names the
  export row or screenshot that proves it.
- **Never invent metrics.** No conversion data = "conversion tracking not
  verifiable", a Critical finding — not an assumed number.
- **Firewall:** no sibling-client account is read, quoted, or compared; suggested
  copy uses the client's `context/brand.md`; writes stay in the workspace + the
  two whitelisted exceptions.
- **Original expression only.** The checklists are common professional knowledge
  authored in our own words — no copied competitor text, examples, or brand names.
