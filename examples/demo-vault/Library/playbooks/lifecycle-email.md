---
type: playbook
status: draft
tags: [playbook, lifecycle-email]
---

# Playbook — lifecycle email & SMS

Delivery guide for the lifecycle-email offer (Klaviyo, $3,000/mo flat).
Draft: flow benchmarks are from Jonah's first builds; tighten after two
more engagements.

## When to run this

New lifecycle retainer, or any account where email is under 20% of revenue
with a list over 25k. SMS lane activates only past 10k opted-in numbers.

## Inputs

- Klaviyo admin access + Shopify collaborator account.
- The client's voice file (their workspace context/brand.md) — the voice
  authority for every send; if it's thin, get one approved sample first.
- List health export: growth, churn, engagement segments, deliverability
  baseline (spam rate, bounce rate).
- goals.md populated with the email revenue-share baseline.

## Steps

1. Deliverability + list audit — owner: email lead. Quality bar: spam rate,
   bounce rate, and sunset policy documented before any volume increase.
2. Core-four flow rebuild, in order: welcome, abandoned checkout,
   post-purchase, winback (weeks 1–4) — owner: email lead. Quality bar:
   every email passes the client's voice rules; each flow QA'd with a real
   test order before go-live.
3. Campaign calendar stand-up — owner: email lead. Quality bar: 2–3 sends
   per week, each to a defined segment, never batch-and-blast to the full
   list.
4. Segment math — owner: email lead. Quality bar: segment definitions
   written down with counts sanity-checked in Klaviyo the day before send.
5. Monday ledger append — owner: email lead. Quality bar: email revenue
   share logged weekly from the same attribution window every time.
6. Monthly deliverability check — owner: email lead. Quality bar: spam
   complaints <0.08%; any breach pauses volume growth until cause is found.

## Outputs

Core-four flows live, a campaign calendar the client can see, weekly
email-rev ledger lines, and a deliverability baseline that survives audits.

## Common failure modes

- Batch-and-blast: short-term revenue, long-term inbox placement damage.
- Discount training — every campaign carries an offer until full price
  stops converting at all.
- Writing in the agency's voice instead of the client's — the unsubscribe
  rate tells on you within three sends.
- Skipping plain-text variants and the QA test order to ship faster.
