# SEO audit checklist — 16 categories, original

The full check catalog. Every check resolves to one of:

- **pass** — meets the threshold; contributes full category credit.
- **warn** — drift that compounds; partial credit (counts as 0.5 of a pass).
- **fail** — broken or absent; zero credit, and the worst-severity ones become
  Criticals.
- **N/A** — does not apply to this site (no images on the page → image checks
  N/A; single-locale site → i18n N/A). N/A checks are **removed from the
  denominator**, never scored as a pass. A pass you didn't earn inflates the
  grade and rots the baseline.

Severity (drives the report ordering and quick-win carving), assigned to each
*failed* check:

- **Critical** — actively suppresses indexing, rankings, or trust (noindex on a
  money page, broken canonical, no HTTPS, blocked in robots.txt).
- **Warning** — degrades performance or relevance but the page still works
  (slow LCP, thin titles, missing alt text at scale).
- **Info** — best-practice gap, low immediate impact (no Open Graph image, no
  breadcrumb schema).

Judgment over mechanics: a 600-word page that fully answers a narrow query is
not "thin"; a noindex on a staging URL is correct, not a Critical. State the
reasoning when you override a mechanical trip.

---

## Category weights

Categories are not equal. Weight reflects how directly the category moves
organic outcomes. Weights sum to 100.

| # | Category | Weight | Why it carries that weight |
|---|---|---|---|
| 1 | Indexability & crawl control | 14 | If the page can't be indexed, nothing else matters |
| 2 | Core on-page tags | 12 | Title/meta/H1/canonical — the relevance backbone |
| 3 | Site performance & Core Web Vitals | 11 | Ranking factor + the biggest UX/conversion lever |
| 4 | Content quality & E-E-A-T | 11 | What actually earns and holds the ranking |
| 5 | Internal linking & site architecture | 8 | Distributes authority; defines what's important |
| 6 | Structured data | 6 | Rich results, entity clarity, AI-answer eligibility |
| 7 | Mobile experience | 6 | Mobile-first indexing is the index |
| 8 | URL structure | 5 | Stable, readable, canonical-friendly paths |
| 9 | Links (internal + external integrity) | 5 | Broken links bleed authority and trust |
| 10 | Images & media | 4 | Weight, alt text, next-gen formats, image search |
| 11 | Security & HTTPS | 4 | HTTPS is table stakes; headers protect trust |
| 12 | Indexation hygiene (duplicates/canonicals) | 4 | Duplicate/parameter sprawl wastes crawl budget |
| 13 | Accessibility (SEO-adjacent) | 3 | Semantic HTML overlaps with crawlability |
| 14 | International / hreflang | 3 | Right page to the right locale (N/A if single-locale) |
| 15 | Social & sharing meta | 2 | Off-search distribution; cheap to fix |
| 16 | Compliance & trust signals | 2 | Cookie/privacy/contactability — trust + some legal risk |

If a whole category is N/A (e.g. international on a single-locale site), drop its
weight from the denominator and re-normalize (see the formula below).

---

## 1. Indexability & crawl control (weight 14)

The gate. Audit these first; a fail here can make every other category moot.

| Check | pass | warn | fail | Sev if fail |
|---|---|---|---|---|
| Robots meta / X-Robots-Tag | indexable money + content pages | noindex on a borderline page (thin/utility) | noindex/none on a page that should rank | Critical |
| robots.txt | present, not blocking important paths or the sitemap | overly broad `Disallow` near important dirs | blocks CSS/JS or a whole indexable section | Critical |
| Sitemap.xml | present, listed in robots.txt, only canonical 200 URLs | stale, or includes redirects/404s | missing, or full of noindex/non-canonical URLs | Warning |
| Crawl blocking of assets | CSS/JS crawlable (render parity) | some non-critical assets blocked | render-critical resources blocked | Warning |
| Orphan pages | money pages reachable in ≤3 clicks | some pages only in sitemap | indexable pages with zero internal links | Warning |
| Soft 404s / thin index | substantive pages indexed | a few near-empty indexable pages | many auto-generated empty pages indexed | Warning |
| Crawl-depth of money pages | ≤3 clicks from home | 4 clicks | >4 clicks (buried) | Warning |

## 2. Core on-page tags (weight 12)

