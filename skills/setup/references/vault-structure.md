# Vault structure spec

The canonical tree. Solo mode omits `Team/`; everything else is shared. Folders
marked *(on demand)* are created only when their first file arrives.

```
CLAUDE.md                      # root routing file — ≤120 lines, always
.claude/
  settings.json                # hooks wiring
  hooks/
    session-end-commit.sh      # git snapshot after each session
    validate-structure.sh      # advisory lint, used by /audit
  output-styles/               # (on demand) user style overrides
.claudeignore
.gitignore
Inbox/                         # capture anything; /daily triages it to its home
Company/                       # the firm's own context — slow-changing facts
  CLAUDE.md
  profile.md                   # firm + operator: who, how we work, one-liner
  offers.md                    # services, packages, pricing, delivery model
  icp.md                       # who we serve: roles, pains, triggers, examples
  brand.md                     # voice, positioning, enemy, words to avoid
  strategy.md                  # goals, current quarter focus, owners
  team.md                      # (agency) people, roles, seats summary
  stack.md                     # tools where work actually happens
  market/                      # (on demand) competitor + market notes
  standards/                   # (on demand) service quality bars, readable from client scope
Clients/                       # one self-contained workspace per client
  CLAUDE.md                    # area firewall rules
  _archive/                    # closed engagements (only folder move in the lifecycle)
  {client-slug}/               # see ../client/references/workspace.md for full spec
Projects/                      # internal, non-client initiatives
  CLAUDE.md
  {project-slug}/
    README.md                  # always; subfolders (research/ drafts/ notes/) on demand
Ops/                           # how the firm runs day to day
  CLAUDE.md
  pipeline.md                  # GENERATED book-of-business roll-up — never hand-edit
  revenue.md                   # GENERATED mrr/billing roll-up — never hand-edit
  tasks.md                     # (solo mode) the firm task board; agency uses Team/{person}/tasks.md
  meetings/                    # internal meetings: YYYY-MM-DD-{topic}.md
  decisions/                   # dated internal decisions: YYYY-MM-DD-{topic}.md
    archive/                   # (on demand) overflow from oversized context files
  case-studies/                # (on demand) harvested, consent-flagged candidates
Daily/                         # the operating log
  CLAUDE.md
  YYYY-MM-DD.md                # day log: brief, session logs, open loops
  YYYY-Www-review.md           # weekly reviews
Team/                          # (agency mode) one folder per person
  CLAUDE.md
  {person-slug}/
    profile.md                 # role, strengths, working style, contact norms
    access.md                  # clients: [slugs] — drives seat scoping
    tasks.md                   # personal task board
    daily/                     # (on demand) personal day logs
Library/                       # reusable assets — the productizable kit
  CLAUDE.md
  playbooks/                   # how we deliver each service, step by step
  templates/                   # document skeletons (reports, proposals, briefs)
  prompts/                     # reusable prompts
  styles/                      # output styles (email, report, proposal, social…)
  swipe/                       # (on demand) reference material worth imitating
Skills/                        # (on demand) per-skill user context, e.g. Skills/{name}/notes.md
```

## Universal frontmatter

Every note gets at minimum:

```yaml
---
type: # one of: context | client | client-goals | meeting | decision | report |
      # brief | daily | weekly-review | project | person | playbook | template |
      # prompt | style | task-board | case-study | note
status: active            # active | draft | on-hold | done | archived
date: YYYY-MM-DD          # when time-bound (meetings, decisions, reports, dailies)
tags: [two, minimum]
---
```

Context files (everything in `Company/` and `Clients/*/context/`, plus profiles)
add `reviewed: YYYY-MM-DD` — the date a human last confirmed the contents. `/audit`
flags anything older than 90 days.

Exempt from note frontmatter: CLAUDE.md routing files (they're instructions, not
notes). Generated roll-ups (`Ops/pipeline.md`, `Ops/revenue.md`) keep the
frontmatter their generator writes.

## Size budgets

| File | Budget | Overflow action |
|---|---|---|
| Root `CLAUDE.md` | ≤120 lines | move detail to folder CLAUDE.md |
| Folder `CLAUDE.md` | ≤50 lines (shorter is better) | prune; folder files are routing, not manuals |
| Any context file | ≤150 lines | archive oldest sections to `Ops/decisions/archive/` |
| Daily note | no limit | roll up in weekly review |

## Naming

- Folders and slugs: kebab-case (`acme-corp`, `q3-site-rebuild`).
- Dated files: ISO prefix (`2026-06-12-kickoff.md`).
- Weekly files: ISO week (`2026-W24-review.md`, `2026-W24.md` for client reports).
- A client's `client:` frontmatter field MUST equal its folder slug — it's the join
  key every roll-up and report greps on.
