---
name: email-sequence
description: Design a multi-email sequence for a Conversion OS client in THEIR voice — welcome, nurture, re-engage, onboarding, or sales — ready to load into their platform. Reads the client's brand, ICP, and offers from the workspace, writes a tracked deliverable with per-email copy plus a metrics plan, and on a re-run leads with what changed. Triggers: /email-sequence, "build an email sequence", "welcome series", "nurture sequence", "re-engagement emails", "onboarding emails", "sales drip", "email flow", "write a drip campaign".
---

# Conversion OS — Email Sequence Designer

Designs a complete, send-ready email sequence inside a client workspace. Pure
design — zero API, no platform connection required. The copy comes out in the
CLIENT's voice (their `context/brand.md`), aimed at the CLIENT's audience
(`context/icp.md`), pointed at the CLIENT's ask (`context/offers.md`). Output is
a tracked deliverable under `work/`, not a throwaway draft.

Pairs with `/email-personalize` for the per-recipient icebreaker layer (this
skill designs the sequence; that one personalizes the opener of a cold send).

## Before any run

1. **Resolve the client.** Explicit arg → client of the current session → ask
   which ("or the agency's own" for our own marketing). Then read
   `Clients/{slug}/CLAUDE.md` and obey its scope contract. For agency-self,
   target `Company/` for reads and write to `Projects/{slug}/` instead of
   `Clients/{slug}/work/`. If no root `CLAUDE.md` exists, stop: "Run /setup first."
