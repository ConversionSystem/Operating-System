# Engagement lifecycle

Status lives in `profile.md` frontmatter. The folder moves exactly once — to
`Clients/_archive/` at the end. Status flips are one-line edits so they actually
happen; the pipeline view is generated, not maintained.

## State machine

```
prospect → proposal → onboarding → active ⇄ paused
                                      ↓
                                   renewal → active        (outcome: renewed-prior on the renewal record)
                                      ↓
                                  offboarding → archived   (folder moves)
prospect | proposal → archived (outcome: lost)             (folder moves)
active   → archived only via offboarding (no skipping the exit ramp)
```

Anything else (e.g. `paused → renewal`, `onboarding → prospect`) is illegal —
explain and offer the legal path. The user can override with explicit
confirmation; log the override in `decisions.md`.

## Transition checklists

Run the checklist before flipping status. Unmet items: ask to resolve now,
carry as tasks, or override (logged).

**prospect → proposal**
- [ ] `profile.md` engagement summary states what we'd be hired to do
- [ ] proposal draft exists in `work/proposal/drafts/`
- [ ] `renewal:` field holds the proposal decision date

**proposal → onboarding** (they signed)
- [ ] signed scope reflected in `## Scope`
- [ ] commercials current: `billing`, `mrr`, `start`, `renewal`
- [ ] `goals.md` has goals with baselines (or a task to capture them in week 1)
- [ ] kickoff meeting scheduled (stub in `meetings/`)

**onboarding → active**
- [ ] kickoff logged
- [ ] `context/brand.md` + `icp.md` exist with real content
- [ ] first ledger observation recorded (the baseline confirmed in the wild)
- [ ] `cadence:` confirmed and first report date agreed

**active → paused** — reason + restart date in `health-note`; open actions parked.
**paused → active** — restart logged in `decisions.md`; goals reviewed for stale targets.

**active → renewal** (auto-suggested by health when `renewal:` ≤ 45 days out)
- [ ] `renewal:` date set in profile.md (no date, no renewal stage)
- [ ] renewal brief generated (brief + percent-to-goal per metric)
- [ ] renewal meeting scheduled
- [ ] recommendation drafted: renew as-is / expand / restructure — with evidence

**renewal → active** — new `renewal:` date; `decisions.md` records terms;
ledger note marks the new period.

**active|renewal → offboarding**
- [ ] final report generated and delivered
- [ ] open actions resolved or explicitly transferred to the client
- [ ] deliverables in `work/*/final/` complete; assets handover noted
- [ ] access/credentials revocation noted in `context/stack.md`

**offboarding → archived** — run the archive flow in SKILL.md (harvest, outcome,
folder move, link fixing, pipeline regen). `outcome:` is mandatory.

## Why frontmatter, not stage folders (the design bet)

Paths are load-bearing: routing tables, wikilinks, seat manifests, scheduled-agent
prompts, and git history all reference `Clients/{slug}/`. Seven folder moves per
client lifetime would break them seven times; one move breaks them once, exactly
when the client *should* fall out of scope. The cost — no visible pipeline in the
file tree — is paid back by the generated `Ops/pipeline.md`, which is better than
a tree anyway: it shows money, health, and renewal dates, not just names.
