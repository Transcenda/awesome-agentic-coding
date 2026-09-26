# Awesome Agentic Coding [![Awesome](https://awesome.re/badge.svg)](https://awesome.re)

<!--lint disable double-link-->

This roadmap helps teams build up their coding agent harness step by step, from everyday work with agents to specs, Skills, hooks, MCP, fleets of parallel agents, and harness and context engineering for long-running agents.

## Contents

- [Working with AI agents](#working-with-ai-agents)
- [Spec-first work](#spec-first-work)
- [Agent instructions, Skills, and tools](#agent-instructions-skills-and-tools)
- [Testing and quality engineering](#testing-and-quality-engineering)
- [Parallel agents and autonomous execution](#parallel-agents-and-autonomous-execution)
- [Harness and context engineering](#harness-and-context-engineering)
- [Security, maintenance, and policy](#security-maintenance-and-policy)
- [Agentic Coding Toolbox](#agentic-coding-toolbox)


## Working with AI agents

### 1. Codebase navigation and a committed repo map

Use the agent to navigate and explain unfamiliar code, then keep what it learned: a repo map with directories, entry points, and build and test commands. Check it against the code, since agents state guesses with confidence, and commit it so the next session starts from the map.

**In practice:** an agent-written repo map or architecture note is committed and kept current, and a later session started from it instead of re-exploring.

### 2. Agentic loop with build, static analysis, and automated tests

Let the agent run its own loop: change code, build, run static analysis and tests, read the failures, fix, repeat. Put build, lint, and tests behind one command that finishes in minutes and gives the same result every run. Set an iteration limit, and read the final diff, because an agent pushed to get green will weaken tests, accept wrong snapshots, or skip guardrails.

**In practice:** build, lint, and tests run with one command in minutes; the agent loops on them with a set limit; the final diff shows no weakened tests, snapshots, or guardrails.

### 3. Independent AI code review before human review

An agent approves its own code, so its "done" is not a signal. Before a human reads a diff, a context that did not write it reviews the diff against the spec: a reviewer sub-agent, a second agent, or a PR bot such as CodeRabbit or Greptile. Keep the merge gate out of the agent's reach with required CI checks and branch protection.

**In practice:** every agent diff is reviewed against the spec by a context that didn't write it and passes CI the agent can't edit before a human sees it, and this has caught a confident but wrong "done" at least once.

### 4. Refactoring and cleanup on every PR and on a schedule

Agents write a lot of code and refactor almost none of it, so cleanup has to be deliberate. Include the cleanup a change exposed in the same PR, and run a scheduled agent that opens small cleanup PRs (#19). For structural changes across the repo, use codemod tools like ast-grep, GritQL, jscodeshift, and Comby, and let the tests verify the result.

**In practice:** you've shipped agent-driven cleanup such as a real refactor, dead code removal, or merged duplication, and cleanup runs with every PR and on a schedule.

## Spec-first work

### 5. Approved plan with acceptance criteria before coding starts

For anything non-trivial, the agent proposes a plan with acceptance criteria and edits nothing until you approve it. Change the plan when the code, tool output, or tests show something new. For anyone who builds without reading the code, the approved plan is the contract.

**In practice:** you approved a plan with acceptance criteria before the agent edited code, updated it after feedback from the repo or tests, and kept the final scope easy to review.

### 6. Specs with explicit design decisions and acceptance criteria

The spec is the main artifact a human still writes and decides what the agents build. Cover the happy path, error and edge cases, acceptance criteria, and the design decisions: data model, API boundaries, options considered and why one won. Update the spec when the implementation proves the design wrong. Spec Kit, Kiro, Tessl, and BMAD-METHOD give this a repeatable flow.

**In practice:** you've written a spec in markdown with the happy path, error cases, acceptance criteria, and design decisions with their trade-offs, and given it to agents as input.

### 7. Documentation and ADRs

Docs are what the next agent reads before it touches the code, and [AI-accessible internal documentation](https://dora.dev/ai/roi/report/) is one of the foundations that decide whether AI pays off. Have the agent update READMEs, API references, and onboarding guides in the same PR as the change, write an ADR for every non-trivial decision, and flag stale docs on a schedule (#19).

**In practice:** you've written or updated a README, API reference, onboarding note, or ADR with an agent in the same PR as the change, and kept it current.

## Agent instructions, Skills, and tools

### 8. Agent instructions committed in the repo

Instructions checked into the repo make agents start faster. Keep them short, scoped to the directory or workflow they apply to, and current; stale or conflicting rules make the agent less reliable. Someone owns them and deletes rules that no longer hold.

**In practice:** your repo has an AGENTS.md, CLAUDE.md, Copilot instructions, or similar guidance that agents actually read, and someone owns keeping it short and current.

### 9. Turning repeated agent mistakes into durable knowledge and memory

Agents repeat the same wrong command or miss the same convention in the next session. When a lesson holds, put it where every agent re-reads it: the repo instructions, a Skill, or shared agent memory. Delete it when it stops applying. [Headroom's `learn`](https://github.com/headroomlabs-ai/headroom) and [GitHub Copilot Memory](https://docs.github.com/en/copilot/concepts/agents/copilot-memory) help capture this.

**In practice:** after a failed task or a review correction, you've saved a reusable lesson in AGENTS.md, CLAUDE.md, a Skill, or agent memory, and a later task used it.

### 10. Deterministic hooks around agent actions

An agent may ignore an instruction, so guardrails should not depend on it. Hooks block tool calls, run formatters and tests after edits, and stop a task before the required checks pass. [Claude Code hooks](https://code.claude.com/docs/en/hooks) and [Codex hooks](https://developers.openai.com/codex/hooks) provide them.

**In practice:** your repo has at least one hook, checked into version control, that blocks a forbidden action or runs a formatter, linter, test, or audit after the agent makes changes.

### 11. Skills for repeated workflows, own and third-party

A Skill turns a repeated workflow into something every agent on the team runs the same way: a SKILL.md the agent loads only when the task needs it, in an open format that works across agents. Write your own for build steps, scaffolding, and PR prep. Load reviewed third-party Skills such as Context7 or Superpowers, pin them, and skip large frameworks unless they clearly beat a simpler setup.

**In practice:** you can point to a SKILL.md in your repo that you wrote and use, name at least one external Skill or docs source you load on purpose, and name one you looked at and chose not to install.

### 12. MCP servers

MCP connects an agent to data and external systems through an open standard. A CLI, a script, or a Skill is often simpler and cheaper in tokens, so use MCP when you need a structured tool contract, an auth boundary, or shared access. Treat every server as code you run with your access: use official or reviewed servers, pin the version, turn off tools and scopes you don't need, and keep destructive actions behind an approval.

**In practice:** you've got at least one reviewed MCP server in use, you can explain its credentials and permissions, you've turned off tools or scopes you don't need, and at least once you chose a CLI or Skill instead of MCP because it was simpler.

### 13. Troubleshooting with scoped, read-only data access

An agent that can see the real logs, traces, CI snapshots, and database schemas troubleshoots; one that can't guesses. Give it scoped, read-only or throwaway access by default, with secrets and personal data stripped before they reach the model, and keep production writes and migrations behind an explicit approval. Sentry and Grafana expose telemetry to agents; DBHub gives scoped database access.

**In practice:** you've troubleshot from real logs, traces, or snapshots with scoped read-only access, or explored a schema and drafted a query or migration, and reviewed and tested any change that writes data separately.

## Testing and quality engineering

### 14. Generating and hardening tests from requirements

More agent-written code means more defects unless the tests grow with it. Have agents write unit, integration, contract, and E2E tests. Write them from the requirements and observed behavior, never from the code the agent just wrote, because a test that mirrors the implementation hides the same bug. Harden them with mutation testing, and use fake or masked data only.

**In practice:** an agent wrote or improved more than one kind of test in a shipped PR, generated the fixtures, and you've shown the tests can fail, with a mutation run or a deliberate bug they caught.

### 15. Browser and device automation for verifying UI changes

An agent that changes a screen should look at the screen. Give it Playwright MCP, Chrome DevTools MCP, or a simulator so it clicks through the flow and reads console and network errors before it says done. Turn checks worth repeating into Playwright or Maestro scripts in CI. Use vision-based computer control only where nothing else reaches.

**In practice:** the agent verifies its own UI changes in a real browser or simulator before it says done, and the repeatable checks run as Playwright or Maestro scripts in CI.

### 16. Evals and regression tests for the agent workflow

Product tests check the code an agent wrote; evals check the workflow that wrote it. Build a small dataset from real tasks and past failures, and re-run it whenever the model, prompts, or tools change. Agent behavior varies between runs, so compare several runs instead of trusting one demo.

**In practice:** you've recorded a real agent run, turned at least one failure into a repeatable eval case, and used it to catch a regression or justify a change to the workflow.

## Parallel agents and autonomous execution

### 17. Parallel sub-agents with worktree isolation and deliberate merges

Parallel sub-agents pay off when the work splits cleanly into parts that each fit one context window. Give each agent one goal and a defined output, and take back a summary, not a transcript. Worktrees give each agent its own checkout and branch; databases, ports, credentials, and caches need their own boundaries, which Portless or Aspire's isolated mode provide. Merge deliberately: rebase, run the full checks per branch, and review each result (#3). Your review capacity sets the useful fleet size.

**In practice:** you've run parallel sub-agents in local worktrees or the cloud, each with one goal and a defined output, isolated down to ports and databases, and can say where the split paid off and where it didn't.

### 18. Sandboxing and granting autonomy gradually

A coding agent runs repo code, package scripts, and network requests. Run it in a dev container, VM, or cloud sandbox with scoped credentials, limited write paths, and a network allowlist. Then grant autonomy gradually: allow low-risk commands and paths, set budgets, and keep approval for privileges, production, publishing, and deleting. Check the permission config into the repo. [Claude Code](https://code.claude.com/docs/en/security), [Codex](https://developers.openai.com/codex/agent-approvals-security), and [Copilot](https://docs.github.com/en/copilot/concepts/agents/cloud-agent/about-cloud-agent) document their controls.

**In practice:** agents run sandboxed by default with a checked-in permission config: low-risk commands need no prompt, production, publishing, and deleting need approval, and every run leaves an audit trail.

### 19. Async, background, and cloud delegated agents

Agents also work while you don't. Delegate a brief to a background or cloud agent and review the PR it returns, or trigger runs on a schedule or repo event: triage issues, investigate failing CI, open small cleanup or dependency PRs. Delegate only what you can verify. On [GitHub Copilot](https://docs.github.com/en/copilot/concepts/agents/cloud-agent/about-automations), [Codex cloud](https://developers.openai.com/codex/app/automations), Cursor, or Claude Code on the web, an unattended run is sandboxed (#18), narrow, budget-limited, and ends in a draft for review (#3).

**In practice:** at least one agent runs unattended, delegated from a brief or triggered by a schedule or event, and opens a draft PR, issue update, or report that a human and automated checks review before anything important lands.

## Harness and context engineering

### 20. Context engineering and token efficiency

The model recalls less as the context window fills, so choose what it sees. Keep instructions short, the toolset small, fetch information only when needed, filter command output, and use prompt caching and model routing. Aim for value per token rather than the lowest count, know your budget, and watch usage per tool, since parallel agents multiply spend. Compression tools like Headroom and RTK help, but check task quality as well as token savings.

**In practice:** you've measured cost, latency, and success before and after a context change, you know your budget and where to see usage per tool, and you can show the savings didn't hurt correctness or hide something important.

### 21. Budgets, stop conditions, and state files for long-running agents

A run that lasts hours needs a turn or token budget, a stop condition, a definition of progress, and feedback each step, such as test results or a checklist. Sessions end through crashes and handoffs, so keep the state in a progress file the agent updates and re-reads, and prefer a clean context with a clear handoff over summarizing history in place. Harness workarounds exist because of what the model can't do yet; review them as models improve.

**In practice:** a long or multi-session run finished cleanly because you set the budget and stop condition, and its state lived in a file the agent re-read rather than in chat history alone.

### 22. Code intelligence and structural memory

Agents edit more accurately when they resolve symbols, types, and references instead of matching text. Give them a language server, AST tools, and semantic search, so edits stop missing call sites or inventing APIs. On very large repos, index the codebase into a code graph of functions, imports, and call chains that the agent queries over MCP, answering "what calls this?" in a few hundred tokens. CodeGraph, Potpie, and codebase-memory-mcp build such graphs; Serena exposes language-server tools over MCP.

**In practice:** your agent has a language server, semantic search, or AST tools beyond text search, and on a repo too big for grep-and-read it queries a prebuilt code graph, with a measured drop in tokens or tool calls to show for it.

#### Further reading

- [Anthropic: Harness design for long-running agent applications](https://www.anthropic.com/engineering/harness-design-long-running-apps)
- [Martin Fowler: Harness engineering for coding agents](https://martinfowler.com/articles/harness-engineering.html)
- [LangChain: The Anatomy of an Agent Harness](https://www.langchain.com/blog/the-anatomy-of-an-agent-harness)
- [Sebastian Raschka: Components of a Coding Agent](https://magazine.sebastianraschka.com/p/components-of-a-coding-agent)

## Security, maintenance, and policy

### 23. Security-focused review and threat modeling

Code review and tests miss authorization gaps, injection points, and exposed secrets. Use AI to trace trust boundaries and suggest abuse paths, then confirm the findings with [Codex Security](https://developers.openai.com/codex/security), CodeQL, Semgrep, and targeted tests.

**In practice:** you've run a real security review or threat-model pass on a meaningful feature or diff, confirmed the findings, and added a fix, a test, or a written decision to accept the risk.

### 24. Supply-chain and dual-use risk

An agent can invent a package name that attackers then register with malware (slopsquatting), pull in a compromised dependency, or follow a prompt injection hidden in content it fetched. Check that a suggested dependency exists and is the right one, pin and scan it, and keep untrusted content such as web pages, issues, and MCP tool results away from tools that can act.

**In practice:** you've caught or prevented a made-up or malicious dependency, and in your setup untrusted input can't reach a destructive action without an approval.

### 25. Managing dependency upgrades and security patches

Upgrades and security patches get put off, which is how CVEs pile up. An agent reads the changelog, updates the call sites, and runs the tests in a loop. Run it unattended (#19): Renovate or Dependabot opens the PR, the agent fixes the breaking changes, and a human reviews the draft.

**In practice:** you've shipped a dependency-upgrade PR where AI handled the breaking changes, applied a security patch with AI triaging the CVE, or used AI to read changelogs and flag breaks early. Your upgrade workflow pairs Dependabot, Renovate, or Snyk with AI.

### 26. AI tools, models, and MCP servers compliant with company policy

Use only the AI tools, models, MCP servers, and Skills your company has approved, with the data the policy allows. The policy covers everyone who builds with agents, and setup enforces it: enterprise accounts, managed settings, and organization-level policies.

**In practice:** every builder on the team knows which AI tools, models, MCP servers, and data are approved, and the setup is enforced by managed settings and enterprise accounts.

## Agentic Coding Toolbox

### AI coding agents

- [Claude Code](https://claude.com/claude-code) - Anthropic's agentic coding CLI and IDE integration.
- [Cursor](https://cursor.com) - AI-first code editor.
- [Codex](https://github.com/openai/codex) - Agentic coding from OpenAI.
- [GitHub Copilot](https://github.com/features/copilot) - GitHub's AI pair programmer.
- [Gemini CLI](https://github.com/google-gemini/gemini-cli) - Google's Gemini CLI.
- [Google Antigravity](https://antigravity.google) - Google's agent-first development environment.
- [Devin](https://devin.ai) - Cognition's autonomous software engineer; Windsurf became Devin Desktop (2026).
- [Cline](https://cline.bot/) - Open source coding AI agent.
- [OpenCode](https://github.com/anomalyco/opencode) - Open-source coding agent for the terminal, desktop, and IDE.

### Code review

- [CodeRabbit](https://coderabbit.ai) - AI code review bot for GitHub/GitLab PRs.
- [Greptile](https://greptile.com) - AI code reviewer with repo-wide context.
- [PR-Agent](https://github.com/The-PR-Agent/pr-agent) - Community-maintained open-source agent for PR descriptions, reviews, and walkthroughs.
- [Ellipsis](https://ellipsis.dev) - Platform to deploy, manage, and observe cloud coding agents; includes AI PR review with auto-fix.

### Codemods and refactoring
- [ast-grep](https://github.com/ast-grep/ast-grep) - Structural search, lint, and rewrite CLI on tree-sitter, with a rule catalog.
- [GritQL](https://github.com/biomejs/gritql) - Query language for structural codemods, now maintained by Biome (formerly Grit, acquired by Honeycomb in 2025).
- [jscodeshift](https://github.com/facebook/jscodeshift) - Meta's AST codemod toolkit for JavaScript and TypeScript.
- [Comby](https://comby.dev) - Language-agnostic structural search-and-replace for multi-file refactoring.
- [OpenRewrite](https://github.com/openrewrite/rewrite) - Automated mass refactoring with a large recipe catalog, strongest on the JVM.
- [Codemod Registry](https://codemod.com/registry) - Ready-made codemods for framework and library migrations, run through the Codemod CLI.
- [YYLO](https://github.com/yylo-dev/yylo) - Command-line orchestrator for coding agents: each task creates a dedicated branch/worktree behind typed task, validation, merge, and release-readiness boundaries, with a merge queue owning risk-based review of receipt-backed changes.

### Spec-driven development

- [Spec Kit](https://github.com/github/spec-kit) - GitHub's toolkit for spec-driven development with AI agents.
- [Kiro](https://kiro.dev) - AWS's spec-first IDE.
- [Tessl](https://tessl.io) - Agent enablement platform (spec and skills lifecycle, plus a skills registry).
- [BMAD-METHOD](https://github.com/bmad-code-org/BMAD-METHOD) - Also fits spec-first: agile AI-driven development organized around spec/brief artifacts.

### Documentation, ADRs, and architecture as code

- [Mintlify](https://mintlify.com) - AI-assisted docs platform for developer documentation.
- [MADR](https://github.com/adr/madr) - Markdown ADR template.
- [log4brains](https://github.com/thomvaill/log4brains) - CLI and static site generator for ADRs.
- [adr-tools](https://github.com/npryce/adr-tools) - Shell-based toolchain for creating and numbering ADRs.
- [Structurizr](https://structurizr.com) - C4 model diagrams from a text DSL, so agents can read and update the architecture.
- [LikeC4](https://likec4.dev) - Architecture-as-code language and toolkit for C4-style diagrams kept in the repo.
- [C4-PlantUML](https://github.com/plantuml-stdlib/C4-PlantUML) - C4 model diagrams in PlantUML text.

### Agent instructions, Skills, and memory

- [AGENTS.md](https://agents.md/) - Open format for repo-level agent instructions.
- [Anthropic Skills](https://github.com/anthropics/skills) - Anthropic's public collection of reusable Agent Skills.
- [Superpowers](https://github.com/obra/superpowers) - Composable Skills framework with sub-agent patterns.
- [awesome-copilot](https://github.com/github/awesome-copilot) - Community-contributed instructions, agents, Skills, and configs for GitHub Copilot, reusable as examples.
- [Context7](https://github.com/upstash/context7) - Up-to-date library documentation for AI agents, loadable selectively.
- [Skills.sh](https://skills.sh/) - The Open Agent Skills Ecosystem from Vercel Labs.
- [Agent OS](https://github.com/buildermethods/agent-os) - Injects your codebase standards and specs into agent instructions.
- [claude-mem](https://github.com/thedotmack/claude-mem) - Persistent, compressed context carried across coding-agent sessions.

### MCP servers for team systems

- [MCP Registry](https://registry.modelcontextprotocol.io/) - Official registry for discovering published MCP servers.
- [MCP Reference Servers](https://github.com/modelcontextprotocol/servers) - Educational reference implementations; evaluate and harden them before production use.
- [Awesome MCP Servers](https://github.com/punkpeye/awesome-mcp-servers) - Community-curated collection of MCP servers.
- [GitHub MCP](https://github.com/github/github-mcp-server) - Official GitHub MCP server.
- [GitLab MCP](https://docs.gitlab.com/user/gitlab_duo/model_context_protocol/mcp_server/) - GitLab's official MCP server for issues, merge requests, and pipelines.
- [Atlassian Rovo MCP Server](https://www.atlassian.com/platform/remote-mcp-server) - Atlassian's remote MCP server for Jira and Confluence.
- [Linear MCP](https://linear.app/docs/mcp) - Linear's official MCP server for issues and projects.
- [Notion MCP](https://github.com/makenotion/notion-mcp-server) - Official Notion MCP server for pages and databases.
- [Slack MCP](https://docs.slack.dev/ai/mcp-server/) - Slack's official MCP server for channels and messages.
- [Figma Dev Mode MCP](https://developers.figma.com/docs/figma-mcp-server/) - Figma's developer MCP for design context and canvas access.
- [MCP Inspector](https://github.com/modelcontextprotocol/inspector) - Visual testing tool for MCP servers; check what a server exposes before the team uses it.
- [Docker MCP Catalog and Toolkit](https://docs.docker.com/ai/mcp-catalog-and-toolkit/) - Curated MCP servers run in containers, with a gateway for credentials and isolation.

### Database and data

- [Chat2DB](https://github.com/OtterMind/Chat2DB) - AI-assisted SQL client supporting major relational and analytical databases.
- [MCP Toolbox for Databases](https://github.com/googleapis/mcp-toolbox) - Google's open-source MCP server for databases, with connection pooling, auth, and observability.
- [DBHub](https://github.com/bytebase/dbhub) - Token-conscious database MCP server for PostgreSQL, MySQL, SQL Server, and more, with a read-only mode.
- [Postgres MCP Pro](https://github.com/crystaldba/postgres-mcp) - PostgreSQL MCP server with configurable read-only or read/write access, index tuning, and query plans.
- [dbt Wizard](https://www.getdbt.com/product/dbt-copilot) - AI agent from dbt Labs that generates models, tests, docs, and semantic definitions from natural language.

### Observability and incident response

- [Rootly](https://rootly.com) - Incident platform with AI agents for investigation and retrospectives.
- [incident.io](https://incident.io) - On-call and incident platform with AI summaries and investigation copilots.
- [PagerDuty AIOps](https://www.pagerduty.com) - AI-driven alert noise reduction and incident automation.
- [Sentry](https://sentry.io) - AI-assisted root-cause analysis with an MCP server for agent queries.
- [Grafana MCP](https://github.com/grafana/mcp-grafana) - Grafana's official MCP server for dashboards, metrics, logs, and alerts.
- [Datadog MCP Server](https://docs.datadoghq.com/bits_ai/mcp_server/) - Datadog's MCP server for querying monitors, logs, traces, and metrics.
- [Spike](https://spike.sh) - Incident management and on-call platform with a remote MCP server for AI agents.

### Cloud and infrastructure

- [Kagent](https://github.com/kagent-dev/kagent) - CNCF Kubernetes-native framework for building and operating agents with tools for Kubernetes, Prometheus, Grafana, Istio, Helm, and other cloud-native systems.
- [AWS MCP Servers](https://github.com/awslabs/mcp) - AWS's open-source MCP servers for documentation, infrastructure, and services.
- [Azure MCP Server](https://github.com/microsoft/mcp) - Microsoft's catalog of official MCP servers, including Azure.
- [gcloud MCP](https://github.com/googleapis/gcloud-mcp) - Google Cloud's MCP server over the gcloud CLI.
- [Kubernetes MCP Server](https://github.com/containers/kubernetes-mcp-server) - MCP server for Kubernetes and OpenShift from the containers project.

### Testing and browser/device automation

- [Agent QA](https://github.com/vostride/agent-qa) - The self-improving QA agent for natural-language web and mobile regression tests.
- [Playwright](https://playwright.dev) - Cross-browser E2E framework.
- [Pact](https://pact.io) - Consumer-driven contract testing for service integration.
- [Diffblue Cover](https://www.diffblue.com) - AI unit test generator for Java/JVM.
- [Trunk Flaky Tests](https://trunk.io/products/flaky-tests) - Detect, quarantine, and track flaky tests across CI.
- [Maestro](https://github.com/mobile-dev-inc/Maestro) - Declarative E2E automation for mobile and web applications.
- [Testcontainers](https://testcontainers.com) - Throwaway databases and services in containers for integration tests the agent can run locally.
- [Stryker](https://stryker-mutator.io) - Mutation testing for JavaScript, .NET, and Scala; shows whether tests can fail.
- [Playwright MCP](https://github.com/microsoft/playwright-mcp) - Browser automation MCP from Microsoft.
- [Chrome DevTools MCP](https://github.com/ChromeDevTools/chrome-devtools-mcp) - Google's MCP server that lets agents drive Chrome and read console, network, and performance data.
- [mobile-mcp](https://github.com/mobile-next/mobile-mcp) - MCP server for iOS and Android automation on simulators, emulators, and devices.
- [Browserbase Stagehand](https://github.com/browserbase/stagehand) - AI-native browser automation layered on Playwright.
- [Browser Use](https://github.com/browser-use/browser-use) - Open-source library that lets LLMs drive real browsers.
- [Anthropic Computer Use](https://platform.claude.com/docs/en/docs/agents-and-tools/computer-use) - Claude's screen, keyboard, and mouse control for agent-driven UI automation.

### Agent traces and evals

- [OpenAI Agent Evals](https://developers.openai.com/api/docs/guides/agent-evals) - Traces, graders, datasets, and evaluation runs for agent workflows.
- [Langfuse](https://github.com/langfuse/langfuse) - Open-source tracing, prompt management, and evaluation platform for LLM applications.
- [Arize Phoenix](https://github.com/Arize-ai/phoenix) - Open-source observability and evaluation for AI applications and agents.
- [promptfoo](https://github.com/promptfoo/promptfoo) - Open-source evals and red-teaming for prompts, agents, and RAG, runnable in CI.
- [Braintrust](https://www.braintrust.dev) - Evals, tracing, and prompt management platform for agents.

### Fleets and orchestration

- [Claude Agent SDK](https://github.com/anthropics/claude-agent-sdk-python) - Anthropic's SDK for building sub-agents and orchestrated workflows.
- [OpenAI Agents SDK](https://github.com/openai/openai-agents-python) - Lightweight multi-agent orchestration with handoffs and tracing.
- [LangGraph](https://github.com/langchain-ai/langgraph) - Graph-based framework for stateful, multi-agent workflows.
- [Claude Code agent teams](https://code.claude.com/docs/en/agent-teams) - Orchestrate teams of Claude Code sessions that share tasks and report back.
- [Conductor](https://conductor.build) - Workspace for running a team of coding agents in parallel, one worktree per task.
- [Superset](https://superset.sh) - Orchestration workspace for any coding agent, with a worktree per task and every session in one place.
- [parallel-code](https://github.com/johannesjo/parallel-code) - Run Claude Code, Codex, and Gemini side by side, each in its own Git worktree.
- [Portless](https://github.com/vercel-labs/portless) - Stable named URLs for localhost services, worktree-aware (Vercel Labs).
- [Aspire](https://aspire.dev/) - Isolated multi-service local dev/test stacks; now language-agnostic (formerly .NET Aspire).

### Sandboxes and permissions

- [Dev Containers](https://containers.dev) - Open specification for containerized development environments, supported by editors, CI, and cloud agents.
- [Docker Sandboxes](https://docs.docker.com/ai/sandboxes/) - Isolated sandboxes from Docker for running coding agents with controlled file and network access.
- [E2B](https://github.com/e2b-dev/E2B) - Open-source secure cloud sandboxes for running agent-generated code.
- [Daytona](https://github.com/daytonaio/daytona) - Secure, elastic infrastructure for running AI-generated code in isolated sandboxes.

### Agents in CI and automations

- [Claude Code Action](https://github.com/anthropics/claude-code-action) - GitHub Action that runs Claude Code on issues, PRs, and schedules.
- [Codex Action](https://github.com/openai/codex-action) - GitHub Action that runs OpenAI Codex in CI workflows.
- [Run Gemini CLI](https://github.com/google-github-actions/run-gemini-cli) - GitHub Action that runs the Gemini CLI for issue triage, PR review, and scheduled tasks.

### Code intelligence and code graphs

- [Serena](https://github.com/oraios/serena) - MCP toolkit that gives agents language-server tools: symbols, references, and semantic edits.
- [CodeGraph](https://github.com/colbymchenry/codegraph) - Pre-indexed code knowledge graph that syncs on code changes, queried over MCP.
- [codebase-memory-mcp](https://github.com/DeusData/codebase-memory-mcp) - Code intelligence MCP server that indexes a codebase into a graph of symbols, calls, and dependencies.
- [Potpie](https://github.com/potpie-ai/potpie) - Context graph for the AI-native SDLC, with agents that answer questions over a codebase.
- [CodeGraphContext](https://github.com/CodeGraphContext/CodeGraphContext) - MCP server and CLI that index local code into a graph database.
- [SCIP](https://github.com/scip-code/scip) - Code intelligence protocol and index format, originally from Sourcegraph.

### Token consumption

- [ccusage](https://github.com/ccusage/ccusage) - Local usage and cost analysis for Claude Code and other coding agents.
- [Headroom](https://github.com/headroomlabs-ai/headroom) - Local-first, reversible compression for agent context, tool outputs, logs, files, RAG chunks, and conversation history; available as a library, proxy, wrapper, or MCP server.
- [Caveman](https://github.com/JuliusBrussee/caveman) - Agent response compression (~70% output token reduction).
- [RTK](https://github.com/rtk-ai/rtk) - CLI proxy for input token filtering on common dev commands.
- [NextReset](https://nextreset.ai/) - Independent Codex reset-history tracker with official incident sources and a browser-local personal timer.
- [Ponytail](https://github.com/DietrichGebert/ponytail) - Skill that stops the agent over-building: it writes only the code the task needs, which cuts output tokens.

### Dependency and security automation

- [Dependabot](https://github.com/dependabot) - GitHub's dependency update bot.
- [Renovate](https://github.com/renovatebot/renovate) - Cross-platform dependency update tool.
- [Snyk](https://snyk.io) - Security platform with AI-assisted fix suggestions for vulnerable dependencies.
- [Trivy](https://github.com/aquasecurity/trivy) - Vulnerability, misconfiguration, secret, and SBOM scanner for repositories and infrastructure.
- [Gitleaks](https://github.com/gitleaks/gitleaks) - Secret scanner for repositories, files, and commit history.
- [Semgrep](https://github.com/semgrep/semgrep) - Static analysis for many languages with security rules the agent can run locally and in CI.
- [CodeQL](https://codeql.github.com) - GitHub's semantic code analysis engine for security queries.
- [Socket](https://docs.socket.dev) - Supply-chain security that checks packages for malware, typosquats, and risky behavior before install.
- [Syft](https://github.com/anchore/syft) - CLI that generates a software bill of materials (SBOM) from code and containers.
- [OWASP Threat Dragon](https://github.com/OWASP/threat-dragon) - Open-source threat modeling tool with diagrams and threat lists.

### Voice input

- [Wispr Flow](https://wisprflow.ai) - AI dictation app for macOS and Windows.
- [Superwhisper](https://superwhisper.com) - macOS voice-to-text built on Whisper-family models.

## Contributing

Contributions are welcome. Read the [contribution guidelines](CONTRIBUTING.md) before proposing a roadmap item or Toolbox entry. The roadmap is kept intentionally short and practical, so additions should be actively maintained, clearly useful, and grounded in a concrete engineering workflow.
