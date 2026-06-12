# Conversion OS — Confidentiality Model

Client work demands walls. Conversion OS gives you three, in escalating
strength — and is honest about what each one is.

## Layer 1 — The behavioral firewall (always on)

Every client workspace carries a `CLAUDE.md` scope contract: while working in
`Clients/{slug}/`, Claude reads only that folder + `Library/` +
`Company/standards/` + `Company/offers.md`; never reads sibling clients; uses
the client's own voice file; writes only inside the workspace plus two
whitelisted exceptions (a one-line daily activity entry, task assignment).
`Clients/CLAUDE.md` states the same rules area-wide, and `/audit` C5 lints for
violations (Library leaks, cross-client references, escaped client material,
credential patterns) and reports them above everything else.

**What it is:** strong, continuously-enforced working discipline for the AI,
with an independent audit. **What it is not:** an access boundary for humans.

## Layer 2 — Seat scoping (agency teams)

Each person's `Team/{person}/access.md` lists their clients. `/team scope`
generates machine-local ignore entries so Claude on that machine never loads
other clients' folders; on Relay-synced teams, folder-level shares mean
out-of-scope client folders never even arrive on the machine.

**What it is:** need-to-know by default — attention scoping plus
accidental-leak prevention, aligned with what sync delivers. **What it is
not:** security against a determined human with filesystem access. Never sell
it as "access control" — we don't.

## Layer 3 — Hard partition (NDA-grade)

When a contract requires real separation: the client folder becomes its own
private git repository, mounted into the vault at `Clients/{slug}/` on exactly
the machines whose seats hold repo access. Enforcement = repository membership;
revocation = removing it. The workspace spec is identical, so every skill works
unchanged. Trade-off: that client rides git sync regardless of the team's main
sync choice, and the operator manages one extra repo per partitioned client.
Default to Layer 2; escalate per client, not vault-wide.

## Operating rules that keep all three honest

1. **Credentials never enter the vault.** `context/stack.md` records *where*
   credentials live (the client's password manager, a named vault), never the
   credentials. `/audit` C5 flags violations.
2. **Archive is dark.** `Clients/_archive/` sits in `.claudeignore` — closed
   engagements leave the AI's view entirely.
3. **The Library never learns client secrets.** Lessons move only through
   `/client harvest`: anonymized, owner-approved, consent-flagged for any
   case-study use.
4. **Offboarding revokes sync first** (see the team skill checklists) — the
   order exists because every later step assumes the person can no longer pull.
5. **Quarterly `/team audit`** reconciles manifests against client `team:`
   arrays; drift is a finding, not a footnote.

## What to tell clients (and prospects) when asked

"Your engagement lives in its own workspace with an enforced scope contract;
our team's AI sessions can't see your material while working on anyone else,
and your folder is only on the machines of the people staffed on your account.
If your NDA requires it, your workspace runs as its own private repository —
access is repository membership, revocable in one step."
