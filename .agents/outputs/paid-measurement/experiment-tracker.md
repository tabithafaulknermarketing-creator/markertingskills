# Paid & Measurement Agent — Experiment Tracker

**Product:** Marketing Skills (open-source) + Magister (magistermarketing.com)
**Maintained by:** Paid & Measurement Agent (updated daily once experiments are live)
**Last updated:** 2026-03-23
**Status:** Initialized — first-ever run. No active experiments. EXP-001 measurement plan ready.

---

## How to Use This File

- This is the Paid & Measurement Agent's source of truth for experiment instrumentation, daily data logging, and results declaration.
- The CRO Agent's experiment-tracker.md is the source of truth for hypotheses, control/variant definitions, and declared results.
- This file covers: tracking event specs, feature flag setup, sample size calculations, runtime management, and daily data logs.
- When a test reaches 95% confidence AND minimum runtime has elapsed, write a result block and hand off to CRO Agent via DONE.md.
- Do not call a winner early based on confidence alone. Enforce minimum runtime to control false positive rate.

---

## Experiment Status Key

| Status | Meaning |
|--------|---------|
| `INSTRUMENTATION READY` | Feature flag created, events firing, awaiting baseline collection |
| `BASELINE COLLECTING` | Pre-test measurement running — no variant served yet |
| `RUNNING` | Feature flag active, both variants live, data collecting |
| `PAUSED` | Halted — see notes |
| `CONCLUDED — WIN` | Variant beat control at ≥95% confidence after minimum runtime |
| `CONCLUDED — LOSS` | Control beat variant |
| `CONCLUDED — INCONCLUSIVE` | No significant difference after full sample + runtime |
| `ESCALATED` | Primary metric dropped >10% on variant — human review required before proceeding |

---

## Active Experiments

*No active experiments as of 2026-03-23. EXP-001 instrumentation is pending PostHog installation on magistermarketing.com.*

---

## EXP-001 — Homepage Hero Headline A/B Test

### Overview

| Field | Value |
|-------|-------|
| **Experiment ID** | EXP-001 |
| **Status** | `PLANNED — awaiting PostHog installation` |
| **Hypothesis source** | CRO Agent experiment-tracker.md (2026-03-23) |
| **Priority** | 1 (highest) |
| **Funnel stage** | Homepage |
| **No engineering required** | Yes — headline text swap via feature flag |

### Hypothesis

Technical founders respond to concrete outcome framing over category or feature framing in the hero headline. Switching from the current positioning-style headline to an outcome-oriented headline that invokes the builder identity ("Ship a marketing engine that runs itself — built for founders who build") will increase the homepage hero CTA click-through rate by ≥15% relative, with no material increase in bounce rate.

**Control:** Current hero headline on magistermarketing.com (to be documented on first confirmed site access)

**Variant A (recommended for EXP-001):** "Ship a marketing engine that runs itself — built for founders who build"

**Why Variant A:** Leads with an active verb ("Ship") the ICP uses daily, frames the outcome ("runs itself") not the category ("AI marketing tool"), and closes with in-group identity ("founders who build") matching today's psychology hook (Social Proof + In-Group Identity). Variants B and C from the CRO backlog are queued for EXP-001b and EXP-001c if this test is inconclusive.

### Primary Metric

**Event:** `homepage_hero_cta_click`
**Definition:** A unique session-level click on the primary CTA button in the hero section of the homepage.
**Calculation:** `hero_cta_clicks / homepage_sessions` per variant, de-duplicated at session level (one click per session).

### Secondary Metric

**Event:** Page → Signup flow start rate
**Definition:** Homepage sessions that land on /signup or /register within the same session.
**Calculation:** `sessions_reaching_signup / homepage_sessions` per variant.

### Guardrail Metric

**Metric:** Session bounce rate on homepage
**Definition:** Sessions that view only the homepage and exit within 15 seconds without any click.
**Threshold:** Do NOT declare a win if bounce rate in the variant increases by >5 percentage points absolute vs. control, even if CTA CTR improves. A headline that drives clicks but repels most visitors is not a net win.

---

### Sample Size Calculation

**Inputs:**
- Baseline CTR (assumed): 3% (50 homepage visitors/day × 3% = 1.5 clicks/day at 500 visitors/day)
- Daily homepage traffic: 500 visitors/day (per task brief)
- Minimum Detectable Effect (MDE): 15% relative lift (3.00% → 3.45%)
- Statistical significance level: 95% (α = 0.05)
- Statistical power: 80% (β = 0.20)
- Number of variants: 2 (control vs. one variant — no multi-arm inflation needed)

**Sample size calculation:**

Using the standard two-proportion z-test formula:

