# Seat scoping — generated per-machine ignores

Goal: on any machine, Claude loads only the clients that seat works on. This is
attention scoping and accidental-leak prevention — NOT security (the human can
still open files their sync shares with them; for contractual walls use the
hard partition in docs/confidentiality.md).

## Mechanism

1. Source of truth: `Team/{slug}/access.md` frontmatter `clients:` list.
2. On `/team scope {person}` (run on that person's machine), generate exclusions:
   - For every client slug NOT in their list → `Clients/{slug}/` line.
   - Always: `Clients/_archive/`.
3. Write target — first available:
   a. Append under the marker comment in `.claudeignore` **if the vault is
      single-machine or .claudeignore is gitignored** (the setup default keeps
      .claudeignore committed for solo vaults; on team vaults, FIRST move it to
      .gitignore so seat lists don't sync between machines and overwrite each
      other — do this migration automatically and say so).
   b. Regenerate idempotently: wipe everything below the marker, re-add.
4. Verify: list 2 excluded paths and confirm reads are skipped.

## Sync interaction

- **Relay teams**: folder-level shares already limit what arrives on the
  machine; generated ignores then align Claude's view with the share map. Both
  derive from access.md — regenerate after any access change.
- **Git teams**: every clone has every file (git has no partial checkout worth
  the pain here). The ignore file is the only scoping layer — state that
  clearly, and route NDA-bound clients to the hard partition instead.

## Owner seats

`role: owner` or `clients: all` → no client exclusions; still excludes
`_archive/`. Owners see the whole board — pipeline.md exists for them.
