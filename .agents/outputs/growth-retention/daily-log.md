# Growth & Retention Agent — Daily Log

---

## 2026-03-23 — First Run (Bootstrap)

**Run type:** Daily — first-ever execution
**Run order:** Wave 4 (parallel with Paid & Measurement Agent)
**Psychology hook in effect:** Social Proof + In-Group Identity (builder/founder identity)
**Upstream handoffs read:** CRO Agent DONE.md (complete), Paid & Measurement Agent (running in parallel — no data available yet)

---

### Status Summary

| Task | Status | Notes |
|------|--------|-------|
| Churn signal monitoring | No data — infrastructure setup drafted | First run; no active subscribers yet |
| Dunning campaign check | No active campaigns — sequence drafted | Ready to deploy on billing activation |
| Referral programme health | Not configured — programme brief drafted | Tool recommendation: Rewardful |
| Free tool pipeline check | No tools live — top opportunity identified | AI marketing audit tool recommended |

No escalation conditions triggered. Monthly churn is not yet measurable (no active subscriber base). All outputs are draft/setup documents.

---

### Task 1: Churn Signal Monitoring

**Status:** First run. No subscriber base, no churn data, no event instrumentation active.

#### Monitoring Infrastructure Needed

Before churn signals can be tracked, the following infrastructure must be in place:

**Event instrumentation (Magister onboarding → PostHog or Mixpanel):**
- `trial_started` — with `acquisition_source`, `plan`, `signup_variant` properties
- `trial_day_1_active`, `trial_day_7_active`, `trial_day_30_active` — login-based activity flags
- `feature_used` — with `feature_name`, `user_id`, `days_since_signup` properties
- `trial_expiry_screen_shown` — required for EXP-004 (CRO Agent handoff)
- `subscription_started` — Stripe webhook → analytics
- `cancellation_initiated` — entry into cancel flow
- `cancellation_completed` — confirmed cancel
- `payment_failed` — Stripe webhook → analytics

**Cohort monitoring (weekly cadence once data exists):**
- D1 / D7 / D30 retention by acquisition cohort
- Trial-to-paid conversion by cohort week
- Disengaged cohort alert: users with 0 logins in 14+ days who have not cancelled (passive churn risk)

**Health score baseline (build when first 50 active users exist):**

```
Health Score (0–100) =
  Login frequency score × 0.30
  Feature usage score   × 0.25
  Support sentiment     × 0.15
  Billing health        × 0.15
  Engagement score      × 0.15
```

Score bands: 80–100 Healthy → Upsell; 60–79 Needs attention → Check-in; 40–59 At risk → Intervention; 0–39 Critical → Personal outreach.

#### ICP-Specific Risk Signals to Watch

For technical founders (Magister ICP), the leading churn signals that matter most:

| Signal | Risk Level | Action |
|--------|-----------|--------|
| No agent workflow run in 14+ days | High | Re-engagement email: "Your marketing loop hasn't run — here's what you're missing" |
| Zero outputs generated after trial day 7 | Critical | Onboarding intervention — activate success-moment trigger |
| Billing page visit with no upgrade | High | Trigger paywall save offer (feeds EXP-004) |
| Trial expiry in 72 hours with no paid conversion | High | Expiry loss-framing email (feeds EXP-004) |
| GitHub repo disconnect / agent config error | High | Technical support trigger — proactive outreach |

#### First 30-Day Retention Priority

Given ICP context (technical founders, small SaaS teams), the highest-risk churn window is Day 1–7 — before the user has run their first autonomous agent loop. Key activation metric hypothesis: **first complete daily agent run** (all 7 agents completing in sequence). Users who complete their first full run within 7 days are significantly less likely to churn at Day 30. Instrument and validate this with cohort data from first 100 users.

**CRO Agent handoff note actioned:** EXP-005 (onboarding skip-to-product) requires Day-7 and Day-30 cohort tracking split by `signup_variant`. This agent will configure cohort tracking columns in the retention-cohort-report once PostHog is instrumented. Alert to CRO Agent if D1 activation rises but D7 retention falls — requires EXP-005 pause.

