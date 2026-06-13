# SEO audit report structure + re-run deltas

How the deliverable is assembled and written into the workspace. The scoring and
check thresholds live in `checklist.md`; this file is the output shape, the
workspace writes, and the re-run path.

## Where everything lands

```
Clients/{slug}/work/seo-audit-{YYYY-MM-DD}/      (Projects/{slug}/… for agency-self)
├── brief.md                       # scope, due, owner, acceptance criteria
├── final/
│   └── audit.md                   # the report (structure below)
├── findings/
│   ├── critical/{n}-{slug}.md     # one file per material finding
│   ├── warning/{n}-{slug}.md
│   └── info/{n}-{slug}.md
└── data/
    ├── baseline.json              # the machine baseline the next run diffs
    ├── pages/{url-slug}.json      # per-URL gathered signals
    ├── robots.txt
    └── sitemap.xml                # (or the user-supplied crawl export)
```

`{YYYY-MM-DD}` makes runs sort chronologically and keeps each baseline distinct —
the re-run path globs `seo-audit-*/` and reads the most recent `baseline.json`.

## brief.md

Standard deliverable brief (matches every other `work/` deliverable):

```markdown
---
type: brief
status: active
date: {{TODAY}}
tags: [client, {slug}, seo-audit]
---
# SEO audit — {Client} — {{TODAY}}
- **Scope:** {n} URLs / templates audited: {list the representative set}
- **Method:** zero-API fetch + {manual export | CWV connector | crawler — note what was used}
- **Due:** {date} · **Owner:** {person} · **Requested by:** {who}
- **Acceptance:** scored audit + quick-wins list + baseline saved for re-audit;
  every Critical has a cited URL and a fix.
```

## final/audit.md — report structure

Frontmatter: `type: report`, `status: active`, `date`, `tags: [client, {slug},
seo-audit, generated]`. Then, in order:

1. **Headline** — one line: grade + score + the single most important takeaway.
   - First run: "Baseline: C+ (72/100). 3 Criticals capping the grade; 9 quick
     wins shippable today."
   - Re-run: lead with the **delta** (see below), not the absolute score.
2. **Re-run delta block** — only on a re-run; see the next section. Skipped on a
   baseline run with a one-liner: "First audit — this is the baseline future
   audits chart against."
3. **Scorecard** — the per-category table, so the math is visible:

   | Category | Score | Weight | Contribution | Worst finding |
   |---|---|---|---|---|
   | Indexability & crawl | 64 | 14 | 9.0 | 🔴 noindex on /pricing |
   | Core on-page tags | 82 | 12 | 9.8 | 🟡 12 duplicate titles |
   | … | | | | |
   | **Overall** | **72 (C+)** | **100** | | **capped at C — see Criticals** |

   Note any N/A categories and the re-normalized weights beneath the table.
4. **Quick wins** — the carved list (from `checklist.md`), highest-impact first.
   Each: what, where (URL/template), the fix, est. effort. This is the section
   the client acts on first.
5. **Findings — worst first** — grouped Critical → Warning → Info. Each finding:
   - **What** (one line) · **Where** (URL + the exact tag/value as evidence) ·
   - **Why it matters** (the ranking/UX/trust consequence) ·
   - **Fix** (concrete, in the client's voice if it's copy) · **Effort** (mins /
     hours / sprint).
   Reference the matching `findings/{sev}/` file so each can be assigned.
6. **Prioritized backlog** — everything that isn't a quick win, ranked by
   impact × effort: P0 (Criticals), P1, P2, P3. This is what `/client report` and
   task stubs draw from.
7. **Method & confidence** — what was fetched vs. inferred; which findings used
   live data (CWV/Search Console) vs. estimates; what a deeper pass would add.

## findings/{sev}/{n}-{slug}.md

One file per material finding so they're individually assignable and closeable:

```markdown
---
type: note
status: open
tags: [seo-audit, {severity}, {category}]
---
# {Short finding title}
- **Category:** {category} · **Severity:** {Critical|Warning|Info}
- **Where:** {URL}  ·  **Evidence:** `{exact tag/value found}`
- **Why:** {the consequence}
- **Fix:** {concrete step}  ·  **Effort:** {mins|hours|sprint}  ·  **Quick win:** {yes|no}
```

## data/baseline.json — the re-run engine

The single most important file in the deliverable. Without it the next run can't
compute deltas and the whole longitudinal pitch collapses. Write it every run:

