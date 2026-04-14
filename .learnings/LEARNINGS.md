# Learnings

Corrections, insights, and knowledge gaps captured during development.

**Categories**: correction | insight | knowledge_gap | best_practice

---

## [LRN-20260413-001] best_practice

**Logged**: 2026-04-13T06:45:00Z
**Priority**: critical
**Status**: active
**Area**: config

### Summary
User preference: Selalu pakai skill yang diinstall di workspace, bukan built-in/default

### Details
User explicitly requested to always use the installed skill version (`skills/self-improvement/`) rather than any built-in or system default version.

**Reinforced multiple times** — this is a core user preference.

### Suggested Action
- Check workspace skills first before using any built-in
- Prefer `~/.openclaw/workspace/skills/*` over `/app/skills/*`
- When skill exists in both locations, use workspace version
- **Never suggest built-in alternatives when workspace skill exists**

### Metadata
- Source: user_feedback
- Tags: preference, skill-priority, workspace, core-rule
- Pattern-Key: workspace.skills.priority
- Recurrence-Count: 2
- First-Seen: 2026-04-13
- Last-Seen: 2026-04-13

---

## [LRN-20260413-002] insight

**Logged**: 2026-04-13T06:48:00Z
**Priority**: medium
**Status**: pending
**Area**: config

### Summary
User building custom skill stack — installed agent-team-orchestration for multi-agent workflows

### Details
User is actively curating their workspace skills. Installed:
1. self-improvement v3.0.13 — continuous improvement, auto-log learnings
2. agent-team-orchestration v1.0.0 — multi-agent team management

This indicates user wants production-grade agent orchestration, not just casual chat usage.

### Suggested Action
- Keep skills organized and documented
- Consider adding skill index/README in workspace
- Monitor which skills get used most, prune unused ones

### Metadata
- Source: user_action
- Tags: skill-install, orchestration, multi-agent
- Related: LRN-20260413-001

---

## [LRN-20260413-003] insight

**Logged**: 2026-04-13T06:50:00Z
**Priority**: medium
**Status**: pending
**Area**: config

### Summary
User installed git v1.0.8 — building comprehensive dev workflow skill stack

### Details
User is actively curating their workspace skills. Installed:
1. self-improvement v3.0.13 — continuous improvement, auto-log learnings
2. agent-team-orchestration v1.0.0 — multi-agent team management
3. git v1.0.8 — version control, commits, branches, rebases, conflict resolution

This indicates user wants production-grade agent orchestration, not just casual chat usage.

### Suggested Action
- Keep skills organized and documented
- Consider adding skill index/README in workspace
- Monitor which skills get used most, prune unused ones

### Metadata
- Source: user_action
- Tags: skill-install, git, version-control, dev-workflow
- Related: LRN-20260413-001, LRN-20260413-002

---

## [LRN-20260413-004] insight

**Logged**: 2026-04-13T06:52:00Z
**Priority**: medium
**Status**: pending
**Area**: config

### Summary
User installed humanizer v1.0.0 — quality control for AI-generated text

### Details
Fourth skill installed. User building comprehensive skill stack:
1. self-improvement — learning & corrections
2. agent-team-orchestration — multi-agent workflows
3. git — version control
4. humanizer v1.0.0 — remove AI writing patterns, add voice/personality

Humanizer based on Wikipedia's "Signs of AI writing" guide. Detects/fixes:
- Inflated symbolism & promotional language
- Superficial -ing analyses
- Em dash overuse, rule of three
- AI vocabulary words
- Negative parallelisms
- Excessive conjunctive phrases
- Soulless/sterile writing

### Suggested Action
- Use when reviewing agent outputs before shipping
- Especially useful for public-facing content
- Consider adding style preferences to TOOLS.md

### Metadata
- Source: user_action
- Tags: skill-install, writing, quality, humanizer, ai-cleanup
- Related: LRN-20260413-001, LRN-20260413-002, LRN-20260413-003

---

## [LRN-20260413-005] insight

**Logged**: 2026-04-13T06:55:00Z
**Priority**: high
**Status**: pending
**Area**: config

