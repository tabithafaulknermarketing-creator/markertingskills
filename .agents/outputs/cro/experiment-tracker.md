# CRO Agent — Experiment Tracker

**Product:** Marketing Skills (open-source) + Magister (magistermarketing.com)
**Maintained by:** CRO Agent (updated daily)
**Last updated:** 2026-03-23
**Status:** Initialized — first-ever run. No active experiments yet.

---

## How to Use This File

- This is the live source of truth for all active, paused, and concluded A/B experiments across the Marketing Skills and Magister funnel.
- The CRO Agent updates this file daily with visitor counts, conversion rates, and statistical confidence per variant.
- When a test reaches 95% statistical significance AND minimum runtime has elapsed, the CRO Agent writes a result block and flags the Paid & Measurement Agent via its DONE.md handoff.
- Concluded experiments are moved to the "Concluded" section with a final result summary and a recommendation to ship or revert.
- Do NOT call a winner early based on confidence alone — enforce minimum runtime to avoid false positives.

---

## Experiment Status Definitions

| Status | Meaning |
|--------|---------|
| `PLANNED` | Hypothesis approved, awaiting instrumentation by Paid & Measurement Agent |
| `RUNNING` | Live and collecting data |
| `PAUSED` | Temporarily halted — see reason in experiment notes |
| `CONCLUDED — WIN` | Variant beat control at ≥95% confidence after minimum runtime |
| `CONCLUDED — LOSS` | Control beat variant at ≥95% confidence after minimum runtime |
| `CONCLUDED — INCONCLUSIVE` | No significant difference after full runtime + minimum sample |
| `ESCALATED` | Negative result >10% drop on primary metric — human review required before proceeding |

---

## Active Experiments

*No active experiments as of 2026-03-23. This is the first-ever run.*
*The Paid & Measurement Agent should instrument EXP-001 first.*

---

## Daily Data Log (populate once experiments are live)

Use the following format for each daily update entry:

| Date | Experiment | Variant | Visitors | Conversions | CR% | Confidence% | Notes |
|------|------------|---------|----------|-------------|-----|-------------|-------|
| — | — | — | — | — | — | — | No active tests |

---

## Planned Experiments (Priority Queue)

### EXP-001 — Homepage Hero: Outcome-Focused Headline
**Status:** `PLANNED`
**Priority rank:** 1
**Funnel stage:** Homepage

**Hypothesis:**
Technical founders respond to concrete outcome framing over category/feature framing in the hero headline. Switching from a positioning-style headline to an outcome-oriented headline that invokes the builder identity will increase the homepage CTA click-through rate by ≥10% relative.

**Control:**
Current headline (to be documented on first site access to magistermarketing.com)

**Variant headline options (test one at a time):**
- Option A: "Ship a marketing engine that runs itself — built for founders who build"
- Option B: "Your AI coding agent now runs your marketing. Autonomous, expert-level, no CMO required."
- Option C: "Stop deprioritising marketing. Start running it on autopilot." *(pain-based)*

**Recommended variant:** Option A — leads with outcome ("ship"), invokes builder identity, and differentiates from generic "AI marketing tool" category.

**Primary metric:** Homepage hero CTA click-through rate
**Secondary metric:** Homepage → Signup flow start rate
**Guardrail metric:** Bounce rate (should not increase significantly)

**Minimum sample size:** 500 visitors per variant
**Recommended runtime:** 14 days minimum
**Minimum detectable effect:** 10% relative lift on hero CTA CTR
**Test platform:** PostHog feature flags (or VWO)

**Implementation notes:**
- No engineering required — headline text swap via feature flag
- If PostHog is live: use `posthog.featureFlags.isFeatureEnabled('exp-001-headline')` to serve variant
- Track: `homepage_hero_cta_click` event on control and variant

**Date planned:** 2026-03-23
**Date started:** —
**Date concluded:** —
**Result:** —

