# CRO Agent — Experiment Tracker

**Product:** Marketing Skills (open-source) + Magister (magistermarketing.com)
**Maintained by:** CRO Agent (updated daily)
**Last updated:** 2026-03-23

---

## How to Use This File

- This file is the live source of truth for all active, paused, and concluded A/B experiments.
- The CRO Agent updates this file daily with visitor counts, conversion rates, and confidence levels.
- When a test reaches 95% statistical significance, the CRO Agent writes a result block and flags the Paid & Measurement Agent.
- Concluded experiments are moved to the "Concluded" section with a final result summary.

---

## Experiment Status Definitions

| Status | Meaning |
|---|---|
| `PLANNED` | Hypothesis approved, awaiting instrumentation |
| `RUNNING` | Live and collecting data |
| `PAUSED` | Temporarily halted (investigate reason) |
| `CONCLUDED — WIN` | Variant beat control at ≥95% confidence |
| `CONCLUDED — LOSS` | Control beat variant at ≥95% confidence |
| `CONCLUDED — INCONCLUSIVE` | No significant difference after full runtime |
| `ESCALATED` | Negative result >10% on primary metric — human review required |

---

## Active Experiments

*No active experiments as of 2026-03-23. This is the first-ever run. See Planned queue below.*

---

## Planned Experiments (Next in Queue)

### EXP-001 — Homepage Hero: Outcome-Focused Headline
**Status:** `PLANNED`
**Priority:** 1
**Hypothesis:** Technical founders respond to concrete outcome framing over feature/category framing in the hero headline. Switching from a category-positioning headline to an outcome headline ("Ship a marketing engine that runs itself — built for founders who build") will increase homepage-to-signup click-through rate.
**Funnel stage:** Homepage
**Control:** Current headline (to be documented on first site access)
**Variant:** "Ship a marketing engine that runs itself — built for founders who build"
**Primary metric:** Homepage CTA click-through rate (hero CTA)
**Secondary metric:** Homepage → Signup completion rate
**Minimum sample size:** 500 visitors per variant (estimated, pending baseline CR)
**Recommended runtime:** 14 days minimum
**Test platform:** PostHog or VWO
**Date planned:** 2026-03-23
**Date started:** —
**Date concluded:** —

---

### EXP-002 — Signup Flow: Social Auth as Primary CTA
**Status:** `PLANNED`
**Priority:** 2
**Hypothesis:** Technical founders prefer low-friction signup paths. Presenting "Sign up with GitHub" or "Sign up with Google" as the visually dominant CTA (above email form) will increase signup completion rate by reducing form friction.
**Funnel stage:** Signup flow
**Control:** Email + password form as primary, social auth as secondary
**Variant:** GitHub/Google auth as primary (large button, above fold), email form below as secondary option
**Primary metric:** Signup completion rate (form start → account created)
**Secondary metric:** Time to complete signup
**Minimum sample size:** 300 signups per variant
**Recommended runtime:** 14–21 days
**Test platform:** PostHog feature flags + custom event tracking
**Date planned:** 2026-03-23
**Date started:** —
**Date concluded:** —

---

### EXP-003 — Homepage Social Proof Bar: Named Peers vs. Logo Soup
**Status:** `PLANNED`
**Priority:** 3
**Hypothesis:** For a technical-founder ICP, social proof from named peers (e.g., "Used by founders at Vercel, Linear, Raycast" or individual founder handles) converts better than generic logo bars, because in-group identity recognition outperforms brand-name association.
**Funnel stage:** Homepage
**Control:** Standard logo bar or no social proof bar
**Variant:** "Built for people like you — founders at [specific recognizable indie/startup names] use Marketing Skills" with founder Twitter handles or headshots
**Primary metric:** Scroll depth past hero section (engagement)
**Secondary metric:** Homepage → Signup rate
**Minimum sample size:** 500 visitors per variant
**Recommended runtime:** 14 days
**Test platform:** PostHog
**Date planned:** 2026-03-23
**Date started:** —
**Date concluded:** —

---

### EXP-004 — Paywall Upgrade: Trial Expiry Copy — Loss Aversion vs. Value Gain
**Status:** `PLANNED`
**Priority:** 4
**Hypothesis:** Loss-aversion framing ("You're about to lose access to X campaigns, Y reports") in the trial expiry screen will outperform value-gain framing ("Upgrade to keep automating your marketing") for Magister's technical-founder segment, who have invested setup effort and dislike losing work.
**Funnel stage:** Paywall (trial expiry)
**Control:** Value-gain framing: "Upgrade to [Pro/Starter] to keep your marketing running"
**Variant:** Loss-aversion framing: "Don't lose what you've built — [X] active campaigns and [Y] weeks of content will pause on [date]"
**Primary metric:** Trial-to-paid conversion rate at expiry screen
**Secondary metric:** Time to upgrade decision (same-session vs. return)
**Minimum sample size:** 200 trial expiry events per variant
**Recommended runtime:** 30 days (lower volume event)
**Test platform:** PostHog + Stripe event correlation
**Date planned:** 2026-03-23
**Date started:** —
**Date concluded:** —

---

### EXP-005 — Onboarding: Guided Checklist vs. Product-First
**Status:** `PLANNED`
**Priority:** 5
**Hypothesis:** Technical founders are self-directed and find onboarding checklists patronizing. Offering a "skip setup, explore now" path immediately post-signup will increase Day-1 activation rate compared to a guided checklist that requires completing 4+ steps before reaching the core product.
**Funnel stage:** Onboarding (post-signup, first session)
**Control:** Guided setup checklist (4–6 steps before reaching dashboard)
**Variant:** Direct product access with a dismissable setup prompt in the corner ("Set up when you're ready — takes 3 min")
**Primary metric:** Day-1 activation rate (reaches core "aha moment" action)
**Secondary metric:** Day-7 retention rate
**Minimum sample size:** 200 new signups per variant
**Recommended runtime:** 21 days (retention signal needs time)
**Test platform:** PostHog + user property segmentation
**Date planned:** 2026-03-23
**Date started:** —
**Date concluded:** —

---

## Concluded Experiments

*None yet. First-ever run.*

---

## Tracker Schema Reference

When logging a running experiment daily, use this row format:

```
| [Date] | [EXP-ID] | [Variant] | Visitors | Conversions | CR% | Confidence% | Notes |
```

Example daily update table (once experiments are live):

| Date | Experiment | Variant | Visitors | Conversions | CR | Confidence | Notes |
|---|---|---|---|---|---|---|---|
| 2026-03-24 | EXP-001 | Control | 0 | 0 | — | — | Test not started |
| 2026-03-24 | EXP-001 | Variant | 0 | 0 | — | — | Test not started |

---

## Statistical Significance Notes

- Target confidence threshold: **95%** (two-tailed)
- Minimum detectable effect (MDE): **10% relative lift** on primary metric
- Use a frequentist calculator (e.g., Evan's A/B Test Calculator or PostHog's built-in) for daily checks
- Do not call winners early — enforce minimum runtime even if confidence is reached before minimum sample
- For low-traffic tests (under 100/day per variant), extend runtime rather than reducing sample targets

---
