# Changelog — Conversion OS

## [1.2.0] — 2026-06-13 · Client-delivery library (open beta)

Nine new delivery skills you run FOR clients — and they write back into the
client's workspace, so each run compounds instead of vanishing into a downloads
folder:

- `/lead-qualify`, `/lead-research`, `/win-loss` (sales)
- `/email-sequence`, `/email-personalize` (outbound)
- `/case-study` (proof, built from your KPI ledger)
- `/seo-audit`, `/seo-optimize`, `/ads-audit` (audits as tracked, re-runnable
  deliverables with longitudinal health scores)

Each reads your client context, lands a deliverable in `work/`, writes baselines
to the goals ledger, and charts deltas on re-run. Zero-API by default. Free
during the open beta.

## [1.1.0] — 2026-06-12 · Open beta

The full suite is now included free while we battle-test with real firms:
`/client` complete (prep, log, draft, report, health engine + pipeline,
lifecycle, archive-with-harvest), `/autopilot`, `/audit`, and `/team` join
`/setup`, `/daily`, and client workspaces/briefs. When the beta ends, the
advanced suite becomes Conversion OS Pro; vaults and their content remain
yours regardless.

## [1.0.1] — 2026-06-12

First public release (Foundation tier).

- `/setup` — vault scaffold, import-first ingestion, adaptive interview
  (solo + agency modes), silent build with report card, first-win brief
- `/client` — client/prospect workspaces with the full context model
  (profile schema, goals ledger format, scope contracts) + one-screen briefs
- `/daily` — resume/save memory protocol, morning brief, inbox triage,
  evening close, weekly review, plain-markdown task boards
- Vault hooks: session-end git snapshot, structure lint
- `examples/demo-vault/` — a seeded agency vault to explore in Obsidian

Hardened by two independent execution tests before release (a cold demo-vault
build and a full end-to-end simulation).
