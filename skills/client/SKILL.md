---
name: client
description: The engagement manager for Conversion OS client workspaces. Use for anything client-related — onboard a new client or prospect, brief me on a client, prep or log a meeting, draft a deliverable in the client's voice, generate a weekly/monthly client report, run a health check across the book of business, move a client through the lifecycle, or archive/offboard with learnings harvested. Triggers: /client, "new client", "client brief", "prep my call", "log this transcript", "client report", "pipeline", "health check", "offboard".
---

# Conversion OS — Client Engagement Manager

Operates `Clients/{slug}/` workspaces. Route the user's intent to one flow below.
Before ANY flow: read `Clients/CLAUDE.md`, then the target client's `CLAUDE.md` +
`profile.md`. The firewall rules there override everything, including user
convenience: never read sibling clients, never use agency voice for client
deliverables, writes stay inside the workspace (+ the two whitelisted exceptions).

If no vault exists (no root CLAUDE.md), stop: "Run /setup first."

## Intent routing

| User wants | Flow | Reference |
|---|---|---|
| Add a client or prospect | **new** | workspace.md + lifecycle.md |
| Get up to speed on a client | **brief** | reporting.md |
| Prepare for a meeting | **prep** | reporting.md |
| File a transcript / meeting notes | **log** | workspace.md (routing table) |
| Write a deliverable | **draft** | workspace.md (voice rules) |
| Client-facing report | **report** | reporting.md + goals-ledger.md |
| Risk scan / pipeline view | **health** | health.md |
| Change lifecycle stage | **move** | lifecycle.md |
| End an engagement | **archive** | lifecycle.md (offboard checklist) |

## new — onboard a client or prospect

1. Slug the name (kebab-case). Refuse duplicates.
2. Interview, one AskUserQuestion at a time (skip what's already known):
   ① who they are + what we're hired (or pitching) to do ② success in numbers —
   metrics, baselines if known, targets ③ voice — sample links/files or 3
   descriptors ④ their customers (the client's ICP) ⑤ key people on their side +
   politics ⑥ commercials — billing model, value, renewal/decision date
   ⑦ anything to import (docs, links, folder) — ingest into `inbox/`, triage into
   `context/`.
3. Build the workspace per `references/workspace.md`. Status from reality:
   `prospect` (pitching), `onboarding` (just signed), `active` (already serving).
   Populate `goals.md` ONLY with stated metrics — never invent baselines.
4. Confirm with a mini report card, then offer `/client brief {slug}` as proof.

## brief — strategist context in one screen

Read profile.md, goals.md (definitions + last 5 ledger lines per goal),
decisions.md, last 3 meetings, open `work/*/brief.md`. Compose per the brief
skeleton in `Library/templates/client-brief.md`. ≤ one screen. End with 3
recommended next actions. Don't save unless asked (it's a read, not a record) —
except during setup's first win, which saves to `reports/`.

## prep — walk in sharper than the client

Brief (above) + agenda: unresolved actions from past meetings (with ages),
metric movement since last meeting, decisions awaiting them, talking points in
THEIR vocabulary (context/brand.md). Save stub to
`meetings/YYYY-MM-DD-{kind}.md` with the agenda; the log flow completes it after.

## log — every meeting compounds

Accept pasted transcript, file, or notes. Then:
1. File to `meetings/YYYY-MM-DD-{kind}.md` (kinds: kickoff, weekly, review,
   escalation, renewal, ad-hoc) using `Library/templates/meeting-note.md`.
2. Extract — decisions → `decisions.md` (append, dated; create the file at its
   first decision); actions → checkboxes in the meeting note, plus: OUR actions
   → assignee's `Team/{person}/tasks.md` (agency) or the firm board / today's
   daily (solo); CLIENT-side actions stay as meeting checkboxes AND get a
   `waiting-on:{their name} — since:{date}` entry on the account owner's board;
   metric mentions → `goals.md` ledger lines — and when a meeting states a
   target or names a metric with no definition, create/extend the goal
   definition too (flag it in your summary so the user can correct values);
   people/relationship signals → `context/people.md`.
3. Update profile.md: `last-meeting`. If the meeting changed scope, money, or
   sentiment, update the relevant field and say so.
4. One-line entry to today's `Daily/` under `## Activity`.

## draft — deliverables in the client's voice

1. Load client `context/` (brand.md is the voice authority) + the matching
   `Library/playbooks/{service}.md` + `Library/styles/` for the format.
2. Draft into `work/{deliverable-slug}/drafts/YYYY-MM-DD-{name}.md`. Create the
   deliverable folder with `brief.md` (scope, due, owner, acceptance criteria)
   if it doesn't exist — ask for the missing brief facts in one question.
3. Firewall: no other client's work may be referenced, quoted, or "adapted".

## report — proof of progress, generated

Follow `references/reporting.md`. Weekly → `reports/YYYY-Www.md`, monthly →
`reports/YYYY-MM.md`. Evidence from the ledger and meeting/work files since the
last report — numbers first, narrative second. Snapshot metric deltas into the
report so it stands alone. Flag goals with no fresh ledger data as "no new data"
rather than guessing. After saving: offer the client-email cover note
(`Library/styles/client-email.md`).

## health — the risk radar

Follow `references/health.md`. Single client: evaluate signals, set
`health/health-note/last-review` in profile.md, report tripped signals with
evidence paths. All clients (`/client health all`): evaluate every non-archived
workspace, then regenerate `Ops/pipeline.md` and `Ops/revenue.md` exactly per the
formats in health.md. Mention renewal radar items (≤45 days) even when green.

## move — lifecycle transitions

Follow `references/lifecycle.md`: validate the transition is legal, run its
checklist (each unmet item = ask or block, user can override), flip `status:` in
profile.md, append the transition to `decisions.md`, refresh pipeline if status
affects it. `archived` is never set by move — that's the archive flow.

## archive — end well, harvest everything

1. Offboard checklist (lifecycle.md): final report delivered, open actions
   resolved/transferred, assets handed over, access revoked (note in stack.md),
   `outcome:` set (renewed-prior | completed | lost | churned).
2. **Harvest** (the compounding step): extract anonymized lessons → propose
   additions to `Library/playbooks/` (user approves each); draft a case-study
   candidate → `Ops/case-studies/{slug}.md` with `consent: pending` frontmatter;
   pull final ledger numbers into the candidate.
3. Set `status: archived`, move folder to `Clients/_archive/{slug}/`, grep the
   vault for inbound links to the old path and fix them, regenerate pipeline.
