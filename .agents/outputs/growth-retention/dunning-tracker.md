# Dunning Tracker — Magister

**Last updated:** 2026-03-23
**Status:** Initialized — no active campaigns (first run)
**Billing provider:** Stripe (assumed — confirm with owner)
**Grace period:** 14 days from first payment failure to hard cancel (recommended)
**Manual review threshold:** £100 MRR/subscriber past final dunning step

---

## Active Dunning Campaigns

| Subscriber | Plan | Failure Date | Failure Type | Current Step | Next Action | Due Date | MRR at Risk |
|------------|------|-------------|--------------|-------------|-------------|----------|-------------|
| — | — | — | — | — | — | — | — |

*No active dunning campaigns. Tracker will be populated when first payment failures occur.*

---

## Dunning Sequence — Magister (Ready to Deploy)

### Overview

Three-email dunning sequence triggered on payment failure. Tone is technical and direct — matching the founder/builder ICP. No guilt-tripping. Clear, frictionless path to update payment.

Stripe Smart Retries handles automated payment retries in parallel with this email sequence. The sequence does not replace retries — it runs alongside them.

**Total sequence window:** 10 days from failure to final warning. Hard cancel on Day 14 if no resolution.

---

### Pre-Dunning: Card Expiry Prevention

Before dunning is ever needed, suppress failures proactively:

| Trigger | Email | Timing |
|---------|-------|--------|
| Card expiring in 30 days | "Heads up — your card expires soon" | 30 days before expiry |
| Card expiring in 7 days | "Your card expires in 7 days — update before your next billing date" | 7 days before expiry |
| Annual renewal in 7 days | "Your Magister subscription renews in 7 days — here's what's scheduled" | 7 days before renewal |

These emails are plain text, sent from a personal-seeming sender name (e.g., "Corey at Magister"), and contain a direct link to the payment update page — no login required.

---

### Step 1 — Payment Failure Alert (Day 0)

**Trigger:** Stripe `invoice.payment_failed` webhook
**Timing:** Send immediately on failure (within 1 hour)
**Tone:** Friendly, factual, no alarm
**Channel:** Email (plain text)

**Subject line:** `Your Magister payment didn't go through`

**Body:**
```
Hey [First Name],

Heads up — your payment for Magister [Plan] didn't process today.

This happens. Card details change, banks flag things. Your access is fine for now.

Update your payment details here:
→ [Direct link to payment update page — no login required]

Takes 30 seconds.

If you're having trouble or have questions, just reply to this email.

— Corey
```

**Operational notes:**
- Link must be a direct Stripe Customer Portal URL or equivalent — no login friction
- Track click-through on payment update link (`dunning_step1_link_click`)
- If payment succeeds after Step 1, suppress remaining sequence immediately

---

### Step 2 — Payment Reminder (Day 3)

**Trigger:** 3 days after initial failure, payment still unresolved
**Timing:** Day 3 at 10am subscriber's timezone (or 10am UTC as fallback)
**Tone:** Helpful reminder, mild urgency
**Channel:** Email (plain text)

**Subject line:** `Quick reminder: update your Magister payment`

**Body:**
```
Hey [First Name],

Still seeing an open payment for your Magister subscription.

Your access is still active — but it won't be if this isn't sorted in the next few days.

Update here:
→ [Direct link to payment update page]

If the card you used has been replaced or you want to switch to a different payment method, the link above handles that too.

Let me know if anything's stuck.

— Corey
```

**Operational notes:**
- Restate what they have access to (makes the loss more concrete)
- If Stripe Smart Retry has already recovered by this point, suppress this email
- Track `dunning_step2_opened`, `dunning_step2_link_click`

---

### Step 3 — Final Warning with Save Offer (Day 7)

**Trigger:** 7 days after initial failure, payment still unresolved
**Timing:** Day 7 at 10am subscriber's timezone
**Tone:** Urgent but not threatening. Include a save offer to reduce final cancellation.
**Channel:** Email (plain text) + in-app banner if product is accessible

**Subject line:** `Your Magister account will be paused in 3 days`

**Body:**
```
Hey [First Name],

Your Magister subscription has been unpaid for 7 days. Unless the payment is updated, your account will be paused on [Date — Day 10].

When paused:
- Your agent workflows stop running
- Your marketing outputs are no longer generated
- Your product context and configurations are saved for 30 days

Update your payment to keep everything running:
→ [Direct link to payment update page]

---

Running into cash flow issues? We can help.

If timing is the issue, reply to this email and we can pause your subscription for 30 days — no charge, no cancel, and you can resume when ready.

— Corey
```

**Operational notes:**
- The pause offer is the save offer at this stage — reduces hard cancel rate by giving a graceful exit that preserves the customer relationship
- "Pause for 30 days" offer is available to all affected subscribers at Step 3 — no MRR threshold required
- Track `dunning_step3_opened`, `dunning_step3_link_click`, `dunning_step3_pause_request`
- If subscriber replies requesting a pause, process manually within 24 hours

---

### Post-Sequence: Hard Cancel (Day 14)

**Trigger:** 14 days after initial failure, payment still unresolved, no pause requested
**Action:** Stripe subscription cancelled via billing system
**Concurrent:** Win-back sequence initiated (separate from dunning — see email-sequence skill)

**Hard cancel email:**

**Subject line:** `Your Magister subscription has ended`

**Body:**
```
Hey [First Name],

Your Magister subscription has ended because the payment issue wasn't resolved.

Your data and configurations are saved for 30 days. When you're ready to restart, you can reactivate from:
→ [Reactivation link]

If you ran into a problem we could have helped with, I'd genuinely like to know. Just reply.

— Corey
```

**Operational notes:**
- Reactivation link should restore previous config, not require a full re-onboarding
- Tag subscriber as `involuntary_churn` in CRM and analytics for win-back segmentation
- Do not add to general marketing list — place in 14-day suppression window before win-back sequence starts

---

## Retry Schedule (Stripe Smart Retries + Manual Reference)

| Day | Action |
|-----|--------|
| Day 0 | Payment fails. Smart Retry attempt 1 queued. Dunning Step 1 email sent. |
| Day 1 | Smart Retry attempt 2. |
| Day 3 | Smart Retry attempt 3. Dunning Step 2 email sent (if still unresolved). |
| Day 5 | Smart Retry attempt 4. |
| Day 7 | Smart Retry final attempt. Dunning Step 3 email sent. |
| Day 10 | Account flagged for pause. In-app warning shown. |
| Day 14 | Hard cancel. Win-back sequence initiated. |

---

## Recovery Metrics to Track (Populate When Live)

| Metric | Target | Current |
|--------|--------|---------|
| Overall payment recovery rate | >50% | — |
| Step 1 recovery (before Step 2) | >25% | — |
| Step 2 recovery (before Step 3) | >15% | — |
| Pause offer acceptance rate (Step 3) | >20% | — |
| Hard cancel rate (of all failures) | <30% | — |
| Win-back rate (post hard cancel, 90 days) | >15% | — |

---

## Escalation Rules

Escalate to manual review (flag in daily-log.md) if:
- Any single subscriber has MRR ≥ £100 and reaches Step 3 without resolving
- More than 3 subscribers in active dunning at the same time (potential billing provider issue)
- Recovery rate falls below 30% in any given week

---

*Tracker initialized: 2026-03-23*
*First campaign entries will appear when Stripe billing is activated for Magister subscriptions*
