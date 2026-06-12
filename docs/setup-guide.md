# Conversion OS — Setup Guide (your first hour)

## Before you start (5 min)

1. **Claude** — Claude Code (terminal/desktop) or Claude Cowork, signed in.
   Pro/Max recommended; setup is the heaviest session you'll run.
2. **Install the plugin** — one of:
   - Marketplace link: Plugins → add marketplace → paste this repo's GitHub URL
     → install `conversion-os`.
   - Claude Code CLI: `claude plugin marketplace add <repo-url-or-local-path>`
     then `claude plugin install conversion-os@conversion-system`.
   - Cowork zip: download repo zip → Customize → Plugins → upload.
3. **Create an empty folder** where the vault will live (e.g. `~/firm-os`).
   Local disk, not iCloud/Dropbox (sync comes later, deliberately).
4. Optional but recommended: install **Obsidian** (free) now; you'll connect it
   after setup. **git** if you want the session-snapshot safety net (you do).

## Gather your ammunition (10 min — this is what makes setup good)

The setup interview is import-first: the more you feed it, the less it asks.
Worth grabbing: your website URL · anything that describes your offers/pricing ·
a positioning or brand doc · 1–3 writing samples that sound like you · your
client list with rough monthly values · exports from Notion/Drive if that's
where your docs live. A voice-dictation tool is genuinely useful here — messy
brain-dumps beat tidy short answers.

## Run it (30–45 min)

1. Open the empty folder as your working folder. Run `/setup`.
2. **Mode**: Solo or Agency. Pick honestly — agency adds team seats; you can
   switch later via `/team`.
3. **Import**: hand over the ammunition. URLs get fetched, files get read.
4. **Interview**: 6–7 questions, one at a time, all skippable. It confirms what
   the imports already said instead of re-asking. Name your real clients in the
   book-of-business question — each becomes a live workspace.
5. **Build**: silent. Then the **report card** — which files are solid, which
   are thin. Thin is normal; the vault grows by use, not by ceremony.
6. **First win**: a brief on your #1 client (or a 7-day plan). Read it. This is
   the product.

## Connect Obsidian (5 min)

Open Obsidian → "Open folder as vault" → pick your vault folder. You now browse
the same files Claude operates. Nothing about the OS requires Obsidian — it's
the best free window onto it.

## Your first week

- Every session: start in the vault folder (that's how Claude gets its memory).
- Each morning: `/daily` → the brief. Before closing: `/daily save`.
- Next client meeting: `/client prep {name}` before, paste the transcript into
  `/client log {name}` after. Watch the workspace compound.
- Friday: `/client report {name} weekly` for your cadence-due clients —
  generated from the ledger, edited by you, sent with the cover note it offers.
- Anything unfiled: drop it in `Inbox/`; `/daily` triages.

## When something feels off

- Claude asking things it should know → the fact has no home yet; say "remember
  this" and it routes it, or check the report card's thin list.
- Vault feels noisy after a few weeks → `/audit`.
- Two devices / teammates → `docs/team-and-sync-guide.md` (don't improvise sync
  — two sync tools on one folder corrupts it).
