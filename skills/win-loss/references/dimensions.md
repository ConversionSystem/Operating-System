# The six analysis dimensions + lost-reason archetypes

The analytical core. Score every won and lost deal against all six lenses, then
look for the lenses where winners and losers **diverge** — those are the ones that
build the persona and the kill-list. A lens where won and lost look identical is
noise; drop it from the writeup. Every claim cites deals and quotes; nothing here
is scored from vibes.

## How to read each deal

For each deal, capture per dimension: a short value (the signal) and the evidence
behind it (deal name + a quote/date from a transcript, email, or meeting note).
Mark evidence strength — **stated** (the buyer or a note says it outright),
**inferred** (you reconstructed it from behavior), or **missing** (no evidence;
don't score it). Persona and kill-list claims should lean on stated/inferred, not
on absences.

---

## D1 — Profile (who the buyer is)

The firmographic and personographic shape of the account and the champion.

- **Company:** size (headcount/revenue band), industry/vertical, business model
  (B2B/B2C, transactional/contract), maturity (startup/scaleup/enterprise),
  region.
- **Champion:** role and seniority, whether they own the budget or have to sell
  internally, their function (the problem-owner vs a side-stakeholder).
- **Account context:** inbound vs outbound origin, referral vs cold, existing
  relationship vs net-new.

*Divergence to look for:* a headcount band, a single vertical, or a champion
seniority that wins repeatedly and loses rarely. Cross-check against the current
`context/icp.md` — confirmation strengthens it; contradiction rewrites it.

## D2 — Fit (problem ↔ offer match)

Whether what the client sells actually solves what this buyer needed.

- **Problem acuity:** was the pain urgent and named, or vague and nice-to-have?
- **Use-case match:** did the buyer's use case sit in the offer's sweet spot, or
  at an edge the product strains to cover?
- **Capability gap:** did the buyer ask for something the offer doesn't do? How
  central was it to the deal?
- **Status quo:** replacing a competitor, replacing a manual process, or buying
  net-new (each has a different win profile).

*Divergence to look for:* edge use-cases and central capability gaps cluster in
losses; sweet-spot, urgent-pain deals cluster in wins. Capability-gap losses are
honest losses — flag them so the client stops chasing the wrong fit.

## D3 — Buying behavior (how they bought)

The mechanics of the buyer's process — the strongest predictor of close, and the
one CRMs capture worst.

- **Decision structure:** single decision-maker vs committee; who else had to say
  yes; was procurement/legal/security involved.
- **Velocity:** time from first touch to decision; stalls and what unstuck them.
- **Engagement:** responsiveness, attendance at meetings, willingness to do
  homework (share data, take a trial, loop in stakeholders).
- **Evaluation rigor:** did they run a structured eval/POC, compare vendors, or
  buy on conviction?

*Divergence to look for:* fast, engaged, single-threaded deals win; deals that
went multi-threaded late, stalled in procurement, or where the champion couldn't
get a meeting tend to lose. Low engagement is the most reliable early loss signal.

## D4 — Motivation (why they bought, or didn't)

The buyer's actual driver, in their words — distinct from the use case.

- **Trigger:** the event that started the search (new hire, a failure, growth, a
  mandate, a renewal coming up elsewhere).
- **Job-to-be-done:** the outcome they're hiring the offer to produce.
- **Emotional/political driver:** career risk, internal credibility, a fire to
  put out, a number they're measured on.
- **Cost of inaction:** what happens if they do nothing — strong in wins, absent
  in "no decision" losses.

*Divergence to look for:* wins have a concrete trigger and a real cost of
inaction; "lost to no decision" almost always lacks both. This dimension is where
you find the language to put in `/email-personalize` and the offer positioning.

## D5 — Deal dynamics (the shape of the engagement)

Commercial and competitive structure of the deal itself.

- **Competition:** who else was in the deal (named competitor, in-house build,
  do-nothing); where the client won or lost on the comparison.
- **Commercials:** deal size vs the buyer's norm, pricing/packaging friction,
  discount asks, contract length.
- **Timing:** budget cycle alignment, urgency vs "next quarter," seasonality.
- **Channel/source:** which lead source or partner produced the deal (ties back
  to where the client should invest).

*Divergence to look for:* a competitor that consistently beats them (a positioning
problem to flag, not a kill-flag); a source that produces wins vs one that
produces tire-kickers; a deal-size band where win-rate falls off a cliff.

## D6 — Objections (what almost or actually broke the deal)

The friction surfaced during the sale — quoted, never paraphrased away.

- **Surfaced objections:** price, capability, trust/proof, timing, internal
  resistance, incumbent lock-in — and how (or whether) each was resolved.
- **Resolution pattern:** which objections the client reliably overcomes vs which
  reliably kill the deal.
- **Late surprises:** objections that appeared only near the close (often the real
  reason behind a "timing" loss).

*Divergence to look for:* objection *types* that appear in wins but get resolved
vs the same types that appear in losses unresolved — that gap is a sales-enablement
recommendation. Objections that only ever appear in losses are kill-list material.

---

## Lost-reason archetypes

Classify every lost deal into one archetype (its dominant cause; note a secondary
if real). Use evidence, not the CRM's dropdown. These map directly to kill-list
flags and to the "top loss: {archetype}" note in the ledger line.

| Archetype | What it looks like in the evidence | Maps to |
|---|---|---|
| **No decision / status quo** | Engaged, then went quiet; no trigger, no cost of inaction; "revisit next quarter." | D4, D3 |
| **Lost to a competitor** | Ran a comparison and chose a named alternative on price, features, or trust. | D5, D6 |
| **Lost to in-house / DIY** | Decided to build or do it manually; offer seen as replaceable. | D2, D5 |
| **Capability / fit gap** | Needed something central the offer doesn't do; honest mismatch. | D2 |
| **Price / value** | Couldn't justify the cost; ROI not landed; discount couldn't bridge it. | D6, D5 |
| **Wrong buyer / no authority** | Champion couldn't get budget or internal buy-in; never reached the decision-maker. | D1, D3 |
| **Bad timing / budget** | Real intent, genuinely wrong moment (frozen budget, reorg, off-cycle). | D5, D3 |
| **Process stall / lost momentum** | Deal died in procurement/legal/security or just lost energy mid-cycle. | D3 |
| **Poor fit, never qualified** | Should never have entered the pipeline; ICP miss from the start. | D1, D2 |

Two uses for the archetype counts: the single most common archetype becomes the
ledger note (`top loss: {archetype}`), and the archetypes that are *preventable by
better qualification* (poor fit, wrong buyer, no decision) become the strongest
kill-list flags — because those are the losses the persona is meant to stop.

## From dimensions to outputs

- **Winning persona** = the D1–D5 signals shared by the **highest-value won**
  deals (not an average of all wins). Lead with the dimensions where won/lost
  diverged hardest.
- **Kill-list flags** = lost-deal signals (any dimension) that are (a) detectable
  *before* the deal is far along and (b) backed by ≥2 cited losses. 5–8 of them,
  each with deal evidence and its archetype.
- **Strategic recommendations** = the divergences that are fixable by the client's
  go-to-market, not by qualification — a positioning gap vs a competitor (D5/D6),
  a weak lead source (D5), an objection the team keeps losing on (D6). Each
  becomes a `decisions.md` block.