---

### EXP-002 — Signup Flow: Social Auth as Primary CTA
**Status:** `PLANNED`
**Priority rank:** 2
**Funnel stage:** Signup

**Hypothesis:**
Technical founders prefer low-friction, zero-typing signup paths. GitHub is the identity provider most trusted and most-used by the technical-founder ICP. Presenting "Sign up with GitHub" as the visually dominant CTA (large button, above the email form) will increase signup completion rate compared to the current layout where email form is primary.

**Control:**
Email + password form as primary signup path; social auth (GitHub/Google) as secondary, smaller option below or beside the form.

**Variant:**
GitHub auth as primary (full-width or prominent button, above fold, with "or" divider leading to email form below). Google auth as secondary social option. Email form remains available but visually subordinate.

**Primary metric:** Signup completion rate (signup page load → account created)
**Secondary metric:** Time-to-signup (seconds from page load to account created)
**Guardrail metric:** Email-signup drop (should not eliminate all email signups — some users legitimately prefer email)

**Minimum sample size:** 300 signups per variant
**Recommended runtime:** 14–21 days
**Minimum detectable effect:** 10% relative lift on signup completion rate
**Test platform:** PostHog feature flags

**Implementation notes:**
- Requires UI reorder — likely achievable without full engineering sprint (CSS/component prop change)
- If GitHub OAuth is already implemented, this is a layout-only change
- If GitHub OAuth is not yet implemented, this requires engineering — flag for escalation

**Date planned:** 2026-03-23
**Date started:** —
**Date concluded:** —
**Result:** —

---

### EXP-003 — Homepage: Named-Peer Social Proof vs. Generic Logo Bar
**Status:** `PLANNED`
**Priority rank:** 3
**Funnel stage:** Homepage

**Hypothesis:**
For a technical-founder ICP, social proof from named peers (founder names, Twitter/X handles, or company names from recognizable indie/startup ecosystems) converts better than a generic logo bar, because in-group identity recognition ("someone like me uses this") is more persuasive than brand-name association for this audience.

**Control:**
No social proof bar, OR generic "trusted by" logo bar without named individuals.

**Variant:**
A social proof strip that reads: "Built for people like you — founders at [indie SaaS name], [indie SaaS name], [indie SaaS name] use Marketing Skills" — with founder first name, product name, and optionally Twitter handle. Keep to 3–5 real, named users once available; use plausible-but-honest copy as placeholder until testimonials are collected.

**Primary metric:** Scroll depth past hero (% reaching below-fold section)
**Secondary metric:** Homepage → Signup rate
**Guardrail metric:** Time on page (should not decrease)

**Minimum sample size:** 500 visitors per variant
**Recommended runtime:** 14 days
**Minimum detectable effect:** 10% relative improvement in below-fold scroll rate
**Test platform:** PostHog

**Implementation notes:**
- Requires real testimonials or founder mentions — Content & Copy Agent should collect these
- Do not fabricate social proof; if real names are unavailable, delay this test and run EXP-001 first
- Consider using GitHub star-giver data or Discord/community members as proof source

**Date planned:** 2026-03-23
**Date started:** —
**Date concluded:** —
**Result:** —

---

### EXP-004 — Paywall: Trial Expiry — Loss Aversion vs. Value Gain Copy
**Status:** `PLANNED`
**Priority rank:** 4
**Funnel stage:** Paywall (Magister — trial expiry screen)

**Hypothesis:**
Loss-aversion framing at the trial expiry moment will outperform value-gain framing for Magister's technical-founder segment. Founders who have invested time setting up their marketing agent feel attached to what they've built; framing expiry as "you'll lose [specific configured assets]" activates sunk-cost attachment and loss aversion more than "upgrade to get more."

**Control:**
Value-gain framing: "Upgrade to [Plan] to keep your marketing running on autopilot"

