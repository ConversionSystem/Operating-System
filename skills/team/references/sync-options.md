# Sync decision tree + honest comparison

## Decide

1. **Solo, one machine** → no sync. Local git (already wired by setup) is your
   history + backup via any normal backup tool.
2. **Solo, multiple devices** → privacy-first: LiveSync (E2EE, self-hosted,
   ~$0–5/mo). Git-comfortable + mostly desktop: git plugin (free, full history).
3. **Team, async, desktop, git-literate** → git plugin on a private repo. Free,
   versioned, conflict-prone only when two people edit the same file between
   pulls.
4. **Team, real-time co-editing** → Relay (CRDT live editing, folder-level
   sharing, per-user accounts). Keep local git underneath for history.
5. **Never** run two whole-vault sync mechanisms on one folder (corruption risk).

## Comparison (tell users the cons unprompted)

| | Git plugin | LiveSync (self-hosted) | Relay |
|---|---|---|---|
| Model | commit/pull on a timer | CouchDB server you own | hosted CRDT co-editing |
| Realtime | no (~10 min) | near (seconds) | yes (live cursors) |
| Conflicts | manual merges happen | auto-merge, edge cases | none (CRDT) |
| History | full git history | revision-based, limited | limited |
| E2E encrypted | no (private repo only) | yes | no (transit/rest only) |
| Per-user access | repo-level only | none (shared credential) | per-user, folder-level shares |
| Mobile | weak/unstable | solid | solid |
| Cost | free | ~$0–5/mo hosting | free ≤3 users → ~$6–18/user/mo |
| Ops burden | low | you run a server | none |
| Watch out | workspace.json must be gitignored; mobile flaky | one credential for everyone; DB needs periodic rebuild | plugin version lock-step across the team; not E2EE |

## Setup pointers

- **Git**: private repo → vault = clone → plugin (community "Git") → auto
  commit+pull ~10 min, merge strategy (not rebase) → each member sets their own
  author identity → ensure `.gitignore` covers `.obsidian/workspace*` (setup's
  template already does).
- **LiveSync**: deploy CouchDB (Railway/Fly free tiers) → plugin → E2EE
  passphrase shared out-of-band → additional devices join via the plugin's
  settings-copy mechanism → calendar a quarterly DB rebuild.
- **Relay**: install plugin → sign in → create a relay → share folders
  selectively (e.g. share `Company/`, `Library/`, `Ops/`, and each seat's
  client folders; keep `Daily/`+`Team/{self}/` private) → invite by share key →
  each member places shared folders in their own vault.
- **Relay + seats**: folder-level shares ARE the access control — share a
  client folder only with that account team. Our `access.md` manifests are the
  source of truth for who gets which share; the AI-side ignore generation (see
  seats.md) keeps Claude's view consistent with it.
