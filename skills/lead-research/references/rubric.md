# Scoring rubric — the three axes

A prospect's score is **three independent 1–10 axes summed to a 3–30 total**,
then mapped to a tier. The axes are deliberately orthogonal: a perfect-fit
account with no buying signal and no way in is not a Hot lead, and the math
should say so out loud. Always show the three numbers and one evidence clause
each — the score is an argument, not a verdict.

## Parsing the ICP into rubric inputs (do this once, up front)

Read `context/icp.md` and extract three buckets. If the file names them
loosely, infer; if it's silent on one, mark it "unspecified" and lean on the
anchor accounts the user gave instead of inventing thresholds.

| Bucket | What you pull from icp.md | Feeds |
|---|---|---|
| **Fit signals** | target role/title, company segment/vertical, size band (headcount/revenue), business model, geography, tech they should run | ICP-fit axis |
| **Disqualifiers** | explicit "not a fit" rules — too small, wrong model, competitor, region we don't serve, named exclusions | the DQ cap |
| **Buying triggers** | the situations that mean "now" — quoted from icp.md and meetings (e.g. "right after they hire a Head of Growth") | Timing axis |

The Accessibility axis draws on `context/offers.md` (does our offer fit their
stage and budget) and `context/people.md` (do we already have a way in).

---

## Axis 1 — ICP-fit (1–10)

How cleanly this account matches the client's own ICP. This is about *what they
are*, independent of timing or reachability.

| Score | Meaning | Typical evidence |
|---|---|---|
| 9–10 | Textbook ICP — matches role, segment, size, and model with nothing off | "Series B fintech, 140 staff, has a VP Demand Gen — exact anchor profile" |
| 7–8 | Strong fit, one soft mismatch that doesn't break the thesis | right segment + size, title is "Head of Marketing" not the named "VP Growth" |
| 5–6 | Plausible fit with real gaps — adjacent vertical, or size at the band's edge | B2B SaaS but in a vertical we haven't sold, headcount just under floor |
| 3–4 | Weak — only one or two signals match; would need a stretch to pitch | right size but wrong model (agency, not SaaS) |
| 1–2 | Not the ICP at all; surfaced as discovery noise | consumer brand, no buying role for our offer |

**Disqualifier cap:** if any `icp.md` disqualifier matches, ICP-fit is **capped
at 3** regardless of other signals — and you record which disqualifier fired in
the row's note. A capped row almost always lands Cold or DQ, which is correct: a
disqualified account is not "a bit warm," it's out.

Resolve "unspecified" buckets conservatively: a missing size band is neutral
(don't punish or reward), not an automatic 10.

## Axis 2 — Timing-signal (1–10)

Freshness and strength of *buying triggers*. This is the axis that decays — a
trigger from 14 months ago is not "now." Every point above ~5 needs a **cited,
dated source**; no source means no points.

| Score | Meaning | Example signals (cite + date each) |
|---|---|---|
| 9–10 | Multiple fresh, on-thesis triggers stacking | new funding round (≤90d) **and** hiring for the exact pain we solve |
| 7–8 | One strong, recent, on-thesis trigger | named the relevant leadership hire last month; public RFP; tool migration announced |
| 5–6 | A real but softer or older signal | hiring broadly (growth, but not the exact role); funding 6–12 months ago |
| 3–4 | Faint or generic signal | general "we're scaling" PR; job posts unrelated to our pain |
| 1–2 | No timing signal found | static site, no news, no hiring movement |

Common triggers to look for (non-exhaustive; match to THIS client's icp.md
triggers first): fresh funding or M&A; hiring for the role/function our offer
serves; leadership change in the buying seat; adoption of (or migration from) a
tech in their stack; product launch or market entry; public intent (event
attendance, content, RFPs, review-site activity); regulatory or seasonal
forcing function. **Record the source and date for each trigger you score** —
"no signal found" beats an inflated guess.

## Axis 3 — Accessibility (1–10)

How reachable and winnable this account is *right now*. A 30/30 ICP-fit account
we can't get a meeting with, that's locked into an incumbent, ranks below a
slightly-worse-fit account with a warm intro.

| Score | Meaning | Typical evidence |
|---|---|---|
| 9–10 | Warm path exists — mutual connection, prior contact in people.md, inbound history, event overlap | "Owner connected to our champion at {client}" |
| 7–8 | Clear cold path — named buyer + verified contact (email/LinkedIn), reachable size, no lock-in | found the VP, public email pattern, no entrenched competitor |
| 5–6 | Reachable but friction — gatekept, large org, contact role unclear | enterprise; only a generic info@ found |
| 3–4 | Hard — no contact found, visible incumbent lock-in, or our offer mis-fits their stage | runs a direct competitor on a long contract |
| 1–2 | Effectively unreachable / wrong stage for our offer | no buyer identifiable; pre-revenue when our offer needs spend |

Accessibility also reflects **offer-fit from `offers.md`**: if our offer needs a
budget or maturity the account plainly lacks, accessibility drops even when a
contact exists. Note the angle (which offer, why now) for every row scoring ≥7
here — it's what the SDR uses.

---

## Tiers & the math

Sum the three axes (range 3–30) → tier:

| Tier | Total | Reading |
|---|---|---|
| **Hot** | 24–30 | Right account, real timing, a way in — work these this week |
| **Warm** | 16–23 | Two of three strong; nurture or wait for the trigger |
| **Cold** | 8–15 | Fit but no urgency, or urgency but weak fit — backlog |
| **DQ** | ≤7 | Disqualified or noise — excluded from outreach, kept for audit trail |

**Borderline rule:** within 1 point of a tier line, round toward the **lower**
tier and say so in the note ("23 → Warm, 1 off Hot; revisit on next trigger").
Honest tiers protect the outreach list's signal.

**Worked example (show this shape in `final/summary.md` for the top accounts):**

```
Northwind Robotics — 26/30 · HOT
  ICP-fit 9   Series B industrial-automation SaaS, 120 staff, has VP Marketing — anchor match
  Timing  9   Raised $40M 2026-05-20 (TechCrunch); hiring "Demand Gen Lead" (careers page, 2026-06-01)
  Access  8   VP Marketing on LinkedIn, public email pattern; no incumbent agency visible
  Angle: pitch {offer: paid-acquisition retainer} — funded + hiring the exact seat = budget forming now
```

```
Quietriver Health — 14/30 · COLD
  ICP-fit 7   Right vertical + size
  Timing  3   No fresh signal; last news 2024
  Access  4   Only info@ found; HIPAA gate slows entry
  Note: fit's there, no urgency — backlog; re-score if a trigger appears
```

```
Acme Forge — 6/30 · DQ
  ICP-fit 3   capped — disqualifier "agencies, not in-house teams" fired
  Timing  2   n/a
  Access  1   n/a
  Note: excluded — kept for audit trail so it isn't re-surfaced next run
```

## Re-run scoring notes

On a re-run, carry forward each prior prospect's axis scores from
`data/baseline.json` and **re-score Timing** in particular — it's the axis that
moves. A Warm that just raised a round or opened the target req becomes Hot, and
that movement is the headline of the new `summary.md`. Tier *drops* matter too:
a prospect whose trigger went stale falls back, and a newly-matched disqualifier
DQs a previously-listed account — flag both.
