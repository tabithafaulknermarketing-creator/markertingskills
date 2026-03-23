# CRO Agent — Experiment Backlog

**Product:** Marketing Skills (open-source) + Magister (magistermarketing.com)
**Maintained by:** CRO Agent
**Last updated:** 2026-03-23
**Total hypotheses in queue:** 7
**Minimum required:** 5 ✓

---

## How to Use This File

- This is the ready-to-run experiment hypothesis queue.
- The CRO Agent adds new hypotheses when the queue drops below 5.
- The Paid & Measurement Agent picks up hypotheses (in priority order) for instrumentation and test setup.
- When a hypothesis is moved to `experiment-tracker.md` and instrumented, mark it `MOVED TO TRACKER` here.
- Hypotheses are prioritised by the ICE matrix: Impact × Confidence × Effort.

**ICE Key:**
- **Impact:** H = meaningful funnel lift expected (>10% relative) | M = moderate lift (5–10%) | L = marginal or hard to measure
- **Confidence:** How certain we are the hypothesis will win, based on ICP knowledge and analogous tests
- **Effort:** H = engineering sprint required | M = design + config changes | L = copy/flag/no-code change

---

## Backlog — Active Hypotheses

---

### HYPOTHESIS-001 — Homepage Hero: Outcome-Focused Headline
**Priority rank:** 1
**Status:** PLANNED (in experiment-tracker.md as EXP-001)

**Hypothesis statement:**
Technical founders visiting the homepage respond more strongly to outcome-focused, builder-identity headlines than to category-positioning headlines. Changing the hero headline to lead with an outcome ("Ship a marketing engine that runs itself") and invoke the builder identity ("built for founders who build") will increase the hero CTA click-through rate by at least 10% relative to the control.

**Funnel stage:** Homepage
**Psychology hook applied:** In-Group Identity — "founder who builds" framing over "marketing tool" framing

**Control description:**
Current homepage headline (to be documented on first live site access). Assumed to be category-positioning copy based on the product's current stage.

**Variant description:**
"Ship a marketing engine that runs itself — built for founders who build"
Alternative if A loses: "Your AI coding agent now runs your marketing. Autonomous. Expert-level. No CMO needed."

**Primary metric:** Hero CTA click-through rate (clicks on primary install/trial CTA ÷ homepage sessions)
**Secondary metric:** Homepage → signup flow start rate

**Estimated impact:** H — Hero headline is the single highest-leverage element on any page; even a modest lift here compounds through every subsequent funnel stage
**Confidence:** M — No live data yet; estimate based on analogous SaaS tests and ICP research
**Effort to implement:** L — Text copy change only; no design or engineering changes required

**Implementation path:**
1. Paid & Measurement Agent instruments PostHog feature flag: `exp-001-homepage-headline`
2. CRO Agent provides approved variant copy
3. Analytics team confirms `homepage_hero_cta_click` event is firing
4. Run 14 days minimum at current traffic

---

### HYPOTHESIS-002 — Signup Flow: Social Auth (GitHub) as Primary CTA
**Priority rank:** 2
**Status:** PLANNED (in experiment-tracker.md as EXP-002)

**Hypothesis statement:**
The technical-founder ICP has a strong preference for GitHub-authenticated signups over email/password forms. GitHub identity is central to their workflow, they use it daily, and it eliminates the cognitive friction of creating yet another username/password. Promoting GitHub auth to primary (full-width, above-fold) and demoting the email form to secondary will increase signup completion rate by at least 10% relative.

**Funnel stage:** Signup
**Psychology hook applied:** Social Proof (GitHub as trusted identity) + Friction reduction for the ICP's natural workflow

**Control description:**
Email field + password field as the primary, above-the-fold signup path. GitHub/Google auth available as a smaller, secondary option.

**Variant description:**
"Sign up with GitHub" as the dominant, full-width primary CTA (above fold). "Sign up with Google" as a secondary social option. Email form preserved but visually subordinate, below a clear "or" divider. No required fields on page load.

**Primary metric:** Signup completion rate (signup page visit → account confirmed created)
**Secondary metric:** Time-to-signup (seconds from page load to account created)

**Estimated impact:** H — For a developer audience, GitHub auth typically lifts signup conversion 15–30% vs. email-first in analogous tools (Linear, Railway, Vercel all use this pattern)
**Confidence:** H — Strong analogous evidence from developer-tool category; the ICP has a near-universal GitHub account
**Effort to implement:** L — Layout-only change if GitHub OAuth is already implemented; M if OAuth needs to be added first

**Prerequisite check:**
Confirm with engineering whether GitHub OAuth is implemented. If not, add OAuth setup to sprint before this test can run. Flag for Paid & Measurement Agent if engineering is required.

---

### HYPOTHESIS-003 — Homepage: Named-Peer Social Proof vs. Generic Logo Bar
**Priority rank:** 3
**Status:** PLANNED (in experiment-tracker.md as EXP-003)

