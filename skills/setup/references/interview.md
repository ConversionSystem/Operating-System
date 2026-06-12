# Onboarding interview script

One AskUserQuestion per question. Quick-picks listed per question, always plus
"Other" (free text — invite voice-dump length answers) and "Skip". Pre-fill from
the Phase 1 corpus: when the corpus already answers a question, convert it to a
confirmation ("Your site says X — accurate?") or skip it silently. Branch
follow-ups fire only on their trigger, max one per question.

## Solo mode (Q1–Q6) · Agency mode (Q1–Q7)

### Q1 — You and the firm  → Company/profile.md
Ask: name, firm name, what you do in one sentence, where you're based, how a
happy client would describe working with you.
Quick-picks: "Solo consultant" · "Fractional exec" · "Studio/agency founder".
Branch — trigger: firm ≠ just the user (partners, staff mentioned in solo mode)
→ ask who else is involved and how (feeds team.md or suggests agency mode; offer
to switch modes if clearly a team).

### Q2 — Offers and pricing  → Company/offers.md
Ask: what you sell (every revenue line), what each costs or how it's priced,
what delivery looks like (retainer, project, performance).
Quick-picks: "One core offer" · "Tiered packages" · "Custom-scoped projects".
Branch — trigger: multiple distinct lines mentioned → ask which one pays the
bills today and which is the growth bet (feeds strategy.md too).

### Q3 — Who you serve  → Company/icp.md (+ brand.md positioning)
Ask: who buys (role + company type), the problem in THEIR words, what triggers
them to look for help, 1–2 real examples (no need to anonymize — this stays in
your vault).
Quick-picks: "One clear ICP" · "Two segments" · "Still figuring it out".
Branch — trigger: "still figuring it out" → ask about the last 3 clients who
paid happily; derive the pattern for them.

### Q4 — Voice  → Company/brand.md
Ask: paste 1–3 things you've written that sound like you (email, post, proposal
fragment) — or describe the voice: 3 adjectives, phrases you use, words you ban.
Quick-picks: "I'll paste samples" · "Describe it for me from my website" ·
"Default: plain, direct, concrete".
Branch — trigger: samples pasted → extract voice rules and read 2 back for
confirmation before writing brand.md.

### Q5 — Book of business + this quarter  → Clients/ seeding + Company/strategy.md
Ask (two parts, one question): (a) list current clients — name, what you do for
them, rough monthly value, how it's going (great / fine / shaky), plus deals in
motion; (b) the firm's 1–3 priorities this quarter, with a number attached where
one exists.
Quick-picks: "3 or fewer clients" · "4–10" · "10+ (I'll list the top 5)" ·
"No clients yet".
Branch — trigger: any client described as shaky → ask what's wrong in one line
(feeds that client's seeded `health: yellow|red` + health-note — the one-time
seeding exception; after setup only /client health sets these).
Each named client becomes a seeded workspace: profile.md with status
(active/prospect), tier (by value), mrr if given, health if hinted. Goals only
if stated — never invent baselines. Part (b) always writes Company/strategy.md
(it's what /daily briefs and the no-clients first win build from).

### Q6 (agency) — Team and seats  → Company/team.md + Team/
Ask: who's on the team — name, role, which clients they touch.
Quick-picks: "2–3 people" · "4–10" · "Just me + contractors".
Branch — trigger: contractors mentioned → ask which clients contractors may see
(feeds access.md manifests; flags docs/confidentiality.md as relevant).
Creates `Team/{person}/` with profile.md, access.md (clients list), tasks.md.

### Q6 (solo) / Q7 (agency) — Stack and drains  → Company/stack.md (+ autopilot notes)
Ask: where work actually lives (email, Slack, meeting recorder, PM tool, CRM),
and the 1–2 recurring chores you'd automate first.
Quick-picks: "Google-centric" · "Microsoft-centric" · "Mixed/other".
Branch — trigger: a meeting recorder or Slack named → note it as an /autopilot
connector candidate and say so in the report card ("autopilot can ingest these").

## Writing the answers

- Synthesize prose; never echo the question as a heading.
- Use their exact phrases for ICP pains and brand voice — specificity is the asset.
- A skipped question = an omitted file or section, plus a "thin/missing" row on
  the report card. Never write a stub.
