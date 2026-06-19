# Awesome Agentic Coding [![Awesome](https://awesome.re/badge.svg)](https://awesome.re)

<!--lint disable double-link-->

This roadmap helps engineers progressively build up their coding agents harness, from ad-hock prompting to custom skills, automated feedback loops, sub-agents, MCPs, agent memory, skip and spec frameworks, and other advanced agentic coding workflows.

## Contents

- [Agentic coding 101](#agentic-coding-101)
- [Spec-first work](#spec-first-work)
- [Agent instructions and Skills](#agent-instructions-and-skills)
- [Testing and quality](#testing-and-quality)
- [Tool integrations and MCP](#tool-integrations-and-mcp)
- [Multi-agent workflows](#multi-agent-workflows)
- [Productivity and operations](#productivity-and-operations)
- [Harness and context engineering](#harness-and-context-engineering)
- [Policy-compliant AI use](#policy-compliant-ai-use)
- [Agentic Coding Toolbox](#agentic-coding-toolbox)


## Agentic coding 101

### 1. Codebase navigation and understanding

A large part of development time is navigation and code comprehension, not code writing. AI is useful to explore the code and understand how it works faster.

**In practice:** you've used AI to explain an unfamiliar flow or find affected files, and onboarding into a new area of the codebase went faster with AI in the loop.

### 2. Planning and replanning before coding starts

For non-trivial changes, have the agent inspect the repository, clarify constraints, and propose a plan and acceptance criteria before editing. Treat the plan as a living hypothesis: update it when code, tool output, or tests reveal new information instead of forcing the implementation through a stale upfront plan.

**In practice:** you've used plan mode before a non-trivial change, revised the plan after repository or test feedback, and kept the final scope and acceptance criteria reviewable.

### 3. Agent mode for code generation

Unlike autocomplete or pure chat, agent mode can inspect files, edit code, run commands, reason across steps, and complete larger tasks end-to-end. Use that autonomy for open-ended work with clear success criteria and environmental feedback; a direct edit or single model call is usually better for simple, predictable tasks.

**In practice:** you've had an agent edit several files in one task, run commands, or complete multi-step work end-to-end.

### 4. Generating the PR summaries and explanation of changes

This improves reviewer speed, handoff quality, and the readability of technical changes in PRs. Tools like CodeRabbit, Qodo, and GitHub Copilot for PRs automate summary and walkthrough generation as part of the PR workflow. Generated summaries are drafts: verify them against the actual diff and test results before publishing.

**In practice:** you've let AI draft a PR summary or change explanation on a recent PR.

### 5. Trying both IDE/desktop and CLI AI agents

Different tasks suit different interfaces. IDE-integrated tools are great for inline edits, quick assistance, and working through extensive code review. CLI agents are better for repo-wide changes, multi-file edits, grep/search-driven exploration, scaffolding, scripted flows, and terminal-heavy work. Trying both lets you pick the right tool for each task rather than forcing one interface into every situation.

**In practice:** you've used both an IDE agent and a CLI agent on real work, and you can say which one fits which kind of task.

### 6. Refactoring and cleaning up existing code

A large share of the work goes into improving code that already works: extracting, renaming, simplifying, removing duplication, cleaning up legacy code. AI is very effective for this kind of work, and it is often only applied to new features, which misses a big part of its value. For repo-wide structural changes, AI pairs well with codemod tools like Grit, jscodeshift, and Comby.

**In practice:** you've done a real refactor with AI — extracting a function, simplifying a component, cleaning up legacy code, or tightening readability across files.

### 7. Self code review before submitting PRs

AI review catches issues earlier, improves diff quality before a human reviewer sees it, and makes feedback on others' code more thorough. This reduces review cycles and raises the quality of what lands in main. Tools like CodeRabbit, Greptile, Qodo, and Ellipsis run this automatically as part of the PR workflow. AI review supplements rather than replaces accountable human review, especially for architecture, security, and product intent.

**In practice:** you've run AI review on your own diff before requesting human review, or left an AI-informed comment on a teammate's PR.

### 8. Agentic loop with build, static analysis, and automated tests

The strongest way to use an agent is to let it close its own feedback loop: make a code change, compile, run static analysis, run tests, read the failures, adjust, and repeat. Define iteration limits and stop conditions, and inspect the final diff: an agent must not make checks pass by weakening tests, accepting incorrect snapshots, suppressing diagnostics, or bypassing guardrails.

**In practice:** you've had an agent run build, linter, and tests in a bounded loop, read failures, iterate, and then show that the checks and final diff still validate the intended behavior.

### 9. Creating and maintaining technical documentation

AI is effective for drafting and updating READMEs, module docs, API references, setup guides, and onboarding notes. Up-to-date documentation improves team velocity and also gives AI agents better context to work from in future sessions. Platforms like Mintlify bring AI writing directly into developer documentation workflows.

**In practice:** you've drafted or updated a README, module doc, API reference, setup guide, or onboarding note with AI.

## Spec-first work

### 10. Task briefs or spec files before larger features

A good spec, used as input to AI, produces better agent output and makes the implementation easier to review. This turns "build X" into an executable plan instead of jumping directly into code generation. Keep specs proportional to the task and update them when implementation evidence changes the design. Spec-driven frameworks like Spec Kit, Kiro, Tessl, and BMAD-METHOD formalize this workflow with templates and phased flows.

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

Source repository context improves agent onboarding, repeatability of work, and code-wide quality. Keep instructions concise, scoped to the relevant directory or workflow, and maintained; large collections of stale or conflicting rules consume context and reduce reliability.

**In practice:** your repo has an AGENTS.md, CLAUDE.md, Copilot instructions, or equivalent guidance that agents actually read.

### 15. Turning repeated agent mistakes into durable repository knowledge

Agents waste time when they repeat the same wrong command, miss the same convention, or receive the same review correction in later sessions. Close the feedback loop by promoting verified lessons into repo instructions, a Skill, or managed agent memory, and remove guidance when it becomes stale. Tools like [Headroom's `learn`](https://github.com/chopratejas/headroom) and [GitHub Copilot Memory](https://docs.github.com/en/copilot/concepts/agents/copilot-memory) can help capture this knowledge.

**In practice:** after a failed task or review correction, you've recorded a reusable lesson in AGENTS.md, CLAUDE.md, a Skill, or managed memory, and a later task benefited from it.

### 16. Deterministic hooks around agent actions

Instructions are probabilistic, so important guardrails and routine checks should not depend on the agent remembering them. Lifecycle hooks can inspect or block tool calls, run formatters and tests after edits, record activity, and prevent a task from finishing before required checks pass. [Claude Code hooks](https://code.claude.com/docs/en/hooks) and [Codex hooks](https://developers.openai.com/codex/hooks) provide pre-tool, post-tool, and session-level control points.

**In practice:** your repo has at least one source-controlled hook that blocks a prohibited action or automatically runs a formatter, linter, test, or audit after relevant agent changes.

### 17. Custom Skills for repeated tasks and reusable commands

Skills help teams move from ad-hoc prompting to full automation of their day-to-day typical workflows. You can define your own custom agent skills and/or use the skill frameworks to cover common automation scenarios.

**In practice:** you've written a reusable Skill for something you do often — build automation, feature scaffolding, dependency updates, PR prep, test generation, or bug triage — instead of re-prompting every time.

### 18. Reusable Skills and context ecosystems

Writing every Skill from scratch is slow and means rediscovering patterns others already solved. Reusable Skills, current documentation providers such as Context7, and composable frameworks such as Superpowers, GSD, and BMAD-METHOD can provide useful building blocks. Do not install a broad framework by default: inspect and pin third-party content, load only what the task needs, and keep it only when it measurably improves outcomes over a simpler workflow.

**In practice:** you selectively load a reviewed Skill or current documentation for the task, and you've removed or avoided framework layers that did not improve quality, speed, or repeatability.

### 19. Sub-agents for parallel or scoped subtasks

Complex tasks sometimes contain independent sub-problems that benefit from separate context windows or parallel work. Start with one agent; add sub-agents when tasks can be cleanly partitioned, when independent perspectives improve confidence, or when the required context exceeds one agent's budget. Avoid multi-agent orchestration for tightly coupled coding work where coordination, duplicate edits, and merge conflicts cost more than the parallelism saves. For custom workflows beyond built-in sub-agents, Agent SDKs like Claude Agent SDK, OpenAI Agents SDK, and LangGraph provide orchestration primitives.

**In practice:** you've compared a single-agent run with a partitioned workflow, given each sub-agent a clear objective and output contract, and can show when the extra coordination paid off.

## Testing and quality

### 20. Generating or improving unit tests

AI helps improve unit test coverage, reducing the time spent on unit testing and avoiding situations where unit tests get skipped. Generated tests should be derived from requirements and externally visible behavior, then reviewed independently; tests that merely mirror the generated implementation can preserve the same mistake. Diffblue Cover generates tests iteratively based on runtime feedback.

**In practice:** you've shipped a PR where AI wrote or improved the unit tests.

### 21. Integration tests, E2E tests, fixtures, and realistic test data

Integration, contract, and E2E tests catch classes of regression that unit tests cannot; choose the test level according to the risk and architecture rather than treating one layer as universally best. AI can generate fixtures and seed data, but use synthetic or sanitized data instead of copying production secrets or personal information. Playwright is a common base for E2E, and Pact supports consumer-driven contract testing between services.

**In practice:** you've generated fixtures, test datasets, or seed data with AI, written integration tests that use them, and had AI evaluate test quality or coverage.

### 22. Browser/device automation for testing and UI interaction

Browser/device automation unlocks a practical workflow for UI validation, screenshot capture, regression checks, and turning written scenarios into automation that runs locally and in CI/CD. Prefer deterministic APIs, selectors, and test frameworks for repeatable checks. Use vision-based computer control when the interface is not otherwise accessible or the task is exploratory, and run it in an isolated environment with approval gates for consequential actions. AI-native libraries like Browserbase Stagehand and Browser Use work alongside Playwright, while computer-use models can drive screen, keyboard, and mouse interactions.

**In practice:** you've got browser or device automation running — a Playwright script, simulator control, screenshot validation, or UI automation generated from a written scenario.

### 23. Debugging failing tests and flaky behavior

AI is good at narrowing hypotheses, reading logs, and suggesting minimal targeted fixes to resolve flaky tests and improve the predictability of CI/CD pipelines. Platforms like Trunk detect, quarantine, and track flaky tests across CI with AI-assisted triage.

**In practice:** you've investigated a failing test or fixed flakiness with AI's help.

### 24. Security-focused review and threat modeling

Generic code review and passing tests do not reliably catch authorization gaps, injection paths, secret exposure, unsafe data flows, or supply-chain risk. Use AI to trace trust boundaries and propose abuse cases, then validate findings with deterministic scanners and targeted tests. Tools such as [Codex Security](https://developers.openai.com/codex/security), CodeQL, Semgrep, and secret scanning complement rather than replace human security review.

**In practice:** you've run a dedicated security review or threat-model pass on a meaningful feature or diff, validated the findings, and added a fix, test, or explicit risk decision.

### 25. Agent traces, evaluations, and regression suites

Product tests validate the code an agent produced; agent evaluations validate the workflow that produced it. Capture end-to-end traces of prompts, tool calls, handoffs, approvals, and outcomes. Build a small representative dataset from real tasks and failures, score both final state and important process constraints, and rerun it when models, prompts, instructions, tools, or permissions change. Because agent behavior is non-deterministic, compare multiple runs where reliability matters instead of trusting one successful demonstration or a public benchmark alone.

**In practice:** you've traced a real agent run, turned at least one failure into a repeatable eval case, and used the result to catch a regression or justify a workflow change.

## Tool integrations and MCP

### 26. Trusted, least-privilege MCP servers

Connected tools make agents much more useful than plain chat, and MCP servers give access to data and external systems. Treat every server as part of the trusted computing base: local servers execute code with client privileges, while remote servers can expose data and actions. Prefer official or reviewed servers, inspect installation commands, pin versions, minimize scopes and enabled tools, and keep write or destructive actions approval-gated. A popular directory is useful for discovery, not a security endorsement. When MCP is not available, a reviewed Skill, vendor SDK, or CLI may be simpler and safer.

**In practice:** you've got at least one reviewed MCP server in active use, can explain its credentials and permissions, and have disabled tools or scopes the workflow does not need.

### 27. Inspecting logs, API responses, and data snapshots safely

AI can help with debugging and investigation work based on actual logs or snapshots instead of guesswork. Use read-only access by default, minimize the time range and fields retrieved, and redact secrets and personal data before they enter model context or traces. Platforms like Sentry and Rootly expose telemetry to agents so they can investigate based on real signals.

**In practice:** you've debugged from scoped, sanitized logs, API output, traces, or QA/CI snapshots instead of guessing, without exposing credentials or unnecessary customer data.

### 28. Exploring databases, modeling data, querying, and generating migrations

AI helps with writing queries, exploring schemas, preparing test data, modeling entities, and drafting migrations. Give exploratory agents read-only or disposable database access by default. Review generated migrations, execution plans, locks, backups, and rollback paths before applying them; production writes and destructive queries should remain explicitly approved. Tools like Outerbase and dbt Copilot bring AI into analytics-engineering contexts.

**In practice:** you've used AI with read-only or disposable data access to explore a schema or draft a query or migration, then reviewed and tested any state-changing operation separately.

## Multi-agent workflows

### 29. Sandboxed, least-privilege environments for agent execution

Coding agents execute repository code, package scripts, MCP tools, and network requests, so prompt injection or a compromised dependency can affect more than the generated diff. Run autonomous work inside a dev container, VM, cloud sandbox, or restricted workspace with scoped credentials, limited write paths, and network allowlists. [Claude Code](https://code.claude.com/docs/en/security), [Codex](https://developers.openai.com/codex/agent-approvals-security), and [GitHub Copilot cloud agent](https://docs.github.com/en/copilot/concepts/agents/cloud-agent/about-cloud-agent) all provide isolation and permission controls that should be configured deliberately.

**In practice:** your agent runs inside a defined boundary without broad host or production credentials, network and write access are scoped, and destructive operations remain approval-gated.

### 30. Graduated autonomy inside bounded environments

Repeated approval prompts can make bounded agent work inefficient. Grant autonomy progressively inside a sandbox: allow known low-risk commands and paths, keep network destinations and credentials scoped, set time or action budgets and checkpoints, and require approval for privilege elevation, production access, publishing, deletion, or other irreversible actions. Do not use unrestricted host access as a shortcut for agent productivity. Methodologies like Agent OS provide conventions for longer-running work, but the controls must fit the actual risk.

**In practice:** you've tuned permissions inside a sandbox, measured fewer unnecessary interruptions, and preserved approval gates and auditability for high-impact actions.

### 31. Git worktrees for parallel features on one machine

Git worktrees let one repo host multiple isolated checkouts at once, so different agents or sessions can work on separate branches without overwriting each other's files. They do not isolate shared databases, ports, credentials, caches, or generated artifacts, so those resources need separate boundaries too. Parallel changes still require review and integration rather than blind merging.

**In practice:** you've got Git worktrees set up and a recent case where they paid off, like a long refactor running while you kept shipping feature work.

### 32. Parallel localhost service instances for integration and E2E tests

Integration and E2E tests are slow because services typically bind to fixed ports, forcing tests to run serially. Tools like Portless (or similar dynamic-port/domains on localhost) let multiple instances of the same stack run in parallel on one machine. This speeds up test suites and makes parallel agent work practical when each agent needs its own running services. .NET teams can also use Microsoft Aspire's isolated mode for the same pattern.

**In practice:** your local setup can run multiple service instances in parallel, and there's a test suite or workflow that actually uses it.

## Productivity and operations

### 33. Voice input for AI coding tools

Voice input removes the typing bottleneck for explaining context, describing bugs, walking through intent, and dictating specs, often where momentum gets lost. Several coding tools now support voice natively (for example, Claude Code's /voice command), and third-party dictation tools like Wispr Flow and Superwhisper layer on top of any coding tool. Pairing voice with agent mode lets you think out loud and have the agent act on it, which is especially effective for exploratory work, debugging narration, and long-form planning.

**In practice:** you've tried voice input with an AI coding tool and can name a moment where it beat typing — debugging narration, dictating a spec, or walking through a design.

### 34. Context engineering and token efficiency

Context is a finite attention budget, not a target to fill. Prefer concise scoped instructions, a minimal toolset, just-in-time retrieval, filtered command output, phase summaries, external artifacts, prompt caching, and model routing. Compression tools such as Headroom, Caveman, and RTK can help, but lossy compression may remove evidence the agent needs; keep originals retrievable and evaluate task quality as well as token savings. Output-side Skills like [Ponytail](https://github.com/DietrichGebert/ponytail) cut cost from the other direction, steering the agent to write only the code the task needs instead of over-engineered output.

**In practice:** you've measured cost, latency, and task success before and after a context change, and can show that the savings did not reduce correctness or hide important evidence.

### 35. Managing dependency upgrades and security patches

Dependency upgrades and security patches are repetitive, tedious work that tends to get deferred, which is exactly how CVEs pile up and breaking-change debt grows. AI is well-suited to this work because it can read changelogs, diff API changes, update call sites, run tests in a loop, and handle most of the mechanical work. Paired with automation tools like Dependabot, Renovate, or Snyk, upgrades become routine instead of risky.

**In practice:** you've shipped a dependency upgrade PR where AI handled the breaking changes, applied a security patch with AI triaging the CVE, or used AI to read changelogs and flag breaks in advance. Your upgrade workflow pairs Dependabot, Renovate, or Snyk with AI.

### 36. Incident response and on-call workflows

On-call work involves triage under time pressure, reading logs and traces quickly, spotting patterns, drafting communication, and writing up postmortems afterward. AI can correlate signals, propose hypotheses, draft runbooks, and turn raw notes into a postmortem. Keep access read-only during investigation where possible, preserve an audit trail, and require an accountable human to approve production changes and external communication. Platforms like Rootly, incident.io, and PagerDuty integrate AI into these workflows directly.

**In practice:** you've had AI help with triage, signal correlation, runbook drafting, turning raw notes into a postmortem, or cutting alert noise.

### 37. Scheduled and event-driven agent automation

Reusable Skills still depend on someone remembering to run them. Scheduled or event-driven agents can triage incoming issues, investigate failing CI, prepare release notes, check documentation drift, or open bounded maintenance PRs without a manual prompt each time. [GitHub Copilot automations](https://docs.github.com/en/copilot/concepts/agents/cloud-agent/about-automations) and [Codex automations](https://developers.openai.com/codex/app/automations) support these workflows. Unattended runs should be sandboxed, narrowly scoped, observable, budget-limited, idempotent where possible, and configured to produce reviewable drafts rather than silently making consequential changes.

**In practice:** at least one agent workflow runs on a schedule or repository event and produces a draft PR, issue update, or report that a human reviews before consequential changes land.

## Harness and context engineering

The items above are the building blocks of a harness. The ones below are about engineering it: tuning the loop, verifying output you can't trust on the agent's word, and giving the agent better ways to see and remember a large codebase. Reach for these when a single agent in a plain loop stops being enough — long autonomous runs, big repos, or work that outlives one session.

### 38. Loop engineering: designing the agent loop, not just prompting it

Item 8 is the basic loop — edit, build, test, repeat. Loop engineering treats that loop as the thing you design: what the agent does each turn, what signal it reads, how it self-corrects, and, critically, when it stops. Set explicit stop conditions and turn or token budgets, decide what counts as progress, and shape the feedback the loop runs on so a long autonomous run converges instead of thrashing or declaring victory early. Agent SDKs and orchestration frameworks help, but the loop's stop conditions and feedback are yours to design regardless of framework.

**In practice:** you've tuned an agent's loop — stop conditions, turn or token budget, what feedback it acts on each iteration — and a long unattended run finished cleanly because of it, not in spite of it.

### 39. Independent verification: the agent does not grade its own work

An agent reviewing its own output almost always approves it, so "the agent says it's done" is not a signal. Put the check where the agent cannot reach it: make the merge gate CI it cannot edit, or run review in a fresh context that never saw the code get written. This is cheap day to day — pipe the diff to a second agent (`git diff | <agent> -p "review this against the spec, list what's wrong"`), use a reviewer sub-agent, or let CodeRabbit or Greptile gate the PR. The point is separation: the reviewer is not the context that wrote the code.

**In practice:** before agent work is accepted, a pass it can't influence has to sign off — CI it can't edit, a fresh-context review of the diff, or a reviewer sub-agent — and you've caught a confidently-wrong "done."

### 40. Code intelligence for the agent, beyond grep

Agents edit more accurately when they can resolve symbols, types, and references instead of pattern-matching text. Give the agent code intelligence — a Language Server (go-to-definition, find-references, type information), tree-sitter or AST tools, and semantic search over the repo — so edits are grounded in real structure rather than string matches. This cuts edits that compile-break, miss call sites, or hallucinate APIs, and it helps in any repo, not just large ones.

**In practice:** your agent has more than text search available — an LSP, semantic code search, or AST tooling — and you can point to an edit it got right because it resolved references instead of grepping for them.

### 41. Code graphs and structural memory for large codebases

On giant repos, grep-and-read stops scaling: the agent burns tokens hunting for things and still misses cross-file relationships. When classical retrieval breaks down, pre-index the codebase into a code graph — functions, classes, imports, call chains — that the agent queries over MCP, answering "what calls this?" in a few hundred tokens instead of tens of thousands. Open source here is moving fast: [CodeGraph](https://github.com/colbymchenry/codegraph), [codebase-memory-mcp](https://github.com/DeusData/codebase-memory-mcp), [CodeGraphContext](https://github.com/CodeGraphContext/CodeGraphContext), and [Potpie](https://github.com/potpie-ai/potpie) build local graphs over tree-sitter and LSP, while [Sourcegraph SCIP](https://github.com/sourcegraph/scip) and [stack-graphs](https://github.com/github/stack-graphs) are mature indexing formats. Use this when repo size, not model capability, is the bottleneck; a small repo does not need it.

**In practice:** on a repo too large for grep-and-read to be cheap, your agent queries a precomputed code graph for structure, and you measured the drop in tokens or tool calls versus letting it search files.

### 42. Continuity across context resets

Even with million-token windows, long runs degrade: cost climbs, attention rots in the middle of very large contexts, and sessions still end through crashes, new chats, or handoffs between agents. For multi-session work, carry state in a durable artifact — a progress or plan file the agent updates and re-reads — and prefer a clean context with a structured handoff over silently summarizing history in place. This is a long-horizon tactic, not something every task needs; most single-session work fits comfortably in a modern context window.

**In practice:** a task that spanned multiple sessions or context resets stayed on track because state lived in a file the agent re-read, not only in conversation history.

#### Further reading

- [Anthropic — Harness design for long-running agent applications](https://www.anthropic.com/engineering/harness-design-long-running-apps)
- [Martin Fowler — Harness engineering for coding agents](https://martinfowler.com/articles/harness-engineering.html)
- [LangChain — The Anatomy of an Agent Harness](https://www.langchain.com/blog/the-anatomy-of-an-agent-harness)
- [Sebastian Raschka — Components of a Coding Agent](https://magazine.sebastianraschka.com/p/components-of-a-coding-agent)

## Policy-compliant AI use

### 43. AI tools compliant with policy and security guidelines

Using only approved AI tools protects company data and keeps AI usage within policy.

IMPORTANT: Check your organization's AI use policy.

**In practice:** you know which AI tools are approved for your work, you're not using anything outside that list, and your IDE/CLI is signed into the enterprise account.

### 44. Token usage and limits understood

Large prompts and connected tools can waste quota and silently degrade results. At the same time, deeper AI usage naturally consumes more tokens, which is expected, and the goal is value per token, not maximizing tokens used.

**In practice:** you know your budget and limits, and you know where to see usage per tool.

## Agentic Coding Toolbox

### AI coding agents

- [Claude Code](https://claude.com/claude-code) - Anthropic's agentic coding CLI and IDE integration.
- [Cursor](https://cursor.com) - AI-first code editor.
- [Codex](https://github.com/openai/codex) - Agentic coding from OpenAI.
- [GitHub Copilot](https://github.com/features/copilot) - GitHub's AI pair programmer.
- [Gemini CLI](https://github.com/google-gemini/gemini-cli) - Google's Gemini CLI.
- [Windsurf](https://windsurf.com) - AI editor.
- [Cline](https://cline.bot/) - Open source coding AI agent.
- [OpenCode](https://github.com/anomalyco/opencode) - Open-source coding agent for the terminal, desktop, and IDE.

### Agent instructions and Skills

- [AGENTS.md](https://agents.md/) - Open format for repo-level agent instructions.
- [Anthropic Skills](https://github.com/anthropics/skills) - Anthropic's public collection of reusable Agent Skills.
- [Superpowers](https://github.com/obra/superpowers) - Composable Skills framework with sub-agent patterns.
- [Context7](https://github.com/upstash/context7) - Up-to-date library documentation for AI agents, loadable selectively.
- [GSD (Get Sh*t Done)](https://github.com/gsd-build/get-shit-done) - Meta-prompting, context-engineering, spec-driven Skills system for Claude Code.
- [Skills.sh](https://skills.sh/) - The Open Agent Skills Ecosystem from Vercel.
- [claude-mem](https://github.com/thedotmack/claude-mem) - Persistent, compressed context carried across coding-agent sessions.

### Agent SDKs and multi-agent frameworks

- [Hermes Agent](https://github.com/nousresearch/hermes-agent) - Self-improving agent framework with procedural memory and multi-platform deployment (Nous Research).
- [Agent OS](https://github.com/buildermethods/agent-os) - Opinionated methodology for long-running autonomous agents.
- [Claude Agent SDK](https://github.com/anthropics/claude-agent-sdk-python) - Anthropic's SDK for building sub-agents and orchestrated workflows.
- [OpenAI Agents SDK](https://github.com/openai/openai-agents-python) - Lightweight multi-agent orchestration with handoffs and tracing.
- [great_cto](https://github.com/avelikiy/great_cto) - Multi-agent automation framework with coding pipelines, compliance reviewers, and human gates for consequential actions.
- [OpenClaw](https://github.com/openclaw/openclaw) - Open-source local-first AI assistant with multi-channel messaging, voice, and Canvas workspaces.

### Spec-driven development

- [Spec Kit](https://github.com/github/spec-kit) - GitHub's toolkit for spec-driven development with AI agents.
- [Kiro](https://kiro.dev) - AWS's spec-first IDE.
- [Tessl](https://tessl.io) - Spec-centric development platform.
- [BMAD-METHOD](https://github.com/bmad-code-org/BMAD-METHOD) - Also fits spec-first: agile AI-driven development organized around spec/brief artifacts.

### Documentation and ADR tooling

- [Mintlify](https://mintlify.com) - AI-assisted docs platform for developer documentation.
- [MADR](https://github.com/adr/madr) - Markdown ADR template.
- [log4brains](https://github.com/thomvaill/log4brains) - CLI and static site generator for ADRs.
- [adr-tools](https://github.com/npryce/adr-tools) - Shell-based toolchain for creating and numbering ADRs.

### AI code review

- [CodeRabbit](https://coderabbit.ai) - AI code review bot for GitHub/GitLab PRs.
- [Greptile](https://greptile.com) - AI code reviewer with repo-wide context.
- [PR-Agent](https://github.com/The-PR-Agent/pr-agent) - Community-maintained open-source agent for PR descriptions, reviews, and walkthroughs.
- [Ellipsis](https://ellipsis.dev) - AI reviewer with auto-fix capability.

### Agent observability and evaluation

- [OpenAI Agent Evals](https://developers.openai.com/api/docs/guides/agent-evals) - Traces, graders, datasets, and evaluation runs for agent workflows.
- [Langfuse](https://github.com/langfuse/langfuse) - Open-source tracing, prompt management, and evaluation platform for LLM applications.
- [Arize Phoenix](https://github.com/Arize-ai/phoenix) - Open-source observability and evaluation for AI applications and agents.

### Codemods and refactoring

- [Grit](https://getgrit.io) - Query language and CLI for AI-assisted codemods.
- [jscodeshift](https://github.com/facebook/jscodeshift) - Meta's AST codemod toolkit for JavaScript and TypeScript.
- [Comby](https://comby.dev) - Language-agnostic structural search-and-replace for multi-file refactoring.
- [Awesome Codemods](https://github.com/rajasegar/awesome-codemods) - A large collection of codemods.

### Testing and AI-native browser automation

- [Playwright](https://playwright.dev) - Cross-browser E2E framework.
- [Pact](https://pact.io) - Consumer-driven contract testing for service integration.
- [Diffblue Cover](https://www.diffblue.com) - AI unit test generator for Java/JVM.
- [Trunk Flaky Tests](https://trunk.io/products/flaky-tests) - Detect, quarantine, and track flaky tests across CI.
- [Maestro](https://github.com/mobile-dev-inc/Maestro) - Declarative E2E automation for mobile and web applications.
- [Browserbase Stagehand](https://github.com/browserbase/stagehand) - AI-native browser automation layered on Playwright.
- [Browser Use](https://github.com/browser-use/browser-use) - Open-source library that lets LLMs drive real browsers.
- [Anthropic Computer Use](https://docs.anthropic.com/en/docs/agents-and-tools/computer-use) - Claude's screen, keyboard, and mouse control for agent-driven UI automation.

### MCP Servers

- [MCP Registry](https://registry.modelcontextprotocol.io/) - Official registry for discovering published MCP servers.
- [MCP Reference Servers](https://github.com/modelcontextprotocol/servers) - Educational reference implementations; evaluate and harden them before production use.
- [Awesome MCP Servers](https://github.com/punkpeye/awesome-mcp-servers) - Community-curated collection of MCP servers.
- [GitHub MCP](https://github.com/github/github-mcp-server) - Official GitHub MCP server.
- [Playwright MCP](https://github.com/microsoft/playwright-mcp) - Browser automation MCP from Microsoft.
- [Figma MCP](https://www.figma.com/) - Figma's developer MCP for design tokens and canvas access.

### Database and data tools

- [Chat2DB](https://github.com/OtterMind/Chat2DB) - AI-assisted SQL client supporting major relational and analytical databases.

### Observability and incident response

- [Rootly](https://rootly.com) - Incident platform with AI agents for investigation and retrospectives.
- [Kagent](https://github.com/kagent-dev/kagent) - CNCF Kubernetes-native framework for building and operating agents with tools for Kubernetes, Prometheus, Grafana, Istio, Helm, and other cloud-native systems.
- [incident.io](https://incident.io) - On-call and incident platform with AI summaries and investigation copilots.
- [PagerDuty AIOps](https://www.pagerduty.com) - AI-driven alert noise reduction and incident automation.
- [Sentry](https://sentry.io) - AI-assisted root-cause analysis with an MCP server for agent queries.
- [ccusage](https://github.com/ccusage/ccusage) - Local usage and cost analysis for Claude Code and other coding agents.
- [agenttrace](https://github.com/luoyuctl/agenttrace) - Local-first TUI for inspecting AI coding agent session cost, tokens, time, and slow-run diagnostics.

### Local development

- [Portless](https://github.com/vercel-labs/portless) - Stable named URLs for localhost services, worktree-aware (Vercel Labs).
- [Microsoft .NET Aspire](https://learn.microsoft.com/en-us/dotnet/aspire/) - Isolated multi-service local dev/test stacks for .NET.

### Voice input

- [Wispr Flow](https://wisprflow.ai) - AI dictation app for macOS and Windows.
- [Superwhisper](https://superwhisper.com) - macOS voice-to-text built on Whisper-family models.

### Token optimization

- [Headroom](https://github.com/chopratejas/headroom) - Local-first, reversible compression for agent context, tool outputs, logs, files, RAG chunks, and conversation history; available as a library, proxy, wrapper, or MCP server.
- [Caveman](https://github.com/JuliusBrussee/caveman) - Agent response compression (~70% output token reduction).
- [RTK](https://github.com/rtk-ai/rtk) - CLI proxy for input token filtering on common dev commands.

### Dependency and security automation

- [Dependabot](https://github.com/dependabot) - GitHub's dependency update bot.
- [Renovate](https://github.com/renovatebot/renovate) - Cross-platform dependency update tool.
- [Snyk](https://snyk.io) - Security platform with AI-assisted fix suggestions for vulnerable dependencies.
- [Trivy](https://github.com/aquasecurity/trivy) - Vulnerability, misconfiguration, secret, and SBOM scanner for repositories and infrastructure.
- [Gitleaks](https://github.com/gitleaks/gitleaks) - Secret scanner for repositories, files, and commit history.

## Contributing

Contributions are welcome. Read the [contribution guidelines](CONTRIBUTING.md) before proposing a roadmap item or Toolbox entry. The roadmap is kept intentionally short and practical, so additions should be actively maintained, clearly useful, and grounded in a concrete engineering workflow.