```
Baseline CTR: p1 = 0.03 (3%)
Target CTR:   p2 = 0.03 × 1.15 = 0.0345 (3.45%)
α = 0.05 (two-tailed), z_α/2 = 1.96
Power = 80%, z_β = 0.842

p_bar = (p1 + p2) / 2 = (0.03 + 0.0345) / 2 = 0.03225

n = [ (z_α/2 × √(2 × p_bar × (1 - p_bar))) + (z_β × √(p1(1-p1) + p2(1-p2))) ]² / (p1 - p2)²

Numerator term 1: 1.96 × √(2 × 0.03225 × 0.96775) = 1.96 × √(0.06245) = 1.96 × 0.2499 = 0.4898
Numerator term 2: 0.842 × √(0.03 × 0.97 + 0.0345 × 0.9655) = 0.842 × √(0.0291 + 0.03331) = 0.842 × √(0.06241) = 0.842 × 0.2498 = 0.2104

n = (0.4898 + 0.2104)² / (0.03 - 0.0345)²
n = (0.7002)² / (0.0045)²
n = 0.49028 / 0.00002025
n ≈ 24,211 per variant
```

**Required sample per variant:** ~24,200 visitors
**Total sample required:** ~48,400 visitors

**Runtime calculation:**
```
Daily traffic: 500 visitors/day
100% of homepage traffic exposed (homepage is a single URL)
Traffic split: 50/50 between control and variant

Days to reach sample = 48,400 / 500 = 96.8 days
```

**Interpretation: This test requires approximately 97 days at 500 visitors/day to reach the required sample size at 15% MDE and 95% confidence.**

---

### Runtime Sensitivity Analysis

| Daily traffic | Days to complete (15% MDE, 95% confidence) |
|--------------|---------------------------------------------|
| 200/day | 242 days — impractical |
| 500/day | **97 days** — long but manageable for P1 test |
| 1,000/day | 48 days — acceptable |
| 2,000/day | 24 days — good |
| 5,000/day | 10 days — fast |

---

### Practical Recommendations

The 97-day runtime at 500 visitors/day is long but not unusual for a low-traffic SaaS homepage with a low-CTR metric. The following approaches are recommended:

**Option 1 (Preferred): Accept the 97-day runtime and run it.**
This is a low-risk, high-impact test. The test costs nothing in engineering time and the metric is critical to understand before paid spend scales. A hero headline test is foundational measurement — run it properly.

**Option 2: Relax confidence threshold to 90% (α = 0.10) to reduce runtime.**
At 90% confidence, the required sample drops to approximately 17,000 per variant (34,000 total), bringing runtime to ~68 days at 500 visitors/day. Acceptable if the team is comfortable with a slightly higher false-positive risk. Document this decision explicitly.

**Option 3: Increase MDE threshold to 20% relative.**
At 20% MDE (3.0% → 3.6%), required sample per variant drops to ~13,600 (total ~27,200), bringing runtime to ~55 days. This means the test can only detect a 20%+ lift — if the true effect is 15–19%, it will be missed. Acceptable only if a 20%+ lift is the minimum meaningful outcome.

**Option 4: Use sequential testing (Bayesian).**
PostHog's A/B test engine uses a Bayesian approach that allows continuous monitoring without inflating false positive rates. This is the recommended approach if early stopping is needed. Under a Bayesian framework, a credible interval of 95% with >80% probability that variant beats control is a valid stopping criterion — often achievable in 40–60% of the classical sample size.

**Recommended approach for this product stage:** Option 4 — use PostHog's built-in Bayesian A/B test to allow earlier decision-making. Set a decision threshold of 95% credibility + minimum 14 days runtime (to capture weekly seasonality). The 14-day minimum runtime is non-negotiable regardless of confidence.

---

### Minimum Runtime Rules

Even if statistical significance or Bayesian credibility is achieved before day 14:

- **Do not call a winner before 14 days.** Weekly traffic patterns can produce misleading early results (weekend vs. weekday visitor behaviour differs).
- **Check for novelty effect.** For any UI or copy test, the first 3 days of data may show inflated CTR on the variant due to novelty. If running a full frequentist analysis, consider discarding the first 3 days of data.
- **Maximum runtime:** 60 days. If the test has not reached decision threshold by day 60, declare INCONCLUSIVE and revert to control. Do not run indefinitely.

---

### Feature Flag Specification

**Flag name:** `exp-001-homepage-headline`
**Platform:** PostHog Feature Flags

**Flag logic:**
```
Flag: exp-001-homepage-headline
Type: Multivariate
Rollout: 100% of homepage traffic

Variants:
  control   → 50% — renders current headline (document current text before enabling flag)
  variant-a → 50% — renders "Ship a marketing engine that runs itself — built for founders who build"

Targeting:
  - All visitors (no audience filtering for this test)
  - Exclude: Internal team IPs (add IP blocklist once known)
  - Exclude: Bot traffic (PostHog handles this automatically via bot detection)
```

