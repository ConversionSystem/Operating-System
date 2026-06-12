# Daily + weekly note formats

## Daily note — `Daily/YYYY-MM-DD.md`

```markdown
---
type: daily
date: YYYY-MM-DD
status: active
tags: [daily, log]
---
# YYYY-MM-DD

## Top 3
1. {move} — {why it's top-3 today}
2. …
3. …

## Calendar-shaped
- {report due / renewal radar / meeting to prep} → `/client {flow} {slug}`

## Open loops
- {item} — {age}d — {owner}

## Watch
- 🔴/🟡 [[Clients/{slug}/profile|Name]]: {health-note}

## Activity
<!-- one-liners appended from client scope and autopilot runs -->

## Sessions
<!-- appended by /daily save -->
### {HH:MM} — {topic}
Decisions: … · Files: … · Open loops: …

## Evening close
{vs Top 3: done/moved/dropped} · {lesson, if any}
```

Morning brief = everything above `## Activity`, freshly composed — argued, not
templated ("Top 3 #1 is the Acme report because it's due today and Acme is
yellow"). Sections with nothing real are omitted (no empty headings).

## Weekly review — `Daily/YYYY-Www-review.md`

```markdown
---
type: weekly-review
date: YYYY-MM-DD
status: active
tags: [weekly, review]
---
# Week Www review

## Wins
- {win} — evidence: [[path]]

## What dragged
- {pattern observed across the week's dailies}

## Client cadence check
| Client | Cadence | Report sent? | Meeting held? | Notes |

## Hygiene
- health checks stale? → /client health all
- context files with reviewed: >90d → {list}

## Next week's Top 3 candidates
1–3 with reasoning, feeding Monday's brief.
```