#### Churn Threshold

Escalation threshold: **>5% monthly churn** (default per product-marketing-context.md — owner should confirm a specific target for Magister once MRR is established). Current: N/A (no subscribers). Next run: check if baseline has been defined.

---

### Task 2: Dunning Campaign Check

**Status:** No active dunning campaigns. No failed payments. No billing events recorded.

Full dunning sequence drafted and ready to deploy — see `dunning-tracker.md`.

**Recommended billing provider for dunning:** Stripe (already aligned with ICP; Smart Retries is built-in; card updater automatic). When Stripe is activated for Magister subscriptions, enable:
- Smart Retries (automatic — no config required in Stripe Billing)
- Automatic card updater (Visa/Mastercard — enabled by default in Stripe)
- Stripe billing emails (use as pre-dunning foundation; supplement with custom sequence via Customer.io or Resend)

**Key decision needed from owner:** What is the grace period before hard-cancel after final dunning step? Recommendation: 14 days total (Day 0 failure → Day 14 hard cancel with reactivation path). Revenue-at-risk threshold for manual review escalation: recommend £100/month MRR per affected subscriber.

---

### Task 3: Referral Programme Health

**Status:** No referral programme configured. No referral links issued. No clicks, signups, or rewards tracked.

Full programme brief drafted and tool recommendation made — see `referral-tracker.md`.

**Summary recommendation:** Launch Magister's referral programme using Rewardful (Stripe-native, ~$49/month). Structure: double-sided — referring user gets 1 month free on next billing cycle; referred user gets 14-day extended trial (vs. standard 7-day). Trigger: prompt in-product after first successful full agent loop run (activation moment). This is the highest-leverage share moment because the user has just seen the product work.

**Why now matters:** Early users are the best referrers. They carry founder-to-founder credibility with the ICP. A referral programme launched at <100 users is a compounding investment — delay of 3 months means losing the window of highest-engagement early adopters.

**Pre-launch blocklist check (fraud prevention):** Set Rewardful rules — max 3 referral rewards per account per 30 days; require referred user to remain active for 14 days before reward is issued; block self-referral via email match.

---

### Task 4: Free Tool Pipeline Check

**Status:** No free tools live. No leads generated via free tools. No email capture from tool channel.

Top free tool opportunity identified and brief drafted — see `free-tool-tracker.md`.

**Summary recommendation:** Build an **AI Marketing Audit Tool** — a web-based tool where a technical founder inputs their SaaS URL and receives an instant automated marketing audit report (SEO health, positioning clarity score, CRO issues flagged, email sequence gaps). Output is partially shown free; full report requires email. Target keyword: "marketing audit tool for SaaS" and "free SaaS marketing audit."

**Strategic rationale:** This tool is directly adjacent to Magister's core value proposition. Every person who uses the audit tool has self-identified as a founder who cares about their marketing quality — the highest-intent segment. Estimated tool-to-trial conversion: 8–15% (based on comparable SaaS audit tools). Email capture rate at partially-gated structure: 35–55%.

**Engineering escalation flag:** Building this tool requires engineering resources (API calls to crawl URL, run scoring logic, generate PDF report). This is flagged for human approval before committing to build. No-code alternative: use Typeform + Zapier + GPT API to deliver a survey-based audit — faster to build, lower quality, but proves demand before full engineering investment.

---

### Recommendations for Next Run (2026-03-24)

1. Confirm billing provider with owner (Stripe assumed) — affects dunning setup timing
2. Confirm referral programme launch go/no-go — Rewardful setup takes ~2 hours
3. Confirm free tool build approach (full build vs. no-code MVP) — affects engineering queue
4. Check if Paid & Measurement Agent has begun cohort instrumentation — feeds Day-7/Day-30 retention tracking
5. Check if Strategy Agent has produced updated psychology hooks for 2026-03-24 daily sequence

---

*Log entry written: 2026-03-23*
*Next entry: 2026-03-24*
