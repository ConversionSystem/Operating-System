---
name: setup
description: Bootstrap a Conversion OS vault — scaffold the folder structure, ingest existing docs, run the adaptive onboarding interview, build personalized firm context, and generate a first win. Use when the user says "set up", "setup", "install the OS", "bootstrap", "initialize my vault", or runs /setup in an empty or new folder.
---

# Conversion OS — Setup

Turn the current folder into the user's operating system. Outcome: a scaffolded
vault, real (never placeholder) context files about their firm, seeded client
workspaces, and one generated deliverable that proves value in the first session.

Work through the phases in order. Don't narrate file creation; show results.

## Phase 0 — Preflight & mode

1. If a `CLAUDE.md` already exists in the current folder, stop and offer `/audit`
   (vault exists) or setup in a different folder. Never scaffold over an existing vault.
2. Note any existing files in the folder — they become import candidates in Phase 1.
3. Ask mode (AskUserQuestion, one question):
   - **Solo** — consultant, freelancer, fractional exec. Leaner tree, no Team/.
   - **Agency** — team serving clients. Adds Team/ seats and aggregated views.
   Default to Solo if skipped. Record as `cos-mode` for the root CLAUDE.md frontmatter.

## Phase 1 — Import first

Before any interview question, gather what already exists. Ask once
(AskUserQuestion with "Other" for free input): website URL, brand/positioning
docs, service/pricing docs, client list, anything in Notion/Drive exports, or a
local folder path. Then:

- Fetch URLs with WebFetch (homepage + about/services pages for a website).
- Read uploaded/local files (PDF, MD, DOCX, CSV).
- Glob + read a provided folder.
- Skim existing files found in Phase 0.
- Nothing to import → say "no problem, the interview covers it" and proceed to
  Phase 2 cold; every question is then asked rather than confirmed.

Build a working corpus. Everything learned here pre-fills interview answers — in
Phase 2, *confirm* instead of asking cold ("Your site says you do X for Y — still
accurate?"). Skip any later question the corpus already answers confidently.

## Phase 2 — Adaptive interview

Read `references/interview.md` and follow it. Mechanics:

- One AskUserQuestion per question, in order. Quick-pick options + "Other"; every
  question skippable.
- Branch follow-ups ONLY when the trigger in the script fires (max one follow-up
  per question). Never interrogate.
- Voice answers welcome: tell the user a messy brain-dump is ideal; you structure it.
- If the user says "skip all" or "just build it", jump to Phase 3 with the corpus.

## Phase 3 — Silent build

Read `references/vault-structure.md` (tree + schemas), then build without narrating:

1. Create the directory tree for the chosen mode.
2. Write system files from `references/system-files.md` (.claudeignore, .gitignore,
   `.claude/settings.json`, both hook scripts; `chmod +x` the hooks). If `git` is
   available and the folder isn't a repo, run `git init` now; the initial commit
   happens once at the END of Phase 3, after all files exist — it powers the
   session-snapshot safety net.
3. Write the root `CLAUDE.md` from `references/root-claude-md.md`, filling every
   placeholder from the corpus (firm name, voice rules, seed rules).
4. Write each folder's `CLAUDE.md` from `references/folder-claude-md.md`.
5. Write `Company/` context files from `references/company-templates.md` — only
   files with real data; omit empty sections entirely. Use the user's exact names,
   numbers, phrases. No `[placeholders]` may survive into the vault.
6. Seed client workspaces for every client named in the interview: follow the
   workspace spec in `../client/references/workspace.md` (tree, profile.md
   frontmatter, per-client CLAUDE.md). Fill status/tier/owner/goals from whatever
   was shared; leave unknowns out rather than inventing.
7. Create today's `Daily/YYYY-MM-DD.md` with a setup log.
8. Create `Library/` starter content from `references/library-kit.md`.

Then show the **report card** — one table: file → one-line summary of what's in it →
confidence (solid / thin / missing). "Thin" rows become the user's top-up list. Tell
them: drop anything into `Inbox/` or just talk — facts get routed automatically.

## Phase 4 — First win

Don't end on an empty promise. Read `references/first-win.md` and generate one of:

- **A client brief** for their most important client (default when clients exist).
- **A 7-day operating plan** from strategy + priorities (when no clients yet).

Deliver it in the session AND save it to the right home. Close with the three
habits: start every session in this folder · `/daily` each morning · `/client` for
anything client-related.

## Hard rules

- Never create a file you'd describe as "ready for the user to fill in".
- Never reproduce interview questions back as headings; write synthesized prose.
- Never skip the report card or the first win.
- If a step fails (no git, WebFetch blocked), continue and note it in the report card.