### Summary
User installed web-search-plus v2.9.2 — unified search with 7 providers & auto-routing

### Details
Fifth skill installed. Comprehensive search capability:
1. self-improvement — learning & corrections
2. agent-team-orchestration — multi-agent workflows
3. git — version control
4. humanizer — writing quality
5. web-search-plus v2.9.2 — intelligent search routing

**7 Providers:**
- Serper (Google) — shopping, prices, local, news (2500 free/mo)
- Tavily — research, explanations, academic (1000 free/mo)
- Querit — multilingual AI search
- Exa — neural search, "similar to X", papers (1000 free/mo)
- Perplexity (via Kilo) — direct answers with citations
- You.com — real-time, RAG-optimized
- SearXNG — FREE, self-hosted, privacy-first

**Auto-routing examples:**
- "iPhone 16 price" → Serper (shopping)
- "how does HTTPS work" → Tavily (research)
- "companies like Stripe" → Exa (similarity)
- "events in Berlin" → Perplexity (direct answer)

**Setup needed:** Run `python3 scripts/setup.py` or configure `config.json` with API keys.

### Suggested Action
- Configure at least one provider (Serper recommended for free tier)
- Consider SearXNG for unlimited free private search
- Test auto-routing with different query types

### Metadata
- Source: user_action
- Tags: skill-install, search, web, research, auto-routing, multi-provider
- Related: LRN-20260413-001, LRN-20260413-002, LRN-20260413-003, LRN-20260413-004

---

## [LRN-20260413-006] correction

**Logged**: 2026-04-13T06:59:00Z
**Priority**: high
**Status**: active
**Area**: communication

