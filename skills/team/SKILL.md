---
name: team
description: Roll Conversion OS out across a team — choose and set up vault sync (git, LiveSync, or Relay compared honestly), create seats with per-client access manifests, generate per-machine ignore files, and onboard/offboard team members. Triggers: /team, "share the vault with my team", "add a team member", "set up sync", "offboard", "who can see which clients".
---

# Conversion OS — Team Rollout

Three jobs: sync (files move between machines), seats (who works here), scoping
(which clients each seat sees). Solo-mode vault? First confirm switching to
agency mode (adds Team/ + updates root CLAUDE.md frontmatter + routing rows).

**Rollout order that works:** operator runs the vault solo 2–3 weeks → add the
most curious teammate, not the most senior → iterate → then the rest. Top-down
mandates fail; visible value spreads. Say this when a brand-new vault asks for
team setup.

## sync — pick one, honestly

Walk `references/sync-options.md` as a decision tree (solo multi-device vs team;
history vs realtime vs encryption; budget). Recommend ONE, state its tradeoffs
out loud, give its setup steps. Defaults: team co-editing → Relay (folder-level
sharing, free ≤3 users) with git underneath for history; git-comfortable
desktop team → git alone; privacy-first multi-device solo → LiveSync. Never mix
two whole-vault sync mechanisms on the same folder.

## seat — add a person

1. Create `Team/{slug}/`: `profile.md` (role, strengths, working style, contact
   norms) · `access.md` (below) · `tasks.md` (tasks.md format from the daily
   skill). Ask only for: name, role, clients they touch, full-time vs contractor.
2. `access.md`:
   ```yaml
   ---
   type: context
   person: {slug}
   role: member        # owner | member | contractor
   clients: [acme-corp, zenith]   # or "all"
   reviewed: {{TODAY}}
   tags: [team, access]
   ---
   ```
   Contractors: explicitly confirm each client on their list.
3. Update Company/team.md roster + the relevant client `team:` arrays.
4. Generate their scoping file per `references/seats.md`.
5. Hand them the onboarding checklist from `references/checklists.md`.

## scope — regenerate seat exclusions

For the named person (or all): read `access.md`, generate the machine-local
ignore per `references/seats.md`. State the honest limit every time: scoping
controls what the AI loads, not what a human can open — contractual
confidentiality needs the hard-partition pattern (docs/confidentiality.md).

## offboard — remove a person cleanly

1. Reassign open tasks from their `tasks.md` (ask who inherits).
2. Remove them from client `team:` arrays + Company/team.md; their owned clients
   get a new `owner:` (ask).
3. Archive `Team/{slug}/` → `Ops/decisions/archive/team-{slug}/`; log the
   offboarding in `Ops/decisions/`.
4. Remind: revoke sync access (Relay member removal / git collaborator removal /
   LiveSync credential rotation — per their sync choice) and any client-tool
   access noted in client stack.md files.

## audit — access review

Table: person × clients (from access manifests) vs reality (client `team:`
arrays). Mismatches = findings. Recommend quarterly.
