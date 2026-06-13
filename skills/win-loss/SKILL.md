---
name: win-loss
description: Win/loss analysis for a Conversion OS client — turn their own closed deals into a winning-customer persona and an evidence-backed kill-list of disqualifying red flags. Reads the client's CRM export, people, and meeting history, segments won vs lost, finds the patterns across six dimensions, and writes the persona back into the workspace so qualification, prospecting, and outreach all sharpen. Triggers: /win-loss, "win loss analysis", "why are we losing deals", "what does a won deal look like", "analyze our closed deals", "winning persona", "build a kill list", "lost deal patterns".
---

# Conversion OS — Win/Loss Analysis

The CRM knows who won and lost; it almost never knows *why*. This skill mines a
client's own closed deals to answer two questions their pipeline can't: what does
a deal we WIN actually look like, and what are the red flags that predict a LOSS?
The output isn't a slide that dies in a folder — it's a winning persona written
into `context/icp.md` and a kill-list that every downstream skill (`/lead-qualify`,
`/lead-research`, `/email-personalize`) reads on its next run.

Resolve the target client first (explicit arg → current session's client → ask).
Read `Clients/{slug}/CLAUDE.md` and obey the firewall: no sibling-client reads,
the client's own data only, writes stay in this workspace. For the agency's own
deals, target `Company/`/`Ops/` and write the deliverable to `Projects/{slug}/`.
If no root `CLAUDE.md`, stop: "Run /setup first."

## Phase 0 — Read the workspace, confirm, never re-ask

Pull what the workspace already holds and confirm in ≤6 lines:
- `context/icp.md` — the current hypothesis of who they sell to (we're about to
  validate or rewrite it from real outcomes).
- `context/offers.md` — what they pitch, price points, where our work plugs in.
- `context/people.md` — client-side contacts and any deal politics already logged.
- `goals.md` — close-rate / revenue goals these patterns connect to.
- `meetings/` — sales-call and review transcripts already in the workspace.

**Re-run check (do this before anything else).** Glob `work/win-loss-*/` for a
prior run. If found, this is a RE-RUN: load its `data/baseline.json`, and lead the
new deliverable with deltas — close-rate movement, won/lost counts since the last
baseline, persona drift, new or retired DQ flags. See `references/outputs.md`.

## Phase 1 — Get the deals + audit field reliability

1. **Source the deals** (zero-API default): a CRM CSV export of closed deals
   (won + lost) with whatever columns exist — name, value, stage, close date,
   owner, source, and a "lost reason" if the CRM captures one. Accept a paste or
   a file in `inbox/`. Persist the raw export to `work/win-loss-{date}/data/`.
2. **Audit the lost-reason field before trusting it.** Count populated, non-junk
   values across lost deals. **If <30% are populated, or they collapse to generic
   buckets ("no budget", "timing", "went dark"), IGNORE the field** and infer
   loss reasons from evidence — transcripts, email threads, meeting notes. A
   reliable field is a shortcut; an unreliable one is a liar. State which path
   you took and why in the report.
3. **Segment** won vs lost; within each, rank by deal value. Flag the **top 5 by
   value** in each segment for deep enrichment; the tail gets lighter treatment.

> Optional accelerators, gated behind "if connected" — never required:
> a CRM connector to pull deals instead of a CSV; email/transcript connectors to
> enrich reasons at scale. Probe what's actually available; if nothing is wired,
> the CSV + workspace-meetings path is complete on its own.

## Phase 2 — Parallel enrichment

For >10 deals, fan out enrichment in fixed batches in ONE message (never
sequential). Each enrichment agent, per deal: gather evidence from the meeting
transcripts in `meetings/`, any email thread (if a connector is wired), and a
light web check on the buyer's company (size, industry, recent signals). Go
**deep on the flagged top-5 per segment** (full reason reconstruction, quoted
objections), **light on the tail** (firmographics + outcome only). Write each
enriched deal record to `data/deals.json` as you go — disk, not just context, so
the run is resumable.

## Phase 3 — Pattern across the six dimensions

Score every won and lost deal against the six lenses in
`references/dimensions.md` (profile, fit, buying behavior, motivation, deal
dynamics, objections). Then find where won and lost **diverge** — a dimension
only matters to the persona or the kill-list if winners and losers separate on
it. Show the math: for each pattern, cite how many deals of each segment carry
it and at least one quoted/dated piece of evidence. A pattern without cited deals
behind it doesn't go in the report.

## Phase 4 — Persona + kill-list, then write the loop

1. **Winning persona** — synthesized from the **highest-value WON deals**, not an
   average of everyone. Who they are, what made them buy, the shape of the deal.
2. **Kill-list** — 5–8 disqualifying red flags, each tied to lost-deal evidence
   ("appeared in 4 of 6 losses; see deal X transcript"). Map each flag to the
   lost-reason archetypes in `references/dimensions.md`.
3. **Write the deliverable and close the loop** per `references/outputs.md`:
   the analysis to `work/win-loss-{date}/final/analysis.md`; the winning persona
   appended as a dated `## Winning persona` section in `context/icp.md`; one
   `goals.md` ledger line; each strategic recommendation as a `decisions.md`
   block; one activity line to today's `Daily/` note. Optional polished deck to
   `work/win-loss-{date}/final/`.

## Format & budgets

Standard SKILL.md: lean body here, detail in `references/` (one hop). Deliverable
files carry universal frontmatter (`type`, `status`, `date`, `tags`); context and
ledger writes follow the workspace schemas exactly. Keep `context/icp.md` under
its 150-line budget — if the persona section pushes it over, archive the oldest
section per the vault overflow rule. Never invent a metric the deals don't
support; "evidence too thin to call" beats a confident guess.
