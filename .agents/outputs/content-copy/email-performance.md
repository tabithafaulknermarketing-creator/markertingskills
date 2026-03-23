# Email Performance Tracker

**Product:** Marketing Skills (open-source) + Magister (magistermarketing.com)
**Maintained by:** Content & Copy Agent (updated daily/on data availability)
**Last updated:** 2026-03-23

---

## Overview

This file tracks the performance of all active email sequences. It serves two purposes:

1. **Sequence registry** — documents every active email sequence, its trigger, goal, and current status.
2. **Performance log** — records open rates, click rates, and conversion outcomes per email, flagging underperformers for rewrite.

**Rewrite thresholds (from INSTRUCTIONS.md):**
- Open rate below 25% → rewrite subject line and preview text
- Click rate below 3% → rewrite body CTA or body copy

---

## Sequence Registry

| Sequence | Status | Trigger | Goal | First deployed | Last updated |
|----------|--------|---------|------|---------------|--------------|
| Welcome — Marketing Skills / Magister | DRAFT | Signup at magistermarketing.com or download of any Marketing Skills asset | Activate free users → drive Magister trial signup | Not yet deployed | 2026-03-23 |

---

## Sequence 1: Welcome — Marketing Skills / Magister

### Sequence Metadata

```
Sequence Name:  Welcome — Marketing Skills / Magister
Trigger:        New signup at magistermarketing.com OR download of a Marketing Skills free asset (lead magnet)
Goal:           Drive trial activation of Magister within 14 days of signup
Audience:       Technical founders, indie hackers, small SaaS teams (no full-time marketing hire)
Length:         6 emails over 12 days
Timing:         See per-email delay below
Exit Conditions:
  - User activates Magister trial (move to onboarding sequence)
  - User unsubscribes
  - Day 14 passes with no activation (move to re-engagement sequence at Day 30)
Email platform: TBD (Customer.io recommended — see tools/integrations/customer-io.md)
Status:         DRAFT — not deployed. Review required before configuring in email tool.
```

---

### Email 1 — Welcome + First Win

```
Email:    1 of 6
Send:     Immediately on signup
Subject:  Your Marketing Skills toolkit is ready
Preview:  One command installs 40+ marketing skills into Claude Code. Here's where to start.
```

**Body:**

You just signed up. Let's make the first 10 minutes count.

Here's the fastest path to your first useful output:

**Step 1 — Install the skills (30 seconds)**
```bash
npx skills add coreyhaines31/marketingskills
```

That's it. Marketing Skills installs into your `.agents/skills/` directory and works immediately with Claude Code, Cursor, Windsurf, or any agent following the Agent Skills spec.

**Step 2 — Run your first skill**

Open your AI agent and try one of these:

- "Run a CRO audit on my homepage" → uses `page-cro`
- "Write a 6-email welcome sequence for [your product]" → uses `email-sequence`
- "Give me 10 SEO-optimised programmatic page ideas for [your product]" → uses `programmatic-seo`

Your agent now follows the same frameworks specialist marketers use — not generic AI output.

**What's coming in this sequence:**

Over the next 10 days, I'll share the three most useful things founders do with Marketing Skills in their first two weeks. Practical, specific, no padding.

