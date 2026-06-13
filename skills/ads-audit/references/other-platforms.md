# Other platforms — interim check notes

Google and Meta have full original check sets (`google-checks.md`,
`meta-checks.md`). LinkedIn, TikTok, and Microsoft Ads get the abbreviated lenses
below until their full sets ship in a later wave. When one of these platforms is
active and has real spend, audit it with these lenses, score it the same way
(`scoring.md`), weight it by spend share, and add an `ads-{platform}-health`
ledger line. The four universal lenses — tracking, structure, creative/audience,
settings — map onto every platform.

## The four universal lenses (apply everywhere)

1. **Tracking & measurement** *(Critical)* — Is the conversion signal real?
   (tag/pixel firing, server-side where available, deduplicated, values passed
   where relevant). Broken tracking = audit-stopping finding regardless of platform.
2. **Structure & spend** *(High)* — Campaigns segmented sensibly, budget on
   winners, bidding/objective matched to the goal, no obvious wasted spend.
3. **Creative & audience** *(High/Medium)* — Enough creative to test, fatigue
   watched, audiences match the ICP, retargeting layer present, no self-competing
   overlap.
4. **Settings, billing & policy** *(Medium)* — No delivery blocks, no disapprovals,
   deliberate placements/locations, no spend-leaking defaults.

## LinkedIn Ads — interim notes

- **Tracking:** Insight Tag installed and firing; Conversions API where set up;
  lead-gen-form completions tracked; offline/CRM conversions imported if used.
- **Structure & spend:** objective fits the funnel stage; bidding deliberate (not
  max-delivery by default on a high-CPC platform); thin tests not starved.
- **Creative & audience:** targeting leans on professional firmographics from
  `context/icp.md` (title, seniority, function, company size/industry); audience
  not so narrow it inflates CPMs; LinkedIn Audience Network reviewed (often a
  waste — exclude if it doesn't perform); creative fresh; lead-form friction low.
- **Settings:** no audience expansion silently broadening targeting; budget pacing sane.

## TikTok Ads — interim notes

- **Tracking:** Pixel + Events API (server-side) firing and deduplicated; key
  events present with recent volume.
- **Structure & spend:** Smart/automated tools used deliberately; budget on
  winners; objective matches the goal.
- **Creative & audience:** native, sound-on, hook-first creative (not recycled
  feed statics); fatigue watched hard (TikTok burns creative fast — frequency/CTR
  decay over the 90d window); spark/UGC mix; audiences match the ICP.
- **Settings:** no disapprovals; placements deliberate; comment moderation sane.

## Microsoft Ads — interim notes

- **Tracking:** UET tag firing; conversion goals set as primary with recent volume.
- **Structure & spend:** if imported from Google, settings/networks reviewed (the
  import carries over Google assumptions that don't fit here); search-term/negative
  hygiene done independently; audience network reviewed (frequent waste — exclude
  if it doesn't perform).
- **Creative & audience:** RSAs strong, assets/extensions present, LinkedIn
  profile targeting used where it fits the ICP.
- **Settings:** billing/policy clear; locations and bidding deliberate.

## Scoring these platforms

Same machinery: assign each interim check a severity, resolve pass/warn/fail/N-A,
score over applicable weight, letter-grade, weight into the account score by spend
share, and write `- {date} | ads-{platform}-health | {score} | {note}` to the
ledger (create the goal def + flag for confirmation if missing). When the full set
ships, the ledger id stays the same so the series is unbroken.