**Hypothesis statement:**
For the technical-founder ICP, seeing that specific, named founders (especially ones they recognize from the indie hacker / build-in-public community) use Marketing Skills is more persuasive than a generic "trusted by" logo bar. In-group identity recognition ("that person is like me") activates social proof more strongly than brand-name association for this audience. Adding a named-peer social proof strip near the hero CTA will increase scroll depth past the hero and lift homepage-to-signup rate.

**Funnel stage:** Homepage
**Psychology hook applied:** Social Proof + In-Group Identity (core hook for 2026-03-23 and ongoing relevance)

**Control description:**
No social proof bar in the hero section, OR a generic logo bar without named individuals or founder context.

**Variant description:**
A strip directly below or beside the hero CTA reading: "Used by founders building in public — [Founder Name], creator of [Product] · [Founder Name], [Product] · [Founder Name], [Product]" — with optional avatar or Twitter handle. If real testimonials are not yet available: placeholder with "[Founder Name] — X followers, Y MRR" style formatting that can be replaced.

**Primary metric:** Scroll depth (% of sessions that scroll past hero section to below-fold content)
**Secondary metric:** Homepage → Signup rate

**Estimated impact:** H — Social proof placement near CTAs is one of the most consistent conversion lifts in B2B SaaS CRO
**Confidence:** M — Must be authentic; fabricated or low-credibility social proof can backfire with technical audiences who will check
**Effort to implement:** M — Requires sourcing real testimonials (Content & Copy Agent handoff) + design component

**Handoff flag for Content & Copy Agent:**
Need 3–5 named founder testimonials or social proof quotes for this experiment. Format: "Quote or social proof statement — [First name], [product name]". Founders with public Twitter/X presence preferred. Can source from GitHub star-givers, Discord community, or direct outreach.

---

### HYPOTHESIS-004 — Paywall: Trial Expiry — Loss Aversion vs. Value Gain Copy
**Priority rank:** 4
**Status:** PLANNED (in experiment-tracker.md as EXP-004)

**Hypothesis statement:**
Founders who have invested effort configuring their marketing agent (setting up context files, running their first agent tasks, reviewing outputs) have developed attachment to what they've built. At the trial expiry moment, framing the decision as "don't lose what you've set up" (loss aversion) will convert more trial users to paid than framing it as "upgrade to get more value" (value gain). The sunk-cost attachment is the primary emotional lever at this stage — not aspiration for new features.

**Funnel stage:** Paywall — Magister trial expiry screen
**Psychology hook applied:** Loss Aversion (Kahneman: losses loom larger than equivalent gains)

**Control description:**
Value-gain framing: "Upgrade to [Starter/Pro] to keep your marketing running on autopilot. [Feature list]. From $X/month."

**Variant description:**
Loss-aversion framing: "Your marketing agent will pause in [X] days. Don't lose the [N] tasks you've configured and the [Y] outputs your agent has produced. Keep it running — from $X/month."
If personalization data is not available: "Don't let your marketing agent go dark. You've done the hard part — setting it up. Keep it running."

**Primary metric:** Trial-to-paid conversion rate at the expiry screen (screen impression → Stripe payment completed)
**Secondary metric:** Time to conversion decision (same-session vs. within 48 hours)

**Estimated impact:** M — Loss aversion framing typically produces 10–20% lift vs. value framing at expiry for tools with high setup investment; moderate confidence given limited analogous data for this specific product category
**Confidence:** M — Behavioural economics strongly supports loss aversion; unknown how strongly it applies to autonomous SaaS vs. content tools
**Effort to implement:** L — Copy-only change; no design changes required; personalization fields are optional enhancement

---

### HYPOTHESIS-005 — Onboarding: Product-First Access vs. Guided Checklist
**Priority rank:** 5
**Status:** PLANNED (in experiment-tracker.md as EXP-005)

**Hypothesis statement:**
Technical founders are pattern-matched to "just let me explore it" behaviour in developer tools. Mandatory onboarding checklists that gate product access feel patronizing and create unnecessary friction before value is delivered. Offering direct product access post-signup with a dismissable, non-blocking setup prompt will increase Day-1 activation (reaching the core "aha moment") compared to a guided checklist that forces sequential completion of setup steps.

**Funnel stage:** Onboarding (post-signup, first session)
**Psychology hook applied:** Autonomy + Competence (self-determination theory — technical founders want to feel in control)

**Control description:**
Guided setup checklist with 4–6 steps presented immediately post-signup. Dashboard or core product features are visible but primary UX emphasizes checklist completion first. Steps might include: connect your product context, configure your first agent task, review your first output, invite a team member.

**Variant description:**
Immediate redirect to core dashboard or agent task interface on signup completion. A dismissable widget in the bottom-right corner reads: "Set up your marketing agent when you're ready — takes 3 min → [Open setup]". No step-gating. Checklist is available but accessed on demand.