[Install Marketing Skills →](https://github.com/coreyhaines31/marketingskills)

— Corey

```
CTA:              Install Marketing Skills → github.com/coreyhaines31/marketingskills
Word count target: ~180 words
Psychology hook:  Momentum (fast first win reduces activation friction)
```

---

### Email 2 — The System (Day 2)

```
Email:    2 of 6
Send:     Day 2 (48 hours after signup)
Subject:  Why your marketing keeps falling behind (and how to fix it systemically)
Preview:  It's not a discipline problem. It's a systems problem. Here's the framework.
```

**Body:**

Most technical founders treat marketing like a to-do list.

Write a blog post. Post on LinkedIn. "We should do email." Repeat until you run out of time, then drop it for three weeks.

That's not a discipline problem. It's a systems problem.

Marketing works when it runs as a system — the same way your CI/CD pipeline, your database migrations, your cron jobs work. Scheduled, consistent, observable.

Marketing Skills is designed around that idea. The full system has 7 agents running in sequence:

1. **Strategy Agent** — sets weekly positioning and psychology hooks
2. **SEO & Content Agent** — audits, keyword briefs, programmatic pages
3. **CRO + Content & Copy** — experiments, copy variants, email sequences (running in parallel)
4. **Paid & Measurement** — campaign review, creative, attribution
5. **Growth & Retention** — churn signals, referral, win-back
6. **Sales & GTM** — pipeline, collateral, launch

Each agent writes to a shared context. Nothing falls through the cracks.

**Magister** automates this entire loop — no manual runs required.

[See how Magister works →](https://magistermarketing.com)

— Corey

```
CTA:              See how Magister works → magistermarketing.com
Word count target: ~200 words
Psychology hook:  Reframe (positions the problem as structural, not personal — removes shame, opens door to solution)
```

---

### Email 3 — Social Proof + Specifics (Day 4)

```
Email:    3 of 6
Send:     Day 4 (96 hours after signup)
Subject:  What founders actually use Marketing Skills for (with examples)
Preview:  3 real use cases from technical founders running their own marketing.
```

**Body:**

I want to show you what this looks like in practice.

Three use cases I see most often from technical founders using Marketing Skills:

**1. Replacing the agency retainer**
A bootstrapped SaaS founder was paying £3,800/month for an SEO agency delivering monthly reports and blog posts. Switched to Marketing Skills + Magister. The SEO Agent runs weekly audits, programmatic page briefs, and schema fixes automatically. Total cost: Magister subscription.

**2. Getting copy that doesn't sound generic**
"I kept getting AI output that could apply to any SaaS." The `product-marketing-context` skill creates a shared context file that every other skill references — your product's positioning, ICP, brand voice, competitive landscape. Copy output starts to sound like you, not ChatGPT.

**3. Running a marketing loop without a marketing hire**
A two-person team (engineer + product) uses the full 7-agent orchestration on a weekly cadence. Monday through Friday, each agent runs its tasks and hands off to the next. The founders review outputs on Friday. Total human time: ~90 minutes per week.

None of these require you to be a marketer. They require you to be a builder who can read a markdown file.

[Try the full setup →](https://magistermarketing.com)

— Corey

```
CTA:              Try the full setup → magistermarketing.com
Word count target: ~250 words
Psychology hook:  Social Proof + In-Group Identity (specific peer use cases, not generic testimonials)
Assumption:       Use cases are representative/illustrative — replace with real named examples when available
```

---

### Email 4 — Objection Handler (Day 7)

```
Email:    4 of 6
Send:     Day 7 (one week after signup)
Subject:  "Can AI actually do real marketing work?"
Preview:  The honest answer, with specifics.
```

**Body:**

I hear this a lot. Fair question.

Generic AI output is bad at marketing because it lacks framework, context, and specificity. Ask ChatGPT to "write a landing page" and you get a template. That's not marketing — that's placeholder copy.

Marketing Skills works differently for three reasons:

**1. Framework-encoded skills**
Each skill encodes a specialist framework — not a prompt. The `page-cro` skill follows a 47-point conversion audit. The `programmatic-seo` skill runs the same playbook a $10k/month SEO agency uses for template-based page generation. The AI doesn't improvise — it executes a documented process.

**2. Product context memory**
Every skill reads your `product-marketing-context.md`. Your ICP, positioning, customer language, brand voice — all loaded before any task runs. Output is specific to your product, not generic SaaS copy.

**3. Human review gates**
Nothing publishes without your sign-off. Agents produce drafts. You approve. The system is designed for safe autonomy — enough to save you 10+ hours/week, not enough to go rogue.

Is it perfect? No. It doesn't replace judgment on positioning decisions or handle legally sensitive claims. But for the systematic, repeatable work — SEO audits, CRO hypotheses, email sequences, social posts — it's as good as a trained junior marketer, running every day, without burning out.

[See the skills library →](https://github.com/coreyhaines31/marketingskills)

— Corey

```
CTA:              See the skills library → github.com/coreyhaines31/marketingskills
Word count target: ~270 words
Psychology hook:  Objection handling (addresses the #1 credibility barrier directly and specifically)
```

---

### Email 5 — Feature Spotlight: Magister Autonomy (Day 10)

```
Email:    5 of 6
Send:     Day 10
Subject:  What happens when you let it run for a week
Preview:  Here's what the full autonomous loop looks like on day 7.
```

**Body:**

Here's what Magister's first week looks like on autopilot.

**Monday — Strategy Agent**
Refreshes your product marketing context, surfaces this week's psychology hook, and flags any positioning inconsistencies from last week's output.

**Tuesday — SEO & Content Agent**
Runs a full SEO audit, generates keyword briefs, produces a batch of programmatic page outlines, and checks schema markup across your site.

**Wednesday — CRO + Content & Copy (parallel)**
CRO Agent identifies conversion drop-off points, queues A/B experiments, and writes copy variant briefs. Content & Copy Agent writes the social post, runs copy edits, and maintains the email sequence.

**Thursday — Paid & Measurement, Growth & Retention, Sales & GTM (parallel)**
Campaigns reviewed. Churn signals checked. Pipeline reviewed. Cold email cadences updated.

**Friday — Strategy Agent**
Reads all seven agents' weekly outputs. Writes a cross-agent alignment memo. Flags strategic decisions that need your attention.

Total outputs produced in one week: 40+ files across SEO, CRO, copy, email, and GTM.

Total human time required: Review the Friday memo. Approve or adjust the 2-3 decisions that actually need you.

That's Magister.

[Start your Magister trial →](https://magistermarketing.com)

— Corey

```
CTA:              Start your Magister trial → magistermarketing.com
Word count target: ~230 words
Psychology hook:  Specificity + Visualisation (day-by-day breakdown makes the value concrete and imaginable)
```

---

### Email 6 — Conversion + Offer (Day 12)

```
Email:    6 of 6
Send:     Day 12
Subject:  Last note from me (for now)
Preview:  If you're still running marketing manually, here's the honest case for changing that.
```

**Body:**

I'll keep this short.

You signed up 12 days ago. If you haven't run a skill yet, I get it — you're shipping product, not reading my emails.

But here's the thing I want to leave you with:

The founders who get the most out of Marketing Skills aren't the ones who find extra time for marketing. They're the ones who stop treating marketing as something to do and start treating it as something to run.

A system running badly is still better than a system that doesn't run at all. And a system running on autopilot compounds faster than one you touch when you remember to.

If you want to see what that looks like for your product specifically — Magister has a free trial. No credit card required to start. You can connect your product context, run the first weekly cycle, and see what comes out.

If it's not useful, you'll know in 24 hours. If it is, you'll wonder why you waited.

[Start your free Magister trial →](https://magistermarketing.com)

Or if you want to explore the open-source toolkit first:
[Browse Marketing Skills on GitHub →](https://github.com/coreyhaines31/marketingskills)

— Corey

P.S. After this, I'll only email when there's something worth reading — a new skill batch, a case study, or something that changes how I think about marketing for technical founders.

```
CTA (primary):    Start your free Magister trial → magistermarketing.com
CTA (secondary):  Browse Marketing Skills on GitHub → github.com/coreyhaines31/marketingskills
Word count target: ~260 words
Psychology hook:  Loss aversion (light) + Identity close (system-runner vs. ad-hoc marketer)
```

---

## Performance Log

*No performance data yet. This is the first run — sequence not yet deployed.*

Once the sequence is live in an email platform, log performance data here after each send.

### Tracking Format

For each email in the active sequence, update the table below within 48 hours of send:

| Email # | Subject | Send Date | Recipients | Opens | Open Rate | Clicks | Click Rate | Conversions | Notes |
|---------|---------|-----------|-----------|-------|-----------|--------|------------|-------------|-------|
| 1 | Your Marketing Skills toolkit is ready | — | — | — | — | — | — | — | Not deployed |
| 2 | Why your marketing keeps falling behind... | — | — | — | — | — | — | — | Not deployed |
| 3 | What founders actually use Marketing Skills for... | — | — | — | — | — | — | — | Not deployed |
| 4 | "Can AI actually do real marketing work?" | — | — | — | — | — | — | — | Not deployed |
| 5 | What happens when you let it run for a week | — | — | — | — | — | — | — | Not deployed |
| 6 | Last note from me (for now) | — | — | — | — | — | — | — | Not deployed |

### Benchmark Reference

| Metric | Below threshold (flag for rewrite) | Target | Strong |
|--------|------------------------------------|--------|--------|
| Open rate | < 25% | 25–40% | > 40% |
| Click rate | < 3% | 3–8% | > 8% |
| Trial conversion (Email 5 + 6) | < 2% | 2–5% | > 5% |

### Rewrite Queue

*Empty — no data yet. Once performance data is available, emails falling below threshold are logged here with rewrite priority.*

| Priority | Email # | Metric | Actual | Threshold | Action | Date flagged |
|----------|---------|--------|--------|-----------|--------|--------------|
| — | — | — | — | — | — | — |

---

## Assumptions & Notes (2026-03-23 — First Run)

- **Email platform not yet selected.** Customer.io recommended for behavior-based automation (see `tools/integrations/customer-io.md`). Resend is an option if a developer-first setup is preferred.
- **Social proof in Email 3 is illustrative.** The three use cases are representative archetypes based on the ICP, not verified customer stories. Replace with attributed quotes or named case studies when available.
- **No subscriber list yet.** Sequence is fully drafted and ready to configure once an email platform is connected and a signup flow is live.
- **Sequence trigger assumes magistermarketing.com signup form.** If the primary acquisition point changes (e.g., GitHub star → email capture), the trigger should be updated.
- **Exit condition to re-engagement sequence** (Day 30 inactive) — re-engagement sequence not yet written. Flag for next weekly Content & Copy sprint.
