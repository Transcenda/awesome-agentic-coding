# Developer's Roadmap for Agentic Coding

This roadmap is for going deeper with agentic coding, beyond just chatting with an AI to generate code. We suggest trying custom skills and
skills frameworks, agentic loops with automated tests, subagents running jobs in parallel, and MCP servers wired into real tools and
data. Below you'll find tools to try and a self-check on the techniques.

## Table of contents

- [Agentic coding 101](#agentic-coding-101)
- [Spec-first work](#spec-first-work)
- [Agent instructions and Skills](#agent-instructions-and-skills)
- [Testing and quality](#testing-and-quality)
- [Tool integrations and MCP](#tool-integrations-and-mcp)
- [Multi-agent workflows](#multi-agent-workflows)
- [Productivity and operations](#productivity-and-operations)
- [Policy-compliant AI use](#policy-compliant-ai-use)
- [Agentic coding toolbox](#agentic-coding-toolbox)


## Agentic coding 101

### 1. Codebase navigation and understanding

A large part of development time is navigation and code comprehension, not code writing. AI is useful to explore the code and understand how it works faster.

**In practice:** you've used AI to explain an unfamiliar flow or find affected files, and onboarding into a new area of the codebase went faster with AI in the loop.

### 2. Planning mode before coding starts

Using AI for planning the work before writing code helps reduce blind edits and improves first-pass quality for larger changes.

**In practice:** you've hit plan mode before writing code for a non-trivial change, and you've got the prompt history, plan, or spec draft to show for it.

### 3. Agent mode for code generation

Unlike autocomplete or pure chat, agent mode can inspect files, edit code, run commands, reason across steps, and complete larger tasks end-to-end. This is a different level of leverage than asking isolated code generation requests or relying on line-by-line suggestions.

**In practice:** you've had an agent edit several files in one task, run commands, or complete multi-step work end-to-end.

### 4. Generating the PR summaries and explanation of changes

This improves reviewer speed, handoff quality, and the readability of technical changes in PRs. Tools like CodeRabbit, Qodo Merge, and GitHub Copilot for PRs automate summary and walkthrough generation as part of the PR workflow.

**In practice:** you've let AI draft a PR summary or change explanation on a recent PR.

### 5. Trying both IDE/desktop and CLI AI agents

Different tasks suit different interfaces. IDE-integrated tools are great for inline edits, quick assistance, and working through extensive code review. CLI agents are better for repo-wide changes, multi-file edits, grep/search-driven exploration, scaffolding, scripted flows, and terminal-heavy work. Trying both lets you pick the right tool for each task rather than forcing one interface into every situation.

**In practice:** you've used both an IDE agent and a CLI agent on real work, and you can say which one fits which kind of task.

### 6. Refactoring and cleaning up existing code

A large share of the work goes into improving code that already works: extracting, renaming, simplifying, removing duplication, cleaning up legacy code. AI is very effective for this kind of work, and it is often only applied to new features, which misses a big part of its value. For repo-wide structural changes, AI pairs well with codemod tools like Grit, jscodeshift, and Comby.

**In practice:** you've done a real refactor with AI — extracting a function, simplifying a component, cleaning up legacy code, or tightening readability across files.

### 7. Self code review before submitting PRs

AI review catches issues earlier, improves diff quality before a human reviewer sees it, and makes feedback on others' code more thorough. This reduces review cycles and raises the quality of what lands in main. Tools like CodeRabbit, Greptile, Qodo Merge, and Ellipsis run this automatically as part of the PR workflow.

**In practice:** you've run AI review on your own diff before requesting human review, or left an AI-informed comment on a teammate's PR.

### 8. Agentic loop with build, static analysis, and automated tests

The strongest way to use an agent is to let it close its own feedback loop: make a code change, compile, run static analysis, run unit tests, read the failures, adjust, and repeat until green. This is how the agent catches its own mistakes (including hallucinated functions or incorrect types) and produces code that is verifiably working rather than only plausible. The output becomes more trustworthy, and throughput goes up dramatically compared to reviewing one-shot generations by hand.

**In practice:** you've had an agent run build, linter, and tests in a loop, read the failures, and iterate until green — the agent closed the loop itself, not a single-shot generation.

### 9. Creating and maintaining technical documentation

AI is effective for drafting and updating READMEs, module docs, API references, setup guides, and onboarding notes. Up-to-date documentation improves team velocity and also gives AI agents better context to work from in future sessions. Platforms like Mintlify bring AI writing directly into developer documentation workflows.

**In practice:** you've drafted or updated a README, module doc, API reference, setup guide, or onboarding note with AI.

## Spec-first work

### 10. Task briefs or spec files before larger features

A good spec, used as input to AI, produces better agent output and makes the implementation easier to review. This turns "build X" into an executable plan instead of jumping directly into code generation. Spec-driven frameworks like Spec Kit, Kiro, Tessl, and BMAD-METHOD formalize this workflow with templates and phased flows.

**In practice:** you've written a spec or design note in markdown and handed it to an agent as input, with AI-drafted execution steps, implementation plan, or acceptance criteria to go with it.

### 11. Generating detailed requirements covering happy paths and failure modes

Corner cases are exactly what gets missed when AI is used only for happy-path code generation. AI can help reduce risk and improve the readiness of the feature across real-world scenarios. Spec-driven frameworks like Spec Kit force authors to enumerate edge cases and acceptance criteria explicitly.

**In practice:** you've walked through happy paths, error states, and corner cases with AI before writing code, so scenario coverage is part of the plan rather than an afterthought.

### 12. Architecture and design-level decisions

Before implementation, there are often design choices, like data model shape, API boundaries, tradeoffs between approaches. AI helps reason through options and write them down so the choice is explicit and reviewable during code review. This sits one level above the feature spec and helps build the feature the right way.

**In practice:** you've produced a design note or tradeoff analysis with AI, or brought AI-drafted content into a design discussion or technical review.

### 13. Creating ADRs and updating architecture documentation

Architecture docs and ADRs often rot or get skipped because they feel heavy to write. AI makes it fast to draft, update, and keep them accurate as the system evolves, so new teammates and AI agents have reliable context for future decisions. Templates like MADR paired with tooling like log4brains or adr-tools keep this low-friction.

**In practice:** you've written or updated an ADR with AI, or refreshed architecture docs as the system evolved.

## Agent instructions and Skills

### 14. Agent instructions committed in the repo

Source repository context improves agent onboarding, repeatability of work, and code-wide quality.

**In practice:** your repo has an AGENTS.md, CLAUDE.md, Copilot instructions, or equivalent guidance that agents actually read.

### 15. Custom Skills for repeated tasks and reusable commands

Skills help teams move from ad-hoc prompting to full automation of their day-to-day typical workflows. You can define your own custom agent skills and/or use the skill frameworks to cover common automation scenarios.

**In practice:** you've written a reusable Skill for something you do often — build automation, feature scaffolding, dependency updates, PR prep, test generation, or bug triage — instead of re-prompting every time.

### 16. Skills frameworks

Writing every Skill from scratch is slow and means rediscovering patterns others already solved. Skills frameworks provide ready-made building blocks that complement your own custom Skills (item 15): prebuilt breadth alongside team-specific depth. Context7 curates agent instructions for popular languages, frameworks, and libraries, and lets you selectively load only the ones relevant to the current task. Composable frameworks like Superpowers, GSD, and BMAD-METHOD combine Skills into larger workflows and support sub-agent patterns for multi-step work.

**In practice:** you pull in Context7 docs for the languages and libraries you actually use, and you've got a framework like Superpowers or GSD running alongside your own custom Skills.

### 17. Sub-agents for parallel or scoped subtasks

Complex tasks are often made of independent sub-problems: exploring one area while drafting another, running a search in parallel with an edit. Most modern coding AI tools can spawn sub-agents (for example, Claude Code's Task/Agent tool, Cursor background agents, or parallel CLI sessions) to keep the main context clean and complete work faster. For custom sub-agent workflows beyond what's built in, Agent SDKs like Claude Agent SDK, OpenAI Agents SDK, and LangGraph provide orchestration primitives.

**In practice:** you've spawned sub-agents for exploration or research, kept your main context clean by offloading to them, and you can explain when that beat running everything in one agent.

## Testing and quality

### 18. Generating or improving unit tests

AI helps improve unit test coverage, reducing the time spent on unit testing and avoiding situations where unit tests get skipped. Dedicated AI test tools like Qodo Cover and Diffblue Cover generate tests iteratively based on runtime feedback.

**In practice:** you've shipped a PR where AI wrote or improved the unit tests.

### 19. Integration tests, E2E tests, fixtures, and realistic test data

Integration tests offer the highest leverage in controlling the quality of code changes and catching regressions. A full integration test suite with E2E tests, fixtures, and seed data covers all the major behaviours of the feature being developed. AI coding agents can also evaluate the quality of the tests and improve the coverage. Playwright is the common base for E2E, and Pact is the standard for consumer-driven contract testing between services.

**In practice:** you've generated fixtures, test datasets, or seed data with AI, written integration tests that use them, and had AI evaluate test quality or coverage.

### 20. Browser/device automation for testing and UI interaction

Browser/device automation unlocks a practical workflow for UI validation, screenshot capture, regression checks, and turning test cases in English into automation scripts that run on the developer's machine and on CI/CD. AI-native libraries like Browserbase Stagehand and Browser Use work alongside Playwright, and Anthropic Computer Use enables direct screen, keyboard, and mouse control for agent-driven UI automation.

**In practice:** you've got browser or device automation running — a Playwright script, simulator control, screenshot validation, or UI automation generated from a written scenario.

### 21. Debugging failing tests and flaky behavior

AI is good at narrowing hypotheses, reading logs, and suggesting minimal targeted fixes to resolve flaky tests and improve the predictability of CI/CD pipelines. Platforms like Trunk detect, quarantine, and track flaky tests across CI with AI-assisted triage.

**In practice:** you've investigated a failing test or fixed flakiness with AI's help.

## Tool integrations and MCP

### 22. Connected MCP servers

Connected tools make agents much more useful than plain chat, and MCP servers give access to data and external systems. Popular examples to start with: browser-control MCP for web automation, Figma MCP for designs, PostgreSQL MCP for database access, GitHub MCP for repo and PR operations. When MCP is not available for a given system, Skills, vendor SDKs, or CLI scripts can play a similar role.

**In practice:** you've got at least one MCP server in active use, recently finished a task through a connected tool, and you know what tooling — MCPs, Skills, SDKs, or CLI scripts — covers the systems you work with.

### 23. Inspecting logs, API responses, and data snapshots safely

AI can help with debugging and investigation work based on the actual data pulled from logs or snapshots, instead of guesswork. Platforms like Sentry (with its AI root-cause analysis and MCP server) and Rootly expose telemetry to agents so they can investigate based on real signals.

**In practice:** you've debugged from real data — logs, API output, traces, QA or CI/CD snapshots — instead of guessing.

### 24. Exploring databases, modeling data, querying, and generating migrations

AI helps with data across the full range of day-to-day tasks: writing queries, exploring schemas, preparing test data, modeling new entities, and drafting migrations. This is useful for feature development, incident investigation, and analytics alike. AI combined with database access (via MCP, Skills, or CLI scripts) turns manual data work into a faster, semi-automated workflow. Tools like Outerbase (AI SQL workspace) and dbt Copilot bring AI into analytics-engineering contexts.

**In practice:** you've used AI to write or explain a SQL query, explore a schema, design a data model, or draft a migration.

## Multi-agent workflows

### 25. Expanded permissions for autonomous agent work

Default permission settings are conservative, and agents ask for confirmation on most actions. As trust in the tools grows and good guardrails are in place (agentic loops, version control, sandboxes), broader permissions can be safely granted so the agent works longer without interruption. This unlocks long refactors, overnight runs, and multi-step automation. Methodologies like Agent OS formalize this with opinionated specs, standards, and conventions for long-running agents.

**In practice:** you've tuned permission settings — approved commands, auto-accept scopes, trust rules — and had a recent task benefit from the broader envelope.

### 26. Git worktrees for parallel features on one machine

Git worktrees let one repo host multiple isolated checkouts at once, so different agents or sessions can work on different features, in multiple branches simultaneously, without conflicting changes. This multiplies throughput: one agent can refactor in one worktree while another implements a feature in a second, and tests run in a third. Agent OS and similar methodologies include conventions for driving multiple parallel worktrees.

**In practice:** you've got git worktrees set up and a recent case where they paid off, like a long refactor running while you kept shipping feature work.

### 27. Parallel localhost service instances for integration and E2E tests

Integration and E2E tests are slow because services typically bind to fixed ports, forcing tests to run serially. Tools like Portless (or similar dynamic-port/domains on localhost) let multiple instances of the same stack run in parallel on one machine. This speeds up test suites and makes parallel agent work practical when each agent needs its own running services. .NET teams can also use Microsoft Aspire's isolated mode for the same pattern.

**In practice:** your local setup can run multiple service instances in parallel, and there's a test suite or workflow that actually uses it.

## Productivity and operations

### 28. Voice input for AI coding tools

Voice input removes the typing bottleneck for explaining context, describing bugs, walking through intent, and dictating specs, often where momentum gets lost. Several coding tools now support voice natively (for example, Claude Code's /voice command), and third-party dictation tools like Wispr Flow and Superwhisper layer on top of any coding tool. Pairing voice with agent mode lets you think out loud and have the agent act on it, which is especially effective for exploratory work, debugging narration, and long-form planning.

**In practice:** you've tried voice input with an AI coding tool and can name a moment where it beat typing — debugging narration, dictating a spec, or walking through a design.

### 29. Token usage optimized with compression and filtering tools

Deep AI usage naturally grows token expense. Dedicated tools can reduce it dramatically: Caveman compresses agent responses by stripping filler and hedging, cutting output tokens by about 70% on average across Claude Code, Cursor, Copilot, Gemini CLI, Windsurf, and others. RTK is a CLI proxy that auto-filters verbose outputs from git, tests, builds, and container commands before the agent reads them, saving 60–90% on input tokens.

**In practice:** you've got Caveman, RTK, or an equivalent token tool running, you apply prompt caching, tight context, or model-per-task selection, and you can point to a measurable reduction.

### 30. Managing dependency upgrades and security patches

Dependency upgrades and security patches are repetitive, tedious work that tends to get deferred, which is exactly how CVEs pile up and breaking-change debt grows. AI is well-suited to this work because it can read changelogs, diff API changes, update call sites, run tests in a loop, and handle most of the mechanical work. Paired with automation tools like Dependabot, Renovate, or Snyk, upgrades become routine instead of risky.

**In practice:** you've shipped a dependency upgrade PR where AI handled the breaking changes, applied a security patch with AI triaging the CVE, or used AI to read changelogs and flag breaks in advance. Your upgrade workflow pairs Dependabot, Renovate, or Snyk with AI.

### 31. Incident response and on-call workflows

On-call work involves triage under time pressure, reading logs and traces quickly, spotting patterns, drafting communication, and writing up postmortems afterward. AI is effective across all of these: it can correlate signals from logs and traces, propose hypotheses, draft runbooks for recurring alerts, and turn raw incident notes into a clean postmortem. Platforms like Rootly, incident.io, and PagerDuty integrate AI into these workflows directly.

**In practice:** you've had AI help with triage, signal correlation, runbook drafting, turning raw notes into a postmortem, or cutting alert noise.

## Policy-compliant AI use

### 32. AI tools compliant with policy and security guidelines

Using only approved AI tools protects company data and keeps AI usage within policy.

IMPORTANT: Check your organization's AI use policy.

**In practice:** you know which AI tools are approved for your work, you're not using anything outside that list, and your IDE/CLI is signed into the enterprise account.

### 33. Token usage and limits understood

Large prompts and connected tools can waste quota and silently degrade results. At the same time, deeper AI usage naturally consumes more tokens, which is expected, and the goal is value per token, not maximizing tokens used.

**In practice:** you know your budget and limits, and you know where to see usage per tool.

## Agentic Coding Toolbox

### AI coding agents

- [Claude Code](https://claude.com/claude-code) — Anthropic's agentic coding CLI and IDE integration
- [Cursor](https://cursor.com) — AI-first code editor
- [Codex](https://openai.com/codex/) - Agentic coding from OpenAI
- [GitHub Copilot](https://github.com/features/copilot) — GitHub's AI pair programmer
- [Gemini CLI](https://github.com/google-gemini/gemini-cli) — Google's Gemini CLI
- [Windsurf](https://windsurf.com) — AI editor
- [Cline](https://cline.bot/) - Open source coding AI agent

### Agent instructions and Skills

- [AGENTS.md](https://agents.md/) — open format for repo-level agent instructions
- [Superpowers](https://github.com/obra/superpowers) — composable Skills framework with sub-agent patterns
- [Context7](https://github.com/upstash/context7) — up-to-date library documentation for AI agents, loadable selectively
- [GSD (Get Sh*t Done)](https://github.com/gsd-build/get-shit-done) — meta-prompting, context-engineering, spec-driven Skills system for Claude Code
- [Skills.sh](https://skills.sh/) - The Open Agent Skills Ecosystem from Vercel

### Agent SDKs and multi-agent frameworks

- [Hermes Agent](https://github.com/nousresearch/hermes-agent) — self-improving agent framework with procedural memory and multi-platform deployment (Nous Research)
- [Agent OS](https://github.com/buildermethods/agent-os) — opinionated methodology for long-running autonomous agents
- [Claude Agent SDK](https://github.com/anthropics/claude-agent-sdk-python) — Anthropic's SDK for building sub-agents and orchestrated workflows
- [OpenAI Agents SDK](https://github.com/openai/openai-agents-python) — lightweight multi-agent orchestration with handoffs and tracing
- [OpenClaw](https://github.com/openclaw/openclaw) — open-source local-first AI assistant with multi-channel messaging, voice, and Canvas workspaces

### Spec-driven development

- [Spec Kit](https://github.com/github/spec-kit) — GitHub's toolkit for spec-driven development with AI agents
- [Kiro](https://kiro.dev) — AWS's spec-first IDE
- [Tessl](https://tessl.io) — spec-centric development platform
- [BMAD-METHOD](https://github.com/bmad-code-org/BMAD-METHOD) — also fits spec-first: agile AI-driven development organized around spec/brief artifacts

### Documentation and ADR tooling

- [Mintlify](https://mintlify.com) — AI-assisted docs platform for developer documentation
- [MADR](https://github.com/adr/madr) — markdown ADR template
- [log4brains](https://github.com/thomvaill/log4brains) — CLI and static site generator for ADRs
- [adr-tools](https://github.com/npryce/adr-tools) — shell-based toolchain for creating and numbering ADRs

### AI code review

- [CodeRabbit](https://coderabbit.ai) — AI code review bot for GitHub/GitLab PRs
- [Greptile](https://greptile.com) — AI code reviewer with repo-wide context
- [Qodo Merge](https://github.com/Codium-ai/pr-agent) — open-source agent for PR descriptions, reviews, and walkthroughs
- [Ellipsis](https://ellipsis.dev) — AI reviewer with auto-fix capability
- [sober-coding](https://github.com/voidborne-d/sober-coding) — open-source CLI that scans for AI-native code smells (duplication, dead branches, deep nesting, missing error handling) and prints fix suggestions

### Codemods and refactoring

- [Grit](https://getgrit.io) — query language and CLI for AI-assisted codemods
- [jscodeshift](https://github.com/facebook/jscodeshift) — Meta's AST codemod toolkit for JavaScript and TypeScript
- [Comby](https://comby.dev) — language-agnostic structural search-and-replace for multi-file refactoring
- [Awesome Codemods](https://github.com/rajasegar/awesome-codemods) - a large collection of codemods

### Testing and AI-native browser automation

- [Playwright](https://playwright.dev) — cross-browser E2E framework
- [Pact](https://pact.io) — consumer-driven contract testing for service integration
- [Qodo Cover](https://github.com/Codium-ai/cover-agent) — open-source AI unit test generation
- [Diffblue Cover](https://www.diffblue.com) — AI unit test generator for Java/JVM
- [Trunk Flaky Tests](https://trunk.io/products/flaky-tests) — detect, quarantine, and track flaky tests across CI
- [Browserbase Stagehand](https://github.com/browserbase/stagehand) — AI-native browser automation layered on Playwright
- [Browser Use](https://github.com/browser-use/browser-use) — open-source library that lets LLMs drive real browsers
- [Anthropic Computer Use](https://docs.anthropic.com/en/docs/agents-and-tools/computer-use) — Claude's screen, keyboard, and mouse control for agent-driven UI automation

### MCP Servers

- [MCP servers repo](https://github.com/modelcontextprotocol/servers)
- [GitHub MCP](https://github.com/github/github-mcp-server) — official GitHub MCP server
- [Playwright MCP](https://github.com/microsoft/playwright-mcp) — browser automation MCP from Microsoft
- [Figma MCP](https://www.figma.com/) — Figma's developer MCP for design tokens and canvas access 

### Observability and incident response

- [Rootly](https://rootly.com) — incident platform with AI agents for investigation and retrospectives
- [incident.io](https://incident.io) — on-call and incident platform with AI summaries and investigation copilots
- [PagerDuty AIOps](https://www.pagerduty.com) — AI-driven alert noise reduction and incident automation
- [Sentry](https://sentry.io) — AI-assisted root-cause analysis with an MCP server for agent queries

### Local development

- [Portless](https://github.com/vercel-labs/portless) — stable named URLs for localhost services, worktree-aware (Vercel Labs)
- [Microsoft .NET Aspire](https://learn.microsoft.com/en-us/dotnet/aspire/) — isolated multi-service local dev/test stacks for .NET

### Voice input

- [Wispr Flow](https://wisprflow.ai) — AI dictation app for macOS and Windows
- [Superwhisper](https://superwhisper.com) — macOS voice-to-text built on Whisper-family models

### Token optimization

- [Caveman](https://github.com/JuliusBrussee/caveman) — agent response compression (~70% output token reduction)
- [RTK](https://github.com/rtk-ai/rtk) — CLI proxy for input token filtering on common dev commands

### Dependency and security automation

- [Dependabot](https://github.com/dependabot) — GitHub's dependency update bot
- [Renovate](https://github.com/renovatebot/renovate) — cross-platform dependency update tool
- [Snyk](https://snyk.io) — security platform with AI-assisted fix suggestions for vulnerable dependencies

## Contributing

Contributions are welcome — open a pull request directly with your proposed change. The roadmap is kept intentionally short and practical, so new items should describe a concrete use case that deepens AI coding usage, with a clear why and an "In practice" prompt that a reader can hold up against their own work.
