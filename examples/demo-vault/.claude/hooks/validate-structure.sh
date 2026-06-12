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
