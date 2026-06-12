---
type: template
status: active
tags: [template, meeting]
---

# Template — meeting note

File as `meetings/YYYY-MM-DD-{kind}.md` (kinds: kickoff, weekly, review,
escalation, renewal, ad-hoc). Frontmatter on the note:

```yaml
---
type: meeting
status: done          # draft while it's a prep stub
date: 2026-06-12      # the meeting date
client: acme-corp     # or `internal: true` for Ops meetings
attendees: [Maya Chen, Jane Doe]
tags: [client, acme-corp, meeting]
---
```

## Summary

Three lines max. What moved, what stalled, what changed.

## Decisions

One per line, each written as: DECIDED: x — because y. Every decision here
also gets appended to the workspace decisions.md, dated.

## Actions

Checkboxes, one per line: `- [ ] action — owner — due YYYY-MM-DD`.
Assignee's copy goes to their task board; the checkbox here is the record.

## Notes

Everything else worth keeping: numbers quoted, objections raised, mood,
context. Write it so the next meeting's prep can be built from it.

## Open questions

Unresolved items that are nobody's action yet — each one either becomes an
action next meeting or gets dropped deliberately.