```json
{
  "date": "2026-06-13",
  "overall_score": 72,
  "grade": "C+",
  "grade_capped_to": "C",
  "critical_gate_reason": "noindex on /pricing",
  "categories": {
    "indexability": 64, "core_tags": 82, "performance": 70, "content": 75,
    "internal_linking": 80, "structured_data": 50, "mobile": 88, "url": 90,
    "links": 85, "images": 60, "security": 100, "indexation": 78,
    "accessibility": 72, "international": "N/A", "social": 40, "compliance": 67
  },
  "active_weight_total": 97,
  "counts": { "critical": 3, "warning": 14, "info": 21 },
  "quick_wins": 9,
  "findings_fingerprint": [
    "indexability:noindex:/pricing",
    "core_tags:dup-title:/blog/*",
    "performance:lcp>4s:/"
  ],
  "scope_urls": ["/", "/pricing", "/blog/x", "/category/y"],
  "method": "zero-api-fetch"
}
```

The `findings_fingerprint` (a stable `category:issue:where` string per finding)
is what lets the next run say *which specific findings* resolved or reappeared,
not just that the count changed.

## Re-run delta block (lead the report with this)

On a re-run, load the prior `baseline.json` and open the report with movement,
not the absolute score. Compute and present:

```markdown
## Since last audit ({prior date} → {{TODAY}})

**Health: 72 (C+) → 78 (C+), +6 points.** ↑ recovering — keep going.

| Movement | Detail |
|---|---|
| ✅ Resolved (4) | noindex on /pricing fixed · sitemap now in robots.txt · hero LCP 5.1s→2.3s · viewport meta added |
| 🔴 New (1) | broken canonical on /blog/new-post → /old-post (Critical) |
| 📈 Improved | Performance 70→81 · Indexability 64→79 |
| 📉 Regressed | Social 40→32 (OG images dropped in the redesign) |
| ➖ Unchanged | Structured data still 50 — FAQ schema opportunity open since last run |

**Net:** the spend on the page-speed work paid off (+11 perf). One new Critical
from the blog migration to fix this week. Structured-data gap is now the oldest
open item — two audits running.
```

Rules for the delta block:

- **Lead with the score change and direction**, then the resolved/new/moved
  breakdown. A flat or falling score is reported as plainly as a gain — no
  burying a regression.
- Diff `findings_fingerprint` arrays: present in old & not new = **resolved**;
  in new & not old = **new**; in both = **persisting** (call out anything open
  across 2+ runs — that's the nag that drives action).
- Tie movement to known work where the workspace shows it (a `decisions.md`
  entry, a shipped `work/` item, a meeting) — "the speed work we agreed in the
  May review landed." That connection is the agency value, not the raw number.

## Workspace writes (do all of these — this is what makes it a deliverable)

After the report is written:

1. **Ledger** → append to `goals.md`, exact format:
   `- {{TODAY}} | seo-health | {score} | {grade}, {n} critical`
   Example: `- 2026-06-13 | seo-health | 72 | C+, 3 critical`.
   - The value is the bare overall score (the unit lives in the goal def).
   - If no `seo-health` goal exists, add the definition and flag it:
     ```yaml
     - id: seo-health
       metric: "Technical SEO health score"
       unit: count
       baseline: {this score}        # first run sets the baseline
       target: 90                    # propose A-grade; user can adjust
       due: {propose +90d}
       direction: up
     ```
     Say in the summary: "Created the `seo-health` goal (baseline {score}) —
     confirm the target/due."
2. **Task stubs** → top findings (every quick win + every Critical) as
   checkboxes. Agency mode → account owner's `Team/{person}/tasks.md`; solo →
   the firm board / today's `Daily/` note. Format:
   `- [ ] SEO: {fix} — {URL} (quick win, ~10m) [[work/seo-audit-{date}/final/audit]]`.
3. **Activity** → one line to today's `Daily/` note under `## Activity`:
   `- SEO audit · {client} · {grade} ({score}), {n} quick wins → [[…/audit]]`.

Writes 2 and 3 are the only cross-workspace writes the firewall allows. Rewrite
suggestions in any finding use the CLIENT's `context/brand.md` voice — never the
agency's.

## Re-run summary line (what you tell the user at the end)

- First run: "Baseline saved: {grade} ({score}). {n} quick wins, {c} Criticals.
  Deliverable at `work/seo-audit-{date}/`. Re-audit after the fixes ship and I'll
  chart the gain."
- Re-run: "{prior grade}→{grade} ({+/−} pts) since {prior date}. {x} resolved,
  {y} new. Ledger updated. Biggest open item: {oldest persisting finding}."
