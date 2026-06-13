# The three passes — discovery, validation, enrichment

Multi-pass on purpose: cast **wide** (discovery), cut to **real and in-ICP**
(validation), then go **deep** only on survivors (enrichment). Going deep before
filtering wastes the expensive work on accounts that wash out. Persist each
pass to `data/` as you go — on context overflow you re-read the JSON, not the
conversation, and a crashed run resumes from the last file written.

Each pass below has a **default (zero-API)** recipe and an optional
**[if connected]** accelerator. The default must fully work alone; accelerators
only buy speed and depth. Never make a connector a hard dependency, and never
enable one the user didn't confirm — probe what's actually available in the
environment first, don't assume from memory.

---

## Pass 1 — Discovery (wide)

**Goal:** a candidate pool ~2–3× the target count. Over-source; validation culls.

**Default (WebSearch / WebFetch):**
1. Turn the parsed ICP into a query set — combine segment/vertical × size/stage ×
   geography × the buying trigger. Run several angles, not one query:
   - "best/top {segment} companies {geo}", industry lists, awards, funded-company
     roundups, "{vertical} companies hiring {role}".
   - directories and aggregators relevant to the vertical (association member
     lists, marketplace category pages, review-site category leaders).
   - trigger-led searches: "{segment} raised funding {recent months}",
     "{segment} 'now hiring' {target role}", launch/expansion announcements.
   - **LinkedIn via search** (zero-API): site-scoped web searches for company and
     people pages matching the role + segment — read the public result snippets;
     do not log in or scrape gated pages.
3. For each hit capture the minimum identity: company name, domain, one-line
   what-they-do, the source URL + date, and the query that surfaced it. **Write
   to `data/discovery.json` as you gather** — append per batch, don't buffer in
   context.
4. Stop when the pool hits ~2–3× target or the queries stop yielding net-new
   names. Note total candidates and the angles that produced them.

**[if connected] accelerators:**
- *Scraping connector (e.g. Apify-style company/people scrapers):* pull a
  larger, structured candidate set from directory or search-result pages in one
  pass instead of reading snippets. Use only public/permissioned pages; honor
  the site's terms.
- *CRM connector:* pull the client's existing accounts to EXCLUDE up front
  (don't re-source current customers/opps) — a dedupe input, not a source.
- *Intent/data connector (if the client has one wired):* seed discovery with
  in-market accounts. Treat its "intent" as a Timing signal in Pass 3, still
  cited.

## Pass 2 — Validation (filter)

**Goal:** every survivor is a real, distinct, in-ICP company we don't already
work. This pass removes; it doesn't enrich.

**Default:**
1. **Dedupe** within the pool (same company, alt domains, rebrands) and against
   the existing book: `context/people.md`, the client's known customers/opps, and
   **prior `prospecting-*/` runs** (re-run dedupe on domain). Flag dupes, don't
   silently drop — the audit trail matters.
2. **Reality check** each candidate against its own site/one source: it exists,
   is operating (not dead/acquired), and is roughly the segment the snippet
   claimed.
3. **ICP gate** on the cheap-to-check fields — segment, rough size band, business
   model, geography. Anything clearly outside the ICP or matching a disqualifier
   is cut here (note which rule fired) so enrichment isn't spent on it. When a
   field can't be cheaply confirmed, keep the candidate and let enrichment
   resolve it — validation cuts the *clearly* out, not the *uncertain*.
4. Write survivors to `data/validated.json` with the identity fields + a
   `validation_note`. Record how many were cut and why (dupe / dead / out-of-ICP
   / disqualifier).

**Parallelism:** if >10 survivors need checking, fan out fixed batches
(~10/agent) in ONE message; each agent writes `data/validated.partN.json`; merge
after. Never validate sequentially when you can batch.

**[if connected] accelerators:**
- *Scraping/enrichment API:* batch-confirm domain liveness, headcount band, and
  vertical for fast gating instead of per-site reads.

## Pass 3 — Enrichment (depth) + scoring

**Goal:** for each survivor, gather exactly the signals the rubric scores, find a
reachable contact, then score and tier. Depth here, because the pool is now
small and qualified.

**Default — gather per prospect (cite source + date on each):**
1. **Fit detail** — confirm size, model, vertical precisely enough to set
   ICP-fit (the icp.md match).
2. **Timing signals** — funding/M&A, hiring for the role/function we serve,
   leadership change in the buying seat, tech adoption/migration, product launch
   or market entry, public intent (events, content, RFPs, review activity). Read
   careers pages, press/news, the company blog, public profiles. **Every signal
   gets a URL + date** or it doesn't score.
3. **Contact / way-in** — the named buyer for our offer (title from icp.md),
   their public profile, a public/permissioned email pattern, and any warm path
   from `context/people.md`. Sets Accessibility.
4. **Angle** — which `offers.md` line we'd pitch and the one-sentence why-now.
5. **Write to `data/enriched.json` as you finish each prospect** (or each batch's
   `data/enriched.partN.json`). Fan out for >10, same pattern as Pass 2.

**Score** every enriched prospect on the three axes per `references/rubric.md`,
apply the disqualifier cap, sum, assign the tier, and capture the per-axis
evidence clauses (they become the `summary.md` rows and CSV columns).

**[if connected] accelerators:**
- *Enrichment API (firmographics/technographics/contacts):* fill size, tech
  stack, verified contact, and recent-news fields in bulk — faster and deeper
  than manual reads. Still record provenance per field.
- *News/funding feed:* stronger, fresher Timing signals.
- *CRM write-back (only if the user asks):* push the final tiered list back to
  their CRM. Default is the CSV deliverable in `work/`; never auto-push.

---

## What each `data/` file holds

| File | Written in | Holds |
|---|---|---|
| `discovery.json` | Pass 1 | raw candidate hits: name, domain, blurb, source URL + date, surfacing query |
| `validated.json` | Pass 2 | survivors + `validation_note`; cut log (count by reason) |
| `enriched.json` | Pass 3 | per-prospect: fit fields, cited timing signals, contact, angle |
| `baseline.json` | end | the SCORED snapshot — each prospect's three axes, total, tier, top signals, sourced date. **This is what the next re-run diffs against.** |

Keep `baseline.json` lean and stable (it's the longitudinal record): domain as
the join key, the three axis scores, total, tier, the trigger that drove Timing,
and the run date. A re-run loads the most recent one, excludes its domains from
fresh discovery, re-scores carry-overs (Timing especially), and leads the new
`summary.md` with the movement.

## Output assembly (after scoring)

From the scored set, write to `final/`:
- `leads.csv` — one row per prospect: company, domain, contact, title, the three
  axis scores, total, tier, the why-now signal (with date), the angle/offer.
- `companies.csv` / `contacts.csv` — the account-level and person-level splits
  (some teams load these into different tools).
- `summary.md` — tier counts; on a re-run the **delta lead first**; then the
  top-10 with the worked per-axis shape from `rubric.md`; then DQs-for-audit and
  any ICP learning you're proposing back to `context/icp.md`.

Then the ledger line (`- {date} | prospects-sourced | {n} | {hot} hot`), the
flagged ICP-learning append if any, and the one-line `Daily/ ## Activity` entry.
