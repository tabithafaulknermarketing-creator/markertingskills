# Product Marketing Context

*Last updated: 2026-03-23*
*Generated: 2026-03-23 — first-run auto-draft from repository contents*

---

## Product Overview

**One-liner:** Marketing Skills is an open-source collection of AI agent skills that gives technical founders and indie marketers a full-stack marketing team in their codebase.

**What it does:** Marketing Skills provides 30+ markdown-based skills that AI coding agents (Claude Code, Cursor, Windsurf, Copilot, etc.) use to perform specialist marketing work — CRO audits, SEO analysis, copy generation, email sequences, paid ad strategy, and growth engineering. Skills install directly to `.agents/skills/` and work with any agent following the Agent Skills spec. The companion product, Magister, deploys a fully autonomous AI CMO that runs these skills on a daily/weekly schedule without human input.

**Product category:** AI agent skills marketplace / autonomous marketing tooling

**Product type:** Open-source skills library (free) + SaaS CMO agent (Magister, paid)

**Business model:**
- Marketing Skills repo: Free / open-source (MIT). Drives awareness, installs, and community.
- Magister (magistermarketing.com): Autonomous AI CMO SaaS — recurring subscription. Primary revenue vehicle.
- Conversion Factory (conversionfactory.co): Done-for-you CRO agency — project/retainer fees.
- Swipe Files (swipefiles.com): Marketing newsletter/community — subscription.

---

## Target Audience

**Target companies:** Early-stage SaaS startups (pre-seed to Series A), indie SaaS products, bootstrapped tools, and small B2B software companies with no dedicated marketing hire.

**Decision-makers:** Technical founders (CEO/CTO who writes code), solo operators, indie hackers, and small product teams where the founder also owns marketing.

**Primary use case:** Replace or augment a missing marketing function — get specialist marketing output (SEO, copy, CRO, paid ads, email) without hiring a full-time marketer or agency.

**Jobs to be done:**
- "I need marketing done but I can't afford a full-time CMO yet"
- "I want my AI coding agent to help with marketing, not just code"
- "I need consistent, high-quality marketing outputs on autopilot"

**Use cases:**
- Technical founder using Claude Code or Cursor daily wants the agent to also handle marketing tasks
- Bootstrapper running SEO, email sequences, and paid ads solo — needs expert-level frameworks
- Small team deploying an autonomous agent to run the marketing loop daily without manual effort

---

## Personas

| Persona | Cares about | Challenge | Value we promise |
|---------|-------------|-----------|------------------|
| Technical Founder | Shipping product, growing MRR, not burning runway | No marketing expertise; too expensive to hire; generic AI output feels amateur | Expert-level marketing output from the AI agent they already use |
| Indie Hacker / Bootstrapper | Leverage, speed, low overhead | Doing everything solo; marketing falls through the cracks | Full marketing team output from a single tool |
| Small Marketing Team (1-2 people) | Scaling output, proving ROI | Not enough bandwidth for all channels; repeating the same tasks | Autonomous agent handles repetitive daily/weekly tasks so humans do strategic work |

---

## Problems & Pain Points

**Core problem:** SaaS founders know they need consistent marketing but lack the time, expertise, or budget to do it well. Generic AI output is surface-level; hiring specialists is expensive.

**Why alternatives fall short:**
- Generic ChatGPT/Claude prompts: No marketing framework, no product context, shallow output
- Hiring a marketing agency: Expensive (£3k–£15k/month), slow, misaligned incentives
- Hiring in-house CMO: Only viable post-Series A; expensive; overkill for early-stage
- DIY with frameworks/books: Time-intensive; hard to maintain consistency; knowledge gaps

**What it costs them:**
- Time: Founders spend 5–15 hours/week on ad hoc marketing with poor results
- Money: Wasted spend on agencies/freelancers who don't understand technical products
- Opportunity: Slow growth while competitors with marketing resources compound faster

**Emotional tension:** "I know marketing matters but I feel out of my depth. I'm not a marketer. Every time I try, it feels generic and I can't tell if it's working."

---

## Competitive Landscape

**Direct competitors:**
- **Jasper / Copy.ai** — AI copywriting tools, not full-stack marketing agents; no CRO/SEO/analytics; no autonomous daily loop
- **HubSpot AI features** — requires HubSpot CRM; expensive; not designed for AI agent workflows
- **Custom GPT agents** — no specialist framework depth; no cross-agent memory; one-off, not systematic

**Secondary competitors:**
- **Marketing agencies** (Conversion Factory competes here) — high cost, human-dependent, not scalable
- **Fractional CMO services** — expensive ($5–15k/month); still requires human availability; not autonomous

**Indirect competitors:**
- **Marketing templates/playbooks** (Swipe Files competes here) — passive knowledge, requires human execution
- **Notion/Coda marketing wikis** — documentation, not execution

---

## Differentiation

