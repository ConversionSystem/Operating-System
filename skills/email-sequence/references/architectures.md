# Email sequence architectures

The design library for `/email-sequence`. Five sequence types, each with a
skeleton (email-by-email jobs, timing, branches), then the universal per-email
block spec and the metrics plan. All original — author copy fresh in the
client's voice; never reuse competitor structure, examples, or numbering.

Read the type the user chose, lift its skeleton, then fill each email's ONE job
with copy from `context/brand.md` (voice) + `context/icp.md` (audience) +
`context/offers.md` (ask). Lengths are ranges — pick the shorter end unless the
offer or audience justifies more (more emails ≠ more conversion; relevance does).

---

## Universal design law (all types)

- **One sequence = one conversion event.** Name it before writing (book a call /
  start a trial / first product action / reply / reactivate). Every email bends
  toward it.
- **One email = one job.** A second ask is a second email. The job is what the
  reader should think, feel, or do by the end of THIS email.
- **One primary CTA per email**, an action + its outcome, repeated at most once
  (top-ish and bottom), never competing with a second link.
- **Value before ask.** The first half of every email pays the reader before it
  asks anything.
- **Timing serves attention, not the calendar.** Front-load when interest is
  hottest (right after the trigger), then widen the gaps. Respect the reader's
  timezone send window if known from `context/stack.md`.
- **Every email earns the next open.** Close loops the next email reopens; the
  preview text is a promise the body keeps.
- **Exit on success.** The moment the reader converts, they leave the sequence —
  never keep selling something they already bought.

---

## 1. Welcome (3–7 emails)

**Job:** deliver the thing they signed up for, set expectations, and turn a
fresh subscriber into someone who opens email #2. Highest-engagement window the
list will ever have — use it. **Trigger:** new subscribe / opt-in / magnet
download. **Conversion event:** the first small "yes" (consume the asset, follow
on one channel, or a soft offer click). **Exit:** sequence end → moves to the
default nurture cadence.

| # | Day | Job of this email |
|---|---|---|
| 1 | 0 (instant) | Deliver what was promised + set the relationship: who you are, what to expect, how often. One link: the asset. |
| 2 | 1 | The origin / "why this matters" — the belief behind the brand. Builds trust, no ask beyond a reply prompt. |
| 3 | 3 | The quick win — one usable insight or step they can act on today. Proves the list is worth opening. |
| 4 | 5–6 | Social proof / who this is for — a short result or story that mirrors the reader (`icp.md`). Soft CTA to the core offer. |
| 5 | 8–10 | The soft offer — name the paid next step as a natural fit, low pressure, one clear CTA + outcome. |
| (6) | 12–14 | Objection / FAQ — answer the top hesitation honestly; restate the CTA. *(Add for considered/higher-price offers.)* |
| (7) | 16–18 | Bridge to nurture — "here's what's coming," set the ongoing rhythm. *(Add for content-led brands.)* |

**Branches:** if they take the soft offer in #4–5, exit to onboarding (don't send
the rest of the pitch). If they open zero of #1–3, the re-engage logic applies
later. Keep 3 emails for a simple list, 5 for an offer-led list, 7 for a
content brand.

---

## 2. Nurture (5–10 emails, every 2–4 days)

**Job:** take an aware-but-not-ready reader and earn the right to ask. Teach
something real, shift one belief, then make the offer feel like the obvious next
move. **Trigger:** welcome complete, or a content/topic tag. **Conversion
event:** book a call / start a trial / request a demo. **Exit:** on conversion,
or to a long-term newsletter cadence if they don't bite.

| # | Cadence | Job of this email |
|---|---|---|
| 1 | day 0 | Name the problem in the reader's words (`icp.md`) and the cost of leaving it. Pure value, no ask. |
| 2 | +2–3d | Reframe — the usual approach is flawed *because*; introduce the better mental model. |
| 3 | +2–3d | Proof the model works — a case, a number from `goals.md`, a mechanism. Plants the offer as the vehicle. |
| 4 | +3–4d | The offer, framed as the model made real. Full CTA + outcome. First true ask. |
| 5 | +3–4d | Objection #1 (price/effort/risk) handled with evidence, not adjectives. Restate CTA. |
| 6 | +3–4d | Objection #2 + a different proof angle (different persona or outcome). |
| (7–9) | +3–4d each | Deepen: a contrarian take, a teardown, a "day in the life with vs without." Each ends on the same CTA. *(Add for longer consideration cycles.)* |
| last | +4d | Soft deadline or summary — recap the stakes, the offer, the one action. Clean close. |