| Check | pass | warn | fail | Sev if fail |
|---|---|---|---|---|
| Title tag | unique, ~30–60 chars, primary term front-loaded | present but truncated/generic/duplicated | missing or boilerplate ("Home") | Critical |
| Meta description | unique, ~70–155 chars, with a reason to click | present but truncated or duplicated | missing on a money page | Warning |
| H1 | exactly one, descriptive, term-aligned | multiple H1s or vague | no H1 | Warning |
| Heading hierarchy | logical H1→H2→H3, no skipped levels | minor skips | headings used only for styling | Info |
| Canonical tag | self-referential or correct cross-canonical | present but inconsistent with internal links | points to a 404/redirect/wrong page | Critical |
| Keyword/intent alignment | title/H1/body match the page's target intent | partial alignment | page targets nothing identifiable | Warning |
| Title/description duplication | all unique sitewide | a handful of dupes | templated dupes at scale | Warning |

## 3. Site performance & Core Web Vitals (weight 11)

Thresholds use the widely-adopted CWV bands. Prefer field data **if a CWV/PSI
source is connected**; otherwise estimate from lab signals (payload size,
render-blocking resources, image weight) and label the finding "estimated".

| Check | pass | warn | fail | Sev if fail |
|---|---|---|---|---|
| LCP (largest contentful paint) | ≤2.5s | 2.5–4.0s | >4.0s | Warning |
| INP (interaction to next paint) | ≤200ms | 200–500ms | >500ms | Warning |
| CLS (cumulative layout shift) | ≤0.1 | 0.1–0.25 | >0.25 | Warning |
| Page weight | ≤~2MB typical page | 2–4MB | >4MB | Warning |
| Render-blocking resources | minimal; critical CSS inlined | a few blocking scripts | many blocking JS/CSS in head | Warning |
| Image optimization (perf) | sized, lazy-loaded, compressed | some oversized | hero images multiple MB uncompressed | Warning |
| Caching & compression | gzip/brotli + sensible cache headers | partial | no compression / no caching | Info |
| Server response (TTFB) | ≤~0.8s | 0.8–1.8s | >1.8s | Warning |

## 4. Content quality & E-E-A-T (weight 11)