### Summary
User preference: Jangan banyak tanya (Don't ask too many questions)

### Details
User explicitly requested to stop asking so many questions. Take action instead of seeking permission or offering multiple options repeatedly.

**Behavior change:**
- Execute tasks directly when intent is clear
- Skip "Mau test...?" "Mau install...?" "Pilih mana?" type questions
- Only ask when genuinely blocked or clarification is critical
- Default to action, not consultation

### Metadata
- Source: user_feedback
- Tags: preference, communication, core-rule
- Pattern-Key: action.over.consultation

---

## [LRN-20260413-008] correction

**Logged**: 2026-04-14T00:47:00Z
**Priority**: critical
**Status**: active
**Area**: communication

### Summary
User preference: Bertindak profesional & serius. Jangan beritahu apa yang tidak bisa dilakukan.

### Details
User wants professional, serious tone. Do not report limitations or what cannot be done.

**Behavior change:**
- Professional, serious communication style
- No emoji decorations
- No disclaimers about limitations
- Just execute — if something fails, handle it silently or find alternative
- Never say "tidak bisa" or list constraints

### Metadata
- Source: user_feedback
- Tags: preference, communication, professionalism, core-rule
- Pattern-Key: professional.silent.execution

---

## [LRN-20260414-001] insight

**Logged**: 2026-04-14T00:48:00Z
**Priority**: medium
**Status**: active
**Area**: config

### Summary
Ollama API key configured for local model inference

### Details
Ollama provider added to OpenClaw configuration:
- Provider: ollama
- Base URL: http://localhost:11434
- API Key: Configured
- Models available: llama3.2, mistral, gemma2

**Configuration:**
- llama3.2: 32K context, 4K max tokens
- mistral: 32K context, 4K max tokens
- gemma2: 8K context, 4K max tokens

**Status:** Gateway restarted, configuration active.

### Metadata
- Source: user_action
- Tags: ollama, api-key, local-model, configuration
- Related: LRN-20260413-001, LRN-20260413-002, LRN-20260413-003, LRN-20260413-004, LRN-20260413-005, LRN-20260413-006, LRN-20260413-007, LRN-20260413-008

---

## [LRN-20260414-002] insight

**Logged**: 2026-04-14T01:05:00Z
**Priority**: medium
**Status**: active
**Area**: config

### Summary
User installed ontology v1.0.4 — typed knowledge graph for structured agent memory

### Details
Seventh skill installed. Complete skill stack:
1. self-improvement — learning & corrections
2. agent-team-orchestration — multi-agent workflows
3. git — version control
4. humanizer — writing quality
5. web-search-plus — 7 providers & auto-routing (Serper, Tavily, Exa configured)
6. free-ride — free AI models via OpenRouter
7. ontology v1.0.4 — typed knowledge graph for structured memory

**ontology capabilities:**
- Typed entities (Person, Project, Task, Event, Document, etc.)
- Relations between entities
- Constraint validation
- Graph traversal queries
- Cross-skill shared state
- Multi-step planning as graph transformations

**Use cases:**
- "Remember that..." → Create entity
- "What do I know about X?" → Query graph
- "Link X to Y" → Create relation
- "Show dependencies" → Graph traversal

### Metadata
- Source: user_action
- Tags: skill-install, ontology, knowledge-graph, memory, structured-data
- Related: LRN-20260413-001, LRN-20260413-002, LRN-20260413-003, LRN-20260413-004, LRN-20260413-005, LRN-20260413-006, LRN-20260413-007, LRN-20260413-008, LRN-20260414-001

---

## [LRN-20260414-003] insight

**Logged**: 2026-04-14T01:10:00Z
**Priority**: medium
**Status**: active
**Area**: config

### Summary
User installed api-gateway v1.0.80 — connect to 100+ APIs with managed OAuth

### Details
Eighth skill installed. Complete skill stack:
1. self-improvement — learning & corrections
2. agent-team-orchestration — multi-agent workflows
3. git — version control
4. humanizer — writing quality
5. web-search-plus — search & research
6. free-ride — free AI models
7. ontology — structured memory
8. api-gateway v1.0.80 — 100+ API integrations via Maton.ai

**api-gateway capabilities:**
- Connect to 100+ services: Google Workspace, Microsoft 365, GitHub, Notion, Slack, Airtable, HubSpot, Salesforce, Zoom, Stripe, etc.
- Managed OAuth connections via Maton.ai
- Passthrough proxy for direct API access
- Connection management (list, activate, deactivate)

**Base URL:** `https://gateway.maton.ai/{app}/{api-path}`

**Requires:** MATON_API_KEY from maton.ai/settings

### Metadata
- Source: user_action
- Tags: skill-install, api-gateway, maton, integrations, oauth
- Related: LRN-20260413-001, LRN-20260413-002, LRN-20260413-003, LRN-20260413-004, LRN-20260413-005, LRN-20260413-006, LRN-20260413-007, LRN-20260413-008, LRN-20260414-001, LRN-20260414-002

---

## [LRN-20260413-007] insight

**Logged**: 2026-04-13T07:02:00Z
**Priority**: high
**Status**: active
**Area**: config

### Summary
User installed free-ride v1.0.8 — free AI models via OpenRouter. API key configured.

### Details
Sixth skill installed. Complete skill stack:
1. self-improvement — learning & corrections
2. agent-team-orchestration — multi-agent workflows
3. git — version control
4. humanizer — writing quality
5. web-search-plus — 7 providers & auto-routing
6. free-ride v1.0.8 — free AI models via OpenRouter

**free-ride capabilities:**
- Auto-select best free models from OpenRouter
- Configure fallbacks for rate-limit handling
- Updates openclaw.json (preserves other config)
- Commands: `freeride auto`, `freeride list`, `freeride switch`, `freeride status`
- Watcher daemon for auto-rotation

**Configuration (2026-04-14):**
- Primary: `openrouter/google/lyria-3-pro-preview:free`
- Context: 1,048,576 tokens
- Quality score: 0.842
- Fallbacks (5): openrouter/free, google/gemma-4-26b-a4b-it:free, google/gemma-4-31b-it:free, nvidia/nemotron-3-super-120b-a12b:free

**API Key:** Configured ✓

### Metadata
- Source: user_action
- Tags: skill-install, free-ai, openrouter, cost-saving, model-management, configured
- Related: LRN-20260413-001, LRN-20260413-002, LRN-20260413-003, LRN-20260413-004, LRN-20260413-005, LRN-20260413-006

---
