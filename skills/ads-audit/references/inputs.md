# Inputs — zero-API default + optional accelerators

The full audit must work from manual exports and screenshots. Connectors only
speed up gathering the SAME data — they are never required. Persist every raw
file to the deliverable's `data/` as you receive it (resilience + resumability;
on context overflow, re-read the files, not the chat).

## Date windows

- **Performance / spend / wasted-spend:** last 30 days (default). Confirm the
  client's real cadence from `profile.md`; a low-volume account may need 60–90.
- **Fatigue / trend / regression:** last 90 days, so frequency climbs and CTR/CPR
  decay are visible.
- Record the exact range used in `brief.md` and `baseline.json` so re-runs compare
  like with like.

## Spend per platform (drives the weighting)

Capture total spend per platform for the window — it sets each platform's share
in the account-wide score (`scoring.md` §5). One number per platform from the
account summary screenshot or export is enough. If a platform's spend is genuinely
unknown, fall back to equal weighting and say so in the report.

## Google Ads — zero-API export list (the default path)

Ask the user to export from the account (CSV), or paste/screenshot:

| Input | Why it's needed |
|---|---|
| Campaign report (cost, conv, conv value, ROAS, impr share) | structure, budget, bidding |
| Ad-group report | grouping, relevance |
| Keyword report (with Quality Score column) | QS, match types, zero-converters |
| **Search-term report** | the wasted-spend goldmine — irrelevant queries |
| Ad / RSA report (ad strength, status) | ads & assets, disapprovals |
| Asset/extension report | sitelinks/callouts coverage, asset status |
| Settings screenshots (networks, locations, bidding, auto-apply) | settings category |
| Conversions screenshot (Goals: primary/secondary, recent volume, status) | G1 — non-negotiable |
| Account status / billing screenshot | policy/billing blocks |

## Meta Ads — zero-API export list (the default path)

| Input | Why it's needed |
|---|---|
| Campaign / ad-set / ad report (results, CPR, ROAS, spend, **frequency**, CTR) | structure, budget, fatigue |
| Delivery/learning column or screenshot (Learning / Learning Limited) | learning phase |
| Events Manager screenshot (pixel events + recent volume) | pixel health |
| CAPI status + deduplication screenshot | CAPI / dedup |
| Event Match Quality screenshot | EMQ |
| Domain verification + Aggregated Event Measurement screenshot | AEM/priority events |
| Ad-preview screenshots (per top-spend ad) | creative, format, placement, message match |
| Delivery-status / policy screenshot | rejected/limited ads |
| Audiences screenshot (saved/custom/lookalike, overlap if checked) | audience & retargeting |

## Other platforms

LinkedIn / TikTok / Microsoft: pull the equivalent campaign + creative +
conversion-tracking exports and a settings screenshot. See `other-platforms.md`
for what to look at until the full check sets ship.

## Optional accelerators — gated behind "if connected"

Each of these only fetches the inputs above more cheaply; none is a dependency. If
a connector isn't present, the manual path above is the complete audit.

- **Platform APIs** (Google Ads API, Meta Marketing API, LinkedIn/TikTok/Microsoft
  ads APIs) — pull reports and account settings directly instead of CSV export.
  Read-only; never mutate the account from an audit.
- **Browser automation** — drive the ads UI to capture settings/status screens the
  user would otherwise screenshot.
- **Analytics connectors** (GA4 / measurement) — corroborate conversion tracking
  and cross-check platform-reported conversions against analytics.

When a connector is used, note it in `brief.md` ("Google data via API; Meta via
manual export") so the next auditor knows the provenance.

## When data is missing

- A whole platform's data absent → audit the others, mark that platform
  "not assessed" in the report, exclude it from the weighted score, and list
  exactly what to export for next time. Never block the run.
- A single input absent → mark the dependent checks **N/A** with the reason, and
  request that input in the report's "to complete the picture" note.
