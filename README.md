# Conversion OS

**The client-operations system for agencies that run on Claude.**

Conversion OS turns a folder of markdown files into your firm's operating
system: persistent memory for every AI session, one self-contained workspace
per client, an engagement lifecycle from prospect to renewal, KPI tracking
that generates client reports, and a daily operating rhythm — all visible in
Obsidian, all owned by you.

> **Open beta — the full suite, free.** Every skill below is included while we
> battle-test the system with real firms. When the beta ends, the advanced
> suite becomes **Conversion OS Pro** (paid); the core stays free. Either way:
> your vault and everything in it is plain markdown and belongs entirely to
> you — nothing you build here can be taken away. Found friction? That's the
> deal — [open an issue](../../issues).

Built by [Conversion System](https://conversionsystem.com) — we run our own
firm on it.

## What's inside

| Command | What it does |
|---|---|
| `/setup` | Scaffolds your vault, ingests your website and docs *before* asking questions, interviews you adaptively, builds your firm's context with zero placeholder files — and ends with a generated brief for your #1 client |
| `/client` | The engagement manager: onboard clients into self-contained workspaces, one-screen strategist briefs, meeting prep and transcript logging, deliverables in *the client's* voice, weekly/monthly reports generated from the KPI ledger, a 9-signal health engine with a book-of-business pipeline, lifecycle transitions with checklists, archive-with-harvest |
| `/daily` | Your operating rhythm: resume context, morning brief, inbox triage, save sessions to memory, evening close, weekly review, plain-markdown task boards |
| `/autopilot` | Builds and schedules an autonomous agent that pulls meeting transcripts, chat, and email into the right client workspaces — with run budgets and human escalation |
| `/audit` | 6-category vault health check: structure, links, freshness, token budgets, the client-confidentiality firewall, frontmatter — score, report, per-category fixes |
| `/team` | Team rollout: sync options compared honestly (git / LiveSync / Relay), seats with per-person client scoping, onboarding/offboarding checklists |

Plus: the layered instruction architecture (a ≤120-line root routing file +
per-folder rules + per-client confidentiality contracts), a session-end git
snapshot hook so every memory write is revertible, and a
[demo vault](examples/demo-vault/) — open it in Obsidian to see the end state
before you start.

## The client-delivery library

The work you run *for* clients — and unlike standalone tools, every result
writes back into that client's workspace, so it compounds. Run a skill, and its
baseline lands in the client's KPI ledger; run it again next month and it leads
with what changed.

| Command | Delivers |
|---|---|
| `/lead-qualify` | Gate a lead list against the client's own ICP, with reasons |
| `/lead-research` | Source + 3-axis-score prospects (Hot/Warm/Cold) from the ICP |
| `/win-loss` | Deal patterns → a winning persona (written to the client's ICP) + a red-flag kill-list the other skills then use |
| `/email-sequence` | A designed multi-email sequence in the client's voice |
| `/email-personalize` | Human-sounding icebreakers, one per enriched lead |
| `/case-study` | A results case study built from the KPI ledger — the before/after *is* the proof |
| `/seo-audit` | A 16-category technical SEO audit with a tracked health score |
| `/seo-optimize` | 8 Search Console analyses → a prioritized optimization roadmap |
| `/ads-audit` | A multi-platform paid-media audit with a budget-weighted score |

Zero external API needed — they run from manual exports and web research;
scraping, Search Console, and ad-platform connectors are optional accelerators.

## Install (5 minutes)

1. **Add the plugin** — in Claude Code or Cowork: Plugins → add marketplace →
   paste this repo's URL → install `conversion-os`. (Or CLI:
   `claude plugin marketplace add ConversionSystem/Operating-System` then
   `claude plugin install conversion-os@conversion-system`.)
2. **Create an empty folder**, open it as your working folder, run `/setup`.
3. Optional: open the same folder as a vault in [Obsidian](https://obsidian.md)
   (free) to browse what Claude builds.

Then: [docs/setup-guide.md](docs/setup-guide.md) for the first hour,
[docs/roadmap.md](docs/roadmap.md) for day 1 → quarter 1.

## Docs

- [Setup guide](docs/setup-guide.md) — your first hour, step by step
- [Adoption roadmap](docs/roadmap.md) — the pace that works (solo first, team in week 4+)
- [Team & sync guide](docs/team-and-sync-guide.md) — git vs LiveSync vs Relay, seats, rollout order
- [Confidentiality model](docs/confidentiality.md) — three layers, honest limits
- [Instruction layer guide](docs/instruction-layer-guide.md) — why the routing files stay small

## Beta notes

- Feedback → [issues](../../issues). The fastest way to shape the product:
  tell us where a flow asked too much, guessed wrong, or slowed you down.
- Done-with-you installs for firms that want it running this month:
  [conversionsystem.com](https://conversionsystem.com).

## License

Source-available — free to use for your own firm and your clients' vaults
during the beta; no redistribution or resale. See [LICENSE](LICENSE). Vaults
you create, and everything in them, are entirely yours — forever.