2. **Read context and CONFIRM — never re-ask what the workspace holds.** Pull
   voice from `context/brand.md`, audience from `context/icp.md`, the ask from
   `context/offers.md`, and any send/list facts from `context/stack.md`. Read
   `goals.md` so the sequence's metric plan ties to a real target. Confirm what
   you found in one line ("Voice: plain, no hype; audience: ops leads at 50–200-
   person SaaS; ask: the 14-day trial") and ask ONLY for what's genuinely absent
   (which sequence type, list/trigger, any hard offer detail not in offers.md).
3. **Check for a prior run (the re-run gate).** Glob
   `work/email-{type}-*/sequence.md` for this client+type. If one exists, this is
   a RE-RUN — see Re-run below before designing.

## Intent routing — five sequence types

| User wants | Type | Job | Length / cadence (detail in architectures.md) |
|---|---|---|---|
| Greet new subscribers, set expectations | **welcome** | Deliver the promised thing, frame the relationship | 3–7 emails, front-loaded (day 0, 1, 3, then spaced) |
| Warm a list toward an offer | **nurture** | Teach, build trust, earn the ask | 5–10 emails, every 2–4 days |
| Wake a cold/lapsed list | **re-engage** | Pattern-interrupt, confirm interest, prune | 3–5 emails, tight then a clean break |
| Activate a new customer | **onboarding** | Drive first value, reduce churn/time-to-value | 4–8 emails, milestone-triggered |
| Convert a warm prospect | **sales** | Stack proof, handle objections, create urgency | 4–7 emails, accelerating to a deadline |

If the user names a goal not a type, map it (e.g. "stop trial users dropping
off" → onboarding; "win back dead leads" → re-engage). Confirm the mapping.

## Phases (every type)

1. **Frame** — restate the type's job, the audience segment, the single
   conversion event, and the entry trigger (signup / tag / purchase / inactivity
   / manual). One sequence = one job.
2. **Architect** — lay out the skeleton from `references/architectures.md` for
   the chosen type: how many emails, each email's ONE job, the timing, and the
   branch/exit conditions. Confirm the skeleton before writing copy.
3. **Write** — for each email produce the full block (timing, subject, preview,
   body, CTA, send conditions) per the per-email spec in `architectures.md`, in
   the client's voice from `context/brand.md`. Apply the copy rules below.
4. **Instrument** — build the metrics plan (`references/architectures.md` §
   Metrics): which metric per email, the benchmark band, and the one decision
   each metric drives. Set a primary KPI for the whole sequence tied to `goals.md`.
5. **Persist** — write the deliverable, the data intermediates, and the ledger
   line (see Writes). End with the next action (load to platform / pair with
   /email-personalize / schedule a 30-day metric check).

## Copy rules (apply to every email)

- **One job per email.** If an email has two asks, it's two emails.
- **Value before ask.** Earn the click; lead with the reader's outcome, not the
  product.
- **CTA = action + outcome**, one per email ("Book your setup call → live in a
  day"), repeated once, never stacked with competing links.
- **Subject 40–60 chars; preview text distinct from the subject** (it extends,
  never repeats). Provide one primary + one A/B alternate per email.
- **Voice is the client's**, from `context/brand.md` — honor its banned words and
  phrasings. If brand.md is thin, say so and ask for one real sample before
  writing; do not improvise a voice.
- **Segment-true.** Every claim and pain must map to `context/icp.md`; no generic
  "busy professional" filler.
- Plain sentences. No manufactured urgency the offer can't back. Original copy —
  never lift competitor lines or examples.

## Re-run — lead with what changed

A prior `work/email-{type}-{date}/` exists for this client+type:
1. Load its `data/baseline.json` (sequence shape + metric targets) and any ledger
   lines for the sequence's KPI since that run.
2. Compute deltas: emails added/removed, offer or audience shifts (diff against
   the current `context/` files), and metric movement if results were logged
   ("open rate 38%→? — no fresh data" or "reply rate 4%→7% since 2026-04").
3. Write the NEW deliverable to a fresh dated folder, and open its `sequence.md`
   with a `## What changed since {prior-date}` block before the sequence itself.
   Append the new KPI value to the ledger (or "no new data" if none).
Longitudinal proof is the point — never silently overwrite the prior run.

## Writes (the differentiator — always to the workspace)

- **Deliverable** → `Clients/{slug}/work/email-{type}-{YYYY-MM-DD}/` with:
  - `brief.md` — scope, due, owner, acceptance criteria (one block; ask only for
    the missing brief facts).
  - `final/sequence.md` — overview (job, audience, trigger, exit) + one block per
    email (timing · subject + A/B · preview · body · CTA · send conditions) +
    `## Metrics to track`. (Use `drafts/` until the user signs off, then `final/`.)
- **Intermediate data** → that deliverable's `data/`: `baseline.json` (the
  sequence shape + per-email metric targets + the KPI), and `inputs.json` (the
  context snapshot you designed from). Persist as you go, not only in context.
- **Ledger line** → `goals.md`, EXACT format
  `- YYYY-MM-DD | {goal-id} | {value} | {note}`, e.g.
  `- 2026-06-13 | email-nurture | 7 | 7-email nurture for trial list, designed`.
  If no matching goal exists, create the definition (id like `email-{type}`,
  unit `count`, the sequence's primary KPI as a second goal if measurable) and
  FLAG it in your summary for the user to confirm — never invent a baseline.
- **Durable learnings** (only if real) → an audience insight uncovered while
  designing appends, dated, to `context/icp.md`; a positioning angle that worked
  appends to `context/offers.md`. Flag each for confirmation.
- **Activity** → one line to today's `Daily/` note under `## Activity`.

## Optional accelerators (gated behind "if connected")

Zero-API is the DEFAULT and the full skill works with no connector. IF the
client's ESP/CRM is connected (e.g. an email platform MCP), you MAY pull real
historical open/click/reply benchmarks to tune the metric bands, or push the
finished sequence as drafts. Never a dependency — absent a connector, use the
benchmark bands in `architectures.md` and hand off a copy-paste-ready file.

## Hard rules

- Firewall: read this client's `context/` only; never another client's sequences,
  copy, or results. Client voice comes from the CLIENT's `context/brand.md` —
  the agency's `Company/brand.md` is only for our own marketing.
- Never claim a benchmark as a guarantee; bands are planning ranges.
- One job per email, one primary CTA per email — no exceptions.
- A deliverable without a `goals.md` ledger line is an unfinished run.
- Original expression only — no copied competitor copy, structure, or brand names.