**Key differentiators:**
- **Agent-native architecture**: Skills are markdown files that plug directly into existing AI coding agents — no new tool to learn
- **Full-stack coverage**: 30+ skills spanning every marketing function (SEO, CRO, copy, paid, retention, GTM)
- **Product context memory**: All skills read a shared `product-marketing-context.md` — no repeating yourself across tasks
- **Autonomous daily/weekly loop**: Orchestrated multi-agent system (Magister) that runs without prompting
- **Open-source foundation**: Free to inspect, fork, and extend; community-contributed improvements

**How we do it differently:** Skills encode specialist marketing frameworks directly into the agent's workflow. The agent doesn't just "know about" marketing — it follows structured, battle-tested processes for each specific task.

**Why that's better:** Consistent, expert-level output on every task. The agent behaves like a trained specialist, not a generalist giving surface-level advice.

**Why customers choose us:** "I use Claude Code every day to ship code — now it does my marketing too, and it's actually good."

---

## Objections

| Objection | Response |
|-----------|----------|
| "I'm not sure AI can do real marketing work" | Skills encode the same frameworks used by expert marketers (JTBD, AIDA, Page CRO checklists, etc.) — output quality reflects the framework quality, not generic AI reasoning |
| "It's too complicated to set up" | `npx skills add coreyhaines31/marketingskills` — one command installs all skills; works in the agent you already use |
| "I don't have an active marketing setup to run this against" | The Strategy Agent creates your product context from scratch in the first run; other agents operate on drafts/recommendations — nothing goes live without human approval |

**Anti-persona:** Enterprise marketing teams with dedicated specialists; companies that need regulatory review of all content; products requiring legally sensitive claims.

---

## Switching Dynamics

**Push (away from current):**
- Tired of writing the same mediocre marketing copy repeatedly
- Paying an agency and getting generic deliverables that don't understand the product
- Watching competitors grow while marketing keeps getting deprioritised

**Pull (toward us):**
- "My AI agent already does my code reviews — I want it to do marketing too"
- Seeing a demo where Claude runs a full CRO audit and writes 5 A/B test hypotheses in under a minute
- Open-source credibility: can read every framework, modify skills, trust the output

**Habit (keeping them stuck):**
- Already paying for a tool (Jasper, HubSpot)
- Marketing is "good enough" and not a top priority right now
- Don't trust AI for creative/strategic work

**Anxiety (about switching):**
- "What if the AI makes a mistake and publishes something wrong?" (addressed: drafts only, human review required)
- "Will this work with my specific agent/IDE?" (addressed: supports Claude Code, Cursor, Windsurf, etc.)

---

## Customer Language

**How they describe the problem:**
- "I keep putting marketing on the back burner"
- "I wrote some copy but it feels generic"
- "I don't know if my SEO is even working"
- "I can't afford a real CMO yet"

**How they describe the solution:**
- "It's like having a marketing co-founder who knows the code"
- "My agent now does a CRO audit every week without me asking"
- "I actually have a positioning document now"

**Words to use:** autonomous, systematic, expert-level, agent-native, founders, technical, SaaS, framework, ships, leverage, compound

**Words to avoid:** "magic", "AI-powered" (overused), "enterprise", "synergy", "holistic", "revolutionary"

**Glossary:**
| Term | Meaning |
|------|---------|
| Skills | Markdown files encoding specialist marketing workflows for AI agents |
| Agent Skills spec | Cross-agent standard for `.agents/skills/` directory |
| Magister | The autonomous AI CMO SaaS product built on Marketing Skills |
| Product Marketing Context | The shared context document all skills reference |
| Orchestrator | The multi-agent coordination system (ORCHESTRATOR.md) |

---

## Brand Voice

**Tone:** Direct, technical, pragmatic. No fluff. Written for people who ship code and value clarity over hype.

**Style:** Conversational but substantive. Shows the work. Leans on specificity ("30+ skills", "one command installs"). Talks to founders as peers.

**Personality:** Builder, craftsperson, no-BS, systematiser, multiplier

---

## Proof Points

**Metrics:** 30+ marketing skills across 9 categories; covers 7 specialist marketing functions; full autonomous daily + weekly loop

**Customers/community:** Technical founders, indie hackers, Claude Code and Cursor users

**Testimonials:** (To be captured from community)
> "[placeholder]" — Founder using Marketing Skills

**Value themes:**
| Theme | Proof |
|-------|-------|
| Comprehensive coverage | 30+ skills across SEO, CRO, copy, paid, retention, GTM |
| Zero new tools | Installs into the coding agent you already use |
| Expert frameworks | Each skill encodes specialist best practices (JTBD, Page CRO, programmatic SEO) |
| Safe autonomy | All outputs are drafts — nothing publishes without human approval |

---

## Goals

**Business goal:** Drive installs of Marketing Skills repo (top-of-funnel) → convert to Magister subscribers (revenue) and Conversion Factory clients (high-ticket).

**Conversion action:** Install Marketing Skills (`npx skills add coreyhaines31/marketingskills`) → Sign up for Magister trial.

**Current metrics:** (To be populated — repo installs, Magister trial signups, MRR)

---

*Assumptions logged: This context was auto-drafted from the repository README, CLAUDE.md, and ORCHESTRATOR.md on 2026-03-23. No live product metrics were available. Sections marked "(To be populated)" require human input. All competitive analysis is based on publicly available information.*
