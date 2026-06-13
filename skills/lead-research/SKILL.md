---
name: lead-research
description: Source a scored, tiered prospect list for a Conversion OS client from THEIR ICP — multi-pass discovery, validation, and enrichment, then a transparent three-axis score (ICP-fit, timing, accessibility) sorted Hot/Warm/Cold. Writes a tracked deliverable, persists raw research, and logs the run to goals.md so the next run charts against it. Triggers: /lead-research, "build a prospect list", "source leads", "find prospects", "who should we target", "net-new pipeline", "find companies matching the ICP", "re-run prospecting".
---

# Conversion OS — Lead Research

Builds a net-new prospect list for ONE client (or the agency itself) from the
ICP the workspace already holds — never a generic scrape. The deliverable lands
in the workspace, the raw research is kept on disk, and the run is logged so the
second run leads with what changed. Zero-API is the default path; connectors
only make it faster.

If no vault exists (no root CLAUDE.md), stop: "Run /setup first."

## Resolve target & scope (do this first, every time)

1. **Whose list?** explicit arg → the client of the current session → ask
   (offer "the agency's own" for our own lead gen). Slug it.
2. **Client** → read `Clients/{slug}/CLAUDE.md` and obey the scope contract:
   never read sibling clients, never let one client's data into another's list.
   Deliverable root = `Clients/{slug}/work/`.
   **Agency-self** → read `Company/`; deliverable root = `Projects/{slug}/`
   (a `prospecting/` project), ICP from `Company/icp.md`, offers from
   `Company/offers.md`. Everything below is identical bar the paths.

## Read before you ask — then CONFIRM

Load and echo back, don't re-interrogate:
- `context/icp.md` → the scoring criteria. Parse it into the rubric inputs:
  fit signals, disqualifiers, buying triggers (see `references/rubric.md`).
- `context/offers.md` → what we'd pitch them; drives the *accessibility* axis
  and the angle note per prospect.
- `goals.md` → if a `prospects-sourced` (or similar pipeline) goal exists, this
  run feeds it; note current value for the ledger.
- `context/people.md` (if present) → existing contacts/relationships raise
  accessibility; don't re-source someone already in the book.

Confirm in one line — "Sourcing 30 prospects for {client} against ICP v{date}:
{tier-A role} at {segment}, triggers {x,y}, disqualify {z}. Pitching {offer}.
Right?" — and only ask for what's genuinely absent (target count, any segment
focus, geography). If `icp.md` is thin, say so and ask for one or two anchor
accounts to pattern-match from rather than inventing criteria.

## RE-RUN — check this BEFORE sourcing

Glob `{work-root}/prospecting-*/` for a prior run of THIS skill for THIS client.
If found, this is a re-run — load `data/baseline.json` from the most recent and:
- **Exclude** already-sourced companies from discovery (dedupe on domain) so the
  list is net-new — but re-score any prior prospect whose signals changed.
- **Compute deltas**: new prospects found, tier movement on carried-over
  accounts (a Warm that just raised → Hot), prospects that went stale.
- **Lead the new deliverable with the delta** ("+18 net-new, 5 Warm→Hot on fresh
  funding, 2 DQ'd since 2026-05"), not a cold re-listing.
- Append the new count to the ledger as a fresh line (never edit the old one).
No prior run = baseline run; say so and the next run will chart against it.

## Phases (detail in references/passes.md)

Three passes, persisting to disk as you go (resilience + resumability):

1. **Discovery (wide)** — turn the ICP into web/LinkedIn-via-search queries; cast
   wide for candidate companies. Write raw hits to `data/discovery.json` as
   gathered. Aim ~2–3× the target count (validation will cull).
2. **Validation (filter)** — confirm each candidate is real, in-segment, and not
   already a client/contact; drop dupes and out-of-ICP. Write
   `data/validated.json`. For >10 survivors, fan out fixed batches in ONE
   message (see Parallelism).
3. **Enrichment (depth)** — for survivors, gather the signals the rubric scores:
   funding/hiring/tech/news/leadership + a reachable contact. Write
   `data/enriched.json`. Then **score** every prospect on the three axes and
   assign a tier.

## Scoring (full rubric in references/rubric.md)

Three independent axes, **1–10 each**, summed to a 3–30 total. Always show the
per-axis math — never a black-box number.
- **ICP-fit** — how cleanly they match `icp.md` (segment, role, size, model).
- **Timing-signal** — fresh buying triggers (funding, hiring for the pain,
  leadership change, tech adoption, public intent).
- **Accessibility** — how reachable/winnable (warm path, contact found, no
  incumbent lock-in, our offer fits their stage).

Tiers: **Hot 24–30 · Warm 16–23 · Cold 8–15 · DQ ≤7**. A disqualifier match
caps ICP-fit at 3 (which usually lands the row in Cold/DQ) — record which
disqualifier fired.

## Parallelism & zero-API

- **Fan-out** for >10 items: dispatch fixed batches (~10/agent) in ONE message,
  never sequentially. Use `sales:lead-researcher` agents if available, else the
  default. Each batch writes its own `data/*.partN.json`; merge after.
- **Zero-API is the default.** Discovery + validation + enrichment all work from
  WebSearch/WebFetch and manual exports. A scraping connector, LinkedIn export,
  or enrichment API is an OPTIONAL accelerator — gated behind "if connected",
  never a hard dependency. See the "if connected" blocks in `passes.md`.

## Writes (the differentiator — do all four)

To `{work-root}/prospecting-{date}/`:
1. **Deliverable** — `final/leads.csv` (one row/prospect, scored columns) plus
   `final/companies.csv` + `final/contacts.csv` splits, and `final/summary.md`
   (tier counts, the delta lead on re-runs, top-10 with the angle + why-now).
   Create `brief.md` (scope, target count, due, owner, acceptance) on first run.
2. **Intermediates** — `data/discovery.json`, `data/validated.json`,
   `data/enriched.json`, `data/baseline.json` (the scored snapshot the next
   re-run diffs against). Persisted as gathered, not held only in context.
3. **Ledger** — append to `goals.md`, EXACT format
   `- {date} | prospects-sourced | {n} | {hot} hot`. If no matching goal exists,
   create the definition (id `prospects-sourced`, `unit: count`, `direction:
   up`) and flag it in your summary for the user to confirm.
4. **Learnings** — durable ICP signals discovered while sourcing (a segment that
   over-indexed for fit, a trigger that reliably predicted Hot) → an append-only,
   dated note in `context/icp.md`, flagged for confirmation. Never silently
   rewrite the ICP.

Plus the one allowed cross-workspace write: a one-line entry to today's
`Daily/` note under `## Activity` ("Sourced 30 prospects for {client}, 7 Hot").

## Firewall (non-negotiable)

- Never read or quote another client's workspace into this list.
- ICP and offers come from THIS client's `context/` (or `Company/` for
  agency-self) — never borrow a sibling's.
- Writes stay inside this workspace, except the single Daily activity line above.
- Source contact data from public/permissioned sources only; never paste
  credentials or scraped private data into the workspace.

## Hard rules

- A scored row without a cited source for its timing signal is a guess — leave
  the axis low and note "no signal found", never inflate.
- Borderline (within 1 pt of a tier line) rounds toward the LOWER tier; say so.
- Dedupe-flag against the existing book (people.md / prior runs); don't re-pitch
  someone already engaged.
- Never invent funding/headcount/news — unverified enrichment is blank, not a
  plausible-sounding fabrication.