**Branches:** clicked the offer but didn't convert → drop into a 2-email sales
mini-sequence (type 5). Replied with a question → exit to a human. No opens in 3
consecutive → suppress and route to re-engage. Build 5 for a simple/low-price
offer, 7–8 standard, 10 only for high-consideration B2B.

---

## 3. Re-engage (3–5 emails, tight then a clean break)

**Job:** find out who's still alive on a cold or lapsed list, get one signal of
life, and cleanly prune the rest (a smaller engaged list beats a big dead one —
it protects deliverability for everyone else). **Trigger:** N days of zero
opens/clicks, or lapsed customer. **Conversion event:** any open/click/reply —
or an explicit "keep me." **Exit:** re-engaged → back to nurture; silent after
the last → suppress/sunset.

| # | Day | Job of this email |
|---|---|---|
| 1 | 0 | Pattern interrupt — short, honest, curiosity subject ("Did we lose you?"). Acknowledge the silence, offer one reason to stay. One low-friction CTA (a single click). |
| 2 | 3 | The "what you missed" — the single best thing since they went quiet, reframed as their gain. |
| 3 | 6 | A genuine incentive or a direct question ("Still the right fit?"). Make replying the easiest path. |
| (4) | 9 | The "is this goodbye?" — state you'll stop emailing unless they act. Honesty as the hook. *(Standard for sunset.)* |
| last | 12 | Final break — "removing you to respect your inbox; one click to stay." Then suppress non-responders. |

