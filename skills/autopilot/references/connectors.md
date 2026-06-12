# Connector probing + splice blocks

## Probe procedure (Phase 1, Q2)

1. List tools/integrations actually available in this environment (MCP servers,
   plugin connectors). Don't trust memory — check.
2. Cross-reference Company/stack.md: tools named there but not connected become
   a "wire these for more signal" note in the final confirmation.
3. For each available + relevant connector, confirm enablement + its scoping
   facts (below). Never enable a connector the user didn't confirm.

## Splice blocks

Each block replaces its `<<CONNECTOR:X>>` marker when enabled (marker deleted
when disabled). Scoping facts in {{...}}.

### TRANSCRIPTS (Fireflies / Granola / Otter / Read.ai — whichever is connected)
```
2a. **Meeting transcripts** ({{TRANSCRIPT_TOOL}}): list meetings completed since
    the freshness window. For each (≤{{TRANSCRIPTS}}): match to a client by
    attendee domain/name against Clients/*/profile.md and context/people.md →
    matched: full /client-log procedure in that workspace · internal: file to
    Ops/meetings/ with decisions/actions extracted · unmatched: Inbox/ wrapper,
    flag in report. Never process a meeting twice (check the target folder first).
```

### CHAT (Slack / Teams / Discord)
```
2b. **Chat** ({{CHAT_TOOL}}, channels: {{CHANNELS}}): scan since freshness
    window. Capture: decisions stated in-channel → relevant decisions.md or
    client decisions.md · commitments ("I'll send X by Y") → assignee's task
    board · client-risk language → escalation candidate. Summarize don't
    transcribe: one line per captured item, linked to source thread.
```

### EMAIL (Gmail / Outlook)
```
2c. **Email** ({{EMAIL_TOOL}}, scope: {{MAILBOX_SCOPE}}): threads since window
    involving client domains ({{CLIENT_DOMAINS}}). Capture commitments,
    scope/money changes, dissatisfaction signals → client workspace (people.md
    note or decisions.md) + escalation if triggers match. NEVER file email
    bodies wholesale — one-line summaries with date + sender.
```

### CALENDAR (Google / Outlook)
```
2d. **Calendar** ({{CAL_TOOL}}): tomorrow's external meetings → add a
    "prep: /client prep {slug}" line to today's daily `## Calendar-shaped` for
    each client meeting found.
```

## Escalation channel block

- Slack DM available: `{{ESCALATION_CHANNEL}}` = "Slack DM to {{PERSON}}".
- Otherwise: "🚨 line at the TOP of today's daily note + first line of the run
  report" — and say so during setup ("escalations will wait for the morning
  brief; wire Slack for real-time").
