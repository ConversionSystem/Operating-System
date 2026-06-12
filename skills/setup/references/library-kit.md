# Library starter kit

Created during Phase 3. Two parts: universal seeds (always) and personalized
seeds (only when the corpus supports them). Frontmatter on all: `type:
playbook|template|prompt|style`, `status: active`, `tags`.

## Universal seeds (write verbatim-ish, adjusted to firm voice)

### Library/templates/meeting-note.md
Skeleton: frontmatter (`type: meeting`, `date`, `client` or `internal`,
`attendees`) · `## Summary` (3 lines max) · `## Decisions` (one per line, each
"DECIDED: x — because y") · `## Actions` (checkboxes: `- [ ] action — owner —
due`) · `## Notes` (the rest) · `## Open questions`.

### Library/templates/client-report-weekly.md
Skeleton: frontmatter (`type: report`, `client`, `date`, period) · `## Wins` ·
`## Metrics` (table: goal · baseline · current · target · trend arrow) ·
`## Shipped` · `## Next period` · `## Needs from you` (client asks, each with a
deadline). Tone note: report in the FIRM's voice, evidence from the ledger.

### Library/templates/client-brief.md
Skeleton: `## State of play` (one paragraph) · `## Momentum` (last 3 ledger
moves + last meeting outcome) · `## Risks` (health signals tripped) · `## Open
loops` (unchecked actions with ages) · `## Recommended next actions` (3, concrete).

### Library/templates/proposal.md
Skeleton: `## The situation` (their words) · `## What success looks like`
(measurable) · `## The plan` (phases, what happens when) · `## Investment`
(from offers.md patterns) · `## Why us` (positioning + proof points) ·
`## Next step` (one action, one date).

### Library/templates/playbook.md
Skeleton for documenting a service: `## When to run this` · `## Inputs` ·
`## Steps` (numbered, each with owner + quality bar) · `## Outputs` ·
`## Common failure modes` · `## Examples` (anonymized only).

### Library/styles/ — four starter styles
`client-email.md` (short, warm, one ask per email, subject = the ask) ·
`report.md` (evidence-first, no adjectives without numbers) ·
`proposal.md` (their words for the problem, our words for the plan) ·
`social-post.md` (hook in line 1, one idea per post, firm voice rules apply).
Each style file: Identity (1 line) · Rules (5–8) · One short example.

## Personalized seeds (corpus-dependent)

- **One playbook per core offer** named in offers.md:
  `Library/playbooks/{offer-slug}.md` using the playbook skeleton, filled with
  whatever delivery detail the interview/corpus gave. Thin is fine — mark
  `status: draft` and list it on the report card as a top-up.
- **Voice calibration prompt**: `Library/prompts/write-like-us.md` — the brand.md
  voice rules condensed into a reusable prompt block.
