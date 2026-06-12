---
name: daily
description: The operating rhythm for a Conversion OS vault — resume context at session start, save session memory at the end, morning brief, inbox triage, evening close, weekly review, and task management. Triggers: /daily, "resume", "where were we", "save this session", "morning brief", "what's on today", "triage my inbox", "evening close", "weekly review", "my tasks".
---

# Conversion OS — Daily Operations

The habit layer. Route intent; default (bare `/daily`) = morning brief if none
exists today, otherwise resume.

Requires a vault (root CLAUDE.md). All flows follow the root routing map; this
skill never invents new homes for information.

## resume — pick up where the firm left off

1. Read: root CLAUDE.md → Company/profile.md → 3 most recent Daily/ files →
   Ops/pipeline.md (if present) → profiles of clients mentioned in those dailies.
2. Deliver a standup, ≤10 lines: what was in motion, open loops (with ages),
   today's known deadlines/renewals, suggested first move.
3. Open today's daily note (create from `references/rituals.md` format if absent).

## save — the session becomes memory

Run at session end or on "save/wrap up". Without asking permission:
1. Append a session log to today's daily note: topics · decisions made · files
   changed · open loops created/closed. Scannable in 20 seconds.
2. Route durable facts that surfaced mid-session to their homes (routing map);
   client facts go through the client workspace rules.
3. Tick completed tasks; add new ones to the right board.
4. Report one line per write: "saved X → path".
(The session-end git snapshot is automatic via hook — don't commit manually.)

## morning — the brief that starts the day

Read: yesterday's daily + open loops · task boards · Ops/pipeline.md flags ·
every active client's `renewal:`/`cadence:` (reports due?) · Projects/ deadlines.
Compose today's note per `references/rituals.md`: **Top 3** (argued, not listed —
why these three) · **Calendar-shaped work** (reports due, renewals ≤45d, meetings
to prep — each with its /client command) · **Open loops** (aging items) ·
**Watch** (health flags). Ask one question only if Top 3 is ambiguous.

## triage — empty the inbox

For each item in `Inbox/` (and any client `inbox/` if asked): identify → route
per the routing map → delete the original. Client-related items move INTO that
client's workspace (use /client log for transcripts). Items that are tasks become
board entries, not files. Report the ledger of moves. Anything genuinely
unclassifiable: ask once, with a recommendation.

## evening — close the day

Compare the day against the morning's Top 3: done / moved / dropped (why).
Tick tasks, carry open loops forward, capture one lesson if the user offers it
(route it — usually a Rules line or a playbook note). Append `## Evening close`
to today's note. 3 questions max, all skippable.

## weekly — the review that resets the board

Read the week's dailies + pipeline + this week's client reports. Compose
`Daily/YYYY-Www-review.md` per rituals.md: wins (evidence-linked) · what dragged
(pattern, not blame) · client cadence check (reports sent? meetings held per
cadence?) · next week's Top 3 candidates. Then propose: run `/client health all`
if last-review dates are stale, and any context files whose `reviewed:` is >90d
old as a 10-minute refresh list.

## tasks — plain markdown boards

Format and conventions in `references/tasks.md`. Solo: `Ops/tasks.md`. Agency:
per-person `Team/{slug}/tasks.md`; assignment from any scope writes to the
assignee's board. No plugin dependency; if the user has a task plugin, respect
it but keep the markdown source of truth.