**Branches:** any engagement at any step → exit immediately to nurture/welcome-
back, stop the sunset. No engagement through the last → move to a suppressed
segment (don't keep mailing). Keep it short; a long re-engage defeats the
purpose. 3 emails to re-spark, 5 to fully sunset.

---

## 4. Onboarding (4–8 emails, milestone-triggered)

**Job:** get a brand-new customer to first value fast and make the product a
habit — this is where churn is won or lost. Triggered by *behavior*, not just
time: each email targets the next milestone, and a milestone reached suppresses
its prompt. **Trigger:** purchase / signup / activation. **Conversion event:**
the activation moment (first core action) → then the habit/expansion moment.
**Exit:** activated and habitual → graduate to lifecycle/expansion email.

| # | Trigger | Job of this email |
|---|---|---|
| 1 | instant on signup | Welcome + the ONE first step (the activation action). Remove every other choice; one button. |
| 2 | day 1 *(if step 1 not done)* | Nudge to the first step, lower the barrier — show how fast/easy, address the silent blocker. |
| 3 | on activation *(or day 2)* | Celebrate the first win + point to the next high-value action. Momentum email. |
| 4 | day 3–4 | Teach a power feature that maps to the reader's `icp.md` goal — "here's how people like you get more out of it." |
| 5 | day 5–7 | Social proof + the outcome at scale — what good looks like after a month. Sets the aspiration. |
| (6) | day 7–10 | Remove a known friction (integration, invite a teammate, import data) — make it stickier. *(Add for multi-seat/data products.)* |
| (7) | day 10–14 | Check-in / human offer — "stuck on anything? reply or grab 15 min." Catches the at-risk. *(Add for higher-touch.)* |
| (8) | pre-renewal / end of trial | The value recap + the convert/upgrade ask, evidenced by what they did. *(Add for trials/subscriptions.)* |

**Branches:** activation done early → skip the nudge emails, jump to the habit
track. Inactive past day N → fork to a dedicated "still there?" path (this is the
churn-save). For a free trial, email #8's deadline framing borrows from the sales
type. Build 4 for a simple product, 6 standard SaaS, 8 for trial-to-paid.

---

## 5. Sales (4–7 emails, accelerating to a deadline)

**Job:** convert a warm prospect (already aware, already interested) into a buyer
by stacking proof, dismantling objections, and creating a real reason to act now.
Most direct of the five. **Trigger:** a high-intent signal — demo attended,
pricing viewed, "send me details," cart/checkout started, sales tag. **Conversion
event:** purchase / signed proposal / booked close call. **Exit:** on purchase
(immediately — never sell what they bought), or to long-term nurture if the
window closes unconverted.

| # | Day | Job of this email |
|---|---|---|
| 1 | 0 | The offer, clearly — what it is, who it's for, the core outcome and the price/terms. No burying the ask. Full CTA. |
| 2 | 1–2 | Proof — the strongest case study / result (from `goals.md` or a real engagement), mirrored to the reader's situation. |
| 3 | 2–3 | Objection demolition — the #1 reason they hesitate, answered with evidence and a risk-reversal (guarantee/trial/terms). |
| 4 | 3–4 | The mechanism / why it works — make the outcome believable, not just asserted. Differentiate honestly. |
| (5) | 4–5 | A second proof angle or a bonus/fast-mover incentive that's genuinely time-bound. *(Add for higher price.)* |
| 6 | 5–6 | Urgency made real — the deadline, the cohort closing, the price change. Only ever a true constraint. |
| last | 6–7 | Last call — short, direct, the single action and the consequence of waiting. Then close the cart/sequence. |

**Branches:** clicked but didn't buy → one targeted follow-up on the matching
objection. Replied → straight to a human. Bought at any step → exit to
onboarding instantly. Never fabricate scarcity; a fake deadline burns the list
and the brand. Build 4 for a low-price/known buyer, 5–6 standard, 7 for a
high-ticket considered purchase.

---

## Per-email block spec (write EVERY email to this shape)

Each email in `sequence.md` is one block:

```
### Email {n} — {one-line job}
- Timing: {day / trigger relative to entry, e.g. "Day 3" or "On activation"}
- Subject: {40–60 chars}   |  A/B: {alternate angle, same length band}
- Preview: {distinct from subject — extends it, ~35–90 chars}
- Body:
  {full copy in the client's voice — value first, one job, scannable}
- CTA: {action + outcome}  →  {link target / placeholder}
- Send conditions: {entry rule; skip-if / branch / exit rule}
```

Rules for the block:
- Subject and preview are a pair — the preview never repeats the subject, it
  earns the open the subject started. Both A/B options stay in the 40–60 char band.
- Body is real, finished copy (not a brief) — the client should be able to paste
  it. Short paragraphs, one idea each; the CTA stands alone on its own line.
- Send conditions make the branch logic explicit so it maps cleanly onto any ESP
  (skip-if-converted, fork-on-inactivity, exit-on-reply).
- Personalization tokens as `{first_name}`-style placeholders the platform fills;
  for cold sends, the opener is left for `/email-personalize` to write per-lead.

---

## Metrics plan (the `## Metrics to track` section)

Instrument the sequence so the re-run has something to chart. For the whole
sequence, set ONE primary KPI tied to a `goals.md` goal (e.g. trial starts,
booked calls, reactivations). Then per email, name the metric, the benchmark
band, and the single decision it drives.

| Metric | What it tells you | Planning band* | If below band, do this |
|---|---|---|---|
| Open rate | Subject + sender + timing land | ~25–45% | Rewrite subject/preview; check send time and from-name |
| Click rate (CTR) | The body + CTA earned the action | ~2–6% of sent | Tighten the one CTA; move value before the ask |
| Click-to-open (CTOR) | Body quality for those who opened | ~10–20% | Body/offer mismatch with the subject's promise |
| Reply rate | Resonance / relationship (esp. cold + re-engage) | ~1–5% | Add a real question; make replying the easy path |
| Conversion (per email) | Which email does the work | sequence-specific | Reorder proof; strengthen the converting email |
| **Primary KPI (sequence)** | Did the sequence do its job | from `goals.md` target | Re-architect, not just re-word |
| Unsubscribe rate | Frequency/relevance health | keep < ~0.5% | Cut an email or widen timing; re-segment |
| Bounce / spam rate | List + deliverability health | bounce < ~2% | Clean the list; pull back send volume |

*Bands are planning ranges, not guarantees, and vary by industry, list warmth,
and country. If an ESP/CRM is connected, replace these with the client's real
historical baselines (the accelerator path) and note that you did.

Each email's metric drives exactly one decision — write that decision into the
plan ("Email 4 is the converter; if its CTR < 4%, the proof in Email 3 is the
fix, not Email 4's copy"). The primary KPI's starting value becomes the
`goals.md` ledger line and the re-run baseline.
