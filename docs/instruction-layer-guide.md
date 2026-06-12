# Conversion OS — Instruction Layer Guide

Why the routing files stay small, and how to keep them that way. This is the
methodology behind the budgets `/audit` enforces.

## The model: one map, many doors

- **Root `CLAUDE.md` (≤120 lines)** loads every session. It carries only what
  every session needs: identity, the startup protocol, the routing map, voice
  rules, taught rules, anti-patterns.
- **Folder `CLAUDE.md` (15–50 lines)** loads when work enters that folder. Local
  rules only.
- **Client `CLAUDE.md` (the scope contract)** loads on entering a workspace and
  *changes the rules* — read scope narrows, voice authority switches, writes get
  whitelisted.
- **Skill references** load only when a skill runs. Procedures live there, never
  in the vault's instruction files.

Public grounding for the approach: Anthropic's guidance on memory files and
instruction specificity (small, specific instruction files outperform large
vague ones by a wide margin), and Karpathy's published notes on maintaining
wiki-style knowledge bases for LLMs (index pages + leaf pages, ruthless
pruning). We apply both with our own budgets and checks.

## What earns a line in the root file

Ask three questions; all must be yes:
1. Needed in *most* sessions? (else → folder file)
2. Would removing it cause a real mistake? (else → delete)
3. Is it stated as a testable behavior? ("Quote prices only from
   Company/offers.md", not "be accurate about pricing")

## Where instructions go

| Instruction kind | Home |
|---|---|
| Universal behavior, routing, voice | root CLAUDE.md |
| How one folder works | that folder's CLAUDE.md |
| Client-scope rules | the client's CLAUDE.md contract |
| Procedures (how to run a report, an audit…) | the skill that does it |
| Document shapes | `Library/templates/` |
| One instruction in two places | nowhere — that's a C4 audit fail |

## The teaching loop

Corrections compound only if they land in writing. When you correct Claude and
the correction generalizes → one line under root `## Rules`. When it's about one
folder's contents → that folder's file. When it's a procedure → tell the skill's
notes (`Skills/{name}/notes.md`). Rules are pruned at audit time with the same
three questions.

## Maintenance rhythm

- **Monthly (`/audit` C4):** root >120 lines, folder files >50, duplicated
  instructions, filler density — each finding comes with a proposed diff; the
  audit never edits instruction files itself.
- **Quarterly:** read the root file top to bottom once, yourself. If a line
  surprises you, it's stale; if you skim a section, it's too long. The file
  should read like a crisp brief to a new chief of staff — because that's what
  it is, every single session.

## Why this matters in money and quality

Every root-file line is paid for in tokens on *every* session, and long
instruction files measurably dilute compliance with the rules that matter. The
discipline isn't tidiness — it's keeping the expensive, load-bearing context
window for actual work.
