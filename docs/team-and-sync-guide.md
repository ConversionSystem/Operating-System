# Conversion OS — Team & Sync Guide

How a vault goes from one machine to a team — without corrupting it, leaking
between clients, or mandating tools people resent.

## The rollout order that works

1. **Operator solo, 2–3 weeks.** Habits first. A half-adopted vault rolled out
   to a team is a graveyard with folders.
2. **Most curious teammate next** — not the most senior. Let them poke holes;
   fix the holes; their results recruit the room.
3. **Then the rest**, each with the day-one checklist (`/team seat` produces it).

## Choosing sync (run `/team` for the guided version)

| Your situation | Use | Cost | The honest catch |
|---|---|---|---|
| One machine | nothing (local git is your history) | $0 | back the folder up like any folder |
| Solo, multi-device, privacy-first | LiveSync (self-hosted, E2EE) | ~$0–5/mo | you run a small server; one credential |
| Solo or small team, desktop, git-literate | git plugin + private repo | $0 | ~10-min sync lag; occasional manual merges; weak mobile |
| Team that co-edits | Relay (CRDT real-time, folder-level shares) — keep git underneath for history | free ≤3 users → ~$6–18/user/mo | not E2E-encrypted; whole team stays on the same plugin version |

Hard rule: **one whole-vault sync mechanism per folder.** Two (e.g. iCloud +
git, or LiveSync + Relay on the same folders) will eventually corrupt the vault.

### Git notes (most common team choice)
Private repo · plugin set to commit+pull ~10 min, merge not rebase · each member
sets their own author identity (accountability) · the setup-generated
`.gitignore` already excludes `.obsidian/workspace*` (the #1 conflict source).

### Relay notes (co-editing teams)
Share folders selectively: `Company/`, `Library/`, `Ops/` to everyone; each
client folder only to its account team (mirrors the access manifests); `Daily/`
and `Team/{self}/` stay private. Folder-level shares are Relay's real access
control — our seat manifests are the source of truth for who gets which share.

### LiveSync notes (privacy-first solo)
Deploy CouchDB on a free tier, enable E2EE, share the passphrase out-of-band,
calendar a quarterly database rebuild (it grows by design).

## Seats and scoping (agency mode)

- `Team/{person}/access.md` lists the clients that seat works on — the single
  source of truth.
- `/team scope {person}` on that person's machine generates their local ignore
  entries so Claude simply never loads other clients.
- **What this is:** attention scoping + accidental-leak prevention.
  **What this is not:** security. A human whose sync delivers a file can open
  it. For NDA-grade walls, see the hard partition in
  [confidentiality.md](confidentiality.md).
- Quarterly: `/team audit` — manifests vs reality.

## Onboarding / offboarding

Both checklists live in the team skill and are produced by `/team seat` and
`/team offboard`. The two rules that matter most:

- **Onboarding:** the new seat reads `Clients/CLAUDE.md` (the firewall) before
  touching any client folder, and runs `/client brief` on each assigned account
  — ten minutes per client replaces a week of shoulder-tapping.
- **Offboarding:** sync access is revoked FIRST, then tasks reassigned, then
  client-tool access from each `context/stack.md`, then the seat archived. Same
  day, in that order.
