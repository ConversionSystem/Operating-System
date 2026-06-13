# Google Ads — category checklist (original)

Six categories. Each check has an id, a severity (sets its weight per
`scoring.md`), pass / warn / fail thresholds, and the evidence to cite. Resolve a
check **N/A** (excluded from scoring) when the account genuinely doesn't use the
feature — note why. Default windows: last 30 days for spend/performance, last 90
for trend and fatigue. Always cite the export row or screenshot.

Zero-API inputs (defaults): campaign / ad-group / keyword / **search-term** / ad /
asset / settings reports as CSV + screenshots of conversion status and billing.
Connectors (optional accelerators, "if connected") just pull the same data faster.

---

## G1 · Conversion tracking & measurement

If this category is broken, every other number is fiction — audit it first.

- **g-conv-primary** *(Critical)* — At least one conversion action exists, is set
  as a **primary** goal, and recorded conversions in the last 7 days.
  - pass: primary conversion(s) firing, recent volume present.
  - warn: conversions exist but volume is suspiciously low/erratic, or a key
    action is "secondary"/observation-only.
  - fail: no primary conversion, zero recent conversions, or status "no recent
    conversions" / "tag inactive".
- **g-conv-dedup** *(High)* — No double-counting: one purchase/lead = one
  conversion; "count" set to *one* for lead actions, *every* only where intended.
  - fail: duplicate tags, or a lead action counting "every" inflating volume.
- **g-conv-value** *(High)* — Conversion **values** are passed (for ecommerce /
  value-based bidding) so ROAS is real, not a count proxy. N/A for pure lead-gen
  with no modeled value.
  - warn: static placeholder value on a varied-value action.
  - fail: value-based bidding running with no values passed.
- **g-enhanced-consent** *(Medium)* — Enhanced Conversions and a consent signal
  (Consent Mode where required) are configured; no obvious gaps that suppress
  recoverable conversions.
- **g-attribution** *(Medium)* — Attribution model is deliberate and consistent
  (e.g. data-driven), not a mix masking cross-campaign credit.
- **g-tag-coverage** *(High)* — The global tag / GA4 link fires on all key pages;
  no thank-you page missing the event. Cite the screenshot or tag test.

## G2 · Wasted spend

Where the money leaks. Lean on the **search-term** report and segment data.

- **g-search-terms** *(Critical)* — Search terms are reviewed and irrelevant
  queries are negated. Quantify wasted spend = spend on terms with zero
  conversions AND clearly off-intent (cite top offenders).
  - pass: <10% of spend on zero-conversion off-intent terms; recent negatives added.
  - warn: 10–25%, or no negatives added in the audit window.
  - fail: >25% on irrelevant terms, or the search-term report is plainly never reviewed.
- **g-negatives** *(High)* — A maintained negative-keyword strategy: shared lists
  applied, brand vs non-brand separated, competitor/junk terms blocked.
  - fail: no negative lists, or obvious money-wasters (jobs, free, cheap, DIY when
    irrelevant) running unblocked.
- **g-match-type-bleed** *(High)* — Broad match isn't bleeding budget into
  unrelated queries without tight negatives + smart bidding guardrails.
  - warn: broad match live with thin negative coverage.
  - fail: broad match dominating spend with no conversions and no negative discipline.
- **g-zero-converters** *(Medium)* — Keywords/ad-groups with significant spend and
  zero conversions over a fair window are paused or reworked, not left bleeding.
- **g-geo-schedule-waste** *(Medium)* — No spend in geographies or dayparts that
  never convert; location targeting is "presence", not "presence or interest",
  unless intended.
- **g-placement-waste** *(Medium)* — On Display/PMax/Video: junk placements
  (made-for-ads sites, irrelevant apps, mobile-game spam) are excluded. N/A if no
  Display/PMax/Video running.

## G3 · Account structure & campaign settings

- **g-network-split** *(High)* — Search and Display are **not** mixed in one
  campaign ("Search Network with Display select" off); networks are deliberate.
  - fail: Search campaigns silently spending on Display.
- **g-campaign-theme** *(Medium)* — Campaigns segment by a real axis (intent,
  product line, geo, brand vs non-brand), not one catch-all bucket.
- **g-budget-distribution** *(High)* — Budget follows performance: top-ROAS
  campaigns aren't budget-capped ("limited by budget") while weak ones overspend.
  - warn: a profitable campaign flagged budget-limited.
  - fail: budget concentrated in losers, winners throttled.
