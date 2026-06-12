---
name: audit
description: Vault health check for Conversion OS — validate structure, link integrity, staleness, token bloat, duplication, frontmatter compliance, and the client-confidentiality firewall. Produces a score and report, then fixes per category with approval. Triggers: /audit, "audit the vault", "health check the vault", "vault is getting messy", "check my OS", "clean up the vault".
---

# Conversion OS — Vault Audit

Keeps a growing vault fast, cheap, and trustworthy. Run monthly (the weekly
review nags when overdue). Never modifies anything without per-category approval;
never touches CLAUDE.md files automatically (findings only).

## Flow

1. **Verify** — root CLAUDE.md exists; else stop ("run /setup").
2. **Sweep** — run `.claude/hooks/validate-structure.sh` and collect its findings;
   then glob all `*.md` (skip `.git`, `.obsidian`, `Clients/_archive`, `.trash`)
   and classify each by `type:` frontmatter (fallback: path).
3. **Check** — run every category in `references/checks.md`. Each finding:
   `category · path(:line) · severity (fail/warn) · evidence · why it matters ·
   fixable?`. Judgment over regex: a 200-line context file mid-rewrite is a warn
   with a note, not a mechanical fail.
4. **Score & report** — per `references/report.md`. Show the scorecard first,
   then findings grouped by category (worst first).
5. **Fix** — for each category WITH fixable findings, one AskUserQuestion:
   apply all / show me each / skip. Apply only what's approved. Protected zones
   never modified: code fences, inline code, URLs, file paths, frontmatter
   values you don't understand, anything inside `Clients/_archive/`.
6. **Save** — report to `Ops/decisions/YYYY-MM-DD-vault-audit.md` (`type:
   decision`, `tags: [audit, generated]`), including score, findings count by
   category, fixes applied, and the re-scored result. Suggest the next audit date.

## The 6 categories (detail in references/checks.md)

| # | Category | Catches |
|---|---|---|
| C1 | Structure | misplaced files, missing profiles/contracts, naming drift, stale Inbox |
| C2 | Links | dead wikilinks, orphan notes, missing entity links |
| C3 | Freshness | `reviewed:` >90d, dateless context, stale health reviews, dead projects |
| C4 | Budget | root >120 lines, folder CLAUDE.md >50, context >150, duplicated instructions |
| C5 | Firewall | Library→Clients references, sibling-client mentions, client material outside workspaces, credentials in stack files |
| C6 | Frontmatter | missing/invalid `type`/`status`/`tags`, slug↔`client:` mismatches, ledger format violations |

C5 failures are always reported first — they're trust failures, not hygiene.

## Hard rules

- Never auto-edit any CLAUDE.md (root, folder, or client contract) — propose diffs.
- Never delete a file without grepping for inbound references and showing them.
- Never "fix" content meaning — hygiene only (links, formatting, placement, frontmatter).
- A finding without a cited path doesn't exist.
