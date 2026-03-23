# Paid & Measurement Agent — Tracking Health

**Product:** Marketing Skills (open-source) + Magister (magistermarketing.com)
**Maintained by:** Paid & Measurement Agent (appended on each run)
**Last updated:** 2026-03-23

---

## 2026-03-23 — Tracking Implementation Plan (First Run)

**Tracking status:** No events confirmed as live. No analytics platform confirmed on magistermarketing.com. This document specifies every conversion event required across the funnel, their triggers, recommended platforms, implementation priority, and current status.

---

## Recommended Tracking Stack

| Layer | Tool | Purpose | Priority |
|-------|------|---------|----------|
| Product analytics + A/B | PostHog | Event tracking, feature flags, cohort analysis, funnel analysis | CRITICAL — must be first |
| Web analytics + SEO | GA4 | Traffic sources, page performance, organic search attribution | HIGH |
| Email platform | Customer.io | Behavior-triggered email events synced via PostHog webhook | HIGH |
| Revenue correlation | Stripe Webhook → PostHog | Trial-to-paid conversion event, revenue attribution | HIGH |
| Tag management | Not required (PostHog SDK preferred over GTM for this stack) | — | LOW |

**Why PostHog first:** PostHog provides event tracking, feature flags (required for A/B tests), cohort analysis (required for EXP-005 retention tracking), and a Stripe integration in one tool. For a technical SaaS founder stack, PostHog is the correct layer-one analytics choice. It can self-host or run on cloud. GA4 runs in parallel for SEO/organic reporting.

---

## Conversion Event Specifications

### Event 1 — Trial Signup Started

| Field | Value |
|-------|-------|
| **Event name** | `trial_signup_started` |
| **Trigger** | User navigates to the signup page (magistermarketing.com/signup or /register) AND the signup form or GitHub auth button is rendered in the viewport |
| **Platform** | PostHog (primary) + GA4 (secondary, via pageview goal) |
| **Implementation** | PostHog: `posthog.capture('trial_signup_started', { source: 'direct' | 'cta_hero' | 'cta_nav' | 'cta_footer', utm_source, utm_medium, utm_campaign })` — fire on signup page load |
| **Properties to capture** | `source` (which CTA referred), UTM parameters (all 5: source, medium, campaign, term, content), referrer URL |
| **Implementation status** | NOT IMPLEMENTED — pending PostHog installation |
| **Priority** | P0 — CRITICAL |
| **Blocking what** | All paid spend, EXP-002, funnel analysis |
| **Validation method** | Load signup page → check PostHog Live Events feed → confirm event fires with correct properties |

---

### Event 2 — Trial Signup Completed

| Field | Value |
|-------|-------|
| **Event name** | `trial_signup_completed` |
| **Trigger** | User successfully creates an account — fires after account creation API call returns 200 OK or after post-signup redirect to dashboard/onboarding |
| **Platform** | PostHog (primary) + GA4 conversion event |
| **Implementation** | PostHog: `posthog.capture('trial_signup_completed', { signup_method: 'email' | 'github' | 'google', utm_source, utm_medium, utm_campaign })` + `posthog.identify(userId, { email, signup_date, signup_method, utm_source })` |
| **Properties to capture** | `signup_method`, UTM parameters, `referrer`, `signup_date` |
| **Implementation status** | NOT IMPLEMENTED — pending PostHog installation |
| **Priority** | P0 — CRITICAL |
| **Blocking what** | All paid spend (this is the primary conversion event), EXP-002, CAC calculation |
| **Validation method** | Complete a test signup → confirm event fires → confirm `identify` call links anonymous session to known user → check GA4 conversion is counting |

---

### Event 3 — Homepage Hero CTA Click