- **g-bidding-strategy** *(High)* — Bidding matches the goal and has enough
  conversion volume to learn (rough floor ~15–30 conv/mo per strategy for
  value/target strategies); not stuck in manual where automation would win, nor
  automated on starved data.
  - warn: target CPA/ROAS set with thin conversion volume.
  - fail: bidding strategy contradicts the stated goal (max-clicks on a lead account).
- **g-pmax-hygiene** *(Medium)* — PMax has brand exclusions, a sensible asset
  group structure, search-theme + audience signals, and isn't cannibalizing brand
  search. N/A if no PMax.
- **g-conflicts** *(Low)* — No duplicate keywords competing across ad groups; no
  self-cannibalizing campaigns bidding on the same terms.

## G4 · Keywords & Quality Score

- **g-quality-score** *(Medium)* — Quality Score distribution is healthy; QS ≤4
  keywords with meaningful spend are flagged for relevance/landing-page fixes.
  - warn: a cluster of high-spend low-QS keywords.
  - fail: most spend on QS ≤3 keywords.
- **g-relevance-grouping** *(Medium)* — Ad groups are tightly themed so ads and
  keywords match intent (not 50 unrelated keywords in one group).
- **g-match-coverage** *(Low)* — Sensible match-type mix for the strategy (exact
  for proven converters, broad+smart bidding for discovery), not 100% one type by
  default.
- **g-brand-strategy** *(Medium)* — A deliberate brand-term decision: bidding on
  own brand where defensible, conceding where it only pays the platform. Cite the
  brand campaign's incrementality signal if available. N/A if no brand campaign by
  choice.
- **g-search-impr-share** *(Low)* — On priority campaigns, lost impression share
  (rank/budget) is understood and acceptable, not silently capping a winner.

## G5 · Ads & assets

- **g-rsa-strength** *(High)* — Responsive Search Ads have enough headlines
  (toward 15) and descriptions, "Good/Excellent" ad strength, and no "Poor".
  - warn: ad strength "Average", or only one RSA per ad group.
  - fail: "Poor" ad strength on spending ad groups, or thin/duplicate headlines.
- **g-ad-count** *(Medium)* — At least the recommended ad coverage per ad group
  (an RSA, ideally a second variant for testing), none with a single dead ad.
- **g-assets-extensions** *(High)* — Core assets/extensions present and approved:
  sitelinks, callouts, structured snippets, plus call/location/lead-form/image as
  relevant. Missing high-value assets = leaving CTR and SERP real estate on the table.
  - fail: no sitelinks/callouts on spending campaigns.
- **g-asset-disapprovals** *(High)* — No disapproved/limited ads or assets
  silently suppressing delivery. Cite the policy status.
- **g-message-match** *(Medium)* — Ad copy reflects the offer and the keyword
  intent, and points at a relevant landing page (handoff to `/ads-landing` if
  deeper LP work is needed). Voice for any *suggested* copy comes from the
  client's `context/brand.md`.
- **g-creative-freshness** *(Low)* — Ads aren't stale relative to current offers;
  seasonal/promo copy isn't expired.

## G6 · Settings, billing & policy

- **g-billing-policy** *(Critical)* — No billing hold, suspended account, or
  policy strike actively blocking delivery. Cite the account-status screenshot.
- **g-location-intent** *(Medium)* — Location options set to "presence" not
  "presence or interest" unless deliberate (re-check overlaps g-geo-schedule-waste
  — score once, in whichever is more material).
- **g-language-network** *(Low)* — Language and network settings match the audience
  and aren't defaulting to spend-leaking partners (search partners on if they
  perform, off if not).
- **g-autoapply-recs** *(Medium)* — Auto-apply recommendations are reviewed, not
  blanket-on letting the platform mutate the account toward its own incentives.
- **g-audience-signals** *(Medium)* — Remarketing/customer-match audiences exist
  and are applied (observation or targeting as intended); the account isn't
  ignoring its own first-party data. N/A if no audiences available.
- **g-tracking-templates** *(Low)* — UTM/tracking templates are consistent so
  downstream analytics attributes correctly; no broken final-URL suffixes.

---

## N/A guidance (so lean accounts aren't punished)

Mark N/A and exclude from the denominator when: no PMax (g-pmax-hygiene), no
Display/Video (g-placement-waste), no ecommerce values (g-conv-value), no
audiences available (g-audience-signals), deliberate no-brand-campaign
(g-brand-strategy). Always state the reason in the finding.
