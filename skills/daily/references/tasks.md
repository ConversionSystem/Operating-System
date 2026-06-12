# Task boards — plain markdown

One board per person (`Team/{slug}/tasks.md`, agency) or one firm board
(`Ops/tasks.md`, solo). No plugin required; greppable; survives any tooling.

## Format

```markdown
---
type: task-board
owner: {person-slug or firm}
status: active
tags: [tasks, {owner}]
---
# Tasks — {owner}

## Now
- [ ] {verb-first task} — due:YYYY-MM-DD — [[Clients/{slug}/profile|Client]] #p1

## Next
- [ ] …

## Waiting
- [ ] {task} — waiting-on:{who} — since:YYYY-MM-DD

## Done (this week)
- [x] {task} — done:YYYY-MM-DD
```

## Conventions

- Verb-first, one line, one owner. Multi-step work = a project or deliverable
  brief, with ONE task pointing at it.
- Inline fields: `due:` ISO date · `#p1/#p2/#p3` priority · client/project
  wikilink when applicable · `waiting-on:` + `since:` in Waiting.
- Sources: /client log action items (assignee's board) · /daily triage ·
  meetings · the user directly.
- Movement: /daily morning surfaces overdue + p1 items; /daily evening ticks and
  carries; weekly review empties Done into the archive section at file bottom.
- Aging: anything in Now > 7 days or Waiting > 14 days gets surfaced by the
  morning brief with its age — boards are for moving, not storing.
