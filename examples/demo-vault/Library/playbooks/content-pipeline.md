---
type: playbook
status: active
tags: [playbook, content]
---
# Playbook — content pipeline

## When to run this
Continuously: capture is always-on; qualify weekly; draft from ready cards only.

## Inputs
Idea cards (Library/templates/content-idea.md), the firm voice prompt
(Library/prompts/write-like-us.md), format style files (Library/styles/).

## Steps
1. Capture — anything resembling an idea gets a card. Triage routes stray
   ideas here. Quality bar: a hook line exists, even rough.
2. Qualify (weekly) — kill cards with no proof or no audience trigger;
   promote the rest to `status: ready`. Quality bar: you can say who it's
   for and why now in one breath.
3. Brief — ready card gets 3 lines: angle, proof, CTA.
4. Draft — firm voice via write-like-us + the format's style file. Client
   content goes through /client draft in the client's voice instead.
5. Publish + recycle — set `status: published` + URL; winners get a recycle
   note: one idea, three formats.

## Outputs
Published assets traceable back to idea cards; a recycle queue of winners.

## Common failure modes
Drafting unqualified ideas (most common) · proof-free opinion pieces ·
the ideas folder as graveyard — weekly review counts cards older than 30 days.

## Examples (anonymized only)
