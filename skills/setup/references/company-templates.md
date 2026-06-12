# Company/ context templates

Shape guides — NOT fill-in-the-blank forms. Write each file as synthesized prose
+ tight lists from the corpus; include a section only when real data exists.
All get frontmatter: `type: context`, `status: active`, `tags`, `reviewed: {{TODAY}}`.

## profile.md — the firm

Sections, in order: **Identity** (firm name, operator(s), location, founded,
one-liner in the user's words) · **How we operate** (principles, working style,
decision habits) · **What a client experiences** (the Q1 "happy client" answer) ·
**Right now** (current season of the business, one paragraph).

## offers.md — what we sell

**Offer lines** — one `##` per offer: what it is, who it's for, price/pricing
model, what delivery looks like, typical timeline. Then **How we price**
(philosophy, floors, what changes price) and **What we don't do** (declined work
— saves every future proposal from scope creep).

## icp.md — who we serve

**Primary ICP**: role + company profile, day-to-day reality, the problem in
their words (quoted phrases), what triggers the search, what they've usually
tried first. **Real examples**: 1–3 named clients/deals that fit. **Disqualifiers**:
who we say no to and why. (Second segment → repeat as `## Secondary ICP`.)

## brand.md — how we sound and where we stand

**Voice rules** (3–7 testable lines: sentence length, jargon policy, banned
words, signature phrases) · **Positioning** (what we are, what we're instead of,
the enemy — the broken default we rescue clients from) · **Proof points**
(numbers, named results worth citing). When samples were pasted: **Calibration
examples** — 2 short before/after pairs showing the voice applied.

## strategy.md — where we're going

**This quarter** (the 1–3 priorities, each with owner and a measurable target if
given) · **This year** (the bigger bets) · **Constraints** (capacity, runway,
non-negotiables). Date-stamp the quarter heading (e.g. `## Q2 2026`) so staleness
is visible.

## team.md — roster (agency)

Table: person · role · clients touched · seat link (`[[Team/{slug}/profile|Name]]`).
Org notes (who decides what) as one short paragraph. Detail lives in `Team/`.

## stack.md — tools

Table: job-to-be-done · tool · notes (where decisions live, what's painful).
End with **Automation wishlist** — the drains from the interview, ranked. This
file is /autopilot's shopping list.
