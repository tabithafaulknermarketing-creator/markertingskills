# Marketing Team Runbook

How to operate your 7-agent autonomous marketing team.

---

## Overview

Your marketing team consists of 7 AI agents, each with a dedicated instruction file and output directory. The team is orchestrated by `.agents/marketing-team/ORCHESTRATOR.md`. All agents read from a shared product context file before running any task.

```
.agents/
├── marketing-team/
│   ├── ORCHESTRATOR.md          ← run order, dependencies, parallelism rules
│   ├── ESCALATIONS.md           ← human attention required (auto-written by agents)
│   ├── strategy/INSTRUCTIONS.md
│   ├── seo-content/INSTRUCTIONS.md
│   ├── cro/INSTRUCTIONS.md
│   ├── content-copy/INSTRUCTIONS.md
│   ├── paid-measurement/INSTRUCTIONS.md
│   ├── growth-retention/INSTRUCTIONS.md
│   └── sales-gtm/INSTRUCTIONS.md
├── outputs/
│   ├── strategy/
│   ├── seo-content/
│   ├── cro/
│   ├── content-copy/
│   ├── paid-measurement/
│   ├── growth-retention/
│   └── sales-gtm/
└── skills/                      ← installed skill SKILL.md files
```

---

## 1. Trigger the Full Team (Daily Run)

To run the complete daily sequence for all 7 agents:

```
Run the full marketing team daily sequence defined in:
.agents/marketing-team/ORCHESTRATOR.md

Follow the wave order:
  Wave 1: Strategy Agent
  Wave 2: SEO & Content Agent
  Wave 3: CRO Agent + Content & Copy Agent (parallel)
  Wave 4: Paid & Measurement + Growth & Retention + Sales & GTM (parallel)

Each agent reads its INSTRUCTIONS.md from .agents/marketing-team/[agent-folder]/
Each agent reads context from .agents/outputs/strategy/product-marketing-context.md
Each agent saves outputs to .agents/outputs/[agent-name]/
Each agent writes a DONE.md to .agents/marketing-team/[agent-folder]/DONE.md when complete
Do not advance to the next wave until all agents in the current wave are DONE
```

---

## 2. Trigger the Full Team (Weekly Run)

To run the weekly task sequence (run on Monday, or any day to catch up):

```
Run the full marketing team weekly sequence defined in:
.agents/marketing-team/ORCHESTRATOR.md

Follow the weekly schedule:
  Monday:    Strategy Agent — full context refresh + weekly planning
  Tuesday:   SEO & Content Agent — full audit + programmatic batch
  Wednesday: CRO Agent + Content & Copy Agent (parallel) — funnel audit + content sprint
  Thursday:  Paid & Measurement + Growth & Retention + Sales & GTM (parallel) — all weekly reviews
  Friday:    Strategy Agent — cross-agent alignment memo + weekly strategy memo

Each agent executes its Weekly Tasks section from its INSTRUCTIONS.md
Outputs saved to .agents/outputs/[agent-name]/ with overwrite (weekly files) or append (logs)
```

---

## 3. Trigger a Single Agent in Isolation

To run one specific agent without triggering the full team:

```
Run the [AGENT NAME] agent in isolation.

Read its instructions from:
  .agents/marketing-team/[agent-folder]/INSTRUCTIONS.md

Pre-flight: read .agents/outputs/strategy/product-marketing-context.md first.

Run: [daily tasks only] OR [weekly tasks only] OR [both]

Save all outputs to .agents/outputs/[agent-name]/
Write DONE.md to .agents/marketing-team/[agent-folder]/DONE.md when complete
```

**Examples:**

```
# Run only the CRO Agent daily tasks
Run the CRO Agent daily tasks from .agents/marketing-team/cro/INSTRUCTIONS.md

# Run only the Content & Copy Agent weekly tasks
Run the Content & Copy Agent weekly tasks from .agents/marketing-team/content-copy/INSTRUCTIONS.md

# Run only the Strategy Agent to refresh context
Run the Strategy Agent product-marketing-context refresh from .agents/marketing-team/strategy/INSTRUCTIONS.md
```

---

## 4. Review Outputs

### View a specific agent's latest output
All outputs are saved as Markdown files in `.agents/outputs/[agent-name]/`.

| What you want to see | File to read |
|---|---|
| What strategy decisions were made | `.agents/outputs/strategy/weekly-strategy-memo.md` |
| This week's SEO health | `.agents/outputs/seo-content/weekly-seo-report.md` |
| Funnel conversion performance | `.agents/outputs/cro/weekly-cro-report.md` |
| Content scheduled this week | `.agents/outputs/content-copy/editorial-calendar.md` |
| Paid campaign performance | `.agents/outputs/paid-measurement/weekly-paid-report.md` |
| Churn and retention health | `.agents/outputs/growth-retention/retention-cohort-report.md` |
| Pipeline and GTM status | `.agents/outputs/sales-gtm/weekly-gtm-report.md` |
| Any escalations requiring attention | `.agents/marketing-team/ESCALATIONS.md` |

