# Marketing Team Orchestrator

This file defines the run order, dependency graph, trigger sequences, parallelism rules, and DONE conditions for all 7 marketing AI agents.

---

## Agent Registry

| # | Agent | Folder | Skills |
|---|---|---|---|
| 1 | Strategy Agent | `strategy/` | `marketing-ideas`, `marketing-psychology`, `product-marketing-context` |
| 2 | SEO & Content Agent | `seo-content/` | `seo-audit`, `ai-seo`, `site-architecture`, `programmatic-seo`, `schema-markup` |
| 3 | CRO Agent | `cro/` | `page-cro`, `signup-flow-cro`, `onboarding-cro`, `form-cro`, `paywall-upgrade-cro`, `popup-cro` |
| 4 | Content & Copy Agent | `content-copy/` | `copywriting`, `copy-editing`, `content-strategy`, `email-sequence`, `cold-email`, `social-content` |
| 5 | Paid & Measurement Agent | `paid-measurement/` | `paid-ads`, `ad-creative`, `ab-test-setup`, `analytics-tracking` |
| 6 | Growth & Retention Agent | `growth-retention/` | `churn-prevention`, `free-tool-strategy`, `referral-program` |
| 7 | Sales & GTM Agent | `sales-gtm/` | `revops`, `sales-enablement`, `pricing-strategy`, `launch-strategy`, `competitor-alternatives`, `lead-magnets` |

---

## Dependency Graph

```
[Strategy Agent]
        │
        │ produces: product-marketing-context.md, psychology-hooks.md
        │
        ▼
[SEO & Content Agent]          ← depends on: Strategy
        │
        │ produces: keyword briefs, high-traffic page list
        │
        ├──────────────────────────────────────┐
        ▼                                      ▼
[CRO Agent]                     [Content & Copy Agent]
 depends on: Strategy, SEO        depends on: Strategy, SEO (keyword briefs)
        │                                      │
        │ produces: experiment briefs,          │ produces: copy variants,
        │ copy variant briefs                   │ cold email sequences, ad copy
        │                                      │
        └──────────┬───────────────────────────┘
                   │
                   ▼
      ┌────────────────────────────────────┐
      │                                    │
      ▼                                    ▼
[Paid & Measurement Agent]    [Growth & Retention Agent]
 depends on: Strategy,         depends on: Strategy, CRO,
 CRO, Content & Copy           Paid & Measurement (cohort data)
      │                                    │
      │ produces: experiment results,      │ produces: win-back briefs,
      │ CAC data, cohort analytics         │ churn data, referral reports
      │                                    │
      └──────────────┬─────────────────────┘
                     │
                     ▼
           [Sales & GTM Agent]
            depends on: Strategy,
            Content & Copy (cold email),
            Paid & Measurement (CAC/lead quality)
                     │
                     │ produces: GTM report,
                     │ collateral, launch briefs
                     │
                     ▼
           [Strategy Agent]
            (reads all weekly reports
             to produce weekly memo)
```

---

## Daily Trigger Sequence

Run each day (recommended: 06:00 local time).

### Wave 1 — Run first, no dependencies
| Agent | DONE condition |
|---|---|
| **Strategy Agent** | `/home/user/markertingskills/.agents/marketing-team/strategy/DONE.md` exists with today's date AND `/home/user/markertingskills/.agents/outputs/strategy/product-marketing-context.md` updated/verified |

### Wave 2 — Run after Wave 1 is complete
| Agent | DONE condition |
|---|---|
| **SEO & Content Agent** | `/home/user/markertingskills/.agents/marketing-team/seo-content/DONE.md` exists with today's date AND daily audit logged |

### Wave 3 — Run in PARALLEL after Wave 2 is complete
Both agents have no dependency on each other and can run simultaneously.

| Agent | DONE condition |
|---|---|
| **CRO Agent** | `/home/user/markertingskills/.agents/marketing-team/cro/DONE.md` exists with today's date AND experiment tracker updated |
| **Content & Copy Agent** | `/home/user/markertingskills/.agents/marketing-team/content-copy/DONE.md` exists with today's date AND daily social post written AND copy edits complete |

### Wave 4 — Run in PARALLEL after Wave 3 is complete
All three agents are independent of each other and can run simultaneously.

| Agent | DONE condition |
|---|---|
| **Paid & Measurement Agent** | `/home/user/markertingskills/.agents/marketing-team/paid-measurement/DONE.md` exists with today's date AND campaign review logged AND tracking health checked |
| **Growth & Retention Agent** | `/home/user/markertingskills/.agents/marketing-team/growth-retention/DONE.md` exists with today's date AND churn signals reviewed AND referral tracker updated |
| **Sales & GTM Agent** | `/home/user/markertingskills/.agents/marketing-team/sales-gtm/DONE.md` exists with today's date AND pipeline reviewed AND launch calendar checked |

### Daily Sequence Summary
```
Wave 1: [Strategy]
Wave 2: [SEO & Content]
Wave 3: [CRO] ║ [Content & Copy]          (parallel)
Wave 4: [Paid & Measurement] ║ [Growth & Retention] ║ [Sales & GTM]   (parallel)
```

