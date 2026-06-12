# Team onboarding / offboarding checklists

## New seat — day one (give this to the person)

- [ ] Tools: Claude (Code or Cowork) signed in · Obsidian installed
- [ ] Vault access via the firm's sync (Relay invite accepted / repo cloned /
      LiveSync joined) — from `/team seat` output
- [ ] Open the vault folder; confirm root CLAUDE.md loads in a fresh session
- [ ] Run `/team scope {me}` on this machine (seat exclusions generated)
- [ ] Read: root CLAUDE.md · Company/profile.md · Company/brand.md ·
      Clients/CLAUDE.md (the firewall — this one's a contract, not a suggestion)
- [ ] For each assigned client: `/client brief {slug}` (10 minutes per client
      replaces a week of tribal knowledge)
- [ ] First ritual: `/daily` tomorrow morning; `/daily save` before closing
- [ ] Know the two whitelisted writes from client scope (daily activity line,
      task assignment) — everything else stays in the workspace

## New seat — operator's side

- [ ] `Team/{slug}/` created (profile, access, tasks) · roster + client `team:`
      arrays updated
- [ ] Sync access granted matching access.md exactly (Relay shares / repo
      collaborator / credentials)
- [ ] Contractor? Each client on their list explicitly confirmed; NDA clients
      checked against the hard-partition list
- [ ] First-week buddy named for vault questions

## Offboarding — same day, in order

- [ ] Sync access revoked FIRST (Relay member removed / repo collaborator
      removed / LiveSync credential rotated)
- [ ] Open tasks reassigned · owned clients get a new `owner:`
- [ ] Client-tool access from each assigned client's `context/stack.md` revoked
- [ ] `Team/{slug}/` archived; departure logged in `Ops/decisions/`
- [ ] If they had `role: owner`: rotate anything secret referenced in stack
      files, audit access manifests (`/team audit`)