**PostHog implementation code (for engineering handoff):**
```javascript
// On homepage component mount:
const variant = posthog.getFeatureFlag('exp-001-homepage-headline');

const heroHeadline = variant === 'variant-a'
  ? "Ship a marketing engine that runs itself — built for founders who build"
  : "[CURRENT HEADLINE — document before enabling flag]";

// On hero CTA click:
posthog.capture('homepage_hero_cta_click', {
  experiment_variant: variant || 'control',
  cta_text: '[button text]',
  page_section: 'hero'
});
```

---

### Pre-Launch Checklist

Before setting the feature flag to active:

- [ ] PostHog snippet installed and confirmed receiving events on magistermarketing.com
- [ ] `homepage_hero_cta_click` event confirmed firing on click of hero CTA (manual QA)
- [ ] Feature flag `exp-001-homepage-headline` created in PostHog with correct variant split (50/50)
- [ ] `experiment_variant` property confirmed in event payload (check PostHog Live Events)
- [ ] Control headline text documented in this tracker (fill in the control headline field)
- [ ] Baseline CTR measurement completed — minimum 5 days of organic homepage traffic data with NO flag active
- [ ] Baseline CTR recorded: ____% (update before launching test)
- [ ] Internal IP exclusion configured in PostHog flag targeting
- [ ] Test launch date set: ____________
- [ ] Test end date set (minimum day 14, maximum day 60): ____________

---

### Baseline Data Collection Log

Collect 5 days of baseline data before activating the feature flag. Record daily:

| Date | Homepage sessions | Hero CTA clicks | CTR% | Notes |
|------|------------------|----------------|-------|-------|
| Pre-launch day 1 | — | — | — | Awaiting PostHog installation |
| Pre-launch day 2 | — | — | — | |
| Pre-launch day 3 | — | — | — | |
| Pre-launch day 4 | — | — | — | |
| Pre-launch day 5 | — | — | — | |
| **Baseline avg** | — | — | **—%** | Use this as p1 in sample size calc |

---

### Daily Data Log (populate once EXP-001 is running)

| Date | Variant | Sessions | Hero CTA clicks | CTR% | Cumulative sessions | Cumulative CTR% | Bayesian credibility % | Notes |
|------|---------|----------|----------------|-------|---------------------|-----------------|------------------------|-------|
| — | Control | — | — | — | — | — | — | Not started |
| — | Variant A | — | — | — | — | — | — | Not started |

---

### Result Block (populate when test concludes)

```
EXP-001 RESULT
Status:         [CONCLUDED — WIN / LOSS / INCONCLUSIVE]
Test run:       [start date] → [end date]
Total runtime:  [N days]

Control CTR:    [X]% ([N] clicks / [N] sessions)
Variant A CTR:  [X]% ([N] clicks / [N] sessions)
Relative lift:  [+/-X]%
Bayesian credibility: [X]%

Guardrail check (bounce rate):
  Control bounce rate:   [X]%
  Variant A bounce rate: [X]%
  Delta:                 [+/-X pp] — [PASS / FAIL]

Secondary metric (signup start rate):
  Control: [X]%
  Variant A: [X]%

Decision:       [SHIP VARIANT / REVERT TO CONTROL / EXTEND TEST]
Reason:         [Explanation]
Next action:    [Queue EXP-001b? Run EXP-002? Other?]
Declared by:    Paid & Measurement Agent
Declaration date: [Date]
```

---

## Planned Experiments Queue (Tracking Perspective)

| ID | Name | CRO priority | Tracking prerequisite | Tracking status |
|----|------|-------------|----------------------|-----------------|
| EXP-001 | Homepage hero headline | 1 | `homepage_hero_cta_click` + PostHog feature flag | NOT READY — pending PostHog |
| EXP-002 | GitHub auth as primary signup CTA | 2 | `trial_signup_completed` + GitHub OAuth status confirmation | BLOCKED — OAuth status unknown |
| EXP-003 | Named-peer social proof strip | 3 | `homepage_scroll_depth` (% reaching below-fold) | NOT READY — pending PostHog; also requires social proof copy |
| EXP-004 | Trial expiry: loss framing vs. gain framing | 4 | `trial_expiry_screen_shown` + Stripe webhook | NOT READY — requires trial cohort to exist |
| EXP-005 | Onboarding: product-first vs. guided checklist | 5 | `onboarding_variant` user property + aha moment event + Day-7 cohort | NOT READY — requires onboarding flow build |

---

## Concluded Experiments

*None. First-ever run.*

---
