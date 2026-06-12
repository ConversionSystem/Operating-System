# Conversion OS — Foundation

**The client-operations system for agencies that run on Claude.**

Conversion OS turns a folder of markdown files into your firm's operating
system: persistent memory for every AI session, one self-contained workspace
per client, and a daily operating rhythm — all visible in Obsidian, all owned
by you.

This is **Foundation**, the free tier. It's the real system, not a teaser: the
full vault architecture, the adaptive onboarding, the client workspace model,
and the daily rituals. What it doesn't do is *run* the engagement for you —
that's [Pro](#conversion-os-pro).

Built by [Conversion System](https://conversionsystem.com) — we run our own
firm on it.

## What Foundation includes

| Command | What it does |
|---|---|
| `/setup` | Scaffolds your vault, ingests the docs and website you already have *before* asking questions, interviews you adaptively, builds your firm's context with zero placeholder files — and ends with a generated brief for your #1 client |
| `/client` | Onboard clients/prospects into self-contained workspaces (their brand, ICP, goals, people, meetings, work), and get a one-screen strategist brief on any of them |
| `/daily` | Your operating rhythm: resume context, morning brief, inbox triage, save sessions to memory, weekly review, plain-markdown task boards |

Plus: the layered instruction architecture (a ≤120-line root routing file +
per-folder rules + per-client confidentiality contracts), a session-end git
snapshot hook so every memory write is revertible, a structure lint, and a
[demo vault](examples/demo-vault/) you can open in Obsidian to see the end
state before you start.

## Install (5 minutes)

1. **Add the plugin** — in Claude Code or Cowork: Plugins → add marketplace →
   paste this repo's URL → install `conversion-os`. (Or CLI:
   `claude plugin marketplace add ConversionSystem/Operating-System` then
   `claude plugin install conversion-os@conversion-system`.)
2. **Create an empty folder**, open it as your working folder, run `/setup`.
3. Optional: open the same folder as a vault in [Obsidian](https://obsidian.md)
   (free) to browse what Claude builds.

Full walkthrough: [docs/setup-guide.md](docs/setup-guide.md).

## Conversion OS Pro

Foundation lets you *hold* a client. Pro lets you *run* the engagement:

- **Reports that write themselves** — weekly/monthly client reports generated
  from the KPI ledger and meeting history, with an email cover note
- **Meeting intelligence** — prep briefs before calls; transcripts filed,
  decisions/actions/metrics extracted after
- **The health engine** — 9 mechanical churn-risk signals, a generated
  book-of-business pipeline, renewal radar
- **Engagement lifecycle** — prospect → renewal as a state machine with
  transition checklists, archive-with-harvest that turns ended engagements
  into playbooks and case studies
- **`/autopilot`** — a scheduled agent that pulls transcripts/chat/email into
  the right client workspaces with budgets and escalation
- **`/audit`** — 6-category vault health checks with a confidentiality lint
- **`/team`** — seats, per-person client scoping, onboarding/offboarding
- **The playbook library** + quarterly update releases

Pro, guided cohort builds, and done-with-you installs:
**[conversionsystem.com](https://conversionsystem.com)** or open an issue here.

## License

Source-available — free to use for your own firm and your clients' vaults; no
redistribution or resale. See [LICENSE](LICENSE). Vaults you create, and
everything in them, are entirely yours.
