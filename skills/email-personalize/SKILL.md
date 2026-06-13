---
name: email-personalize
description: Write human-sounding cold-email icebreakers — one per enriched lead — in the client's voice, tied to the client's offer. Reads an enriched lead list and the client's context, calibrates tone on two samples, then fans out writers and runs programmatic QC. Triggers: /email-personalize, "write icebreakers", "personalize the cold emails", "first lines for these leads", "opening lines for outreach", "personalize this lead list".
---

# Conversion OS — Email Personalize

Turns an enriched lead list into one icebreaker per lead that reads like a human
wrote it after thirty seconds on the prospect's site — then ties that observation
to the client's offer so the line earns the pitch that follows. Pairs with
`/email-sequence` (the sequence is the body; this is the opening line per lead).

The whole game is sounding human at scale. A generic "Loved what you're building
at {Company}!" is worse than no personalization — it signals a mail-merge and
burns the send. This skill's QC exists to kill exactly those lines.

Resolve the target client first: explicit arg → the client of the current
session → ask which (or "the agency's own"). Then read `Clients/{slug}/CLAUDE.md`
and obey the scope contract: never read sibling clients, the voice comes from
THIS client's `context/brand.md`, writes stay inside the workspace. For the
agency's own outreach, target `Company/` for reads and write to `Projects/{slug}/`.

## Phase 0 — Read the workspace, confirm, don't re-ask

Pull what the workspace already knows and CONFIRM in ≤5 lines — never
re-interrogate:

- **The offer** — `context/offers.md`: what the client sells and where it plugs
  in. This is the *connect-to-pitch*; every icebreaker must bridge to it.
- **The voice** — `context/brand.md`: voice rules, vocabulary, banned words. The
  icebreaker is written in the CLIENT's voice (it goes out under their name), not
  the agency's. If brand.md is thin, say so and ask for one sample line.
- **The audience** — `context/icp.md`: who these leads are and the pains that
  make a connecting observation land.
- **The lead file** — locate the enriched list. Default source is a prior
  `/lead-research` run: `work/prospecting-*/leads.csv`. Otherwise accept a pasted
  CSV / path. Confirm the enrichment columns present (company, role, signal,
  site, news, etc.) — the icebreaker can only reference data that exists.

Then check `work/` for a prior `email-personalize-*` run for this client → if
found, this is a **RE-RUN** (see below).

## Phase 1 — Calibrate on two samples (the only required question)

1. Pick two contrasting leads from the file (e.g. one rich in signal, one thin).
2. Write 2 icebreakers each, fully obeying `references/rules.md` and the client's
   voice. Show the observation each one is built on.
3. **One AskUserQuestion**: which lands, what to dial (warmer/drier, shorter,
   more/less direct about the offer). Capture the user's pick + notes as the
   *approved examples* — these ride along verbatim into every writer's prompt.
4. Persist the calibration to the deliverable's `data/calibration.md` so a re-run
   starts from the locked-in tone, not a cold guess.

## Phase 2 — Fan out the writers (parallel)

1. Create the deliverable: `work/email-personalize-{date}/` with `brief.md`
   (scope, source lead file, due, owner, acceptance = "1 icebreaker/lead, 0 QC
   fails, voice-true").
2. Batch leads into fixed groups of ~5. In ONE message, dispatch one writer
   sub-agent per batch (never sequentially). Each writer gets, verbatim:
   `references/rules.md` (the full ruleset), the approved calibration examples,
   the client's voice rules + banned words, and the offer's connect-to-pitch.
3. Each writer returns, per lead: the `icebreaker`, the one `observation` it's
   built on, and the `source_field` that observation came from (for auditability).
4. Persist each batch to `data/batch-{n}.json` as it returns — never hold results
   only in context (resilience + resumability on overflow).

## Phase 3 — Programmatic QC, then assemble

Run every line through the QC gate in `references/rules.md` (banned openers and
filler, no em-dashes, person-not-company focus, observation must connect to the
offer, length and read-aloud checks, no hallucinated facts beyond `source_field`).
Each line passes or is sent back for ONE rewrite with the specific failure; a
line that can't pass cleanly gets a blank icebreaker + a `qc_note` rather than a
fabricated one (a blank beats a tell).

Then assemble:

- **Append an `icebreaker` column** to the lead file, written to
  `work/email-personalize-{date}/final/leads-personalized.csv` (the source file
  is never mutated in place; intermediates stay in `data/`). Keep the
  `observation`, `source_field`, and `qc_note` columns alongside it so the user
  can audit and edit before sending.
- **Ledger line** to `goals.md`, exact format
  `- {date} | icebreakers-written | {n} | {pass} passed QC, {blank} blanked, ICP {version}`.
  If no `icebreakers-written` goal exists, create the definition (unit: count,
  direction: up) and flag it for the user to confirm.
- **One-line activity entry** to today's `Daily/` note `## Activity`.
- If a banned-phrase or voice pattern recurs across QC fails (e.g. the client's
  voice keeps tripping a filler word), append it — dated, flagged for
  confirmation — to `context/brand.md` banned words, so the next run starts tighter.

## Re-run — lead with what changed

On a detected prior run: load its `final/leads-personalized.csv` as the baseline.
Reuse the locked calibration from the prior `data/calibration.md` (don't re-ask
tone). Then:

- **Only-new leads**: write icebreakers for leads not in the baseline; leave
  existing lines untouched unless the user asks for a refresh.
- **Refresh**: re-personalize leads whose enrichment changed (new signal/news),
  showing old → new per line.
- Lead the deliverable with the delta: "+{n} new leads personalized, {m}
  refreshed on new signal; QC pass rate {x}% vs {y}% last run." Append the new
  ledger line so the series charts.

## Dependencies

Zero-API by default — the full skill runs from the enriched CSV the workspace
already holds plus the client's context files. No scraping or platform API is
required. If an enrichment connector is connected, it's an optional accelerator
to *top up* a thin lead's signal before writing — never a precondition.
