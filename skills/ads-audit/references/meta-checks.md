# Meta Ads — category checklist (original)

Four categories (Facebook/Instagram). Each check has an id, severity (weight per
`scoring.md`), pass / warn / fail thresholds, and cited evidence. Resolve **N/A**
(excluded) where the feature genuinely doesn't apply. Default windows: 30 days for
performance, 90 for fatigue/trend. Cite the export row, Ads Manager column, or
screenshot of Events Manager.

Zero-API inputs (defaults): campaign / ad-set / ad reports as CSV (with frequency,
results, CPR, ROAS columns), Events Manager screenshots (pixel + CAPI status,
event match quality, deduplication), and ad-preview screenshots for creative.
Connectors (optional, "if connected") pull the same faster.

---

## M1 · Tracking & measurement (pixel / CAPI)

Broken signal here corrupts optimization and reporting — audit first.

- **m-pixel-fires** *(Critical)* — The Pixel is installed and firing the right
  standard events (Lead / Purchase / etc.) with recent volume; no "no activity"
  or broken-event warnings.
  - pass: key events firing, recent volume.
  - warn: events fire but volume is erratic or a key event is missing.
  - fail: pixel inactive, key event not firing, or Events Manager shows errors.
- **m-capi** *(Critical)* — Conversions API is live and **deduplicated** against
  the pixel (matching event_id), recovering signal lost to iOS/ad-blockers/cookie
  limits.
  - warn: CAPI present but no deduplication, or browser-only with a known gap.
  - fail: no CAPI on a conversion account in the post-ATT era.
- **m-event-match-quality** *(High)* — Event Match Quality is "Good/Great" —
  enough customer parameters (email, phone, fbp/fbc, IP/UA) passed to match
  conversions to people.
  - warn: EMQ "Ok".
  - fail: EMQ "Poor" on the primary event.
- **m-domain-aggregated-events** *(High)* — Domain verified and Aggregated Event
  Measurement configured with the priority events ordered correctly. N/A if no
  web conversions (pure lead-form/IG).
  - fail: unverified domain or events unprioritized on a web-conversion account.
- **m-conversion-window** *(Medium)* — Attribution setting is deliberate
  (e.g. 7-day click) and consistent across reporting; not silently 1-day,
  undercounting and misleading bid optimization.

## M2 · Creative

Meta is a creative-led auction — this category carries the most weight after tracking.

- **m-creative-volume** *(High)* — Enough live creatives per ad set to let the
  system find winners (a healthy spread, not a single ad carrying spend), with a
  testing cadence.
  - warn: one or two creatives per ad set, no recent tests.
  - fail: a single ad absorbing nearly all spend with nothing in test.
- **m-fatigue** *(High)* — No fatigued creatives: rising **frequency** alongside
  falling CTR / rising CPR over the 90-day window. Quantify and name offenders.
  - pass: frequency in a healthy band (roughly ≤2–3 over the window for prospecting),
    stable CTR/CPR.
  - warn: frequency climbing with early CTR softening.
  - fail: high frequency with clear CTR decay and CPR inflation — money burning on
    worn-out creative.
- **m-format-mix** *(Medium)* — A deliberate format mix (video, static, carousel,
  UGC) and **placement-aware** assets (proper 9:16 for Reels/Stories, not just
  feed crops). N/A placements you've deliberately opted out of.
  - warn: one format only, or feed assets stretched into Stories.
- **m-hook-message-match** *(Medium)* — Creatives lead with a strong hook, match
  the offer in `context/offers.md`, and speak to the audience in `context/icp.md`;
  the CTA pairs action + outcome. Any *suggested* copy uses the client's
  `context/brand.md` voice.
- **m-policy-status** *(High)* — No rejected/limited ads silently suppressing
  delivery; no learning-limited reviews. Cite delivery status.
- **m-landing-consistency** *(Medium)* — The ad's promise matches the landing page
  (scent + speed); hand off to `/ads-landing` for deep LP work.

## M3 · Account structure & learning phase

- **m-learning-phase** *(High)* — Ad sets exit the **learning phase** (toward ~50
  optimization events / 7 days); they aren't stuck "Learning Limited" from too many
  small ad sets or constant edits.
  - warn: some ad sets learning-limited.
  - fail: most spend in learning-limited ad sets, or constant resets from frequent edits.
- **m-consolidation** *(High)* — The account is consolidated enough to feed the
  algorithm (CBO/Advantage+ where it fits; not 20 fragmented ad sets splitting the
  same audience and starving each of events).
  - warn: fragmented ad sets diluting signal.
  - fail: severe fragmentation, every ad set starved.
- **m-budget-allocation** *(High)* — Budget concentrates on proven winners (by CPR
  / ROAS), not spread flat or stuck on losers; campaign budget optimization used
  where appropriate.
  - fail: spend dominated by negative-ROAS ad sets.
- **m-objective-fit** *(Medium)* — Campaign objective and optimization event match
  the real goal (optimizing for Purchase/Lead, not Link Clicks or Landing Page
  Views as a proxy).
  - fail: optimizing for clicks on a conversion account.
- **m-advantage-features** *(Low)* — Advantage+ placements/audience expansion used
  deliberately (on where it helps, constrained where control is needed), not
  blindly toggled.

## M4 · Audience & targeting

- **m-audience-overlap** *(Medium)* — Active audiences don't heavily overlap and
  self-compete in the auction (driving up costs); overlapping ad sets are merged
  or excluded.
  - warn: moderate overlap on key audiences.
  - fail: heavy overlap inflating CPMs across the account.
- **m-retargeting** *(High)* — A retargeting layer exists (site visitors, engagers,
  video viewers, customer lists) **excluding** existing converters where
  appropriate; the account isn't pure cold prospecting leaving warm demand on the
  table. N/A if first-party/pixel audiences are genuinely unavailable.
  - fail: no retargeting despite available audiences.
- **m-exclusions** *(Medium)* — Sensible exclusions: existing customers excluded
  from acquisition, recent purchasers from prospecting, employees/junk filtered.
- **m-lookalike-firstparty** *(Medium)* — Lookalikes are seeded from high-quality
  first-party sources (purchasers, high-LTV, qualified leads — not all-traffic);
  customer-list audiences uploaded and fresh. N/A if no first-party seed available.
- **m-geo-demo-fit** *(Low)* — Geo/age/gender/detailed targeting match the ICP and
  aren't either needlessly narrow (starving delivery) or wastefully broad with no
  signal to guide it.

---

## N/A guidance

Mark N/A and exclude when: pure lead-form/IG with no web conversions
(m-domain-aggregated-events), placements deliberately opted out (m-format-mix for
those), no first-party audiences available (m-retargeting, m-lookalike-firstparty,
some m-exclusions). Always state the reason in the finding so the score stays honest.
