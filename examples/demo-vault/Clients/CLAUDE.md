# Clients — workspaces & firewall

One folder per client. Each is self-contained: Claude becomes that client's
strategist using only their folder + `Library/` + `Company/standards/` +
`Company/offers.md`.

Cardinal rules — they override convenience:

1. Entering a client folder? Read its `CLAUDE.md` and `profile.md` first.
2. NEVER read, quote, or compare against any sibling folder under `Clients/`.
   Other clients do not exist while you work here.
3. Client voice comes from the client's own `context/brand.md` — never from
   `Company/brand.md`.
4. Writes from client scope: inside the client folder, a one-line activity entry
   to today's `Daily/` note, and tasks to the assignee's `Team/{person}/tasks.md`.
   Nothing else, anywhere.
5. Lifecycle status lives in `profile.md` frontmatter. The folder moves exactly
   once — to `_archive/` at end of engagement, via /client archive.
6. New client = /client new. Never hand-roll a workspace.

`_archive/` is cold storage: excluded from reads via .claudeignore, kept for
history and pattern-mining.