**Total minimum waves: 4**
**Estimated wall-clock time (assuming each agent takes ~5 min):** ~20 minutes end-to-end

---

## Weekly Trigger Sequence

Run once per week (recommended: Monday, except where noted by agent).

| Day | Agent | Weekly task trigger |
|---|---|---|
| **Monday** | Strategy Agent | Full context refresh, psychology brief, ideas backlog, alignment memo |
| **Tuesday** | SEO & Content Agent | Full SEO audit, programmatic batch, AI SEO review, schema sweep |
| **Wednesday** | CRO Agent | Full funnel audit, experiment brief production |
| **Wednesday** | Content & Copy Agent | Editorial calendar, email sequence, cold email cadence, social batch, copy sprint |
| **Thursday** | Paid & Measurement Agent | Campaign review, creative batch, A/B test setup, analytics audit |
| **Thursday** | Growth & Retention Agent | Churn review, referral audit, retention cohort report, win-back brief |
| **Thursday** | Sales & GTM Agent | RevOps review, sales collateral sprint, competitor updates, lead magnet audit |
| **Friday** | Strategy Agent | Cross-agent weekly alignment memo + weekly strategy memo (reads all other agents' weekly reports) |

### Weekly Dependencies
- Strategy Agent runs **Monday** (sets context for the week) and **Friday** (reads all outputs, produces strategy memo)
- Tuesday/Wednesday/Thursday agents must each complete their weekly tasks before Friday's Strategy Agent memo runs
- Thursday agents (Paid & Measurement, Growth & Retention, Sales & GTM) run in parallel

```
Monday:    [Strategy — context refresh]
Tuesday:   [SEO & Content — full audit]
Wednesday: [CRO — funnel audit] ║ [Content & Copy — content sprint]   (parallel)
Thursday:  [Paid & Measurement] ║ [Growth & Retention] ║ [Sales & GTM]  (parallel)
Friday:    [Strategy — weekly alignment memo + strategy memo]
```

---

## DONE Conditions (per agent)

The orchestrator checks for a `DONE.md` file in each agent's folder with today's date before triggering the next wave.

| Agent | DONE file | Required contents |
|---|---|---|
| Strategy | `.agents/marketing-team/strategy/DONE.md` | Date, context updated Y/N, hooks surfaced |
| SEO & Content | `.agents/marketing-team/seo-content/DONE.md` | Date, pages audited, handoffs to CRO and Content agents |
| CRO | `.agents/marketing-team/cro/DONE.md` | Date, experiments monitored, briefs produced |
| Content & Copy | `.agents/marketing-team/content-copy/DONE.md` | Date, copy variants produced, cold email ready |
| Paid & Measurement | `.agents/marketing-team/paid-measurement/DONE.md` | Date, campaigns reviewed, tracking checked |
| Growth & Retention | `.agents/marketing-team/growth-retention/DONE.md` | Date, churn reviewed, referrals checked |
| Sales & GTM | `.agents/marketing-team/sales-gtm/DONE.md` | Date, pipeline reviewed, collateral status |

---

## Parallelism Rules

**Run sequentially (strict order):**
- Strategy → SEO & Content (SEO agent reads context file)
- SEO & Content → CRO (CRO agent reads high-traffic page list)

**Run in parallel (no dependency between them):**
- CRO + Content & Copy (Wave 3)
- Paid & Measurement + Growth & Retention + Sales & GTM (Wave 4)

**Special rule — Content & Copy and CRO interaction:**
Content & Copy Agent may begin before CRO Agent is DONE. It picks up any CRO copy variant briefs as they appear. It does not need to wait for the full CRO run to complete its own daily tasks.

---

## Escalation Handling

If any agent writes an `ESCALATION` block in its daily log:

1. The orchestrator halts all downstream agents that depend on that agent's output
2. A notification is written to `.agents/marketing-team/ESCALATIONS.md` with: agent name, date, escalation description, and blocked agents
3. Human review is required before the blocked agents restart
4. Agents with no dependency on the escalating agent continue running normally

---

## Global Rules for All Agents

**Project root:** `/home/user/markertingskills` — always use absolute paths. Relative paths will fail in scheduled/automated sessions where the working directory may differ.

1. Every agent reads `/home/user/markertingskills/.agents/outputs/strategy/product-marketing-context.md` before starting any task
2. No agent contacts external parties (customers, prospects, press) autonomously — all outbound assets are drafted and saved, not sent
3. No agent commits spend, changes live campaigns, or publishes to production without a human-approved deploy step — outputs are drafts and recommendations unless a deployment pipeline is explicitly configured
4. All outputs are saved to `/home/user/markertingskills/.agents/outputs/[agent-name]/` with date-stamped filenames
5. All DONE.md files are written to `/home/user/markertingskills/.agents/marketing-team/[agent-folder]/DONE.md`
6. All escalations are written to `/home/user/markertingskills/.agents/marketing-team/ESCALATIONS.md`
7. Agents do not ask the human for input during normal operation — they make best-effort decisions and log assumptions