| Field | Value |
|-------|-------|
| **Event name** | `homepage_hero_cta_click` |
| **Trigger** | User clicks the primary CTA button in the hero section of the homepage (magistermarketing.com) — fires on click event, before navigation |
| **Platform** | PostHog (primary) |
| **Implementation** | PostHog: `posthog.capture('homepage_hero_cta_click', { cta_text: '[button text]', experiment_variant: 'control' | 'variant-a', page_section: 'hero' })` — the `experiment_variant` property is populated by the PostHog feature flag value for EXP-001 |
| **Properties to capture** | `cta_text` (exact button label), `experiment_variant` (for A/B attribution), `page_section`, `session_id` |
| **Implementation status** | NOT IMPLEMENTED — pending PostHog installation |
| **Priority** | P0 — CRITICAL for EXP-001 baseline |
| **Blocking what** | EXP-001 baseline collection, EXP-001 test launch, homepage CTA optimisation |
| **Validation method** | Click hero CTA on homepage → check PostHog Live Events → confirm `experiment_variant` property matches the active feature flag variant |
| **Notes** | This event must fire identically on control and variant — the only difference in the property payload should be `experiment_variant`. Do not create separate event names per variant. |

---

### Event 4 — Install Command Copied

| Field | Value |
|-------|-------|
| **Event name** | `install_command_copied` |
| **Trigger** | User clicks the "copy" button on any code block containing the install command (`npx skills add coreyhaines31/marketingskills`) — fires on clipboard copy event |
| **Platform** | PostHog (primary) + GA4 event |
| **Implementation** | PostHog: `posthog.capture('install_command_copied', { source_page: 'homepage' | 'github_readme' | 'docs' | 'email', command_variant: 'npx' | 'other' })` — wire to `navigator.clipboard.writeText` callback or onClick on copy button |
| **Properties to capture** | `source_page`, `command_variant`, `utm_source` if present |
| **Implementation status** | NOT IMPLEMENTED |
| **Priority** | P1 — HIGH |
| **Blocking what** | Open-source funnel top-of-funnel measurement, GitHub → install conversion rate |
| **Validation method** | Click copy button on install command → PostHog Live Events confirms event with correct `source_page` |
| **Notes** | This is the primary conversion event for the open-source (free) funnel. It acts as a proxy for install intent since actual npm/npx execution happens client-side and cannot be tracked server-side. |

---

### Event 5 — GitHub Repository Star

| Field | Value |
|-------|-------|
| **Event name** | `github_repo_starred` |
| **Trigger** | User stars the Marketing Skills GitHub repository |
| **Platform** | PostHog via GitHub webhook (GitHub App → webhook → PostHog capture API) |
| **Implementation** | Set up GitHub App webhook for `star` event on the `coreyhaines31/marketingskills` repository → POST to PostHog capture API: `{ event: 'github_repo_starred', properties: { stargazer_login, starred_at } }`. Note: GitHub does not provide email — this event is anonymous unless linked to a PostHog user via a downstream signup. |
| **Properties to capture** | `stargazer_login` (GitHub username), `starred_at` (ISO timestamp), `repo_name` |
| **Implementation status** | NOT IMPLEMENTED |
| **Priority** | P2 — MEDIUM |
| **Blocking what** | GitHub star → signup conversion funnel analysis, referral attribution |
| **Validation method** | Star the repo with a test account → check PostHog for event ingestion via the capture API |
| **Notes** | This metric serves as a leading indicator of top-of-funnel health. Track star velocity (stars/day, stars/week) as a proxy for organic reach. Attribution to downstream signups is approximate — use `utm_source=github_stars` as best-effort correlation. |

---

### Event 6 — Email Capture

