# Icebreaker rules — write + QC

The complete ruleset. Phase 2 hands this to every writer verbatim; Phase 3 runs
the QC gate at the bottom against every line. Everything here is original
craft-knowledge for cold-email opening lines — author and apply it in our own
words; never paste a prospect's site copy or a competitor's template into a line.

## What an icebreaker is (and isn't)

A cold-email icebreaker is the FIRST line of the email — the one sentence (rarely
two) that proves a human looked at this specific prospect before hitting send,
and then earns the pitch that follows. It is not flattery, not a summary of the
prospect's website, not a weather opener. Its job is mechanical: lower the
reader's guard enough that they read line two.

Three things make a line work:

1. **A real, specific observation** — something true about THIS prospect that
   could not be said about the next lead on the list. Drawn only from the
   enrichment data on hand (the `source_field`), never invented.
2. **A reason it matters to them** — the observation lands because it touches a
   pain, a goal, or a recent move. Generic praise ("great site!") touches
   nothing.
3. **A bridge to the offer** — the line sets up, in one breath, why the client's
   offer is relevant. Without the bridge, you have a nice compliment and no email.

## The non-negotiables

- **Person, not company.** Anchor on the human or their work, not the corporate
  entity. "Saw you shipped the new onboarding flow" beats "Acme is growing fast."
  People reply to people.
- **One observation, one line.** Resist stacking two facts. The tightest line
  that connects to the offer wins. If you have two good observations, pick the
  one closest to the pain the offer solves.
- **It must connect to the offer.** Every line bridges — implicitly or
  explicitly — to the client's connect-to-pitch from `offers.md`. An observation
  that doesn't tee up the offer is a dead end; rewrite or blank it.
- **Sound spoken, not written.** Read it aloud. If it sounds like ad copy or a
  press release, it fails. Contractions, plain words, the rhythm of a real
  message a busy person dashed off.
- **No em-dashes.** They read as machine-written in cold email. Use a comma, a
  period, or recast the sentence.
- **No hallucinated facts.** Reference only what's in the lead's enrichment
  columns. If the data is thin, write a thinner-but-true line or blank it — never
  manufacture a detail to sound personal.
- **Length: roughly 12–30 words.** Long enough to be specific, short enough to
  scan in the preview pane. One sentence is ideal; two short ones is the ceiling.
- **The client's voice, not the agency's.** This goes out under the client's
  name. Honor `context/brand.md` voice rules and banned words. When the client's
  voice and these rules conflict on a phrasing, the client's voice wins as long
  as the QC gate still passes.

## Banned openers and filler (auto-fail in QC)

These are the mail-merge tells. A line containing any of them fails QC outright:

- **Hollow praise**: "love what you're doing", "impressed by", "big fan of",
  "amazing work", "huge admirer", "love the mission". Praise with no specific
  object is noise.
- **The fake-discovery opener**: "I came across your profile/company", "I
  stumbled upon", "I was browsing and noticed" — everyone knows you ran a list.
- **The presumptuous compliment**: "you're clearly the expert", "as a thought
  leader", "as a visionary".
- **Weather / throat-clearing**: "Hope this finds you well", "Hope you're having
  a great week", "Quick question for you".
- **Corporate filler**: "synergy", "circle back", "touch base", "reach out to
  pick your brain", "leverage", "in today's fast-paced world".
- **The merge-field smell**: any line that still works verbatim if you swap in a
  different company name. If `{Company}` is interchangeable, the line is generic.
- **Em-dashes** (—) anywhere in the line.

## Anchors that work (use the enrichment you have)

Map the lead's strongest available signal to an opener angle:

| Enrichment signal | Opener angle |
|---|---|
| Recent funding / raise | the next bottleneck a raise usually exposes (which the offer solves) |
| Hiring / open roles | the strain those roles imply (scaling pain the offer eases) |
| New product / feature / launch | a specific thing about the launch + the follow-on need |
| Recent content / post / talk | a genuine point of agreement or a sharp follow-up question |
| Tech-stack / tooling signal | a known gap or adjacent need that pairs with their stack |
| Geography / segment / niche | a pattern you see in that exact niche (not "companies like yours") |
| Award / press / milestone | the milestone + what tends to come right after it |
| Thin data (name + role only) | a true, role-specific line — no fabricated specifics, keep it short |

Pick the signal closest to the pain the offer addresses, not the flashiest one.

## Calibration examples (good vs bad)

These are illustrations of the *shape*, written fresh. They are NOT to be copied
into live lines — every real line is built from the lead's own data and the
client's voice.

**Bad → why → fixed**

- "Hi! I love what you're doing at NorthPeak, such an inspiring company!"
  → hollow praise, company-anchored, interchangeable. → "Saw NorthPeak's ops
  lead just posted about manual invoice reconciliation eating your month-end —
  that's usually the first thing that breaks past 200 clients."

- "I came across your website and was impressed by your innovative solutions."
  → fake-discovery + corporate filler, zero specifics. → "Your pricing page
  splits self-serve from enterprise but routes both to the same demo form —
  worth a look if you're trying to keep sales focused on the bigger deals."

- "Congrats on the funding round, exciting times! We help companies scale."
  → generic praise; the bridge to the offer is bolted on, not earned by the
  observation.
  → "Congrats on the Series A. Most teams find their old onboarding can't
  carry the new headcount, which is exactly the seam we tighten."

**Good (note: specific object, person/work-anchored, bridges to an offer)**

- "Your talk on cutting CAC by killing low-intent channels matched what we keep
  seeing — the leftover spend usually hides in branded search no one audits."
- "Noticed you're hiring two SDRs but still routing inbound by hand; that gap is
  where most of the speed-to-lead loss lives before the reps even ramp."

## QC gate (Phase 3 runs every line through this)

A line PASSES only if all hold. Any miss → one targeted rewrite; second miss →
blank icebreaker + `qc_note` (a blank beats a tell).

1. **Specific observation present**, traceable to a real `source_field`. No
   observation, or one not in the data → fail.
2. **No banned opener or filler** from the lists above. Pattern-match
   case-insensitively, including close variants.
3. **No em-dash** anywhere in the line.
4. **Person/work-anchored**, not pure company-entity praise.
5. **Bridges to the offer** — the line plausibly sets up the client's
   connect-to-pitch. A standalone compliment with no path to the offer fails.
6. **Voice-true** — obeys `context/brand.md` rules and contains no client-banned
   words.
7. **Length 12–30 words**, ≤2 sentences, reads naturally aloud.
8. **Not interchangeable** — swapping a different company name in must break the
   line's specificity. If it survives the swap, it's generic → fail.
9. **No hallucination** — every named fact appears in the lead's enrichment. A
   fact you can't source → strip it or blank the line.

Report QC as a one-line tally in the deliverable: `{pass} passed · {rewrite}
rewritten · {blank} blanked`, and carry per-line `qc_note` for anything blanked
so the user can supply the missing data and re-run just those.
