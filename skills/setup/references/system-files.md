# System files

Write these verbatim (filling `{{...}}` where present), then `chmod +x` both hooks.

## .claudeignore

```
# Conversion OS — excluded from AI reads
Clients/_archive/
.git/
.obsidian/
.trash/
.DS_Store
# Per-seat client exclusions are appended below by /team. On team vaults /team
# moves seat scoping to a machine-local mechanism so seats don't sync over each
# other — see docs/confidentiality.md and the team skill's seats reference.
```

## .gitignore

```
.DS_Store
.trash/
.obsidian/workspace.json
.obsidian/workspace-mobile.json
# Machine-local seat scoping (agency teams): each seat generates its own
.claudeignore.local
```

Note: on solo vaults `.claudeignore` is committed. On team vaults /team switches
seat exclusions to a local mechanism — see `../../team/references/seats.md`.

## .claude/settings.json

```json
{
  "hooks": {
    "SessionEnd": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "bash \"$CLAUDE_PROJECT_DIR/.claude/hooks/session-end-commit.sh\""
          }
        ]
      }
    ]
  }
}
```

## .claude/hooks/session-end-commit.sh

```bash
#!/bin/bash
# Conversion OS safety net: snapshot the vault after every session so any
# memory write can be diffed or reverted. Silent no-op when git is absent.
cd "${CLAUDE_PROJECT_DIR:-$(cd "$(dirname "$0")/../.." && pwd)}" || exit 0
command -v git >/dev/null 2>&1 || exit 0
[ -d .git ] || exit 0
git add -A >/dev/null 2>&1
git diff --cached --quiet 2>/dev/null && exit 0
git commit -m "session snapshot: $(date '+%Y-%m-%d %H:%M')" >/dev/null 2>&1
exit 0
```

## .claude/hooks/validate-structure.sh

```bash
#!/bin/bash
# Conversion OS structure lint — advisory. Prints findings, always exits 0.
# Run from vault root (or via /audit, which interprets the output).
cd "${CLAUDE_PROJECT_DIR:-$(cd "$(dirname "$0")/../.." && pwd)}" || exit 0
f=0
# 1. Root may contain only CLAUDE.md + dotfiles
for x in *; do
  [ -d "$x" ] && continue
  case "$x" in CLAUDE.md) ;; *) echo "ROOT-FILE: $x (only CLAUDE.md belongs at root)"; f=1;; esac
done
# 2. Every client workspace needs profile.md and CLAUDE.md
for d in Clients/*/; do
  case "$d" in Clients/_archive/*|"Clients/*/") continue;; esac
  [ -f "${d}profile.md" ] || { echo "CLIENT-NO-PROFILE: $d"; f=1; }
  [ -f "${d}CLAUDE.md" ]  || { echo "CLIENT-NO-CONTRACT: $d"; f=1; }
done
# 3. profile.md client: field must equal folder slug
grep -H "^client:" Clients/*/profile.md 2>/dev/null | while IFS=: read -r path _ val; do
  slug=$(basename "$(dirname "$path")")
  v=$(echo "$val" | tr -d ' ')
  [ "$v" = "$slug" ] || echo "CLIENT-SLUG-MISMATCH: $path says '$v', folder is '$slug'"
done
# 4. Library must never reference client folders (the rule statement in
#    Library/CLAUDE.md itself is exempt)
grep -rln "Clients/" Library/ 2>/dev/null | grep -v "^Library/CLAUDE.md$" | while read -r p; do
  echo "LIBRARY-FIREWALL: $p references Clients/"
done
# 5. Daily filenames must be ISO dates or weekly reviews (routing file exempt)
for p in Daily/*.md; do
  [ -e "$p" ] || continue
  b=$(basename "$p" .md)
  [ "$b" = "CLAUDE" ] && continue
  echo "$b" | grep -Eq '^[0-9]{4}-([0-9]{2}-[0-9]{2}|W[0-9]{2}-review)$' || echo "DAILY-NAME: $p"
done
# 6. Stale inbox items (>7 days). NOTE: mtime-based, so approximate — sync and
#    clones reset mtimes. /audit C1 re-checks inbox rot by content dates.
find Inbox -type f -mtime +7 2>/dev/null | while read -r p; do echo "INBOX-STALE: $p"; done
exit 0
```
