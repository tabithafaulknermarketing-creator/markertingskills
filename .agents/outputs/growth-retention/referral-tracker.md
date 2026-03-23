# Referral Programme Tracker — Magister

**Last updated:** 2026-03-23
**Status:** Initialized — programme not yet configured (first run)
**Recommended tool:** Rewardful
**Programme type:** Double-sided customer referral (not affiliate — see note below)

---

## Active Referral Links

| Referrer | Email | Plan | Link ID | Clicks | Signups Attributed | Trials Converted | Rewards Triggered | Reward Status | Joined |
|----------|-------|------|---------|--------|-------------------|-----------------|------------------|--------------|--------|
| — | — | — | — | — | — | — | — | — | — |

*No referral links issued. Tracker will be populated when programme launches.*

---

## Programme Summary Metrics (Rolling 30 Days)

| Metric | Target | Current |
|--------|--------|---------|
| Active referrers (referred ≥1 in 30 days) | ≥5% of active users | — |
| Total referral clicks | — | — |
| Signups from referral links | — | — |
| Trial-to-paid from referrals | ≥20% | — |
| Rewards triggered | — | — |
| Reward fulfilment failures | 0 | — |
| % of new customers from referrals | Target: 15-20% | — |
| Referred user 30-day retention | Target: >70% | — |

---

## Referral Programme Brief — Magister

### Programme Rationale

Technical founders trust peer recommendations over paid advertising. The Magister ICP — builders, indie hackers, small SaaS teams — form tight-knit communities on Twitter/X, Indie Hackers, Discord servers, and in Slack groups. A well-structured referral programme turns every happy early adopter into a credibility node in exactly the networks where the next customer is likely to be found.

Referred customers for B2B SaaS products typically have 16–25% higher LTV, 18–37% lower churn, and refer others at 2–3x the rate of organic acquires. For a pre-growth-stage product like Magister, these compounding effects are more valuable per dollar than most paid channels.

### Incentive Model: Double-Sided

Double-sided rewards have higher conversion rates because they create a "win-win" framing that makes sharing feel less transactional. The referring user can share with confidence — they're giving their friend a genuine benefit, not just promoting a product.

| Party | Reward | Mechanics |
|-------|--------|-----------|
| Referring user (existing Magister subscriber) | 1 month free on next billing cycle | Applied as credit to next invoice after referred user converts to paid |
| Referred user (new signup via referral link) | 14-day extended trial (vs. standard 7-day) | Applied automatically at signup via referral link; clearly shown on pricing/signup page |

**Why these specific rewards:**
- **1 month free for referrer**: Tangible, easy to communicate ("I can get a free month if you sign up"). Costs less than a cash payout but feels like real money. Does not require a commission payout infrastructure — it's a billing credit.
- **14-day extended trial for referred user**: Directly reduces friction at the main conversion barrier. Technical founders want time to evaluate tools properly before paying. Doubling the trial period is a material incentive for this audience, not a generic discount.

**Reward issuance timing:** Reward is issued to referrer only after referred user has been an active paid subscriber for 14 days (prevents fraud and ensures reward reflects genuine acquisition, not free trial gamesmanship).

### Sharing Mechanism

**Primary:** In-product referral prompt — shown as a banner/modal inside Magister after the user completes their first full agent loop run (the activation moment). Copy: *"Your marketing loop just ran. Know another founder who should have this? Share your link — they get a 14-day free trial, you get a free month."*

**Secondary:** Email trigger — sent 7 days after trial-to-paid conversion. Subject: `You can earn a free month of Magister`. Body: explain the programme, include unique referral link.

**Tertiary:** Account settings page — permanent referral link with programme explanation accessible at any time.

