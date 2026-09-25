# Awesome Agentic Coding [![Awesome](https://awesome.re/badge.svg)](https://awesome.re)

<!--lint disable double-link-->

This roadmap helps teams build up their coding agent harness step by step — from everyday work with agents to specs, Skills, hooks, MCP, fleets of parallel agents, and harness and context engineering for long-running agents.

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

Agents read code faster than anyone and forget all of it when the session ends. Use them to navigate and explain unfamiliar code, and keep what they learned: a repo map with directories, entry points, and build and test commands; notes for the modules they touched; an architecture note for anything they worked out that nobody had written down. Verify it against the code first — agents state guesses with confidence — then commit it, so the next session starts from the map instead of from zero.

**In practice:** an agent-written repo map or architecture note is committed and kept current, and a later session started from it instead of re-exploring.

### 2. Agentic loop with build, static analysis, and automated tests

The best way to use an agent is to let it run its own feedback loop: change code, build, run static analysis, run tests, read the failures, fix, repeat. The loop is only as good as the checks in it, so make them worth running: one documented command that builds, lints, type-checks, and tests in minutes and gives the same answer every run — a slow or flaky check teaches the agent nothing. Give the loop an iteration limit and a stop condition, and always read the final diff: an agent under pressure to get green will weaken tests, accept wrong snapshots, hide warnings, or skip guardrails. Hooks (#10) and CI it can't edit (#3) catch what you miss.

**In practice:** build, lint, and tests run with one command in minutes; the agent loops on them with a set limit; the final diff shows no weakened tests, snapshots, or guardrails.

### 3. Independent AI code review before human review

An agent reviewing its own code approves it, so "the agent says it's done" is not a signal. Before any human reads a diff, have a context that never saw it written review it against the spec: a reviewer sub-agent, a second agent over the diff (`git diff | <agent> -p "review this against the spec, list what's wrong"`), or a PR bot like CodeRabbit, Greptile, or PR-Agent. Keep the merge gate out of the agent's reach — CI with required checks, branch protection, a review it can't approve. Then the human reviews a diff that has already passed, and spends the time on what AI review can't judge: architecture, security, and product decisions.

**In practice:** every agent diff is reviewed against the spec by a context that didn't write it and passes CI the agent can't edit before a human sees it — and this has caught a confident but wrong "done".

### 4. Refactoring and cleanup on every PR and on a schedule

Agents write a lot of code and refactor almost none of it, so a codebase built with them degrades unless cleanup is deliberate. They are good at exactly this work — extracting functions, renaming, simplifying, removing duplication and dead code — yet most teams point them only at new features. Make cleanup routine: every PR includes the cleanup the change exposed, and a scheduled agent opens small cleanup PRs on its own (#19). For structural changes across the repo, pair the agent with codemod tools like ast-grep, GritQL, jscodeshift, and Comby, and let the tests verify the result instead of reading every file.

**In practice:** you've shipped agent-driven cleanup — a real refactor, dead code removed, duplication merged — and cleanup runs with every PR and on a schedule.

## Spec-first work

### 5. Approved plan with acceptance criteria before coding starts

For anything non-trivial, the agent reads the repo, checks the constraints, and proposes a plan with acceptance criteria — and no agent edits code until you approve it, especially when several will work on it in parallel (#17). A plan is a living document: when the code, tool output, or tests show something new, change the plan instead of forcing the work through an out-of-date one. For anyone who builds without reading the code, the approved plan is the contract — what changes, and how you'll know it worked.

**In practice:** you approved a plan with acceptance criteria before the agent edited code, updated it after feedback from the repo or tests, and kept the final scope easy to review.

### 6. Specs with explicit design decisions and acceptance criteria

The spec is the main artifact a human still writes — engineer or product manager — and it decides what the agents build. A good one turns "build X" into a clear plan: the happy path, the error and edge cases agents skip when nobody names them, acceptance criteria, and the design decisions stated outright — data model, API boundaries, the options considered and why one won. Use the agent to work through the trade-offs, and write them down where the next agent will read them. Keep specs as small as the task allows and update them when the implementation proves the design wrong. Spec Kit, Kiro, Tessl, and BMAD-METHOD give this a repeatable Specify → Plan → Tasks → Implement flow.

**In practice:** you've written a spec in markdown — happy path, error cases, acceptance criteria, and the design decisions with their trade-offs — and given it to agents as input.

### 7. Documentation and ADRs

Documentation is no longer only for people: READMEs, module docs, API references, onboarding guides, architecture docs, and ADRs are what the next agent reads before it touches the code, and [AI-accessible internal documentation](https://dora.dev/ai/roi/report/) is one of the foundations that decide whether AI pays off at all. Agents are also the cheapest way to keep docs current — the work that always went stale because nobody had time. Make it part of the change: the agent updates the docs in the same PR, writes an ADR for every non-trivial decision, and a scheduled run flags docs that drifted from the code (#19). Mintlify brings AI writing into docs workflows; MADR with log4brains or adr-tools keeps ADRs easy to write.

**In practice:** you've written or updated a README, API reference, onboarding note, or ADR with an agent in the same PR as the change, and kept it current.

## Agent instructions, Skills, and tools

### 8. Agent instructions committed in the repo

Instructions checked into the repo help the agent start faster, work consistently, and keep quality up across the codebase. Keep them short, scoped to the directory or workflow they apply to, and up to date — large sets of stale or conflicting rules fill up the context and make the agent less reliable. Treat them as team-owned code: someone owns them, changes get reviewed, and rules that no longer hold get deleted.

**In practice:** your repo has an AGENTS.md, CLAUDE.md, Copilot instructions, or similar guidance that agents actually read, and someone owns keeping it short and current.

### 9. Turning repeated agent mistakes into durable knowledge and memory

Agents waste time when they repeat the same wrong command, miss the same convention, or need the same review correction again in a later session. Most tools now capture memory on their own, so the discipline is curating it: when you find a lesson that holds, put it where the whole team's agents re-read it — the repo instructions, a Skill, or shared agent memory — and delete it when it no longer applies. Tools like [Headroom's `learn`](https://github.com/headroomlabs-ai/headroom) and [GitHub Copilot Memory](https://docs.github.com/en/copilot/concepts/agents/copilot-memory) help capture this.

**In practice:** after a failed task or a review correction, you've saved a reusable lesson in AGENTS.md, CLAUDE.md, a Skill, or agent memory, and a later task used it.

### 10. Deterministic hooks around agent actions

The agent may or may not follow an instruction, so important guardrails and routine checks should not depend on it remembering them. Hooks can check or block tool calls, run formatters and tests after edits, log what happened, and stop a task from finishing before the required checks pass. [Claude Code hooks](https://code.claude.com/docs/en/hooks) and [Codex hooks](https://developers.openai.com/codex/hooks) give pre-tool, post-tool, and session control points.

**In practice:** your repo has at least one hook, checked into version control, that blocks a forbidden action or runs a formatter, linter, test, or audit after the agent makes changes.

### 11. Skills for repeated workflows, own and third-party

Skills turn a workflow you repeat into something every agent on the team runs the same way each time. A Skill is a directory with a SKILL.md file that loads in stages — the agent reads a one-line description first, and the full instructions only when they are needed. It is now an open format that works across many agents, not one vendor's feature. Write your own for tasks you do often (build steps, scaffolding, dependency updates, PR prep, test generation, bug triage). You can also load reviewed third-party Skills and docs, such as Context7, Superpowers, or BMAD-METHOD — but don't install a large framework by default: check and pin third-party content, load only what the task needs, and keep it only if it clearly beats a simpler setup.

**In practice:** you can point to a SKILL.md in your repo that you wrote and use, name at least one external Skill or docs source you load on purpose, and name one you looked at and chose not to install.

### 12. MCP servers

MCP lets an agent connect to data and external systems, and it is now an open standard (governed under the Linux Foundation). It is not the default choice, though: for many tasks a CLI, a script, or a reviewed Skill is simpler and uses fewer tokens than running a server, so use MCP when you need a structured tool contract, an auth boundary, or shared multi-tenant access. Treat every server as code you trust and run: a local server runs with your access, and a remote server can read data and take actions. Use official or reviewed servers, check the install command, pin the version, turn off tools and scopes you don't need, and keep write or destructive actions behind an approval. A popular directory helps you find servers; it does not vouch for them.

**In practice:** you've got at least one reviewed MCP server in use, you can explain its credentials and permissions, you've turned off tools or scopes you don't need — and at least once you chose a CLI or Skill instead of MCP because it was simpler.

### 13. Troubleshooting with scoped, read-only data access

An agent that can see the real logs, traces, API responses, CI/QA snapshots, and database schemas troubleshoots; one that can't, guesses. Give it that access scoped and read-only (or throwaway) by default — a narrow time range, only the fields it needs, secrets and personal data stripped before they reach the model or the trace. Databases get extra care: review the generated migration, query plan, locks, backups, and rollback path before anything runs, and keep production writes and destructive queries behind an explicit approval. Sentry, Grafana, and Rootly expose telemetry to agents; DBHub, Postgres MCP Pro, and MCP Toolbox for Databases give scoped database access.

**In practice:** you've troubleshot from real logs, traces, or snapshots with scoped read-only access, or explored a schema and drafted a query or migration — and reviewed and tested any change that writes data separately.

## Testing and quality engineering

### 14. Generating and hardening tests from requirements

More agent-written code means more defects, unless the tests grow with it. Have agents write the unit, integration, contract, and E2E tests, and the fixtures and seed data those tests need. Three rules keep the tests honest. Write them from the requirements and the behavior users see, never from the code the agent just wrote — a test that mirrors the implementation hides the same bug. Harden them: mutation testing with Stryker or similar on the modules that matter proves a test can actually fail. And use fake or masked data, never production secrets or personal data. Playwright is a common base for E2E, Pact covers consumer-driven contract testing, Diffblue Cover writes unit tests from runtime behavior, and Trunk finds and quarantines flaky tests.

**In practice:** an agent wrote or improved more than one kind of test in a shipped PR, generated the fixtures, and you've shown the tests can fail — a mutation run or a deliberate bug they caught.

### 15. Browser and device automation for verifying UI changes

An agent that changes a screen should look at the screen. Give it Playwright MCP, Chrome DevTools MCP, or a simulator, and it loads the page, clicks through the flow, takes screenshots, and reads the console and network errors before it says done. Anything worth checking twice becomes a Playwright or Maestro script in CI, with stable selectors. Keep vision-based computer control for the cases nothing else reaches, in an isolated environment with approvals for actions that matter. Browserbase Stagehand and Browser Use work alongside Playwright; computer-use models drive the screen, keyboard, and mouse.

**In practice:** the agent verifies its own UI changes in a real browser or simulator before it says done, and the repeatable checks run as Playwright or Maestro scripts in CI.

### 16. Evals and regression tests for the agent workflow

Product tests check the code an agent wrote; agent evals check the workflow that wrote it. Record end-to-end traces of prompts, tool calls, handoffs, approvals, and results. Build a small dataset from real tasks and past failures, score both the final result and the steps that matter, and re-run it as a regression suite whenever the model, prompts, instructions, tools, or permissions change. Agent behavior varies between runs, so when reliability matters, compare several runs instead of trusting one good demo or a public benchmark.

**In practice:** you've recorded a real agent run, turned at least one failure into a repeatable eval case, and used it to catch a regression or justify a change to the workflow.

## Parallel agents and autonomous execution

### 17. Parallel sub-agents with worktree isolation and deliberate merges

Parallel sub-agents pay off when the work splits cleanly: independent parts that each fit in one context window, a second opinion on a risky change, a repo too big for one agent. Give each agent one goal and a defined output, and take back a summary, not a transcript. Isolate with worktrees — each agent gets its own checkout and branch — and remember what worktrees don't isolate: databases, ports, credentials, caches, and build output need their own boundaries, which Portless or Aspire's isolated mode provide by running several copies of the same stack. Merge deliberately: rebase, run the full checks per branch, review each result (#3). Tightly coupled work loses more to coordination and merge conflicts than parallelism saves, and the useful size of a fleet is set by how much you can review, not by how many agents the tool allows. The Claude Agent SDK, OpenAI Agents SDK, and LangGraph give you the building blocks.

**In practice:** you've run parallel sub-agents — local worktrees or cloud — each with one goal and a defined output, isolated down to ports and databases, and can say where the split paid off and where it didn't.

### 18. Sandboxing and granting autonomy gradually

A coding agent runs repo code, package scripts, tools, and network requests, so one prompt injection or one bad dependency reaches far past the diff. Every major tool ships a sandbox now; turn it on — a dev container, VM, or cloud sandbox with scoped credentials, limited write paths, and a network allowlist — and start there, not at full host access. Then grant autonomy gradually so approvals stop slowing you down: allow the known low-risk commands and paths, set time or action budgets, and keep approval for raising privileges, touching production, publishing, or deleting. Check the permission config into the repo so every agent on the team runs inside the same boundary. [Claude Code](https://code.claude.com/docs/en/security), [Codex](https://developers.openai.com/codex/agent-approvals-security), and the [GitHub Copilot cloud agent](https://docs.github.com/en/copilot/concepts/agents/cloud-agent/about-cloud-agent) all have isolation and permission controls worth setting up on purpose.

**In practice:** agents run sandboxed by default with a checked-in permission config: low-risk commands need no prompt, production, publishing, and deleting need approval, and every run leaves an audit trail.

### 19. Async, background, and cloud delegated agents

Agents also work while you don't. Delegate — write a brief, hand it to a background or cloud agent, review the PR it returns — or trigger on a schedule or a repo event: triage new issues, investigate failing CI, draft release notes, flag stale docs, open small cleanup or dependency PRs. A well-written issue that comes back as a draft PR is also how people who never open an IDE build with agents. Delegate only what you can verify: a small brief and explicit acceptance criteria. Delegated or triggered — [GitHub Copilot coding agent and automations](https://docs.github.com/en/copilot/concepts/agents/cloud-agent/about-automations), [OpenAI Codex cloud and automations](https://developers.openai.com/codex/app/automations), Cursor background agents, Claude Code on the web — an unattended run is sandboxed (#18), narrow, observable, budget-limited, repeatable, and ends in a draft for review (#3), not in a large change merged on its own.

**In practice:** at least one agent runs unattended — delegated from a brief or triggered by a schedule or event — and opens a draft PR, issue update, or report that a human and automated checks review before anything important lands.

## Harness and context engineering

### 20. Context engineering and token efficiency

Context is a limited attention budget, not a space to fill — the model recalls less well as the window fills up, so choosing what it sees beats cramming it. Keep instructions short and specific, keep the toolset small, fetch information only when you need it, filter command output, summarize finished phases, move detail into external files, and use prompt caching and model routing. Deeper AI use uses more tokens, which is fine — aim for value per token, not the highest or lowest count, and know your plan's budget, limits, and where to see usage per tool. Parallel agents multiply spend, so set a team budget and watch usage per tool. Compression tools like Headroom, Caveman, and RTK can help, but lossy compression can drop something the agent needs, so keep the originals and judge task quality, not just token savings.

**In practice:** you've measured cost, latency, and success before and after a context change, you know your budget and where to see usage per tool, and you can show the savings didn't hurt correctness or hide something important.

### 21. Budgets, stop conditions, and state files for long-running agents

A run that lasts hours needs its loop designed, not just prompted. Give it a turn or token budget, a stop condition, a definition of progress, and feedback it acts on every step — test results, a checklist it marks off — so it finishes instead of circling, or stopping early and calling it done. Plan for the context to end: long runs degrade even in million-token windows, and sessions die through crashes, new chats, and handoffs. Keep the state in a file the agent updates and re-reads — a progress or plan file — and prefer a clean context with a clear handoff over quietly summarizing history in place. Every harness workaround exists because of something the model can't do yet; review them as models improve instead of carrying them forward.

**In practice:** a long or multi-session run finished cleanly because you set the budget and stop condition, and its state lived in a file the agent re-read — not only in chat history.

### 22. Code intelligence and structural memory

Agents edit more accurately when they can resolve symbols, types, and references instead of matching text patterns. Give the agent code intelligence — a language server (go-to-definition, find-references, types), tree-sitter or AST tools, and semantic search over the repo — so edits are based on real structure. This cuts changes that break the build, miss call sites, or invent APIs. On very large repos, grep-and-read gets slow and even this isn't enough: index the codebase into a code graph — functions, classes, imports, call chains — that the agent queries over MCP, answering "what calls this?" in a few hundred tokens instead of tens of thousands. CodeGraph, CodeGraphContext, Potpie, and codebase-memory-mcp build local graphs on tree-sitter and LSP; Serena exposes language-server tools over MCP; SCIP is a mature index format. Use code intelligence everywhere; add a code graph when repo size, not the model, is the bottleneck.

**In practice:** your agent has more than text search — a language server, semantic search, or AST tools — and on a repo too big for grep-and-read it queries a prebuilt code graph, with a measured drop in tokens or tool calls to show for it.

#### Further reading

- [Anthropic — Harness design for long-running agent applications](https://www.anthropic.com/engineering/harness-design-long-running-apps)
- [Martin Fowler — Harness engineering for coding agents](https://martinfowler.com/articles/harness-engineering.html)
- [LangChain — The Anatomy of an Agent Harness](https://www.langchain.com/blog/the-anatomy-of-an-agent-harness)
- [Sebastian Raschka — Components of a Coding Agent](https://magazine.sebastianraschka.com/p/components-of-a-coding-agent)

## Security, maintenance, and policy

### 23. Security-focused review and threat modeling

Normal code review and passing tests don't reliably catch missing authorization checks, injection points, exposed secrets, unsafe data flows, or supply-chain risk. Use AI to trace trust boundaries and suggest ways the code could be abused, then confirm the findings with scanners and targeted tests. [Codex Security](https://developers.openai.com/codex/security), CodeQL, Semgrep, and secret scanning add to human security review; they don't replace it.

**In practice:** you've run a real security review or threat-model pass on a meaningful feature or diff, confirmed the findings, and added a fix, a test, or a written decision to accept the risk.

### 24. Supply-chain and dual-use risk

Agentic coding adds new supply-chain risks. An agent can invent a package name that doesn't exist, which attackers then register and fill with malware ("slopsquatting"); it can pull in a compromised dependency; or it can be steered by a prompt injection hidden in content it fetched. The same power that ships features can also be misused, so build security in from the start rather than adding it in review. Check that a suggested dependency actually exists and is the right one, pin and scan it, keep untrusted content — web pages, issues, PR comments, MCP tool results — away from tools that can take action, and keep an audit trail. Scanners like Trivy, Snyk, and Gitleaks add to human judgment; they don't replace it.

**In practice:** you've caught or prevented a made-up or malicious dependency, and in your setup untrusted input can't reach a destructive action without an approval.

### 25. Managing dependency upgrades and security patches

Dependency upgrades and security patches are repetitive and easy to put off, which is how CVEs pile up and breaking-change debt grows. AI is a good fit here: it can read changelogs, compare API changes, update the call sites, run tests in a loop, and handle most of the manual work. Paired with Dependabot, Renovate, or Snyk, upgrades become routine instead of risky. Run it unattended where you can (#19): Renovate or Dependabot opens the PR, an agent fixes the breaking changes and runs the tests, and a human reviews the draft.

**In practice:** you've shipped a dependency-upgrade PR where AI handled the breaking changes, applied a security patch with AI triaging the CVE, or used AI to read changelogs and flag breaks early. Your upgrade workflow pairs Dependabot, Renovate, or Snyk with AI.

### 26. AI tools, models, and MCP servers compliant with company policy

Use only the AI tools, models, MCP servers, and Skills your company has approved, and only with the data the policy allows — that is what keeps company data inside the company. Everyone builds with agents now, engineers and product, design, QA, and ops alike, so the policy covers all of them and is enforced by setup rather than memory: agent CLI and IDE signed into the enterprise account, managed settings and organization-level policies enforcing the rest.

**In practice:** every builder on the team knows which AI tools, models, MCP servers, and data are approved, and the setup is enforced by managed settings and enterprise accounts, not by memory.

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
