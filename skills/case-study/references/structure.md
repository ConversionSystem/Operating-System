# Case-study structure — section schema, ledger→proof mapping, re-run, candidate

The procedure behind the four discovery steps in SKILL.md. Goal: a results story
where a skeptical buyer (or a competitor's lawyer) can trace every claim to a
file in the workspace. Build the evidence map first; write second.

## The evidence map (build before drafting)

For each section you intend to write, you must be able to name its source. Write
this map to `data/evidence.json` as you go — it is both your validation gate and
the audit trail a re-run reads.

| Section | Source of truth | What "no data" looks like |
|---|---|---|
| Hero metric | `goals.md` baseline + latest ledger line | no goal has both a baseline and a later observation → there is no hero metric, stop |
| Money quote | a line in `meetings/` or `decisions.md`, attributed via `context/people.md` | no real quote in the files → omit the quote block, do not invent |
| Challenge | profile `## Engagement summary` + earliest meetings + the baseline value | thin starting context → describe only what's recorded, flag the gap |
| Actions | `decisions.md` blocks + files in `work/*/final/` | a claimed action with no decision/shipped file → cut it |
| Results | later ledger lines (after the actions) + the hero metric | ledger silent after the action → "results pending", not a guess |
| Supporting metrics | other goals in `goals.md` with movement | goal with no in-window ledger data → "no new data" row |

Rule: **a section with no cited source is not written.** Mark it `[needs data]`
in the draft and surface it to the user rather than filling it with plausible
prose. One invented number discredits the whole asset — and ours is supposed to
be the trustworthy one.

## Hero metric — picking and framing it

1. Read every goal in `goals.md` frontmatter (`id`, `metric`, `unit`, `baseline`,
   `target`, `direction`).
2. For each, find the **before** and the **after**:
   - before = `baseline:` field; if absent, the earliest ledger line for that id.
   - after = the latest ledger line for that id.
3. Compute the move honestly, respecting `direction`:
   - `direction: up` — after > before is the win. Lift = `after − before`;
     percent = `(after − before) / before × 100`.
   - `direction: down` — after < before is the win (CAC/CPL/cost). Frame as a
     reduction: "CAC down 31%, $68 → $47".
   - Pick the goal with the most material, **real** move as the hero. Ties: prefer
     the metric the client cares about most (their words in `goals.md` /
     meetings), or the one closest to / past `target`.
4. **Unit-aware framing** by `unit`: `usd` → "$X → $Y"; `pct` → "X% → Y%";
   `ratio` → "X → Y" (e.g. ROAS 2.1 → 3.0); `count` → "X → Y per month";
   `hours` → "X → Y hrs". Always cite the two ledger dates ("between 2026-05-04
   and 2026-06-09").
5. **Honesty guards.** If the latest move is a regression, do not cherry-pick an
   earlier peak as "current" — that is the lie our positioning forbids. Either
   the metric isn't the hero, or the story is "held the gain through a hard
   stretch" — both true, both fine. If `target` isn't hit yet, say "on pace to /
   X% of the way to" — never imply the target was reached.

## Money quote — sourcing and attribution

- Grep `meetings/*.md` and `decisions.md` for the client describing the outcome
  in their own language (search the `## Notes`, `## Summary`, and quoted lines).
- Quote **verbatim**. Attribute to the named person and role from
  `context/people.md` (e.g. "— Dana Whitfield, Founder"). Cite the meeting file
  as the source in `evidence.json`.
- A paraphrase is not a quote. If no one said something quotable, omit the quote
  block entirely — a strong metric with no quote beats a fabricated quote.
- Respect `context/people.md` preferences: if a contact is flagged as not-for-
  attribution, use role only ("the founder") or drop the name.

## The arc — section schema

The canonical study (`final/case-study-{date}.md`) follows this skeleton. Keep it
tight — proof, not prose. Written in the **client's** `context/brand.md` voice
(or `Company/brand.md` in agency-self mode), honoring banned words and
positioning from `context/offers.md`.

```markdown
---
type: case-study
status: draft            # draft until the client/agency approves the copy
client: {slug}
date: {YYYY-MM-DD}
consent: pending         # pending | granted | declined — gates publication
tags: [client, {slug}, case-study]
---

# {Client} — {one-line outcome in their voice}

**At a glance**
- Hero result: {before → after, % move, dates}
- Timeframe: {engagement start → metric date}
- Service: {from context/offers.md}

## The challenge
{1–2 paragraphs: the starting state and the baseline. Where they were,
in numbers, and why it mattered. Sourced from profile + earliest meetings.}

## What we did
{The actions, as a short ordered list — each a real decision or shipped
deliverable, dated. From decisions.md + work/*/final/. No vague "optimized";
say what shipped.}
1. {action} — {date} ({work/ or decisions.md citation})
2. ...

## The results
{The hero metric front and center, then 1–2 supporting metrics that moved.
Each is a ledger-traced number with its dates. A small before/after table.}

| Metric | Before | After | Change |
|---|---|---|---|
| {hero} | {baseline} | {current} | {±%} |
| {support} | ... | ... | ... |

> "{verbatim money quote}"
> — {Name, Role} ({meeting citation})

## In their words / next
{Optional: where the engagement goes from here, or a forward-looking line.
Only if recorded — otherwise omit.}
```

Section order is fixed (challenge → actions → results); the quote sits inside or
just after results where it lands hardest. Omit any optional block that lacks
evidence rather than padding it.

## Validation pass (gate before generating)

Walk the draft top to bottom. For each factual claim:

- Hero/supporting number → must equal a `goals.md` ledger value (no rounding that
  flatters; cite the line).
- Quote → must appear verbatim in a `meetings/`/`decisions.md` file, attributed.
- Action → must map to a `decisions.md` block or a file in `work/*/final/`.
- Timeframe/dates → must come from frontmatter, ledger dates, or meeting dates.

Anything failing the gate is cut or marked `[needs data]` and raised with the
user. Only after the whole draft passes do you finalize. Record the pass result
(claims checked, any gaps) in `evidence.json`.

## Re-run — lead with what changed

On invocation, glob `Clients/{slug}/work/case-study-*/` (newest first). If a
prior run exists:

1. Load its `data/baseline.json` (the hero metric + value + date it captured).
2. Recompute the hero metric from the current ledger.
3. **Delta vs the prior case study** — lead the new study and your summary with
   the movement since: e.g. "Since the 2026-04 case study, ROAS held 3.0 and
   email revenue share climbed 17% → 23%." A flat or down metric is reported
   honestly ("held through a CPM spike").
4. Append the new value to `goals.md` (one ledger line, format below) and write a
   fresh `baseline.json` so the NEXT re-run charts against this one.
5. Update the existing `Ops/case-studies/{slug}.md` candidate in place rather
   than creating a second one.

`baseline.json` shape (minimal, durable):
```json
{ "goal_id": "roas", "value": 3.0, "unit": "ratio", "as_of": "2026-06-09",
  "case_study_date": "2026-06-13" }
```

## Ledger echo — exact format

Append exactly one line per the goals-ledger spec — `- date | id | value | note`,
value is a bare number:

```
- 2026-06-13 | roas | 3.0 | published in case study
```

If the case study introduces a NEW summary metric (e.g. a blended "revenue per
visitor") that has no goal, create the goal definition in `goals.md` frontmatter
first — `id`, `metric`, `unit`, `direction`, and `target`/`baseline` only if real
— then log it, and flag the new goal in your summary so the user can confirm or
correct it. **Never invent a baseline** to make a story rounder.

## Ops candidate — anonymization + consent

Write/refresh `Ops/case-studies/{slug}.md`, the same artifact `/client archive`
harvests. It is `consent: pending` and **anonymized until the user confirms
publish consent**:

- Mask the client name → an industry descriptor ("a coastal furniture brand",
  "a 40-seat B2B SaaS"). Keep the real `client:` slug in frontmatter (internal
  join key) but not in the body.
- Round or band identifying absolutes that could deanonymize ("~$X00k/yr revenue"
  not the exact figure); keep the **relative** moves (percentages, ratios) intact
  — they're the proof and aren't identifying.
- Strip person names from the body (role only) unless `context/people.md` shows
  attribution consent.
- Frontmatter records consent state so it can flip later:

```markdown
---
type: case-study
status: draft
client: {slug}             # internal join key only
consent: pending           # pending | granted | declined
consent-note: ""           # who can approve, any conditions
anonymized: true           # flips to false only after consent: granted
hero: { goal: roas, before: 2.1, after: 3.0, as_of: 2026-06-09 }
tags: [case-study, generated]
---
```

When the user confirms consent, flip `consent: granted`, `anonymized: false`, and
restore the real name/figures in the body (still firewall-safe — it's the
client's own data, written with their permission).

## Optional deck (accelerator, not default)

Only if asked. Derive every slide from the canonical markdown — same numbers,
same quote, same arc — so the deck can never drift from the validated text. Save
the pptx to `work/case-study-{date}/final/` alongside the markdown. The markdown
ships first and remains the single source of truth; the deck is a rendering of
it. No deck tool available → deliver the markdown and note the deck as a
follow-up. This is the only place a connector touches this skill, and it is
strictly optional.

## Firewall reminders (non-negotiable)

- Never read, quote, or "adapt" another client under `Clients/`. One client's
  win never appears in another's story.
- Client-facing copy = the CLIENT's `context/brand.md`. `Company/brand.md` is
  only for agency-self case studies.
- The only cross-workspace writes are the `Ops/case-studies/` candidate (an
  explicit, designed harvest path) and the one-line `Daily/` activity entry.
  Everything else stays inside the client workspace.