Judge against `context/icp.md` (who must be convinced) and `context/offers.md`
(what's being sold). This is the category where human judgment outweighs any rule.

| Check | pass | warn | fail | Sev if fail |
|---|---|---|---|---|
| Depth vs. intent | fully answers the target query for this audience | partial / generic | thin or off-topic for the intent | Warning |
| Experience & expertise signals | author/credentials, first-hand proof where the topic demands it (YMYL) | weak signals | none on trust-sensitive pages | Warning |
| Originality | distinct POV, original data/examples | derivative | boilerplate/spun/duplicated content | Warning |
| Freshness | updated where recency matters; dates accurate | stale on time-sensitive pages | visibly outdated money pages | Info |
| Keyword cannibalization | one page per intent | two near-duplicate targets | several pages competing for one query | Warning |
| Readability & scannability | clear structure, sentence/paragraph length fits audience | dense walls of text | unreadable for the stated ICP | Info |
| Conversion alignment | money pages have a clear, relevant CTA | weak/buried CTA | no CTA on a money page | Info |

## 5. Internal linking & site architecture (weight 8)

| Check | pass | warn | fail | Sev if fail |
|---|---|---|---|---|
| Logical hierarchy | clear hub/topic clusters; money pages central | flat or shallow grouping | no discernible structure | Warning |
| Internal link depth to money pages | ≤3 clicks | 4 clicks | buried >4 | Warning |
| Descriptive anchor text | keyword-relevant, varied | generic ("click here") at scale | empty/image-only nav anchors | Info |
| Link equity flow | important pages well-linked internally | uneven | money pages under-linked | Warning |
| Breadcrumbs | present + BreadcrumbList schema | present, no schema | none on a deep site | Info |
| Contextual links | in-body links between related pages | nav-only linking | isolated content silos | Info |

## 6. Structured data (weight 6)

| Check | pass | warn | fail | Sev if fail |
|---|---|---|---|---|
| Markup presence | relevant types present (Organization, Article, Product, FAQ, etc.) | partial coverage | none where eligible | Warning |
| Validity | valid JSON-LD, no required-field errors | warnings only | parse errors / invalid types | Warning |
| Accuracy | matches visible page content | minor mismatch | markup describes content not on page (spam risk) | Critical |
| Format | JSON-LD (preferred) | microdata/RDFa only | malformed mix | Info |
| Eligibility coverage | rich-result-eligible types implemented | some missed | obvious opportunities unused (FAQ, HowTo, Review) | Info |

## 7. Mobile experience (weight 6)

| Check | pass | warn | fail | Sev if fail |
|---|---|---|---|---|
| Responsive viewport | correct `meta viewport` | present but fixed-width elements | no viewport meta | Critical |
| Tap targets & spacing | comfortably tappable | some cramped controls | unusable controls on mobile | Warning |
| Mobile/desktop parity | same content + links both | minor differences | content/links hidden on mobile | Warning |
| Readability | legible without zoom | small base font | text too small to read | Info |
| Interstitials | none intrusive | dismissible but aggressive | full-screen blocking interstitial | Warning |

## 8. URL structure (weight 5)

| Check | pass | warn | fail | Sev if fail |
|---|---|---|---|---|
| Readability | short, lowercase, hyphenated, descriptive | some noise | opaque IDs/query strings as primary URLs | Info |
| Consistency | one casing/trailing-slash convention | mixed | conflicting versions resolving to dupes | Warning |
| Parameters | clean canonical paths | tracking params leaking into index | session IDs / infinite parameter space crawled | Warning |
| Depth | shallow, logical folders | deep nesting | excessive folder depth | Info |
| Keyword presence | natural terms in slug | generic | dates/IDs where evergreen intended | Info |

## 9. Links — internal + external integrity (weight 5)

| Check | pass | warn | fail | Sev if fail |
|---|---|---|---|---|
| Broken internal links | none | a few 404s | many, or on money pages | Warning |
| Redirect chains/loops | direct links | single redirects | chains >2 hops or loops | Warning |
| Broken outbound links | none | a few dead externals | many dead externals | Info |
| Outbound link quality | relevant, reputable | some low-quality | links to spam/PBN-style sites | Warning |
| rel attributes | sponsored/ugc/nofollow used correctly | inconsistent | paid links followed (policy risk) | Warning |

## 10. Images & media (weight 4) — N/A if the page has no meaningful images

| Check | pass | warn | fail | Sev if fail |
|---|---|---|---|---|
| Alt text | descriptive on content images | generic/keyword-stuffed | missing at scale | Warning |
| File format | WebP/AVIF where supported | mixed legacy | huge PNG/uncompressed JPG | Info |
| Dimensions & responsiveness | sized attrs + srcset | some unsized | layout-shifting images | Warning |
| Lazy loading | below-fold lazy-loaded | partial | everything eager | Info |
| Descriptive filenames | meaningful names | generic | `IMG_0001.jpg` everywhere | Info |
| Image sitemap / indexability | images indexable | partial | images blocked where image search matters | Info |

## 11. Security & HTTPS (weight 4)

| Check | pass | warn | fail | Sev if fail |
|---|---|---|---|---|
| HTTPS | valid cert, whole site | mixed content warnings | no HTTPS / expired cert | Critical |
| HTTP→HTTPS redirect | forced sitewide | inconsistent | HTTP version serves 200 | Warning |
| HSTS | present | absent | — | Info |
| Security headers | CSP/X-Content-Type/Referrer-Policy present | partial | none | Info |
| Mixed content | none | a few insecure assets | login/forms over HTTP | Warning |

## 12. Indexation hygiene — duplicates & canonicals (weight 4)

| Check | pass | warn | fail | Sev if fail |
|---|---|---|---|---|
| Duplicate content | canonicalized/consolidated | some near-dupes | large duplicate clusters indexed | Warning |
| WWW/non-WWW + protocol | one canonical host | inconsistent links | both versions indexable | Warning |
| Pagination | handled (canonical or self-referential) | unclear | duplicate paginated content indexed | Info |
| Faceted/parameter pages | controlled (canonical/robots) | leaking | parameter explosion indexed | Warning |
| Trailing-slash / case dupes | normalized | some | both forms indexable | Info |

## 13. Accessibility — SEO-adjacent (weight 3)

Only the accessibility checks that overlap with crawlability/semantics; a full
WCAG audit is a separate deliverable.

| Check | pass | warn | fail | Sev if fail |
|---|---|---|---|---|
| Semantic HTML | nav/main/header/article used | div-soup with some structure | no landmarks | Info |
| Link/button semantics | real `<a>`/`<button>` | mixed | JS-only clickables (uncrawlable) | Warning |
| Image alt (a11y overlap) | present | partial | decorative/empty everywhere | Info |
| Language attribute | `lang` set | missing on multilingual | wrong/missing | Info |
| Color/contrast & focus | meets basics | minor issues | unusable for AT (flag, don't grade hard) | Info |

## 14. International / hreflang (weight 3) — N/A if single-locale

| Check | pass | warn | fail | Sev if fail |
|---|---|---|---|---|
| hreflang presence | on every localized URL | partial | none on a multi-locale site | Warning |
| Return tags | reciprocal, valid | some missing | non-reciprocal (ignored by engines) | Warning |
| Language/region codes | valid ISO codes + x-default | minor errors | invalid codes | Warning |
| Canonical vs. hreflang | consistent | mismatched | canonical points across locales | Warning |
| Locale targeting | correct content per locale | thin translations | machine-translated/duplicate locales | Info |

## 15. Social & sharing meta (weight 2)

| Check | pass | warn | fail | Sev if fail |
|---|---|---|---|---|
| Open Graph | title/description/image/url present | partial | none | Info |
| Twitter/X cards | card type + image | partial | none | Info |
| OG image | correct size, resolves, on-brand | wrong dimensions | broken/missing on money pages | Info |
| Sharing accuracy | matches the page | stale | misleading | Info |

## 16. Compliance & trust signals (weight 2)

| Check | pass | warn | fail | Sev if fail |
|---|---|---|---|---|
| Privacy/cookie | policy linked; consent where required | present but thin | none where legally required | Warning |
| Contactability (NAP/trust) | clear contact + business info | partial | none (hurts E-E-A-T + trust) | Info |
| Favicon & branding | present, resolves | low-res | missing (shows in SERP) | Info |
| Custom 404 | helpful, links home/search | bare | default server error | Info |
| Ads/intrusive layout | clean | some heavy ad density | content buried under ads | Warning |

---

## The health-score formula (show this math in every report)

Per-category, then weighted into one number. Transparent by design — the report
prints the table; the score is the visible sum, never a black box.

**1. Per-category score (0–100):**

```
applicable_checks = total_checks − N/A_checks          (in this category)
earned            = (passes × 1.0) + (warns × 0.5)
category_score    = round( earned / applicable_checks × 100 )
```

A category with every check N/A is itself N/A (dropped from the overall).

**2. Re-normalize weights** so the applicable categories sum to 100:

```
active_weight_total = sum(weight of every non-N/A category)
adj_weight(cat)     = weight(cat) / active_weight_total × 100
```

(With no N/A categories, `active_weight_total = 100` and weights are unchanged.)

**3. Overall health score (0–100):**

```
health_score = round( Σ  category_score(cat) × adj_weight(cat) / 100 )
```

**4. Letter grade:**

| Score | Grade | Read |
|---|---|---|
| 90–100 | A | Strong; protect and refine |
| 80–89 | B | Healthy; targeted fixes |
| 70–79 | C | Workable; clear gaps |
| 60–69 | D | Material problems; prioritize |
| <60 | F | Foundational issues; fix before scaling spend |

Use +/- on the boundary thirds (e.g. 72 → C+, 67 → D+) for finer month-over-month
resolution; it makes ledger trends legible.

**5. Critical gate (honesty rule):** any unresolved **Critical** finding caps the
overall grade at **C** regardless of the computed score — a site that's noindexed
or not on HTTPS is not a "B" no matter how clean its meta tags are. State the cap
explicitly: "computed 84 (B), capped at C: noindex on /pricing".

### Worked example

Single-locale site → category 14 (international) is N/A, weight 3 drops.
`active_weight_total = 97`. Say category 2 (core tags, weight 12) earns 8 passes,
2 warns, 1 fail across 11 applicable checks → `(8 + 1)/11 × 100 = 82`. Its
adjusted weight is `12/97 × 100 = 12.4`, contributing `82 × 12.4/100 = 10.2`
points. Sum every category's contribution → the overall score. Then apply the
Critical gate.

## Quick-wins carve

After scoring, pull every **Critical or Warning** finding whose fix is **under
~15 minutes and needs no design/dev sprint**: a missing/duplicate meta tag, a
broken canonical, an absent alt at template level, an uncompressed hero image, a
sitemap not referenced in robots.txt, a missing viewport meta, a 301 that should
replace a redirect chain. These lead the action plan — disproportionate return,
shippable today. Anything needing a content rewrite, a migration, or engineering
is NOT a quick win; it goes in the prioritized backlog instead.