| Field | Value |
|-------|-------|
| **Event name** | `email_captured` |
| **Trigger** | User submits their email address in any opt-in form (homepage, lead magnet download, popup, footer newsletter) before creating a full account |
| **Platform** | PostHog (primary) + Customer.io (receives email for sequence trigger) |
| **Implementation** | PostHog: `posthog.capture('email_captured', { form_location: 'homepage_hero' | 'exit_popup' | 'lead_magnet' | 'footer', lead_magnet: '[asset name]' | null })` + `posthog.identify(tempId, { email })` before full signup; Customer.io: email is passed to Customer.io via API to trigger welcome sequence |
| **Properties to capture** | `form_location`, `lead_magnet` (null if general newsletter), `utm_source`, `utm_campaign` |
| **Implementation status** | NOT IMPLEMENTED — email capture form not yet confirmed live |
| **Priority** | P1 — HIGH |
| **Blocking what** | Welcome email sequence deployment, email list building, top-of-funnel lead measurement |
| **Validation method** | Submit test email in form → PostHog shows `email_captured` event with correct `form_location` → Customer.io shows new contact created → welcome email sequence triggers |

---

### Event 7 — Trial Expiry Screen Shown

| Field | Value |
|-------|-------|
| **Event name** | `trial_expiry_screen_shown` |
| **Trigger** | User reaches the trial expiry gate — fires when the paywall/expiry modal or page renders for a user whose trial has ended |
| **Platform** | PostHog (primary) |
| **Implementation** | PostHog: `posthog.capture('trial_expiry_screen_shown', { days_since_signup: N, actions_taken_in_trial: N, experiment_variant: 'control' | 'loss-framing' })` — `experiment_variant` populated by EXP-004 feature flag |
| **Properties to capture** | `days_since_signup`, `actions_taken_in_trial` (count of agent tasks or sessions), `trial_plan`, `experiment_variant` |
| **Implementation status** | NOT IMPLEMENTED |
| **Priority** | P2 — MEDIUM (required for EXP-004, but EXP-004 is 4th in priority queue) |
| **Blocking what** | EXP-004 (trial expiry copy A/B test), trial-to-paid conversion rate measurement |
| **Validation method** | Create test account, expire trial manually in Stripe → confirm expiry screen renders → PostHog event fires with correct properties |

---

### Event 8 — Upgrade / Subscription Started

| Field | Value |
|-------|-------|
| **Event name** | `subscription_started` |
| **Trigger** | User completes payment and a Stripe subscription is created — fires via Stripe webhook |
| **Platform** | PostHog (via Stripe webhook → server-side capture) + GA4 (e-commerce purchase event) + Stripe (native) |
| **Implementation** | Stripe webhook on `customer.subscription.created` → server-side: `posthog.capture({ distinctId: userId, event: 'subscription_started', properties: { plan: 'starter' | 'pro' | 'scale', mrr: N, trial_converted: true | false, days_to_convert: N, utm_source } })` |
| **Properties to capture** | `plan`, `mrr` (monthly revenue), `trial_converted` (boolean), `days_to_convert` (days from signup to payment), `utm_source`, `utm_campaign` |
| **Implementation status** | NOT IMPLEMENTED — Stripe integration not yet confirmed |
| **Priority** | P1 — HIGH |
| **Blocking what** | Revenue attribution, CAC by channel, trial-to-paid conversion rate for EXP-004, ROAS calculation for paid campaigns |
| **Validation method** | Test subscription via Stripe test mode → Stripe webhook fires → PostHog receives server-side event with correct properties → GA4 shows purchase event |
| **Notes** | This is the ultimate downstream conversion event. Every paid campaign optimises toward this. Ensure `utm_source` from the original acquisition session is passed through to this event via user property set at signup. |

---

## UTM Parameter Scheme

A consistent UTM naming convention must be established before any paid campaigns launch. All links from all channels must use this scheme.

### Standard Parameters

| Parameter | Values | Notes |
|-----------|--------|-------|
| `utm_source` | `reddit`, `linkedin`, `twitter`, `google`, `producthunt`, `github`, `newsletter`, `email` | Always lowercase |
| `utm_medium` | `paid`, `organic`, `email`, `social`, `referral`, `cpc` | `paid` for any spend |
| `utm_campaign` | `[date]-[objective]-[audience]` e.g. `2026-03-awareness-founders` | Date prefix enables campaign tiering |
| `utm_content` | `[creative-variant]` e.g. `variant-a-identity`, `variant-b-pain` | Critical for creative A/B measurement |
| `utm_term` | `[keyword]` for Google Search; not required for social | Google only |