**Variant:**
Loss-aversion framing: "Don't lose what you've set up — your [N] active agent tasks and [X] weeks of queued content will pause on [specific date]. Keep it running."

**Primary metric:** Trial-to-paid conversion rate (trial expiry screen → payment completed)
**Secondary metric:** Time to upgrade decision (same-session vs. returned within 48h)
**Guardrail metric:** Support ticket volume related to expiry confusion (should not increase)

**Minimum sample size:** 200 trial expiry events per variant
**Recommended runtime:** 30 days (lower-volume event; requires sufficient trial cohort)
**Minimum detectable effect:** 15% relative lift on trial-to-paid conversion at expiry
**Test platform:** PostHog + Stripe webhook correlation

**Implementation notes:**
- Requires trial expiry event tracking in PostHog (`trial_expiry_shown`)
- Variant copy requires access to user's actual configuration data (N tasks, queued content) — may need personalization via API
- If personalization is not available, use generic version: "Your marketing agent will pause. Upgrade to keep it running."

**Date planned:** 2026-03-23
**Date started:** —
**Date concluded:** —
**Result:** —

---

### EXP-005 — Onboarding: Product-First Access vs. Guided Checklist
**Status:** `PLANNED`
**Priority rank:** 5
**Funnel stage:** Onboarding (post-signup, first session)

**Hypothesis:**
Technical founders are self-directed and find mandatory onboarding checklists patronizing. They prefer to explore and discover independently. Offering direct product access immediately post-signup (with a non-blocking, dismissable setup prompt) will increase Day-1 activation rate compared to a guided checklist that gates product access behind 4+ completion steps.

**Control:**
Guided setup checklist (4–6 required steps shown before reaching the main dashboard or core product experience).

**Variant:**
Direct access to the dashboard/core product immediately post-signup. A dismissable, corner-positioned setup prompt reads: "Set up your marketing agent when you're ready — takes 3 minutes." Progress is visible but never blocking.

**Primary metric:** Day-1 activation rate (% of new signups who reach the defined "aha moment" action within 24 hours)
**Secondary metric:** Day-7 retention rate (% returning within 7 days)
**Guardrail metric:** Onboarding completion rate (should not drop to near-zero — some completion is desirable)

**Minimum sample size:** 200 new signups per variant
**Recommended runtime:** 21 days (retention signal requires time to manifest)
**Minimum detectable effect:** 10% relative improvement in Day-1 activation rate
**Test platform:** PostHog user properties + cohort analysis

**Implementation notes:**
- Requires a defined "aha moment" event — suggest: first agent skill triggered, first output file generated, or first marketing task completed
- Requires user property tagging at signup: `onboarding_variant: 'guided' | 'product-first'`
- Growth & Retention Agent should review Day-7 and Day-30 cohort data once this test runs

**Date planned:** 2026-03-23
**Date started:** —
**Date concluded:** —
**Result:** —

---

## Concluded Experiments

*None yet. First-ever run.*

---

## Statistical Significance Reference

- **Target confidence threshold:** 95% (two-tailed)
- **Minimum detectable effect (MDE):** 10% relative lift on primary metric (15% for low-volume paywall tests)
- **Calculator:** Use PostHog's built-in A/B significance calculator or Evan's A/B Test Calculator (evanhahn.com/ab-test-calculator)
- **Early stopping rule:** Do NOT call winners before minimum runtime is met, even if 95% confidence is reached early — this inflates false-positive rate
- **Low-traffic protocol:** For tests generating fewer than 100 visitors/day per variant, extend runtime rather than reducing sample targets
- **Novelty effect:** For onboarding and UI-change tests, discard the first 3 days of data to filter novelty effect

---

## Experiment Brief Archive

Full briefs for planned experiments are in `experiment-backlog.md`.
Weekly experiment briefs (produced per INSTRUCTIONS.md) are saved to `experiment-briefs/[date]-[test-name].md`.

---