**Primary metric:** Day-1 activation rate — % of new signups who complete the defined "aha moment" action within 24 hours
**Secondary metric:** Day-7 retention rate (% returning to the product within 7 days of signup)
**Guardrail metric:** Onboarding completion rate (track that it does not collapse entirely — some users need guidance)

**Estimated impact:** M — Product-first onboarding is a well-documented pattern for developer tools (Vercel, Railway, Supabase all use this); risk is that users who need guidance churn faster
**Confidence:** M — Strong directional evidence from analogous tools; Magister's setup complexity (context files, agent tasks) may mean some users genuinely need guidance
**Effort to implement:** M — Requires routing logic change and dismissable component; moderate engineering effort

**Note for Growth & Retention Agent:**
This test requires Day-7 and Day-30 cohort tracking. The Growth & Retention Agent should flag if the product-first variant shows higher Day-1 activation but lower Day-7 retention — that outcome would suggest the variant drives exploration without enough habit formation.

---

### HYPOTHESIS-006 — Pricing Page: Recommended Plan Visual Callout
**Priority rank:** 6
**Status:** QUEUED (not yet in experiment-tracker.md)

**Hypothesis statement:**
Founders visiting the Magister pricing page experience "which plan is right for me?" anxiety when plans are presented with equal visual weight. Adding a "Most popular" or "Recommended for founders" badge on one plan, with a subtle visual elevation (different background, border highlight), reduces decision paralysis and increases clicks to the recommended plan's CTA.

**Funnel stage:** Pricing page (public, pre-signup)
**Psychology hook applied:** Social Proof ("Most popular") + Decision simplification (reducing cognitive load)

**Control description:**
Pricing page with two or three plans presented at equal visual weight. No recommendation callout. User must compare plans and self-select.

**Variant description:**
Middle (or most appropriate) plan receives a "Recommended for solo founders" badge in the plan header. Slight visual distinction: slightly larger card, or different border color, or "Most popular" label. The CTA on this card reads "Start with [Plan Name]" vs. generic "Get started" on other plans.

**Primary metric:** Recommended-plan CTA click rate (clicks on that specific plan's CTA ÷ pricing page sessions)
**Secondary metric:** Pricing page → signup rate (total)

**Estimated impact:** M — Recommended plan callouts consistently lift conversion on SaaS pricing pages (15–30% in published case studies); particularly effective when plans are otherwise similar in perceived value
**Confidence:** H — One of the most replicated findings in SaaS pricing CRO; high confidence directionally
**Effort to implement:** L — CSS/copy-only change; no logic changes required

---

### HYPOTHESIS-007 — Exit-Intent Popup: In-Group Builder Copy vs. Generic Lead-Gen Offer
**Priority rank:** 7
**Status:** QUEUED (not yet in experiment-tracker.md)

**Hypothesis statement:**
Exit-intent popups with generic lead-gen copy ("Subscribe to our newsletter for marketing tips") will underperform for the technical-founder ICP, who are skeptical of marketing-style copy. An exit-intent popup using in-group identity language ("Before you go — here's what other founders who build are doing") paired with a specific, tangible asset (case study or founder breakdown) will generate higher popup conversion rate than a generic newsletter subscribe offer.

**Funnel stage:** Popup (homepage and top landing pages, exit intent)
**Psychology hook applied:** Social Proof + In-Group Identity (today's primary psychology hook)

**Control description:**
Generic email capture popup: "Get marketing tips for SaaS founders — subscribe to our newsletter." Email field + subscribe CTA. Standard trigger: exit intent after 30 seconds.

**Variant description:**
In-group identity framing: "Before you go — here's how three founders replaced their agency with an AI marketing agent." CTA links to a case study page or email series. If email capture is required: "Send me the case studies" rather than "Subscribe." Decline text: "No thanks, I'm managing marketing fine."

**Primary metric:** Popup conversion rate (popup impressions → CTA click or email submission)
**Secondary metric:** Email open rate for captured leads (quality signal)

**Estimated impact:** L — Popup conversion rates are inherently low (2–5% baseline); the relative lift from better copy may be meaningful but absolute numbers will be small until traffic is higher
**Confidence:** M — In-group framing is directionally sound for this ICP; email open rate will confirm lead quality
**Effort to implement:** L — Copy-only change; popup trigger and display logic is identical between variants

---

## Adding New Hypotheses

When the queue drops below 5 ready-to-run hypotheses, the CRO Agent generates new ones using the following priority framework:

1. **Identify the lowest-converting funnel stage** — review experiment-tracker.md for stage-level conversion data
2. **Apply the relevant skill** — use `page-cro`, `signup-flow-cro`, `onboarding-cro`, `paywall-upgrade-cro`, or `popup-cro` depending on the stage
3. **Apply today's psychology hook** — from `psychology-hooks.md` in the Strategy Agent outputs
4. **Validate against ICP** — every hypothesis must be grounded in the technical-founder / indie-hacker persona; test assumptions that are specific to this audience, not generic SaaS
5. **Estimate ICE score** — Impact, Confidence, Effort — and rank against existing backlog

---
