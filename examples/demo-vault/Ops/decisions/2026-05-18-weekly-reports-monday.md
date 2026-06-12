---
type: decision
status: active
date: 2026-05-18
tags: [ops, decision, reporting]
---

# 2026-05-18 — Weekly client reports go out Monday by 12:00 PT

## Decision

Every retainer client's weekly report ships Monday before 12:00 PT, covering
the prior ISO week, generated from that client's goals ledger — no exceptions,
no Friday sends.

## Reasoning

Friday reports got buried over weekends twice in May (read receipts told the
story), and Monday sending forces the ledger to be current by Monday morning,
which keeps S2 (stale data) from ever tripping silently. It also gives the
weekly call later in the week a written artifact to argue with.

## Owner

Maya. Jonah appends each account's ledger lines by end of day Tuesday for
mid-week observations; Monday's report uses whatever the ledger holds —
"no new data" is an acceptable cell, an invented number is not.
