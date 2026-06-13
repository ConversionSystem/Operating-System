---
name: case-study
description: Builds a client-results case study from a real Conversion OS engagement — hero metric pulled from goals.md (never invented), a money quote from a meeting, a challenge→actions→results arc — written canonically to the client's reports/ and harvested as a consent-flagged candidate that feeds future sales. Use when the user wants to turn a win into a case study, write a results story, document an engagement's outcome, produce a proof asset, or harvest a closing client for marketing. Triggers: /case-study, "write a case study", "turn this into a case study", "results story", "proof asset", "document this win", "we should publish this", "case study for {client}".
---

# Conversion OS — Case Study

Turns a real engagement into a results story that is **provably true** — every
number traced to `goals.md`, every quote traced to a meeting, every claim
section-validated before a word is generated. The output is canonical text in
the client's `reports/` (reusable across deck, web, deal-room) and a
consent-flagged candidate in `Ops/case-studies/` that future sales pulls from.
This is the asset competitors can't make: they have a results PDF in a downloads
folder; we have a baseline, a ledger, and the meeting where the client said it.

## Before anything

1. Resolve the target (explicit arg → current session's client → ask). Read
   `Clients/CLAUDE.md`, then the client's `CLAUDE.md` + `profile.md`. Obey the
   firewall: never read a sibling client, never pull another client's numbers or
   quotes into this story, **client voice comes from this client's
   `context/brand.md`** — never `Company/brand.md`.
2. **Read context, confirm, don't re-ask.** Pull what the workspace already
   holds and state it back: goals + ledger from `goals.md`, voice from
   `context/brand.md`, the offer/positioning from `context/offers.md`, who said
   what from `context/people.md` + `meetings/`, what we decided from
   `decisions.md`, what we shipped from `work/*/`. Only ask for what's genuinely
   absent (e.g. publish consent, a logo for a deck).
3. **Re-run check** (do this before generating). Glob
   `work/case-study-*/` for a prior run of THIS skill for THIS client. If found,
   this is a RE-RUN — load its `data/baseline.json`, compute deltas vs the hero
   metric it captured, and **lead the new study with what changed** ("ROAS held
   the gain and added 0.3 since the last case study, 2026-04"). See
   `references/structure.md` § Re-run.

If no root `CLAUDE.md` exists, stop: "Run /setup first." If `goals.md` has no
ledger observations, stop and say so — a case study with no measured before/after
is a brochure, not proof; offer to log the numbers first via `/client log`.

## Agency-self mode

The agency can write its OWN case studies. Then reads come from `Company/`
(`Company/brand.md` is the correct voice here) and the source engagement is an
archived client in `Clients/_archive/{slug}/` plus its harvested candidate in
`Ops/case-studies/{slug}.md`. Output goes to `Projects/{slug}/` instead of a
client's `work/`. Everything else below is identical.

## Flow

Run the four discovery steps, **validate every section against evidence**, THEN
generate. "No data" beats a guess at every step — an empty results column is
honest; an invented one is the one lie that discredits the whole asset.

1. **Hero metric — from the ledger, not invented.** Pick the goal with the
   strongest, real before→after from `goals.md`: baseline (the `baseline:` field
   or earliest ledger line) → current (last ledger line), framed by
   `direction`. Compute the lift honestly (absolute and percent; for
   `direction: down`, a fall is the win). Cite the exact ledger dates. If no goal
   has both a baseline and a later observation, there is no hero metric — say so.
2. **Money quote — from a meeting, attributed.** Grep `meetings/` and
   `decisions.md` for the client saying the outcome in their words. Quote
   verbatim, attribute to the named person from `context/people.md`, cite the
   meeting file. No real quote → omit the quote block; never fabricate or
   paraphrase-into-quotes.
3. **The arc — Challenge → Actions → Results.** Challenge from the engagement's
   starting state (profile `## Engagement summary`, earliest meetings, the
   baseline). Actions from `decisions.md` + shipped `work/*/final/` (what we
   actually did, with dates). Results from later ledger lines + the hero metric.
   Each action ties to a result where the evidence connects them.
4. **Validate, then draft.** Walk each section; any claim without a cited source
   (ledger line, meeting, decision, shipped file) is cut or marked
   `[needs data]`. Then write the markdown in **this client's voice**
   (`context/brand.md` rules + banned words), positioned via `context/offers.md`.

Detail — section schema, the ledger→proof mapping, anonymization, and the deck
option — lives in `references/structure.md` (one hop).

## Writes (the differentiator — never skip)

Persist as you go; never hold the only copy in context.

- **Canonical study** → `Clients/{slug}/work/case-study-{date}/final/case-study-{date}.md`
  (the reusable text — deck, landing page, and deal-room all derive from it).
  Create the deliverable folder with `brief.md` (scope, due, owner, acceptance:
  "every metric ledger-traced, every quote meeting-traced, voice = client") if
  absent.
- **Intermediates** → that deliverable's `data/`: `evidence.json` (hero metric +
  ledger citations, quote + source, action→result links) and `baseline.json`
  (the hero metric snapshot a future re-run charts against). Written to disk as
  gathered.
- **Ledger echo** → append the headline metric as one `goals.md` line in the
  EXACT format `- YYYY-MM-DD | {goal-id} | {value} | published in case study`.
  This re-confirms the number and timestamps the proof. If the case study coins
  a NEW summary metric with no goal, create the goal definition first and flag it
  for the user to confirm (never invent a baseline).
- **Consent-flagged candidate** → `Ops/case-studies/{slug}.md` with
  `consent: pending` frontmatter (anonymized per `references/structure.md` until
  consent flips to `granted`). This is the same artifact `/client archive`
  harvests, so a study written mid-engagement and one written at offboard land in
  one place. If a candidate already exists, update it in place; don't duplicate.
- **Activity line** → one line to today's `Daily/` note under `## Activity` (a
  firewall-whitelisted cross-workspace write).
- **Optional deck** → `work/case-study-{date}/final/` (pptx) only if asked; the
  markdown is always canonical and ships first.

## Hard rules

- A number not in `goals.md` does not go in the case study. Invent nothing.
- A quote not in a meeting/decision file is not a quote. Attribute or omit.
- Client-facing copy uses the CLIENT's `context/brand.md` voice and respects its
  banned words; agency-self studies use `Company/brand.md`.
- The candidate in `Ops/case-studies/` is `consent: pending` and anonymized
  until the user confirms publish consent — names and identifying figures masked.
- Zero-API by default — everything here is built from the workspace. A deck
  generator (pptx) or a screenshot/asset connector is an OPTIONAL accelerator,
  never required.
- Never read or cite another client. The firewall is the product.
