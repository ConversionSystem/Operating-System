---
name: seo-audit
description: Technical SEO audit of a client's site as a tracked Conversion OS deliverable — 16 original categories scored to a letter grade, quick wins carved out, a baseline that every re-audit charts against. Reads the client workspace (site URLs, prior audits) and writes the audit, findings, baseline, and a goals.md ledger line back into it. Zero-API by default; a crawler or Core Web Vitals tool is an optional accelerator. Triggers: /seo-audit, "audit my site", "SEO audit", "technical SEO", "why isn't this site ranking", "re-audit the site", "site health check".
---

# Conversion OS — Technical SEO Audit

A loose SEO tool dumps a PDF into a downloads folder and forgets you by Tuesday.
This audit lands in the client's workspace as a dated deliverable with a saved
baseline, so the next run leads with "+6 health points since May" instead of
starting from zero. Longitudinal proof is the product.

Operates inside one client workspace. Resolve the target before anything else:
explicit arg → the client of the current session → ask which (offer "the agency's
own site" for our marketing). Then read `Clients/{slug}/CLAUDE.md` and obey it —
never read sibling clients, never quote one client's data into another's. If no
root `CLAUDE.md` exists, stop: "Run /setup first."

For the agency auditing ITSELF: target `Company/` for reads, write the
deliverable to `Projects/{slug}/` instead of `Clients/{slug}/work/`.

## Phase 0 — Resolve context, never re-ask (read before you ask)

Read what the workspace already holds and CONFIRM it in one line; do not
interrogate the user for facts on disk:

- **Site URL(s)** — `context/stack.md` (system table) → else `profile.md`
  `links.site`. Note staging/subdomains/locales if listed. No URL anywhere is
  the *only* thing you ask for.
- **Audience & intent** — `context/icp.md` (informs the content-quality and
  E-E-A-T categories: who the pages must convince).
- **What they sell** — `context/offers.md` (which URLs are money pages; those
  get audited hardest).
- **Voice** — `context/brand.md` (the client's own voice, for any rewrite
  suggestions — never `Company/brand.md` for client-facing work).
- **Goals** — `goals.md` (is there an `seo-health` goal? organic-traffic or
  ranking targets to tie findings to?).

Confirm in ≤4 lines: "Auditing {site} for {client}; money pages {a, b};
audience {one phrase}. Prior audit: {date or none}." Correct on user reply.

## Phase 1 — Detect a prior run (the re-run path is first-class)

Glob `work/seo-audit-*/` (or `Projects/{slug}/seo-audit-*/`). If a prior run
exists, this is a **RE-RUN**: load its `data/baseline.json`, and this audit
leads with deltas — score change, categories that moved, findings resolved vs
newly tripped, regressions. A flat or falling score is reported as loudly as a
win. If none, it's a baseline run and says so. See `references/report.md` for the
exact delta block.

## Phase 2 — Gather signals (zero-API is the default path)

Default, no paid anything: fetch each in-scope URL and the homepage's
`robots.txt` + `sitemap.xml` with WebFetch; read rendered HTML for tags, headings,
links, structured data, and resource hints; pull a few representative templates
(home, a money page, a content page, a category) rather than every URL. For
sites too large to fetch page-by-page, ask the user for an export (a crawler CSV
of URLs + status codes + tags, a `sitemap.xml`) and read that.

**If connected** (optional accelerators, never required): a crawl/scrape
connector for breadth; a Core Web Vitals / PageSpeed source for field
performance data; Search Console for indexation truth. Use them to widen
coverage and replace estimates with measured numbers — note in the report which
findings used live data vs. inference.

Persist everything to the deliverable's `data/` as you gather it
(`data/pages/{url-slug}.json`, `data/robots.txt`, `data/sitemap.xml`) — on
context overflow, re-read the files, not the conversation.

## Phase 3 — Score the 16 categories

Run every category in `references/checklist.md`. Each check resolves to
**pass / warn / fail** against the stated thresholds, or **N/A** (excluded from
the math — never counted as a pass). Each finding records: `category · severity
(Critical/Warning/Info) · evidence (the URL + the exact tag/value) · why it
matters · fix · effort`. A finding without a cited URL or value does not exist.

Compute the weighted health score and letter grade with the formula in
`references/checklist.md` (transparent math — show the per-category table, never
a black-box number). Carve **quick wins**: Critical or Warning findings fixable
in under ~15 minutes (a missing meta description, an un-compressed hero image, a
broken canonical).

## Phase 4 — Write the deliverable (the differentiator)

Per `references/report.md`. Create `work/seo-audit-{YYYY-MM-DD}/` with:

- `brief.md` — scope (URLs audited), due, owner, acceptance criteria.
- `final/audit.md` — the report: score + grade, the re-run delta block (if any),
  category scorecard, quick wins, then findings worst-first.
- `findings/{critical,warning,info}/` — one short markdown file per material
  finding (page, evidence, fix, effort) so they can be assigned and closed
  individually.
- `data/baseline.json` — the machine baseline the next run diffs against:
  overall score, grade, per-category scores, and a findings fingerprint. **This
  file is what makes the re-run path work — always write it.**

Then write back to the workspace:

- **Ledger** — append to `goals.md`, exact format:
  `- {YYYY-MM-DD} | seo-health | {score} | {grade}, {n} critical` (e.g.
  `- 2026-06-13 | seo-health | 72 | C+, 3 critical`). If no `seo-health` goal
  is defined, create the definition (`unit: count`, `direction: up`, baseline =
  this score) and flag it in your summary for the user to confirm.
- **Task stubs** — the top findings (quick wins + Criticals) become checkbox
  task stubs: the account owner's `Team/{person}/tasks.md` in agency mode, the
  firm board / today's `Daily/` note in solo mode.
- **Activity** — one line to today's `Daily/` note under `## Activity`
  ("SEO audit for {client}: {grade}, {n} quick wins"). These two cross-workspace
  writes are the only ones the firewall permits.

## Phase 5 — Confirm

Show the user: grade + score, the headline delta (re-run) or "baseline saved"
(first run), the quick-win count, and the deliverable path. Offer the next move:
fix the quick wins, brief the client (`/client report`), or re-audit after the
fixes ship.

## Hard rules

- **Read before asking.** The URL, audience, offers, and voice live in the
  workspace — confirm them, never re-interview. Re-asking what's on disk is the
  loose-tool tell.
- **Always write the baseline.** No `data/baseline.json` = the re-run path is
  dead and the deliverable is just a PDF with extra steps.
- **Cite or it doesn't exist.** Every finding names a URL and the exact value.
- **Show the math.** The score is a visible weighted sum, never a vibe.
- **Zero-API is the default.** Connectors are accelerators gated behind "if
  connected" — the full audit must complete from fetched HTML + a manual export.
- **Firewall.** No sibling-client reads; rewrite suggestions use the CLIENT's
  `context/brand.md`. Writes stay in this workspace + the two whitelisted
  exceptions (Daily activity, assignee tasks).
