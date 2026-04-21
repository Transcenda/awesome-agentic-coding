# Developer's Roadmap for Agentic Coding Adoption

AI coding agents get used in very different ways. Some go deep — agentic loops, sub-agents, custom Skills, parallel workflows. Others stay shallow, mostly autocomplete and one-shot code generation. The gap between the two is where most of the productivity lives.

This list is a checklist to help you try the deeper use cases and increase the depth of your AI usage. Use it as a self-assessment to find the next deeper use case to try.

## Table of contents

- [AI tools use in a policy-compliant way](#ai-tools-use-in-a-policy-compliant-way)
- [Agentic Coding Fundamentals](#agentic-coding-fundamentals)
- [Spec-first work](#spec-first-work)
- [Agents Instructions and Skills](#agents-instructions-and-skills)
- [Testing and quality](#testing-and-quality)
- [Tool integrations and MCP](#tool-integrations-and-mcp)
- [Multi-Agent Workflows](#multi-agent-workflows)
- [Productivity and operations](#productivity-and-operations)

---

## AI tools use in a policy-compliant way

### 1. All AI tools are compliant with company policy and security guidelines

**Why this is important?** Using only approved AI tools protects company data and keeps AI usage within policy.

IMPORTANT: Check your organization's AI use policy.

**Self-check:** clear on which AI tools are approved for your work, not using any tools outside the approved list, IDE/CLI signed into the enterprise account.

### 2. Token usage and limits are understood

**Why this is important?** Large prompts and connected tools can waste quota and silently degrade results. At the same time, deeper AI usage naturally consumes more tokens — that is expected.

The goal is value per token, not maximizing tokens used.

**Self-check:** clear on your budget and limits, know where to see usage information per tool.

---

## Agentic Coding Fundamentals

### 3. AI is used for codebase navigation and understanding

**Why this is important?** A large part of development time is navigation and code comprehension, not code writing. AI is useful to explore the code and understand how it works faster.

**Self-check:** recent example of AI explaining a flow or identifying affected files, onboarding into an unfamiliar area sped up by AI.

### 4. Planning mode is used before coding starts

**Why this is important?** Using AI for planning the work before writing code helps reduce blind edits and improves first-pass quality for larger changes.

**Self-check:** prompt history, plan, or spec draft created before implementation; planning phase used for recent larger changes.

### 5. Agent mode is used for code generation, not autocomplete or pure chat

**Why this is important?** Agent mode can inspect files, edit code, run commands, reason across steps, and complete larger tasks end-to-end. This is a different level of leverage than asking isolated code generation requests in chat or relying on line-by-line autocomplete.

**Self-check:** recent task where an agent changed several files, recent task where an agent executed commands or completed multi-step work.

### 6. AI is used for managing branches, generating the PR summaries and explanation of changes

**Why this is important?** This improves reviewer speed, handoff quality, and the readability of technical changes in PRs.

**Self-check:** recent PR with summary or change explanation drafted by AI, branch or commit flow handled with AI.

### 7. Both IDE/desktop and CLI AI agents have been tried

**Why this is important?** Different tasks suit different interfaces. IDE-integrated tools are great for inline edits, quick assistance, and working through extensive code review. CLI agents are better for repo-wide changes, multi-file edits, grep/search-driven exploration, scaffolding, scripted flows, and terminal-heavy work. Trying both lets you pick the right tool for each task rather than forcing one interface into every situation.

**Self-check:** recent example of using an IDE agent, recent example of using a CLI agent, can articulate which kind of work fits which interface.

### 8. AI is used for refactoring and cleaning up existing code

**Why this is important?** A large share of the work goes into improving code that already works — extracting, renaming, simplifying, removing duplication, cleaning up legacy code. AI is very effective for this kind of work, and it is often only applied to new features, which misses a big part of its value.

**Self-check:** recent refactor done with AI assistance, AI used to extract a function or simplify a component, legacy code cleaned up with AI, readability improved with AI across several files.

### 9. AI is used for self code review before submitting PRs

**Why this is important?** AI review catches issues earlier, improves diff quality before a human reviewer sees it, and makes feedback on others' code more thorough. This reduces review cycles and raises the quality of what lands in main.

**Self-check:** recent PR where AI review was run on your own changes before human review, or a review comment on a teammate's PR informed by AI analysis.

### 10. AI is used in an agentic loop that includes build, static analysis, and automated tests

**Why this is important?** The strongest way to use an agent is to let it close its own feedback loop — make a code change, compile, run static analysis, run unit tests, read the failures, adjust, and repeat until green. This is how the agent catches its own mistakes (including hallucinated functions or incorrect types) and produces code that is verifiably working rather than only plausible. The output becomes more trustworthy, and throughput goes up dramatically compared to reviewing one-shot generations by hand.

**Self-check:** recent task where the agent ran build, linter, and tests in a loop; agent iterated on its own output until feedback was green; not a single-shot code generation — the loop was closed by the agent.

### 11. AI is used to create and maintain technical documentation

**Why this is important?** AI is effective for drafting and updating READMEs, module docs, API references, setup guides, and onboarding notes. Up-to-date documentation improves team velocity and also gives AI agents better context to work from in future sessions.

**Self-check:** recent README, module doc, or API reference created or updated with AI; setup guide or onboarding notes updated with AI.

---

## Spec-first work

### 12. Task brief or spec files are created before the implementation of larger features

**Why this is important?** A good spec, used as input to AI, produces better agent output and makes the implementation easier to review. This turns "build X" into an executable plan instead of jumping directly into code generation.

**Self-check:** ticket or design note with a markdown spec used as AI input, execution steps or implementation plan or acceptance checklist written with AI.

### 13. AI is used to generate detailed requirements for a comprehensive UX and explain various happy and failure paths

**Why this is important?** Corner cases are exactly what gets missed when AI is used only for happy-path code generation. AI can help reduce risk and improve the readiness of the feature across real-world scenarios.

**Self-check:** prompt history or checklist covering happy path and error states, corner cases surfaced with AI help, full-scenario coverage considered before implementation.

### 14. AI is used for architecture and design-level decisions for the feature

**Why this is important?** Before implementation, there are often design choices — data model shape, API boundaries, tradeoffs between approaches. AI helps reason through options and write them down so the choice is explicit and reviewable during code review. This sits one level above the feature spec and helps build the feature the right way.

**Self-check:** recent design note or tradeoff analysis produced with AI, AI-written input used in a design discussion or technical review.

### 15. AI is used to create ADRs and update architecture documentation for the whole codebase

**Why this is important?** Architecture docs and ADRs often rot or get skipped because they feel heavy to write. AI makes it fast to draft, update, and keep them accurate as the system evolves, so new teammates and AI agents have reliable context for future decisions.

**Self-check:** recent ADR entry created or updated with AI, architecture document updated with AI as the system evolved.

---

## Agents Instructions and Skills

### 16. Agent instructions are committed in the repo

**Why this is important?** Source repository context improves agent onboarding, repeatability of work, and code-wide quality.

**Self-check:** AGENTS.md, CLAUDE.md, or Copilot instruction files present in the repo; equivalent repo-visible guidance maintained.

### 17. Repeated tasks and reusable commands are documented in the form of custom Skills

**Why this is important?** Skills help teams move from ad-hoc prompting to full automation of their day-to-day typical workflows. You can define your own custom agent skills and/or use the skill frameworks to cover common automation scenarios.

**Self-check:** reusable Skill for build automation or feature scaffolding or dependency updates, Skill for PR prep or test generation or bug triage, repeatable work automated with a Skill instead of ad-hoc prompting.

### 18. Skills frameworks are used

**Why this is important?** Writing every Skill from scratch is slow and means rediscovering patterns others already solved. Skills frameworks provide ready-made building blocks that complement your own custom Skills (item 17) — prebuilt breadth alongside team-specific depth. Context7 curates agent instructions for popular languages, frameworks, and libraries, and lets you selectively load only the ones relevant to the current task. Composable frameworks like Superpowers combine Skills into larger workflows and support sub-agent patterns for multi-step work.

**Self-check:** Context7 used to selectively load agent instructions for the languages or libraries in use, composable framework like Superpowers integrated into your workflow, framework Skills combined with your own custom Skills.

### 19. Sub-agents are used to delegate parallel or scoped subtasks

**Why this is important?** Complex tasks are often made of independent sub-problems — exploring one area while drafting another, running a search in parallel with an edit. Most modern coding AI tools can spawn sub-agents (for example Claude Code's Task/Agent tool, background agents, parallel sessions in Cursor, or terminal-spawned parallel CLI agent sessions) to keep the main context clean and complete work faster.

**Self-check:** recent session where one or more sub-agents were spawned for exploration or research, sub-agents used to keep main context clean during multi-part work, can explain when sub-agents were more effective than single-agent work.

---

## Testing and quality

### 20. AI is used to generate or improve unit tests

**Why this is important?** AI helps improve unit test coverage, reducing the time spent on unit testing and avoiding situations where unit tests get skipped.

**Self-check:** recent PR with unit tests added or improved by AI.

### 21. AI is used for integration tests, E2E tests, fixtures, and realistic test data

**Why this is important?** Integration tests offer the highest leverage in controlling the quality of code changes and catching regressions. A full integration test suite with E2E tests, fixtures, and seed data covers all the major behaviours of the feature being developed. AI coding agents can also evaluate the quality of the tests and improve the coverage.

**Self-check:** fixtures or test datasets or seed data generation scripts produced with AI, integration tests that use AI-generated fixtures, test quality or coverage improved with AI evaluation.

### 22. Browser/device automation is used for testing and UI interaction

**Why this is important?** Browser/device automation unlocks a practical workflow for UI validation, screenshot capture, regression checks, and turning test cases in English into automation scripts that run on the developer's machine and on CI/CD.

**Self-check:** browser-based automation script in use, mobile device simulator control script, screenshot validation run as part of testing, UI automation generated from a written scenario.

### 23. AI is used to debug failing tests and flaky behavior

**Why this is important?** AI is good at narrowing hypotheses, reading logs, and suggesting minimal targeted fixes to resolve flaky tests and improve the predictability of CI/CD pipelines.

**Self-check:** recent failing test investigation with AI involvement, flaky test fix with AI help.

---

## Tool integrations and MCP

### 24. MCP servers are connected and used

**Why this is important?** Connected tools make agents much more useful than plain chat, and MCP servers give access to data and external systems. Popular examples to start with: browser-control MCP for web automation, Figma MCP for designs, PostgreSQL MCP for database access, GitHub MCP for repo and PR operations. When MCP is not available for a given system, Skills, vendor SDKs, or CLI scripts can play a similar role.

**Self-check:** at least one MCP server configured and in active use, recent task completed through a connected tool, know which MCPs or Skills or SDKs or CLI scripts cover your common systems.

### 25. AI is used to inspect logs, API responses, and data snapshots safely

**Why this is important?** AI can help with debugging and investigation work based on the actual data pulled from logs or snapshots, instead of guesswork.

**Self-check:** recent investigation using logs or API output or traces, snapshots from QA or CI/CD used as AI input, real data driving the debugging rather than guesswork.

### 26. AI is used to explore databases, model data, query, and generate migrations

**Why this is important?** AI helps with data across the full range of day-to-day tasks — writing queries, exploring schemas, preparing test data, modeling new entities, and drafting migrations. This is useful for feature development, incident investigation, and analytics alike. AI combined with database access (via MCP, Skills, or CLI scripts) turns manual data work into a faster, semi-automated workflow.

**Self-check:** recent SQL query written or explained with AI, schema explored with AI help, data model designed with AI input, migration script drafted with AI.

---

## Multi-Agent Workflows

### 27. Permissions are expanded to enable more autonomous agent work

**Why this is important?** Default permission settings are conservative, and agents ask for confirmation on most actions. As trust in the tools grows and good guardrails are in place (agentic loops, version control, sandboxes), broader permissions can be safely granted so the agent works longer without interruption. This unlocks long refactors, overnight runs, and multi-step automation.

**Self-check:** permission settings tuned with approved commands or auto-accept scopes or trust rules, recent task completed with broader permissions where the trust envelope helped.

### 28. Git worktrees are used to run multiple features or branches in parallel on one machine

**Why this is important?** Git worktrees let one repo host multiple isolated checkouts at once, so different agents or sessions can work on different features, in multiple branches simultaneously, without conflicting changes. This multiplies throughput — one agent can refactor in one worktree while another implements a feature in a second, and tests run in a third.

**Self-check:** git worktrees set up and in active use, recent case where parallel worktrees helped — e.g., long refactor while continuing feature work.

### 29. Parallel service instances run on localhost for parallel integration and E2E tests

**Why this is important?** Integration and E2E tests are slow because services typically bind to fixed ports, forcing tests to run serially. Tools like Portless (or similar dynamic-port/domains on localhost) let multiple instances of the same stack run in parallel on one machine. This speeds up test suites and makes parallel agent work practical when each agent needs its own running services.

**Self-check:** local environment configured for parallel service instances, test suite or workflow that benefits from running services in parallel.

---

## Productivity and operations

### 30. Voice input is used to work with AI coding tools

**Why this is important?** Voice input removes the typing bottleneck for explaining context, describing bugs, walking through intent, and dictating specs — often where momentum gets lost. Several coding tools now support voice natively (for example, Claude Code's /voice command), and third-party dictation and realtime voice tools can be layered in. Pairing voice with agent mode lets you think out loud and have the agent act on it, which is especially effective for exploratory work, debugging narration, and long-form planning.

**Self-check:** voice input tried with at least one AI coding tool, situation where voice was a better fit than typing — debugging or dictating a spec or walking through a design.

### 31. Token usage is actively optimized with compression and filtering tools

**Why this is important?** Deep AI usage naturally grows token expense. Dedicated tools can reduce it dramatically: Caveman compresses agent responses by stripping filler and hedging, cutting output tokens by about 70% on average across Claude Code, Cursor, Copilot, Gemini CLI, Windsurf, and others. RTK is a CLI proxy that auto-filters verbose outputs from git, tests, builds, and container commands before the agent reads them, saving 60–90% on input tokens.

**Self-check:** Caveman or RTK or equivalent token-optimization tool in use, concrete practices applied (prompt caching, tight context, model-per-task selection), measurable token reduction you can point to.

### 32. AI is used to manage dependency upgrades and security patches

**Why this is important?** Dependency upgrades and security patches are repetitive, tedious work that tends to get deferred — which is exactly how CVEs pile up and breaking-change debt grows. AI is well-suited to this work because it can read changelogs, diff API changes, update call sites, run tests in a loop, and handle most of the mechanical work. Paired with automation tools like Dependabot or Renovate, upgrades become routine instead of risky.

**Self-check:** recent dependency upgrade PR where AI handled the breaking changes, security patch applied with AI triaging the CVE and proposing the fix, AI used to read changelogs and call out likely breaking changes in advance, upgrade workflow integrated with Dependabot or Renovate or equivalent alongside AI assistance.

### 33. AI is used for incident response and on-call workflows

**Why this is important?** On-call work involves triage under time pressure, reading logs and traces quickly, spotting patterns, drafting communication, and writing up postmortems afterward. AI is effective across all of these — it can correlate signals from logs and traces, propose hypotheses, draft runbooks for recurring alerts, and turn raw incident notes into a clean postmortem.

**Self-check:** recent incident where AI helped triage or correlate signals, runbook drafted with AI for a recurring alert, postmortem written with AI from raw incident notes, alert noise reduced with AI help.

---

## Tools mentioned

### AI coding agents

- [Claude Code](https://claude.com/claude-code) — Anthropic's agentic coding CLI and IDE integration
- [GitHub Copilot](https://github.com/features/copilot) — GitHub's AI pair programmer
- [Cursor](https://cursor.com) — AI-first code editor
- [Windsurf](https://windsurf.com) — AI editor
- [Gemini CLI](https://github.com/google-gemini/gemini-cli) — Google's Gemini CLI

### Agent instructions and Skills

- [AGENTS.md](https://agents.md/) — open format for repo-level agent instructions
- [Context7](https://github.com/upstash/context7) — up-to-date library documentation for AI agents, loadable selectively
- [Superpowers](https://github.com/obra/superpowers) — composable Skills framework with sub-agent patterns

### MCP servers

- [GitHub MCP](https://github.com/github/github-mcp-server) — official GitHub MCP server
- [Playwright MCP](https://github.com/microsoft/playwright-mcp) — browser automation MCP from Microsoft
- [Figma MCP](https://www.figma.com/) — Figma's developer MCP for design tokens and canvas access
- PostgreSQL MCP — database MCP (several implementations in the [MCP servers repo](https://github.com/modelcontextprotocol/servers))

### Local development

- [Portless](https://github.com/vercel-labs/portless) — stable named URLs for localhost services, worktree-aware (Vercel Labs)

### Token optimization

- [Caveman](https://github.com/JuliusBrussee/caveman) — agent response compression (~70% output token reduction)
- [RTK](https://github.com/rtk-ai/rtk) — CLI proxy for input token filtering on common dev commands

### Dependency and security automation

- [Dependabot](https://github.com/dependabot) — GitHub's dependency update bot
- [Renovate](https://github.com/renovatebot/renovate) — cross-platform dependency update tool

---

## Contributing

Contributions are welcome. Open an issue to discuss a new item or improvement, or submit a pull request with changes. The roadmap is kept intentionally short and practical — new items should describe a concrete use case that deepens AI coding usage, with a clear Why and a Self-check that a reader can evaluate against their own work.

## License

This project is licensed under the terms in [LICENSE](./LICENSE).
