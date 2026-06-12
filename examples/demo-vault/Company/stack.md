---
type: context
status: active
tags: [company, stack, tools]
reviewed: 2026-06-12
---

# Stack — where work actually happens

| Job | Tool | Notes |
|---|---|---|
| Paid media | Meta Ads Manager, Google Ads | budgets + tests live here; weekly numbers copied to client ledgers by hand (painful) |
| Lifecycle email/SMS | Klaviyo | flows + campaigns; revenue-share number pulled Mondays |
| Storefront data | Shopify (client accounts) | source of truth for orders/AOV; access via collaborator accounts |
| Reporting | this vault + Google Sheets | ledger is canonical; Sheets only for client-side margin models |
| Comms | Slack (internal) + Slack Connect (clients) | decisions made in Slack must be copied to the vault same day |
| Meetings | Zoom + transcript export | transcripts pasted into /client log |
| Tasks | vault task boards (`Team/{person}/tasks.md`) | no external PM tool; boards are the truth |
| Billing | Stripe invoicing | monthly, 1st of month, auto-charge |
| Design handoff | Figma | Tessa's files; final assets land in client `assets/` |

## Automation wishlist

1. Monday metric pull: Meta/Google/Klaviyo numbers appended to each client's
   goals ledger automatically — the single biggest weekly time drain (~2 hrs).
2. Zoom transcript → /client log without copy-paste.
3. Draft the Monday cover email from the saved weekly report automatically.
4. Renewal radar: 45-day warning surfaced in /daily without anyone checking.