**Format:** Unique URL per user (not a referral code — URLs convert at higher rates because they're one-click). Example: `magistermarketing.com/ref/[username]`

### Trigger Moments

Launch the referral prompt at these high-intent moments (in priority order):

1. **After first full agent loop completion** — Highest activation energy; user has just experienced the core value for the first time. This is the prime share moment.
2. **After first paid invoice** — User has committed financially; trust is established.
3. **7 days after trial-to-paid conversion** — Post-purchase glow period; NPS would likely be high.
4. **After achieving a notable outcome** — e.g., after first piece of content published via agent, or first A/B test launched.

Do not show referral prompt during trial (before activation) or within the first 48 hours of signup — too early, user has not seen value yet.

### Fraud Prevention Rules

Configure these rules in Rewardful before programme launches:
- Maximum 3 referred users earning rewards per referrer per 30 days (prevents bulk referral abuse)
- Self-referral blocked: email match between referrer and referred user
- Referred user must reach paid status and remain active for 14 days before reward is issued
- Reward witheld if referred user uses a disposable email domain (flag a blocklist)

---

## Tool Recommendation: Rewardful

### Why Rewardful (vs. ReferralHero vs. Custom)

| Factor | Rewardful | ReferralHero | Custom Build |
|--------|-----------|--------------|-------------|
| Stripe-native | Yes — deep integration, billing credits automatic | Partial | Requires build |
| Time to launch | ~2 hours | ~3 hours | 2–4 weeks |
| Monthly cost | $49/month (Starter) | $99+/month | Dev time + maintenance |
| Affiliate support | Yes (can extend programme to affiliates later) | Limited | Requires build |
| ICP fit | Used by many SaaS founders — credible | More B2C-oriented | N/A |
| Fraud controls | Good rule set | Basic | Requires build |
| Referral-only (no affiliate) | Can do both — start referral, add affiliate layer later | Referral-focused | N/A |

**Verdict: Rewardful.** At $49/month with Stripe-native billing credit automation and a clean API, Rewardful is the right fit for a technical founder-run SaaS at this stage. It handles the billing integration cleanly (referral credit applied as invoice discount — no manual accounting), and the affiliate programme feature means the same platform can later support a separate affiliate/creator tier without migrating tools.

**Alternative consideration — Tolt:** Tolt ($29/month) is also viable and slightly cheaper, with similar Stripe integration. Consider Tolt if cost matters significantly at launch and the affiliate layer is deprioritised for 6+ months. However, Rewardful has more community resources and integrations relevant to the ICP.

**Do not build custom at this stage.** Engineering time is better spent on the free tool (higher expected ROI) and product. A custom referral system provides no differentiation for a B2B SaaS.

### Setup Requirements (Rewardful)

1. Create Rewardful account and connect Stripe
2. Configure double-sided incentive (billing credit for referrer + trial extension coupon for referred)
3. Generate referral link format: `magistermarketing.com/ref/[username]`
4. Install Rewardful JS snippet on magistermarketing.com signup flow
5. Add referral link to in-product dashboard (post-activation prompt)
6. Configure fraud rules (see above)
7. Test full referral loop end-to-end before publicising

**Estimated setup time:** 2–3 hours (Rewardful + Stripe config) + 1 hour for in-product placement.
**Engineering escalation required:** Yes — in-product referral prompt and account settings page require frontend implementation. Flag to engineering when programme is approved for launch.

---

## Reward Fulfilment Log

| Date | Referrer | Referred User | Reward Type | Status | Notes |
|------|----------|---------------|------------|--------|-------|
| — | — | — | — | — | — |

*No rewards issued yet.*

---

## Referral Programme Launch Checklist

- [ ] Owner approves programme structure and incentive values
- [ ] Rewardful account created and Stripe connected
- [ ] Billing credit (1 month free) configured for referrer reward
- [ ] Trial extension coupon (14-day) configured for referred user reward
- [ ] Fraud prevention rules set
- [ ] In-product referral prompt built (post-activation moment)
- [ ] Referral link page in account settings built
- [ ] Email trigger (Day 7 post-conversion) configured in Customer.io or Resend
- [ ] End-to-end test completed
- [ ] Programme announcement email drafted (Content & Copy Agent)
- [ ] Programme live — begin tracking

---

*Tracker initialized: 2026-03-23*
*Next check: 2026-03-24 — confirm programme launch go/no-go with owner*
