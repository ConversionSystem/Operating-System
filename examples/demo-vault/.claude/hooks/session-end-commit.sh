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