### Example UTM URLs

```
Reddit Variant A (Identity):
https://magistermarketing.com?utm_source=reddit&utm_medium=paid&utm_campaign=2026-03-awareness-founders&utm_content=variant-a-identity

LinkedIn Single Image Variant B (Pain):
https://magistermarketing.com?utm_source=linkedin&utm_medium=paid&utm_campaign=2026-03-awareness-founders&utm_content=variant-b-pain

Email CTA — Email 5 of welcome sequence:
https://magistermarketing.com?utm_source=email&utm_medium=email&utm_campaign=welcome-sequence&utm_content=email-5-trial-cta
```

### UTM Governance Rules

1. Never launch a paid campaign without UTM parameters on every link
2. Never use different capitalisation for the same source (reddit not Reddit)
3. Document all active UTM combinations in a separate campaign sheet when live
4. PostHog auto-captures UTM parameters on page load — verify this is enabled in PostHog settings
5. GA4 also auto-captures UTM parameters — ensure both are receiving them

---

## Tracking Health Status Summary

| Event | Platform | Priority | Status |
|-------|----------|----------|--------|
| `trial_signup_started` | PostHog + GA4 | P0 | NOT IMPLEMENTED |
| `trial_signup_completed` | PostHog + GA4 | P0 | NOT IMPLEMENTED |
| `homepage_hero_cta_click` | PostHog | P0 | NOT IMPLEMENTED |
| `install_command_copied` | PostHog + GA4 | P1 | NOT IMPLEMENTED |
| `email_captured` | PostHog + Customer.io | P1 | NOT IMPLEMENTED |
| `subscription_started` | PostHog + GA4 + Stripe | P1 | NOT IMPLEMENTED |
| `github_repo_starred` | PostHog via webhook | P2 | NOT IMPLEMENTED |
| `trial_expiry_screen_shown` | PostHog | P2 | NOT IMPLEMENTED |

**Overall tracking health:** RED — No events are confirmed live. No paid spend should be committed until P0 events are confirmed firing.

---

## Implementation Sequence (Recommended Order)

**Day 1 (unblocks everything):**
1. Install PostHog SDK on magistermarketing.com (snippet or npm package)
2. Verify PostHog is receiving pageview events
3. Fire `homepage_hero_cta_click` on hero CTA (enables EXP-001 baseline)
4. Fire `trial_signup_started` on signup page load
5. Fire `trial_signup_completed` on successful account creation + PostHog identify call

**Day 2 (unblocks paid campaigns):**
6. Install GA4 snippet and link GA4 property to site
7. Fire `install_command_copied` on all install command copy buttons
8. Set up UTM parameter passthrough testing (use UTM Builder to create test links, verify PostHog receives utm_source)
9. Fire `email_captured` on any email opt-in forms

**Day 3 (unblocks revenue attribution):**
10. Configure Stripe webhook → PostHog server-side capture for `subscription_started`
11. Test full conversion funnel: anonymous visit → signup → subscription in Stripe test mode → confirm PostHog shows linked event chain

**Day 5+ (after baseline collection starts):**
12. Create PostHog feature flag `exp-001-homepage-headline` (see experiment-tracker.md for flag logic)
13. Verify `experiment_variant` property populates correctly on `homepage_hero_cta_click` events
14. Launch EXP-001 (see experiment-tracker.md for runtime and analysis instructions)

**Week 2+ (lower priority):**
15. GitHub repo webhook → PostHog for `github_repo_starred`
16. `trial_expiry_screen_shown` event (required for EXP-004 when trial cohorts exist)
17. Customer.io connection for email sequence analytics sync

---

*Next tracking health update: 2026-03-24 — confirm whether PostHog and GA4 are live on magistermarketing.com.*

---
