# First win — never end setup on an empty vault

Pick by what onboarding produced. Generate it fully, show it in the session, save
it to its home, and tell the user where it lives.

## Path A — client brief (default when ≥1 client was seeded)

Target: the highest-tier seeded client (break ties: shakiest health, then highest
mrr). Build the brief from everything just learned: who they are, scope, what
"going well/shaky" means right now, money, and 3 concrete recommended next
actions in the firm's voice. Save to `Clients/{slug}/reports/{{TODAY}}-brief.md`
(`type: brief`). Close with: "This took 30 seconds because the vault now knows
your book. It gets sharper with every meeting you log — try `/client prep {slug}`
before the next call."

## Path B — 7-day operating plan (no clients yet)

Build from strategy.md + offers.md + icp.md: this week's 3 priorities translated
into concrete daily moves (incl. pipeline-building actions tied to the ICP), each
with a where/when. Save to `Daily/{{TODAY}}.md` under `## This week`. Close with:
"Run `/daily` tomorrow morning — it picks this plan up and builds your brief
around it."

## Path C — proposal skeleton (user explicitly mid-deal during onboarding)

If the interview surfaced a live deal ("sending a proposal Friday"), offer this
instead: a proposal draft for that prospect from offers.md + icp.md + their
described situation, in the firm's voice. Save to
`Clients/{prospect-slug}/work/proposal/drafts/{{TODAY}}-proposal.md` (the prospect
workspace was seeded with `status: proposal`). This is the strongest possible
first win — only use when the deal is real.