### View all agents' daily logs (quick scan)
```bash
# View today's activity across all agents
cat .agents/outputs/strategy/daily-log.md
cat .agents/outputs/seo-content/daily-log.md
cat .agents/outputs/cro/daily-log.md
cat .agents/outputs/content-copy/daily-log.md
cat .agents/outputs/paid-measurement/daily-log.md
cat .agents/outputs/growth-retention/daily-log.md
cat .agents/outputs/sales-gtm/daily-log.md
```

### Check for escalations that need your attention
```bash
cat .agents/marketing-team/ESCALATIONS.md
```

Escalations are written automatically when an agent encounters a blocker or a decision requiring budget approval. Only escalations require your input — everything else runs autonomously.

---

## 5. Update the Product Marketing Context

The product marketing context file is the shared source of truth read by all 7 agents before every task. Keeping it current is the single highest-leverage thing you can do as the human operator.

**File location:** `.agents/outputs/strategy/product-marketing-context.md`

### Option A — Let the Strategy Agent update it
```
Run the Strategy Agent product-marketing-context refresh task from:
.agents/marketing-team/strategy/INSTRUCTIONS.md

Use the product-marketing-context skill to update the context document.
Save updated file to .agents/outputs/strategy/product-marketing-context.md
```

### Option B — Edit it directly
Open `.agents/outputs/strategy/product-marketing-context.md` in any text editor and update the relevant section. The file uses standard Markdown with these sections:

```markdown
## Product Description
## Target Audience / ICP
## Positioning Statement
## Key Differentiators
## Messaging Hierarchy
## Tone of Voice
## Competitor Landscape
## Pricing & Plans
## Active Campaigns
## Channel Priorities
```

After editing, all agents will automatically pick up the new version on their next run — no other action required.

### What triggers a context update?
Update the context file whenever:
- Your ICP, positioning, or messaging changes
- A new product tier, feature, or pricing change is released
- A significant competitor move changes the landscape
- You enter a new market or vertical
- A campaign objective changes

---

## 6. Add a New Skill to an Agent

1. Install the skill to `.agents/skills/` (copy from `skills/` directory or install via plugin)
2. Open the relevant agent's `INSTRUCTIONS.md` in `.agents/marketing-team/[agent]/`
3. Add the skill name to the **Agent Identity > Skills** line
4. Add the corresponding daily or weekly task that uses the skill
5. Add the output file to the **Output Format & Save Locations** table

---

## 7. Reset an Agent's DONE Status

If you need to re-run an agent that has already written its DONE.md today:

```bash
# Delete the DONE flag to allow re-run
rm .agents/marketing-team/[agent-folder]/DONE.md
```

Then trigger the agent again using the single-agent command in Section 3.

---

## 8. Common Scenarios

### "I just updated our pricing — make sure all agents know"
1. Update `.agents/outputs/strategy/product-marketing-context.md` (Pricing & Plans section)
2. Run: `Strategy Agent daily tasks` to propagate the psychology hook and flag any inconsistencies
3. All other agents will pick up the new pricing on their next run

### "I want to launch a new feature next month"
1. Run: `Sales & GTM Agent — launch-strategy task`
2. It will create a launch brief in `.agents/outputs/sales-gtm/launch-briefs/`
3. The brief will cascade to Content & Copy (copy), SEO (page), CRO (landing page), and Paid (campaign)

### "We're seeing high churn this month"
1. Run: `Growth & Retention Agent — weekly churn review`
2. Check `.agents/outputs/growth-retention/weekly-churn-review.md` for root cause analysis
3. The agent will brief the Content & Copy Agent on win-back emails and the CRO Agent on cancel flow improvements automatically

### "I want to check if any agents need my attention"
```bash
cat .agents/marketing-team/ESCALATIONS.md
```
If the file is empty or has no entries from today, everything is running autonomously. No action needed.

---

## Escalation Protocol

Agents only surface to you when:
1. A **blocker** is encountered that requires access, information, or a decision the agent cannot make
2. A **budget decision** is required (spend increase, new channel, pricing change, tool purchase)

All escalations are written to `.agents/marketing-team/ESCALATIONS.md` with the agent name, date, description, and which downstream agents are blocked.

You do not need to monitor daily logs — only the ESCALATIONS file requires regular human review.
