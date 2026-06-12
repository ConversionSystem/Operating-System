# Audit check catalog

Severity: **fail** = breaks routing, trust, or token budget · **warn** = drift
that compounds. Fixable column = eligible for the per-category fix flow.

## C1 — Structure

| Check | Trip | Sev | Fixable |
|---|---|---|---|
| Root files | non-CLAUDE.md file at vault root | fail | yes (move to routed home) |
| Client integrity | workspace missing profile.md or CLAUDE.md | fail | yes (create from spec, ask for facts) |
| Naming | non-kebab slugs; non-ISO dated files | warn | yes (rename + fix inbound links) |
| Inbox rot | Inbox/ items >7 days | warn | yes (run triage) |
| Empty shells | 0-byte or heading-only files | warn | yes (delete after reference check) |
| Wrong-home meetings | client meetings in Ops/meetings/ (client name in title/content) | fail | yes (move into workspace) |

## C2 — Links

| Check | Trip | Sev | Fixable |
|---|---|---|---|
| Dead wikilinks | `[[target]]` resolving to nothing | fail | yes (retarget or unlink, per link) |
| Orphans | no inbound links AND not reachable from any routing file | warn | yes (link from logical parent or archive) |
| Naked entities | client/person/project names in prose without wikilink (first mention per note) — never applied inside `Library/` (adding client links there would CREATE a C5 leak) or `Inbox/` | warn | yes (add links, conservative) |

## C3 — Freshness

| Check | Trip | Sev | Fixable |
|---|---|---|---|
| Stale context | `reviewed:` >90 days on Company/ or client context | warn | no (human review list) |
| Undated context | context file without `reviewed:` | warn | yes (add field, dated today, flagged) |
| Stale health | active client `last-review` >30d | warn | no (recommend /client health all) |
| Dead projects | Projects/ untouched >60d with status: active | warn | yes (propose on-hold) |
| Stale quarter | strategy.md quarter heading in the past | fail | no (human: re-set strategy) |

## C4 — Budget

| Check | Trip | Sev | Fixable |
|---|---|---|---|
| Root size | root CLAUDE.md >120 lines | fail | no (propose a move-to-folders diff) |
| Folder size | folder CLAUDE.md >50 lines | warn | no (propose diff) |
| Context size | any context file >150 lines | warn | yes (archive oldest sections to Ops/decisions/archive/, with approval) |
| Duplication | same instruction in root + folder file | fail | no (propose which copy dies) |
| Filler | hedging/filler density in instruction files (CLAUDE.md, SKILL notes) | warn | yes (tighten, show diff) |

## C5 — Firewall (trust)

| Check | Trip | Sev | Fixable |
|---|---|---|---|
| Library leak | any `Clients/` path or client name in Library/ (exempt: the firewall rule statement in Library/CLAUDE.md) | fail | yes (anonymize or remove, shown first) |
| Cross-client | client A's name/path inside client B's workspace | fail | no (human decision — report loudly) |
| Escaped material | client engagement data in Company/, Ops/, Projects/ — client *names* are expected in ICP examples, rosters, generated roll-ups (pipeline.md/revenue.md), daily Watch/Activity lines, and entity wikilinks; scope/commercials/deliverable *content* outside the workspace is the violation | fail | yes (move into workspace) |
| Credentials | password/key/token patterns anywhere | fail | yes (redact + note where they should live) |
| Archive bleed | `Clients/_archive/` missing from .claudeignore | fail | yes (re-add line) |

## C6 — Frontmatter & data

| Check | Trip | Sev | Fixable |
|---|---|---|---|
| Missing core fields | no `type`/`status`/`tags` — exempt: CLAUDE.md routing files and raw `Inbox/` captures (triage adds frontmatter when filing) | warn | yes (infer + add, flagged) |
| Invalid enums | status/health/tier outside allowed values | fail | yes (correct with user) |
| Slug mismatch | profile `client:` ≠ folder name | fail | yes (fix field, never the folder) |
| Ledger format | goals.md lines not `- date \| id \| value \| note` | fail | yes (reformat, value-preserving) |
| Unknown goal ids | ledger id with no goal definition | fail | no (human: define or correct) |
| Generated edits | hand-edits in pipeline.md/revenue.md (content drift vs frontmatter date) | warn | yes (regenerate) |
