# Criteria — ICP→gate parsing & verification rules

How to turn the client's prose ICP into a boolean gate, how to verify each lead
against live sources, and the exact decision logic. All original expression;
qualification logic is common professional practice, authored here in our own words.

## 1. Parse the ICP into a gate

`context/icp.md` is written for humans — pains, triggers, example customers, roles.
Convert it into three machine-checkable buckets. Read the whole file, then sort
every stated attribute:

| Bucket | What goes here | Combine with |
|---|---|---|
| **MUST** | Non-negotiables the lead has to satisfy | AND |
| **ALT** | Acceptable variants of a MUST ("SaaS *or* marketplace") | OR within the MUST |
| **NOT** | Disqualifiers — anything the ICP says is explicitly wrong-fit | NOT (any hit = out) |

Common attribute types to extract (only those the ICP actually states — never
invent a criterion the client didn't give you):

- **Firmographic** — industry/vertical, company size (headcount or revenue band),
  geography/region, business model (B2B/B2C, SaaS/services/ecom), maturity/stage.
- **Role/seniority** — the buyer or champion title(s); decision-maker vs influencer.
- **Need/trigger** — the pain or event that makes them a buyer now (hiring,
  funding, a platform migration, a compliance deadline, a tool they already run).
- **Capacity** — can they afford/deploy the offer (budget band, existing spend,
  team to use it). Cross-check against `context/offers.md` price point.
- **Exclusions** — competitors, current clients, industries they refuse, regions
  they don't serve, sizes too small/large to serve profitably.

**Inferred disqualifiers.** If `icp.md` lists no NOTs, derive the obvious inverse
of the MUSTs (e.g. MUST "50–500 employees" → NOT "<50 or >500") and label them
*inferred* so the user can correct. Don't fabricate exclusions with no basis.

**Output the gate as a table** before scoring so the user corrects it once:

```
MUST  industry      ∈ {B2B SaaS, marketplace}        [ALT: marketplace]
MUST  size          50–500 employees
MUST  buyer role    Head/VP/Director of {Growth|Marketing|Demand}
MUST  trigger       any of: hiring growth roles · raised in last 12mo · runs {tool}
NOT   industry      agency / reseller (they're competitors)
NOT   size          <50 or >500            [inferred]
NOT   geography     outside {regions offer serves}
```

Capture the ICP version (a `version:`/`reviewed:` field in `icp.md`, else its
`reviewed:` date) — it goes in the ledger note and `baseline.json`.

## 2. Verification — sources & rules

The reason this skill earns money: **list data lies.** Roles go stale, companies
die, sizes are self-reported and wrong, scraped emails misattribute. So no
criterion is trusted from the input row alone — each MUST/NOT is checked against
live evidence. Target **2–3 independent sources per lead**, stopping early once the
verdict is decided (all MUSTs confirmed, or one disqualifier confirmed).

### Source ladder (zero-API default)

1. **Company website** — the canonical truth for what they do, who they serve,
   size signals (team/careers page), region, and business model. Fetch homepage +
   about/careers as needed. WebFetch.
2. **A third-party site** — a review/directory/marketplace listing, a news result,
   or a public registry. Corroborates industry, size band, and that the company is
   alive and operating. WebSearch the company name + a corroborating term.
3. **LinkedIn-via-web** — search the person + company through the open web (don't
   require a logged-in scrape) to confirm the role is current and the seniority
   matches. Resolves the most common list lie: the contact left or changed title.

**If a scraping/enrichment connector is connected** (optional accelerator only):
use it to batch-pull headcount, industry codes, and current role in one pass, then
treat its output as *one source* — still corroborate a MUST with a second when the
verdict is close. Never make the connector a hard dependency; the full skill must
run on WebSearch + WebFetch alone.

### Per-criterion verdicts

For each MUST/NOT, record one of:

- **met** — a source confirms it. Store the deciding source URL.
- **not-met** — a source contradicts it (this is what trips a disqualifier).
- **unknown** — 2–3 sources checked and none settled it. Don't keep digging
  past the source budget; mark unknown and move on.

Persist per-lead results to `data/verified-batch-{n}.json`:

```json
{ "company": "...", "person": "...", "role": "...", "site": "...",
  "checks": [ {"criterion":"size","verdict":"met","source":"https://…/careers"},
              {"criterion":"role","verdict":"unknown","source":null} ],
  "decision": "Y", "reason": "...", "borderline": true, "dupe_of": null }
```

## 3. Decision logic (the gate)

Binary, not a score. Apply in order:

1. **Any disqualifier (NOT) verified not-met → Qualified N.** Reason = the
   disqualifier and its source. Disqualifiers win over everything.
2. **All MUSTs met (each MUST satisfied directly or via a valid ALT) and no
   disqualifier hit → Qualified Y.** Reason = the strongest 1–2 confirming facts.
3. **A MUST is `unknown` after the source budget, nothing disqualifying found →
   borderline → Qualified Y.** Reason names the unverified MUST ("Y — fit on
   industry+size; couldn't confirm role is current"). Set `borderline: true`.

**Why borderline qualifies:** a human reviewer drops a wrongly-kept lead in
seconds; a wrongly-killed lead is gone for good. We optimize for not throwing away
real prospects. The `borderline?` column lets the user spot-check exactly those.

**Reason quality.** Every reason is one concrete clause tied to a criterion and,
where it decided the verdict, a source. Banned: "not a fit", "low quality",
"doesn't match" with no attribute named.

- Good (Y): "B2B SaaS, ~120 staff per careers page, VP Growth role current on
  LinkedIn — clears all MUSTs."
- Good (N): "Marketing agency — on the ICP disqualifier list (competitor)."
- Good (borderline): "Industry + size fit; could not verify the contact still
  holds the buyer role — flagged borderline, kept."

## 4. Dedupe

Match on normalized company + person. On a hit, keep both rows and set
`dupe_of` to the surviving row's id — **flag, never auto-drop** (the user decides
which record is canonical; a silent drop can delete the better-sourced row).
Same company, different person = not a dupe (multiple contacts is normal).

## 5. Disqualifier-pattern learning

Tally `decision == "N"` reasons by criterion. If one criterion drives a large
share of rejections (rule of thumb >30% of all drops), the list source is
systematically off-ICP — surface it and propose a dated, confirmation-flagged
append to the `## Disqualifiers` section of `context/icp.md`:

```
- 2026-06-13 | observed: 41% of {source} leads rejected as <50 employees —
  consider excluding {source}'s small-business segment (flagged, confirm)
```

Only propose; the user confirms before it's written. This is the workspace getting
smarter each run — the loop loose tools don't have.

## 6. Edge cases

- **No `icp.md`** — one AskUserQuestion to capture the bar, offer to write it to
  `context/icp.md` afterward so the next run confirms instead of asks.
- **Empty/garbage list** — report it, write nothing, suggest `/lead-research` to
  source a list from the ICP instead.
- **Mixed-language / international leads** — verify region as a MUST; non-served
  geography is a clean disqualifier, not a borderline.
- **A lead with no website and no findable presence** — unknown on every MUST,
  nothing disqualifying → borderline Y with reason "no verifiable presence —
  manual check needed". Don't silently drop.
