# Reporting procedures (brief · prep · weekly · monthly)

Skeletons live in `Library/templates/` (client-brief.md, client-report-weekly.md);
this file is the composition procedure. Universal rules: evidence before
narrative; numbers from the ledger only; firm voice (`Company/brand.md`) for
reports since they're agency-authored — client voice is for deliverables.

## Brief (internal, one screen)

Reads: profile.md · goals.md (defs + last 5 ledger lines per goal) · decisions.md
(last 5) · last 3 meetings · open work/*/brief.md. Compose: **State of play** (one
paragraph: scope, status, money, mood) → **Momentum** (ledger movement + last
meeting outcome) → **Risks** (tripped health signals, cited) → **Open loops**
(unchecked actions, with ages and owners) → **3 recommended next actions**
(concrete: verb, object, deadline).

## Prep (brief + agenda)

Add to the brief: **Agenda** built from unresolved actions (oldest first), metric
movement since last meeting ("leads 118 → 131 since we spoke"), decisions waiting
on them, and 2–3 talking points phrased in the client's own vocabulary (pull
exact phrases from `context/brand.md` / `context/icp.md`). Save as a meeting stub
with `status: draft`; /client log completes it.

## Weekly report → `reports/YYYY-Www.md`

1. Window = since the previous `YYYY-Www.md`/`YYYY-MM.md` file (briefs in
   `reports/` don't count as reports), or 7 days if none.
2. Gather: ledger lines in window · meetings in window (decisions, completed
   actions) · work/ files touched (shipped = anything that moved to final/).
3. Compose per the Library skeleton: Wins (max 3, each tied to a number or a
   shipped artifact) → Metrics table (goal · baseline · current · target · trend
   arrow; "no new data" where the ledger is silent in-window) → Shipped → Next
   period (from open briefs + agreed actions) → Needs from you (each ask gets a
   date).
4. Snapshot the numbers INTO the report (it must stand alone in an email).
5. Frontmatter: `type: report`, `client`, `date`, `period: YYYY-Www`.

## Monthly report → `reports/YYYY-MM.md`

Weekly procedure plus: **Trajectory** per goal — percent-to-goal, pace vs `due`
("at current pace, target lands ~3 weeks late"), and one recommendation per
off-pace goal (do differently / re-baseline / re-scope — with reasoning). Include
a 1-paragraph **Month in review** narrative up top; executives forward this one.

## After saving any report

Offer the cover email (Library/styles/client-email.md): 3 sentences max — the
single headline number or win, one thing you need from them, link/attachment
note. Subject = the headline ("Acme weekly: leads +11%, one approval needed").
