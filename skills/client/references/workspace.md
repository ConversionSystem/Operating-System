# Client workspace spec

The unit of the whole system: one folder, one client, one complete brain.
Created only by /client new (or seeded by /setup).

## Tree

```
Clients/{client-slug}/
├── CLAUDE.md                  # scope contract (template below)
├── profile.md                 # canonical record (schema below)
├── goals.md                   # KPI definitions + ledger — created at first goal
├── decisions.md               # append-only: ## YYYY-MM-DD — {decision} — created at first decision
├── context/
│   ├── brand.md               # THEIR voice: rules, phrases, banned words
│   ├── icp.md                 # THEIR customers: roles, pains, triggers
│   ├── offers.md              # THEIR products/services and positioning
│   ├── people.md              # client-side contacts: role, preferences, politics
│   └── stack.md               # their tools/platforms we touch (NEVER credentials)
├── meetings/                  # YYYY-MM-DD-{kind}.md
├── work/
│   └── {deliverable-slug}/
│       ├── brief.md           # scope, due, owner, acceptance criteria
│       ├── drafts/
│       └── final/
├── reports/                   # YYYY-Www.md weekly · YYYY-MM.md monthly · briefs
├── inbox/                     # raw client-supplied material awaiting triage
└── assets/                    # logos, images, binaries
```

Create `context/` files only when content exists; same for `goals.md` and
`decisions.md` (a contentless file is a placeholder — the no-placeholder rule
wins). `meetings/`, `work/`, `reports/`, `inbox/`, `assets/` are always created
with a `.gitkeep` inside (they're routing rails, and git won't carry empty
folders through clones without it).

## profile.md frontmatter schema

```yaml
---
type: client
client: acme-corp            # MUST equal folder slug — the join key
name: "Acme Corp"
status: active               # prospect | proposal | onboarding | active |
                             # paused | renewal | offboarding | archived
outcome:                     # set at archive only: renewed-prior | completed | lost | churned
tier: A                      # A strategic | B core | C transactional
owner: {person-slug}         # agency lead on the account
team: [{person-slugs}]       # everyone staffed (agency mode)
services: [{offer-slugs}]    # which Company/offers.md lines apply
billing: retainer            # retainer | project | performance | hybrid
mrr: 6500                    # USD/month equivalent; 0 for unpaid prospects
start: 2026-03-01
renewal: 2026-09-01          # next decision date (proposal due date for prospects);
                             # month-only knowledge → first of month + a "day TBD"
                             # note in Operating notes
cadence: weekly              # weekly | biweekly | monthly — reporting rhythm
health: green                # green | yellow | red — set by /client health
                             # (seeded once by /setup from interview hints)
health-note: ""              # evidence summary for the current health value
last-review:                 # last health evaluation date
last-meeting:                # maintained by /client log
links: {site: "", drive: ""}
reviewed: {{TODAY}}
tags: [client, {client-slug}]
---
```

Body sections: `# {Name}` · `## Engagement summary` (what we're hired to do, in
whose words, success criteria) · `## Scope` (in / explicitly out) ·
`## Operating notes` (approval chains, invoicing quirks, landmines).

## Per-client CLAUDE.md (scope contract — write verbatim, fill name)

```markdown
# {{Name}} — client workspace

You are {{Name}}'s strategist while working in this folder.

1. READ freely: this folder, `Library/`, `Company/standards/`, `Company/offers.md`.
2. NEVER read, quote, reference, or compare against any other folder under
   `Clients/`. Other clients do not exist in this scope.
3. Their voice lives in `context/brand.md` HERE — never use `Company/brand.md`
   for client-facing work. Agency voice is only for our own cover notes.
4. WRITE only inside this folder, plus exactly two exceptions: a one-line
   activity entry to today's `Daily/` note, and tasks to the assignee's
   `Team/{person}/tasks.md`.
5. Everything here is confidential to this engagement. Lessons leave only via
   /client harvest — anonymized, with approval.
6. Lifecycle status lives in `profile.md` frontmatter; never move this folder
   except via /client archive.
```

## Routing inside the workspace

| Fact type | Home |
|---|---|
| Commercials, staffing, scope, state | `profile.md` |
| Metric definitions + observations | `goals.md` |
| Anything decided, with reasoning | `decisions.md` |
| How they sound / who they sell to / what they sell | `context/brand.md` / `icp.md` / `offers.md` |
| Person-level intel | `context/people.md` |
| What happened in a meeting | `meetings/` (then extracted) |
| Things we make | `work/{slug}/` |
| What we tell the client | `reports/` |
| Unfiled raw material | `inbox/` → triage on next /daily or /client touch |
