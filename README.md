# Personal Roadmap for AI Adoption

A developer's roadmap for agentic coding adoption. Use this as a personal growth framework and mentorship guide to deepen your use of AI coding tools beyond basic prompting.

## Table of contents

- [AI tools use in a policy-compliant way](#ai-tools-use-in-a-policy-compliant-way)
- [AI coding basics](#ai-coding-basics)
- [Spec-first work](#spec-first-work)
- [Agents instructions and code repository context handling](#agents-instructions-and-code-repository-context-handling)
- [Testing and quality](#testing-and-quality)
- [Tool integrations and MCP](#tool-integrations-and-mcp)
- [Multi-Agent Workflows and Advanced Use Cases](#multi-agent-workflows-and-advanced-use-cases)

---

## AI tools use in a policy-compliant way

### 1. All AI tools are compliant with company policy and security guidelines

**Why this is important?** Engineers must understand the importance of following security guidelines and using only approved tools. This protects company data and keeps AI usage within policy. Approved AI tools are helping collect and analyze the engineer's needs based on usage statistics, and in case of non-enterprise accounts the usage stats typically isn't included in AI tools adoption reportings.

IMPORTANT: Ask your manager for the AI Use Policy on your particular project.

**Evidence:** the engineer can describe which tools are allowed, confirm that they do not use tools outside the approved list, and demonstrate that they are signed into the enterprise/company account in the IDE/CLI client using the proper GitHub ID or ClaudeCode ID

### 2. Token usage and limits are understood

**Why this is important?** Large prompts and connected tools can waste quota and silently degrade results. At the same time, engineers going deeper with AI will naturally consume more tokens - that is expected.

The goal is to be aware about the value per token, not maximizing tokens usage.

**Evidence:** engineer can explain budget and limits, and show where usage information is visible per AI tools.

---

## AI coding basics

### 3. AI is used for codebase navigation and understanding

**Why this is important?** A large part of engineering time is navigation and code comprehension, not code writing. AI is useful to explore the code and understand how it works faster.

**Evidence:** Recent example where AI helped explain a flow, identify affected files, or speed up onboarding into an unfamiliar area.

### 4. Planning mode is used before coding starts

**Why this is important?** Using AI for planning your work before writing code helps reduce blind edits and improves first-pass quality for larger changes.

**Evidence:** prompt history, a plan, a spec draft, or a transcript showing that planning happened before the feature implementation started.

### 5. Agent mode is used for code generation, not autocomplete or pure chat

**Why this is important?** Agent mode can inspect files, edit code, run commands, reason across steps, and complete larger tasks end-to-end. This is a different level of leverage than asking isolated code generation requests in chat or relying on line by line autocomplete.

**Evidence:** Demonstrated example where the agent changed several files, executed commands, or completed a task with multiple steps.

### 6. AI is used for managing branches, generating the PR summaries and explanation of changes

**Why this is important?** This improves reviewer speed, handoff quality, and the readability of technical changes in PRs

**Evidence:** Recent Pull Request where the summary, or change explanation drafted with AI help.

### 7. Both IDE/desktop and CLI AI agents have been tried

**Why this is important?** Different tasks suit different interfaces. IDE-integrated tools are great for inline edits, quick assistance, and working through extensive code review. CLI agents are better for repo-wide changes, multi-file edits, grep/search-driven exploration, scaffolding, scripted flows, and terminal-heavy work. Trying both lets engineers pick the right tool for each task rather than forcing one interface into every situation.

**Evidence:** engineer has real recent examples of using both IDE and CLI agents, and can explain which fits which kind of work based on their own experience.

### 8. AI is used for refactoring and cleaning up existing code

**Why this is important?** A large share of engineering time goes into improving code that already works - extracting, renaming, simplifying, removing duplication, cleaning up legacy code. AI is very effective for this kind of work, and engineers who only apply AI to new features miss a big part of its value.

**Evidence:** recent example of a refactor done with AI assistance like extracting a function, simplifying a component, cleaning up legacy code, or improving readability across several files.

### 9. AI is used for self code review before submitting PRs

**Why this is important?** AI review catches issues earlier, improves diff quality before a human reviewer sees it, and helps engineers give better feedback on others' code. This reduces review cycles and raises the quality of what lands in main.

**Evidence:** recent PR where the engineer ran an AI review pass on their own changes before requesting human review, or a review comment on a teammate's PR informed by AI analysis.

### 10. AI is used in an agentic loop that includes build, static analysis, and automated tests

**Why this is important?** The strongest way to use an agent is to let it close its own feedback loop - make a code change, compile, run static analysis, run unit tests, read the failures, adjust, and repeat until green. This is how the agent catches its own mistakes (including hallucinated functions or incorrect types) and produces code that is verifiably working rather than only plausible. Engineers who operate this way trust the output more and get dramatically more done than those who review one-shot outputs by hand.

**Evidence:** recent task where the engineer set up or used an agentic loop where the agent ran build, linter, and tests and iterated on its own output until feedback was green not a single-shot code generation.

### 11. AI is used to create and maintain technical documentation

**Why this is important?** AI is effective for drafting and updating READMEs, module docs, API references, setup guides, and onboarding notes. Up-to-date documentation improves team velocity and also gives AI agents better context to work from in future sessions.

**Evidence:** recent README, module doc, API reference, or setup guide created or updated with AI help.

---

## Spec-first work

### 12. Task brief or spec files are created before the implementation of larger features

**Why this is important?** The better specs are built as the input artifacts for AI agents, and those are used to get the better agent output and makes it easier to review the implementation. This turns "build X" into an executable plan instead of jumping directly into code generation.

**Evidence:** Jira ticket with a markdown spec, or a design note used as agent input, together with execution steps, an implementation plan, or an acceptance checklist created with AI.

### 13. AI is used to generate detailed requirements for a comprehensive UX and explain various happy and failure paths

**Why this is important?** Corner cases are exactly what gets missed when AI is used only for happy-path code generation. AI can help reduce risk and improve the readiness of the feature across real-world scenarios.

**Evidence:** Prompts history or a checklist that covers happy path, error states, corner cases, and the approach to comprehensive feature implementation.

### 14. AI is used for architecture and design-level decisions for the feature

**Why this is important?** Before implementation, engineers often face design choices - data model shape, API boundaries, tradeoffs between approaches. AI helps reason through options and write them down, so the choice is explicit and reviewable during the code review. This sits one level above the feature spec and helps build the feature in the right way.

**Evidence:** recent design note, or tradeoff analysis produced with AI help as input to a design discussion or technical review.

### 15. AI is used to create ADRs and update architecture documentation for the whole codebase

**Why this is important?** Architecture docs and ADRs often rot or get skipped because they feel heavy to write. AI makes it fast to draft, update, and keep them accurate as the system evolves, so new teammates and AI agents have reliable context for future decisions.

**Evidence:** recent architecture document or ADR entry created or updated in the repo with AI help.

---

## Agents instructions and code repository context handling

### 16. Agent instructions are committed in the repo

**Why this is important?** source repository context improves agent onboarding, repeatability of work, and code-wide quality.

**Evidence:** files such as AGENTS.md, GitHub Copilot instruction folders, CLAUDE.md, or equivalent repo-visible guidance

### 17. Repeated tasks and reusable commands are documented in the form of custom Skills

**Why this is important?** Skills help teams move from ad-hoc prompting to full automation of their day to day typical workflows. You can define your own custom agent skills and/or use the skill frameworks to cover the common automation scenarios.

**Evidence:** a reusable instructions for build automation, feature scaffolding, dependency updates, PR prep, test generation, workflows for bug triage or similar repeatable work

### 18. Skills frameworks are used

**Why this is important?** Look at Context7 for reusable agent instructions for majority of languages, libraries. Skills frameworks like Superpowers that allows composability and sub-agents.

**Evidence:** examples of use for Context7, Superpowers or similar skills frameworks.

### 19. Sub-agents are used to delegate parallel or scoped subtasks

**Why this is important?** Complex tasks are often made of independent sub-problems - exploring one area while drafting another, running a search in parallel with an edit. Most modern coding AI tools can spawn sub-agents (for example Claude Code's Task/Agent tool, background agents, parallel sessions in Cursor, or terminal-spawned parallel CLI agent sessions) to keep the main context clean and complete work faster.

**Evidence:** recent session where the engineer spawned one or more sub-agents for exploration, research, or an independent subtask, and can explain how that was more effective than a single-agent approach.

---

## Testing and quality

### 20. AI is used to generate or improve unit tests

**Why this is important?** AI helps improve the unit tests coverage, reducing the time spend for unit testing and avoiding the situation when unit tests are skipped.

**Evidence:** recent PR where code changes came with unit tests added or improved through AI

### 21. AI is used for integration tests, E2E tests, fixtures, and realistic test data

**Why this is important?** Integration tests offer the highest leverage in controlling the quality of the code changes and catching regressions. Engineers can plan the integration tests suite with e2e tests, fixtures and seed data to cover the all major behaviours of the feature under development. AI coding agents can be also used to evaluate the quality of the tests and improve the coverage.

**Evidence:** Generated fixtures, test datasets, mocks, seed data generation scripts with integration tests that use all that

### 22. Browser/device automation is used for testing and UI interaction

**Why this is important?** Browser/device automation unlocks a practical workflow for UI validation, screenshot capture, regression checks, and turning test cases in English into tests automation scripts that can be run on developer's machine and on CI/CD

**Evidence:** Browser-based script or mobile device simulator control script example, screenshot validation run, or generated UI automation from a written scenario

### 23. AI is used to debug failing tests and flaky behavior

**Why this is important?** AI is good at narrowing hypotheses, reading logs, and suggesting the minimal targeted fixes to resolve flaky tests and improve the predictability of your CI/CD pipelines.

**Evidence:** recent failing test investigation or flaky test fix with AI involvement

---

## Tool integrations and MCP

### 24. MCP servers are connected and used

**Why this is important?** Connected tools make agents much more useful than plain chat, and MCP servers give access to data and external systems. Popular examples engineers can start with: browser-control MCP for web automation, Figma MCP for designs, PostgreSQL MCP for database access, GitHub MCP for repo and PR operations. When MCP is not available for a given system, Skills, vendor SDKs, or CLI scripts can play a similar role.

**Evidence:** engineer has some configured MCP/tools and can talk about the recent task done through connected tools

### 25. AI is used to inspect logs, API responses, and data snapshots safely

**Why this is important?** AI can help debugging and support work based on the actual data pulled for troubleshooting.

**Evidence:** recent investigation using logs, API output, traces, or snapshots from QA/prod or CI/CD pipeline research

### 26. AI is used to explore databases, model data, query, and generate migrations

**Why this is important?** Engineer can write the single-purpose tool for troubleshooting issues with data or analyzing data coming from production support. AI agents can help write queries, understanding schemas, preparing test data to reproduce the problems. AI combined with database access (via MCP, Skills, or CLI scripts) turns manual troubleshooting into a semi-automated workflow.

**Evidence:** recent prod support tickets where the engineer used AI to write or explain a SQL query, explore a schema, design a new data model, or draft a migration script to address the production issue.

---

## Multi-Agent Workflows and Advanced Use Cases

### 27. Voice input is used to work with AI coding tools

**Why this is important?** Voice input removes the typing bottleneck for explaining context, describing bugs, walking through intent, and dictating specs - often where engineers lose momentum. Several coding tools now support voice natively (for example, Claude Code's /voice command), and third-party dictation and realtime voice tools can be layered in. Engineers who pair voice with agent mode can think out loud and have the agent act on it, which is especially effective for exploratory work, debugging narration, and long-form planning.

**Evidence:** engineer has tried voice input with an AI coding tool and can describe a situation where it was a better fit than typing - for example, narrating a debugging session, dictating a spec, or walking through a design.

### 28. Permissions are expanded to enable more autonomous agent work

**Why this is important?** Default permission settings are conservative, and agents ask for confirmation on most actions. As engineers gain trust in their tools and set up good guardrails (agentic loops, version control, sandboxes), they can safely grant broader permissions so the agent can work longer without interruption. This unlocks long refactors, overnight runs, and multi-step automation.

**Evidence:** engineer has tuned permission settings for their tool (approved command lists, auto-accept scopes, trust rules), and can walk through a recent task that benefited from the broader trust envelope.

### 29. Git worktrees are used to run multiple features or branches in parallel on one machine

**Why this is important?** Git Worktrees let one repo host multiple isolated checkouts at once, so different agents or sessions can work on different features, in multiple branches simultaneously without conflicting changes. This multiplies throughput - one agent can refactor in one worktree while another implements a feature in a second, and tests run in a third.

**Evidence:** engineer has set up git worktrees and can describe a recent case where parallel worktrees helped - for example, running a long refactor while continuing work on a separate feature.

### 30. Parallel service instances run on localhost for parallel integration and E2E tests

**Why this is important?** Integration and E2E tests are slow because services typically bind to fixed ports, forcing tests to run serially. Tools like Portless (or similar dynamic-port/domains on localhost) let multiple instances of the same stack run in parallel on one machine. This speeds up test suites and makes parallel agent work practical when each agent needs its own running services.

**Evidence:** engineer has configured their local environment to run multiple instances of the same services in parallel to allow multiple AI agents run full agentic loop locally.

### 31. Token usage is actively optimized with compression and filtering tools

**Why this is important?** Deep AI usage naturally grows token expense. Engineers can reduce it dramatically with dedicated tools: Caveman (https://github.com/JuliusBrussee/caveman) compresses agent responses by stripping filler and hedging, cutting output tokens by about 70% on average across Claude Code, Cursor, Copilot, Gemini CLI, Windsurf, and others. RTK (https://github.com/rtk-ai/rtk) is a CLI proxy that auto-filters verbose outputs from git, tests, builds, and container commands before the agent reads them, saving 60-90% on input tokens.

**Evidence:** engineer has tried Caveman, RTK, or an equivalent token-optimization tool, or applies concrete practices — prompt caching, tight context, model-per-task selection — and can point to a measurable reduction.
