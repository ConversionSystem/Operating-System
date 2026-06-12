---
name: autopilot
description: Build and schedule the autonomous context engine for a Conversion OS vault — a recurring agent that pulls meeting transcripts, chat, and email through available connectors into the right client workspaces and daily notes, with run budgets and human escalation. Triggers: /autopilot, "keep the vault updated automatically", "schedule the OS", "set up the operator agent", "auto-ingest my meetings".
---

# Conversion OS — Autopilot

A vault you update by hand dies in two weeks. Autopilot generates a
battle-spec'd autonomous agent prompt from THIS vault's reality, then schedules
it. One run = ingest fresh signal → file it where the routing map says → flag
what needs a human → report.

## Phase 0 — Silent discovery (no questions)

Read: root CLAUDE.md (mode, conventions) · Company/profile.md + stack.md (the
automation wishlist!) · Company/team.md (escalation candidates) · Clients/
profiles (active slugs, cadences) · Ops/pipeline.md. Cache: firm name, mode,
active client slugs, candidate connectors from stack.md, escalation candidates.
Summarize in ≤6 lines; ask only for corrections.

## Phase 1 — Ask only the gaps (one AskUserQuestion each, skip any already known)

1. **Cadence** — daily (recommended start) / twice daily / hourly / custom.
   Note honestly: local scheduled tasks need the machine awake; cloud
   routines/managed agents run with the laptop closed but need vault access via
   sync or a remote MCP (see docs/team-and-sync-guide.md). Recommend: start
   local daily, graduate later.
2. **Connectors** — probe live per `references/connectors.md` (list available
   MCP tools/integrations; match against stack.md candidates). Confirm which to
   wire; for each, the one or two scoping facts the fragment needs (e.g. which
   Slack channels, which calendar).
3. **Escalation** — who gets pinged when a run finds something urgent, and how
   (Slack DM if wired; otherwise flagged at the top of the daily note). Define
   "urgent": client-risk language, missed-deadline evidence, money/scope changes.
4. **Budgets** — per run: standard 40 reads / 25 writes / 15 transcripts /
   3 escalations · light 20/10/8/1 · heavy 80/50/30/5 · custom. Hard caps —
   the agent stops at the cap and says so in its report.

## Phase 2 — Render

1. Read `references/agent-prompt.md` (the template) and
   `references/connectors.md` (per-connector blocks).
2. Fill every `{{PLACEHOLDER}}` from Phases 0–1. Splice only enabled connector
   blocks; delete disabled sections entirely (no dead headers).
3. Sanity pass: zero unfilled `{{ }}`; every client slug real; budgets present.
4. Show a preview (cadence, connectors, escalation, budgets) → confirm → save to
   `Ops/autopilot-prompt.md` (`type: prompt`, `tags: [autopilot, generated]`).

## Phase 3 — Schedule

Wire the saved prompt on the chosen cadence using whatever scheduler this
environment provides (scheduled tasks / cron / cloud routines) with the vault
root as working directory. If no scheduler is available here, give exact manual
setup steps for the user's platform instead — never pretend it's scheduled.
Confirm: prompt path, cadence, next run, where reports land (daily note
`## Activity` + `## Autopilot` section).

## Maintenance

Re-run /autopilot after: new connector, team change, escalation change, or when
run reports show repeated budget exhaustion (raise budgets or cadence). The
prompt is regenerated, never hand-patched — edits belong in vault context, which
discovery reads.
