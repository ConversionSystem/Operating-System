---
name: lead-qualify
description: Gate a client's raw lead list against THEIR ICP and hand back only the leads worth working, each with a reason. Reads the client's icp.md as the qualification bar (never re-asks it), verifies each lead against live web sources because list data lies, and writes a tracked deliverable plus a goals ledger line. Triggers: /lead-qualify, "qualify these leads", "filter my lead list", "are these leads a fit", "score this list against our ICP", "clean my lead list", "which of these leads should I call".
---

# Conversion OS — Lead Qualify

Take a pile of leads, keep the ones that match the client's actual customer, throw
the rest back with reasons. The bar is the client's own ICP — already in the
workspace, so we confirm it, we never re-interview it. This is a binary gate, not
a beauty contest: a lead is in or out, and every verdict cites evidence.

Resolve the target client first (explicit arg → current session's client → ask;
"the agency's own" routes to `Projects/`). Read `Clients/{slug}/CLAUDE.md` and
obey the firewall: no sibling-client reads, deliverables stay in this folder.
If no vault exists (no root `CLAUDE.md`), stop: "Run /setup first."

## Phase 0 — Resolve & confirm the bar

1. **Load the ICP.** Read `context/icp.md` — this IS the qualification criteria.
   Also skim `context/offers.md` (what we'd sell them, sharpens "fit") and
   `context/people.md` if scoring named contacts. Never ask the user to restate
   their ICP; that's the loose-tool tell the whole workspace exists to kill.
2. **Confirm in one line, don't interrogate.** Echo the bar you parsed back:
   "Gating against ICP v{version}: {3–5 word summary of musts}. Right?" One
   AskUserQuestion only if `icp.md` is genuinely thin or absent.
3. **Detect a prior run** (RE-RUN path): glob `work/lead-intake-*/`. If found,
   load its `data/baseline.json` and announce this is a re-run — see Phase 5.

## Phase 1 — Parse ICP into a gate

Read `references/criteria.md`. Turn the prose ICP into an explicit boolean gate:
hard MUSTs (AND), acceptable alternatives (OR), and disqualifiers (NOT). Show the
parsed gate as a short table before scoring so the user can correct it once. If
`icp.md` lists no disqualifiers, derive the obvious inverse of the musts and flag
them as inferred.

## Phase 2 — Ingest the list

Accept a CSV path or pasted rows. Normalize columns (company, person, role, site,
email, source). **Persist raw immediately** to
`work/lead-intake-{date}/data/raw-leads.csv` — never hold the list only in
context (resumability). Dedupe by company+person; **flag** duplicates in a
`dupe-of` column, never silently drop them. Count `total` for the ledger.

## Phase 3 — Verify against live sources (fan-out)

List data lies — stale roles, dead companies, wrong size. So every lead is checked
against 2–3 live sources per `references/criteria.md` (the company site + a review
or directory site + a LinkedIn-via-web lookup). Default path is **zero-API**:
WebSearch + WebFetch only. A scraping/enrichment connector, *if connected*, is an
optional accelerator — never required.

- For >10 leads, **fan out fixed batches of ~10 per sub-agent in ONE message**
  (never sequential). Use `sales:lead-researcher` if available, else the default
  agent. Give each batch the parsed gate verbatim.
- Each sub-agent writes its results to
  `data/verified-batch-{n}.json` as it finishes (disk persistence; on overflow,
  read the files, not the conversation).
- Per lead, record: each gate criterion → met / not-met / unknown, with the source
  URL that decided it.

## Phase 4 — Gate & decide

Apply `references/criteria.md` decision logic:

- **All MUSTs met (or a valid OR alternative) and no disqualifier → Qualified Y.**
- **Any disqualifier hit → Qualified N**, reason = the disqualifier.
- **A MUST is unverifiable after 2–3 sources → borderline → qualify** (Y, reason
  flags the unknown). We err toward keeping; a human can drop a borderline faster
  than they can resurrect a wrongly-killed lead.
- Reason is one concrete clause citing the deciding criterion + source, never a
  bare "not a fit".

## Phase 5 — Write the deliverable (the differentiator)

Assemble `work/lead-intake-{date}/`:

- `brief.md` — scope, source list, ICP version gated against, date, owner,
  acceptance ("every lead has a Y/N + cited reason").
- `final/qualified.csv` — qualified leads, columns: company, person, role, site,
  reason, source-urls, borderline?, dupe-of. Plus `final/disqualified.csv` (kept,
  not deleted — the audit trail and the disqualifier signal).
- `data/` — `raw-leads.csv`, `verified-batch-*.json`, and `baseline.json`
  (`{date, icp_version, total, qualified, disqualified, borderline, dq_reasons:{}}`).
- **Ledger line** — append to `goals.md`, EXACT format:
  `- {date} | leads-qualified | {n} | of {total}, ICP {version}`.
  If no `leads-qualified` goal exists, create the definition (`unit: count`,
  `direction: up`) and flag it in your summary for the user to confirm.

**RE-RUN:** when Phase 0 found a prior run, lead the summary with the delta vs its
baseline — "{n} qualified ({+/-} vs {prior date}); qualify-rate {x}% → {y}%; new
disqualifier theme: {…}". Still append a fresh ledger line; the series is the moat.

**Learning loop:** if one disqualifier reason accounts for a large share of the
drops (e.g. >30% rejected for "company too small"), propose an append to
`context/icp.md` disqualifiers — dated, flagged for the user's confirmation, never
written silently.

## Phase 6 — Report & log

Show: counts (qualified / disqualified / borderline / dupes-flagged), the top 3
disqualifier reasons by frequency, paths to the deliverable, and the ledger line
written. One-line entry to today's `Daily/` note under `## Activity`. End with the
obvious next action — usually `/lead-research` to top up the list or
`/email-personalize` to work the qualified set.

## Hard rules

- The ICP comes from the workspace; re-asking it is a bug.
- Binary gate, never a 1–10 score. Borderline → qualify. Dupes flagged, never
  auto-dropped. Disqualified leads kept on disk, never deleted.
- Every verdict cites a source URL. "List says so" is not verification.
- Zero-API is the default; connectors are "if connected" accelerators only.
- Firewall: no sibling-client data; agency-self runs write to `Projects/{slug}/`.
