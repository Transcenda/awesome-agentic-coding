# Awesome Agentic Coding [![Awesome](https://awesome.re/badge.svg)](https://awesome.re)

<!--lint disable double-link-->

This roadmap helps engineers build up their coding agent harness step by step — from simple prompting to custom Skills, feedback loops, sub-agents, MCP, agent memory, and spec-driven workflows, up to harness and context engineering for long-running agents.

## Contents

- [Agentic coding 101](#agentic-coding-101)
- [Spec-first work](#spec-first-work)
- [Agent instructions, Skills, and tools](#agent-instructions-skills-and-tools)
- [Testing and quality engineering](#testing-and-quality-engineering)
- [Multi-agent and autonomous execution](#multi-agent-and-autonomous-execution)
- [Harness and context engineering](#harness-and-context-engineering)
- [Security, maintenance, and policy](#security-maintenance-and-policy)
- [Agentic Coding Toolbox](#agentic-coding-toolbox)


## Agentic coding 101

### 1. Codebase navigation and understanding

A lot of development time goes into reading and understanding code, not writing it. Use AI to explore a codebase and understand how it works faster.

**In practice:** you've used AI to explain an unfamiliar flow or find the files a change touches, and getting up to speed in a new part of the codebase was faster with AI.

### 2. Planning and replanning before coding starts

For anything non-trivial, have the agent read the repo, check the constraints, and propose a plan with acceptance criteria before it edits code. Treat the plan as something you update: change it when the code, tool output, or tests show something new, instead of forcing the work through an out-of-date plan.

**In practice:** you've used plan mode before a non-trivial change, updated the plan after feedback from the repo or tests, and kept the final scope and acceptance criteria easy to review.

### 3. Agent mode for code generation

Unlike autocomplete or plain chat, agent mode can read files, edit code, run commands, and work through several steps to finish a larger task. Use it for open-ended work that has clear success criteria and feedback from the environment, like builds and tests. For small, predictable changes, a direct edit or a single prompt is usually enough.

**In practice:** you've had an agent edit several files in one task, run commands, and finish multi-step work end to end.

### 4. Refactoring and cleaning up existing code

A lot of work is improving code that already works: extracting functions, renaming, simplifying, removing duplication, cleaning up old code. AI is good at this, but people often use it only for new features and miss this value. For large structural changes across the repo, pair AI with codemod tools like GritQL, jscodeshift, and Comby.

**In practice:** you've done a real refactor with AI — extracted a function, simplified a component, cleaned up old code, or improved readability across files.

### 5. Self review and PR preparation before requesting human review

Run AI review on your own diff before a human sees it: it catches problems early and improves the change. The same pass can draft the PR summary so reviewers understand it faster. Tools like CodeRabbit, Greptile, Qodo, and Ellipsis do this automatically. Treat the summary as a draft and check it against the real diff and test results. AI review adds to human review, it does not replace it — especially for architecture, security, and product decisions.

**In practice:** you've run AI review on your own diff and had it draft the PR summary before asking for human review, and you checked both against the real changes.

### 6. Agentic loop with build, static analysis, and automated tests

The best way to use an agent is to let it run its own feedback loop: change code, build, run static analysis, run tests, read the failures, fix, and repeat. Set a limit on iterations and a clear stop condition, and always check the final diff — the agent must not make checks pass by weakening tests, accepting wrong snapshots, hiding warnings, or skipping guardrails.

**In practice:** you've had an agent run build, linter, and tests in a loop with a set limit, read the failures, fix them, and then shown that the checks and the final diff still do what you intended.

## Spec-first work

### 7. Task briefs and specs before larger features

A good spec makes agent output better and the result easier to review — it turns "build X" into a clear plan instead of jumping straight to code. A good spec covers not just the happy path but also error cases, edge cases, and acceptance criteria, which is what gets missed when AI is used only for happy-path code. Keep specs as small as the task allows, and update them when the implementation shows the design was wrong. Spec-driven tools like Spec Kit, Kiro, Tessl, and BMAD-METHOD give this a repeatable Specify → Plan → Tasks → Implement flow.

**In practice:** you've written a spec in markdown — covering the happy path, error cases, and acceptance criteria — and given it to an agent as input, with AI-drafted steps to go with it.

### 8. Architecture and design-level decisions

Before you implement, there are usually design choices: the shape of the data model, API boundaries, trade-offs between approaches. Use AI to think through the options and write them down, so the choice is clear and can be reviewed. This sits one level above the feature spec and helps you build the feature the right way.

**In practice:** you've written a design note or trade-off comparison with AI, or brought AI-drafted content into a design discussion or review.

### 9. Documentation and ADRs

AI is good at writing and updating the docs around code — READMEs, module docs, API references, setup and onboarding guides — and the architecture docs and ADRs that usually go stale or get skipped because they feel like a lot of work. Keeping them current helps the team move faster and gives agents better context in future sessions. Mintlify brings AI writing into docs workflows; MADR with log4brains or adr-tools keeps ADRs easy to write.

**In practice:** you've written or updated a README, API reference, onboarding note, or ADR with AI, and kept it current as the system changed.

## Agent instructions, Skills, and tools

### 10. Agent instructions committed in the repo

Instructions checked into the repo help the agent start faster, work consistently, and keep quality up across the codebase. Keep them short, scoped to the directory or workflow they apply to, and up to date — large sets of stale or conflicting rules fill up the context and make the agent less reliable.

**In practice:** your repo has an AGENTS.md, CLAUDE.md, Copilot instructions, or similar guidance that agents actually read.

### 11. Turning repeated agent mistakes into durable knowledge and memory

Agents waste time when they repeat the same wrong command, miss the same convention, or need the same review correction again in a later session. When you find a lesson that holds, write it into the repo instructions, a Skill, or agent memory the agent can re-read across sessions — and delete it when it no longer applies. Tools like [Headroom's `learn`](https://github.com/headroomlabs-ai/headroom) and [GitHub Copilot Memory](https://docs.github.com/en/copilot/concepts/agents/copilot-memory) help capture this.

**In practice:** after a failed task or a review correction, you've saved a reusable lesson in AGENTS.md, CLAUDE.md, a Skill, or agent memory, and a later task used it.

### 12. Deterministic hooks around agent actions

The agent may or may not follow an instruction, so important guardrails and routine checks should not depend on it remembering them. Hooks can check or block tool calls, run formatters and tests after edits, log what happened, and stop a task from finishing before the required checks pass. [Claude Code hooks](https://code.claude.com/docs/en/hooks) and [Codex hooks](https://developers.openai.com/codex/hooks) give pre-tool, post-tool, and session control points.

**In practice:** your repo has at least one hook, checked into version control, that blocks a forbidden action or runs a formatter, linter, test, or audit after the agent makes changes.

### 13. Skills: author your own and reuse an open standard

Skills turn a workflow you repeat into something the agent runs the same way each time. A Skill is a directory with a SKILL.md file that loads in stages — the agent reads a one-line description first, and the full instructions only when they are needed. It is now an open format that works across many agents, not one vendor's feature. Write your own for tasks you do often (build steps, scaffolding, dependency updates, PR prep, test generation, bug triage). You can also load reviewed Skills and docs from others, such as Context7, Superpowers, GSD, or BMAD-METHOD — but don't install a large framework by default: check and pin third-party content, load only what the task needs, and keep it only if it clearly beats a simpler setup.

**In practice:** you can point to a SKILL.md in your repo that you wrote and use, name at least one external Skill or docs source you load on purpose, and name one you looked at and chose not to install.

### 14. MCP servers

MCP lets an agent connect to data and external systems, and it is now an open standard (governed under the Linux Foundation). It is not the default choice, though: for many tasks a CLI, a script, or a reviewed Skill is simpler and uses fewer tokens than running a server, so use MCP when you need a structured tool contract, an auth boundary, or shared multi-tenant access. Treat every server as code you trust and run: a local server runs with your access, and a remote server can read data and take actions. Use official or reviewed servers, check the install command, pin the version, turn off tools and scopes you don't need, and keep write or destructive actions behind an approval. A popular directory helps you find servers; it does not vouch for them.

**In practice:** you've got at least one reviewed MCP server in use, you can explain its credentials and permissions, you've turned off tools or scopes you don't need — and at least once you chose a CLI or Skill instead of MCP because it was simpler.

### 15. Reading logs, traces, and databases safely

The agent debugs and explores data much better when it can see the real thing — logs, API responses, traces, CI/QA snapshots, database schemas — instead of guessing. Give it read-only or throwaway access by default, keep the time range and fields small, and remove secrets and personal data before they reach the model or the trace. For databases, review the generated migration, query plan, locks, backups, and rollback path before you run it; production writes and destructive queries stay behind an explicit approval. Sentry and Rootly expose telemetry to agents; Outerbase and dbt Copilot help with database work.

**In practice:** you've used AI with scoped, read-only or throwaway access to debug from real logs or snapshots, or to explore a schema and draft a query or migration — and you reviewed and tested any change that writes data separately.

## Testing and quality engineering

### 16. Generating and improving tests across levels

Use AI to write tests at every level — unit, integration, contract, and E2E — and to generate the fixtures and seed data they need. Two rules keep the tests honest: write them from the requirements and the behavior users see, not from the code the agent just wrote (a test that copies the implementation hides the same bug), and use fake or masked data, never production secrets or personal data. Playwright is a common base for E2E, Pact covers consumer-driven contract testing, Diffblue Cover writes unit tests from runtime behavior, and Trunk finds and quarantines flaky tests.

**In practice:** you've shipped a PR where AI wrote or improved tests at more than one level, generated the fixtures or seed data for them, and helped you fix a failing or flaky test.

### 17. Browser and device automation for testing and UI interaction

Browser and device automation is useful for UI checks, screenshots, regression tests, and turning a written scenario into automation that runs locally and in CI. Use stable APIs, selectors, and test frameworks for checks you want to repeat. Use vision-based computer control only when the UI is hard to reach any other way or the task is exploratory, and run it in an isolated environment with approvals for actions that matter. Browserbase Stagehand and Browser Use work alongside Playwright, and computer-use models can drive the screen, keyboard, and mouse.

**In practice:** you've got browser or device automation running — a Playwright script, simulator control, screenshot checks, or UI automation built from a written scenario.

### 18. Agent traces, evaluations, and regression suites

Product tests check the code an agent wrote; agent evals check the workflow that wrote it. Record end-to-end traces of prompts, tool calls, handoffs, approvals, and results. Build a small dataset from real tasks and past failures, score both the final result and the steps that matter, and re-run it whenever the model, prompts, instructions, tools, or permissions change. Agent behavior varies between runs, so when reliability matters, compare several runs instead of trusting one good demo or a public benchmark.

**In practice:** you've recorded a real agent run, turned at least one failure into a repeatable eval case, and used it to catch a regression or justify a change to the workflow.

## Multi-agent and autonomous execution

### 19. Sub-agents and multi-agent orchestration

Some tasks split into independent parts that each work better in their own context window or in parallel. Give each sub-agent one clear goal and a defined output, and have it return a short summary instead of its full transcript. Start with a single agent and add more only when the work splits cleanly, when a second opinion raises confidence, or when the context is too big for one agent. Skip it for tightly coupled work, where the coordination, duplicate edits, and merge conflicts cost more than you save. The Claude Agent SDK, OpenAI Agents SDK, and LangGraph give you the building blocks.

**In practice:** you've run a multi-agent workflow where each agent had one goal and a defined output, compared it against a single-agent run, and can say when the extra coordination was worth it.

### 20. Sandboxing and granting autonomy gradually

A coding agent runs repo code, package scripts, tools, and network requests, so a prompt injection or a bad dependency can affect more than the diff. Run this work in a dev container, VM, cloud sandbox, or restricted workspace with scoped credentials, limited write paths, and an allowlist of network destinations. Then loosen the rules step by step so approvals don't slow you down: allow known low-risk commands and paths, set time or action budgets and checkpoints, and require approval for raising privileges, touching production, publishing, or deleting. Don't give full host access as a shortcut. [Claude Code](https://code.claude.com/docs/en/security), [Codex](https://developers.openai.com/codex/agent-approvals-security), and the [GitHub Copilot cloud agent](https://docs.github.com/en/copilot/concepts/agents/cloud-agent/about-cloud-agent) all have isolation and permission controls worth setting up on purpose.

**In practice:** your agent runs inside a set boundary with no broad host or production access, its network and write access are limited, you've tuned permissions to cut needless prompts, and risky actions still need approval and leave an audit trail.

### 21. Git worktrees and parallel isolation on one machine

Git worktrees let one repo have several checkouts at once, so different agents or sessions work on separate branches without overwriting each other's files. They don't separate shared databases, ports, credentials, caches, or build output, so those need their own boundaries — Portless (dynamic ports and domains on localhost) or Aspire's isolated mode let you run several copies of the same stack in parallel when each agent needs its own running services. You still review and merge parallel changes on purpose, not blindly.

**In practice:** you've run agents or sessions in parallel on one machine, kept isolated with worktrees plus separate services where needed, and can point to a case where it paid off — like a long refactor running while you kept shipping.

### 22. Async, background, and cloud delegated agents

Agents can also run without you at the keyboard. Either you delegate — write a brief, hand it to a background or cloud agent, and review the PR it returns — or you trigger the agent on a schedule or a repo event (triage new issues, look into failing CI, draft release notes, check for stale docs, open small maintenance PRs). Delegation has limits — most teams delegate far less than they use AI interactively — so save it for small, well-defined tasks you can verify. Delegated or triggered ([GitHub Copilot coding agent and automations](https://docs.github.com/en/copilot/concepts/agents/cloud-agent/about-automations), [OpenAI Codex cloud and automations](https://developers.openai.com/codex/app/automations), Cursor background agents, Claude on the web), an unattended run should be sandboxed, narrow, observable, budget-limited, repeatable, and set up to open a draft for review — not to make big changes on its own.

**In practice:** at least one agent runs unattended — delegated from a brief or triggered by a schedule or event — and opens a draft PR, issue update, or report that a human and automated checks review before anything important lands.

## Harness and context engineering

The items above are the parts of a harness — the tools, prompts, loop, and memory around the model. Harness engineering is designing that setup: tuning the loop, checking output you can't take on the agent's word, and giving the agent better ways to see and remember a large codebase. A useful split is the brain (the model and its loop), the hands (sandboxes and tools), and the session (a durable, replayable record of what happened). Reach for these when one agent in a plain loop isn't enough — long unattended runs, big repos, or work that spans more than one session. One warning: a harness is built around what the model can't do yet, and those workarounds go stale as models improve, so review them instead of carrying them forward.

### 23. Context engineering and token efficiency

Context is a limited attention budget, not a space to fill — the model recalls less well as the window fills up, so choosing what it sees beats cramming it. Keep instructions short and specific, keep the toolset small, fetch information only when you need it, filter command output, summarize finished phases, move detail into external files, and use prompt caching and model routing. Deeper AI use uses more tokens, which is fine — aim for value per token, not the highest or lowest count, and know your plan's budget, limits, and where to see usage per tool. Compression tools like Headroom, Caveman, and RTK can help, but lossy compression can drop something the agent needs, so keep the originals and judge task quality, not just token savings. Output-side Skills like [Ponytail](https://github.com/DietrichGebert/ponytail) cut cost the other way, by getting the agent to write only the code the task needs instead of over-building.

**In practice:** you've measured cost, latency, and success before and after a context change, you know your budget and where to see usage per tool, and you can show the savings didn't hurt correctness or hide something important.

### 24. Loop engineering: designing the agent loop, not just prompting it

The basic loop earlier in this list — edit, build, test, repeat — is the starting point. Loop engineering treats the loop itself as something you design: what the agent does each turn, what signal it reads, how it corrects itself, and when it stops. Set clear stop conditions and turn or token budgets, decide what counts as progress, and shape the feedback the loop runs on so a long unattended run makes progress and finishes, instead of going in circles or stopping too early and calling it done. SDKs and frameworks help, but the stop conditions and feedback are yours to design, whatever framework you use.

**In practice:** you've tuned an agent's loop — stop conditions, a turn or token budget, and the feedback it acts on each step — and a long unattended run finished cleanly because of it.

### 25. Independent verification: the agent does not grade its own work

An agent reviewing its own output almost always approves it, so "the agent says it's done" is not a signal. Put the check where the agent cannot reach it: make the merge gate CI it cannot edit, or run review in a fresh context that never saw the code get written. This is cheap day to day — pipe the diff to a second agent (`git diff | <agent> -p "review this against the spec, list what's wrong"`), use a reviewer sub-agent, or let CodeRabbit or Greptile gate the PR. The reviewer must not be the same context that wrote the code.

**In practice:** before agent work is accepted, a check it can't influence has to sign off — CI it can't edit, a fresh-context review of the diff, or a reviewer sub-agent — and you've caught a confident but wrong "done."

### 26. Code intelligence and structural memory

Agents edit more accurately when they can resolve symbols, types, and references instead of matching text patterns. Give the agent code intelligence — a language server (go-to-definition, find-references, types), tree-sitter or AST tools, and semantic search over the repo — so edits are based on real structure. This cuts changes that break the build, miss call sites, or invent APIs. On very large repos, grep-and-read gets slow and even this isn't enough: index the codebase into a code graph — functions, classes, imports, call chains — that the agent queries over MCP, answering "what calls this?" in a few hundred tokens instead of tens of thousands. [CodeGraph](https://github.com/colbymchenry/codegraph), [CodeGraphContext](https://github.com/CodeGraphContext/CodeGraphContext), and [Potpie](https://github.com/potpie-ai/potpie) build local graphs on tree-sitter and LSP; [Sourcegraph SCIP](https://github.com/sourcegraph/scip) and [stack-graphs](https://github.com/github/stack-graphs) are mature index formats. Use code intelligence everywhere; add a code graph when repo size, not the model, is the bottleneck.

**In practice:** your agent has more than text search — a language server, semantic search, or AST tools — and on a repo too big for grep-and-read it queries a prebuilt code graph, with a measured drop in tokens or tool calls to show for it.

### 27. Continuity across context resets

Even with million-token windows, long runs get worse over time: cost climbs, the model pays less attention to the middle of a very large context, and sessions still end through crashes, new chats, or handoffs between agents. For work that spans sessions, keep the state in a file — a progress or plan file the agent updates and re-reads — and prefer starting a clean context with a clear handoff over quietly summarizing the history in place. This is for long tasks; most single-session work fits fine in a modern context window.

**In practice:** a task that ran across several sessions or context resets stayed on track because the state lived in a file the agent re-read, not only in the chat history.

#### Further reading

- [Anthropic — Harness design for long-running agent applications](https://www.anthropic.com/engineering/harness-design-long-running-apps)
- [Martin Fowler — Harness engineering for coding agents](https://martinfowler.com/articles/harness-engineering.html)
- [LangChain — The Anatomy of an Agent Harness](https://www.langchain.com/blog/the-anatomy-of-an-agent-harness)
- [Sebastian Raschka — Components of a Coding Agent](https://magazine.sebastianraschka.com/p/components-of-a-coding-agent)

## Security, maintenance, and policy

### 28. Security-focused review and threat modeling

Normal code review and passing tests don't reliably catch missing authorization checks, injection points, exposed secrets, unsafe data flows, or supply-chain risk. Use AI to trace trust boundaries and suggest ways the code could be abused, then confirm the findings with scanners and targeted tests. [Codex Security](https://developers.openai.com/codex/security), CodeQL, Semgrep, and secret scanning add to human security review; they don't replace it.

**In practice:** you've run a real security review or threat-model pass on a meaningful feature or diff, confirmed the findings, and added a fix, a test, or a written decision to accept the risk.

### 29. Supply-chain and dual-use risk

Agentic coding adds new supply-chain risks. An agent can invent a package name that doesn't exist, which attackers then register and fill with malware ("slopsquatting"); it can pull in a compromised dependency; or it can be steered by a prompt injection hidden in content it fetched. The same power that ships features can also be misused, so build security in from the start rather than adding it in review. Check that a suggested dependency actually exists and is the right one, pin and scan it, keep untrusted content away from tools that can take action, and keep an audit trail. Scanners like Trivy, Snyk, and Gitleaks add to human judgment; they don't replace it.

**In practice:** you've caught or prevented a made-up or malicious dependency, and in your setup untrusted input can't reach a destructive action without an approval.

### 30. Managing dependency upgrades and security patches

Dependency upgrades and security patches are repetitive and easy to put off, which is how CVEs pile up and breaking-change debt grows. AI is a good fit here: it can read changelogs, compare API changes, update the call sites, run tests in a loop, and handle most of the manual work. Paired with Dependabot, Renovate, or Snyk, upgrades become routine instead of risky.

**In practice:** you've shipped a dependency-upgrade PR where AI handled the breaking changes, applied a security patch with AI triaging the CVE, or used AI to read changelogs and flag breaks early. Your upgrade workflow pairs Dependabot, Renovate, or Snyk with AI.

### 31. AI tools compliant with policy and security guidelines

Using only approved AI tools protects company data and keeps AI usage within policy.

IMPORTANT: Know your organization's AI use policy.

**In practice:** you know which AI tools are approved for your work, you're not using anything outside that list, and your IDE/CLI is signed into the enterprise account.

## Agentic Coding Toolbox

### AI coding agents

- [Claude Code](https://claude.com/claude-code) - Anthropic's agentic coding CLI and IDE integration.
- [Cursor](https://cursor.com) - AI-first code editor.
- [Codex](https://github.com/openai/codex) - Agentic coding from OpenAI.
- [GitHub Copilot](https://github.com/features/copilot) - GitHub's AI pair programmer.
- [Gemini CLI](https://github.com/google-gemini/gemini-cli) - Google's Gemini CLI.
- [Windsurf](https://windsurf.com) - AI editor; acquired by Cognition (2025).
- [Cline](https://cline.bot/) - Open source coding AI agent.
- [OpenCode](https://github.com/anomalyco/opencode) - Open-source coding agent for the terminal, desktop, and IDE.

### Agent instructions and Skills

- [AGENTS.md](https://agents.md/) - Open format for repo-level agent instructions.
- [Anthropic Skills](https://github.com/anthropics/skills) - Anthropic's public collection of reusable Agent Skills.
- [Superpowers](https://github.com/obra/superpowers) - Composable Skills framework with sub-agent patterns.
- [Context7](https://github.com/upstash/context7) - Up-to-date library documentation for AI agents, loadable selectively.
- [GSD (Get Sh*t Done)](https://github.com/gsd-build/get-shit-done) - Meta-prompting, context-engineering, spec-driven Skills system for Claude Code.
- [Skills.sh](https://skills.sh/) - The Open Agent Skills Ecosystem from Vercel Labs.
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
- [Tessl](https://tessl.io) - Agent enablement platform (spec and skills lifecycle, plus a skills registry).
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
- [Ellipsis](https://ellipsis.dev) - Platform to deploy, manage, and observe cloud coding agents; includes AI PR review with auto-fix.

### Agent observability and evaluation

- [OpenAI Agent Evals](https://developers.openai.com/api/docs/guides/agent-evals) - Traces, graders, datasets, and evaluation runs for agent workflows.
- [Langfuse](https://github.com/langfuse/langfuse) - Open-source tracing, prompt management, and evaluation platform for LLM applications.
- [Arize Phoenix](https://github.com/Arize-ai/phoenix) - Open-source observability and evaluation for AI applications and agents.

### Codemods and refactoring

- [GritQL](https://github.com/biomejs/gritql) - Query language for structural codemods, now maintained by Biome (formerly Grit, acquired by Honeycomb in 2025).
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
- [Anthropic Computer Use](https://platform.claude.com/docs/en/docs/agents-and-tools/computer-use) - Claude's screen, keyboard, and mouse control for agent-driven UI automation.

### MCP Servers

- [MCP Registry](https://registry.modelcontextprotocol.io/) - Official registry for discovering published MCP servers.
- [MCP Reference Servers](https://github.com/modelcontextprotocol/servers) - Educational reference implementations; evaluate and harden them before production use.
- [Awesome MCP Servers](https://github.com/punkpeye/awesome-mcp-servers) - Community-curated collection of MCP servers.
- [GitHub MCP](https://github.com/github/github-mcp-server) - Official GitHub MCP server.
- [Playwright MCP](https://github.com/microsoft/playwright-mcp) - Browser automation MCP from Microsoft.
- [Figma Dev Mode MCP](https://developers.figma.com/docs/figma-mcp-server/) - Figma's developer MCP for design context and canvas access.
- [Vestige](https://github.com/samvallad33/vestige) - Local-first MCP memory server for coding agents with SQLite storage, FSRS-style retention, hybrid retrieval, provenance/correction tools, and dashboard inspection.

### Database and data tools

- [Chat2DB](https://github.com/CodePhiliaX/Chat2DB) - AI-assisted SQL client supporting major relational and analytical databases.
- [Outerbase](https://github.com/outerbase/studio) - Open-source database interface with a table viewer and AI query runner; acquired by Cloudflare (2025) and folded into D1/Workers.
- [dbt Copilot](https://www.getdbt.com/product/dbt-copilot) - AI assistant from dbt Labs that generates models, tests, docs, and semantic definitions from natural language.

### Observability and incident response

- [Rootly](https://rootly.com) - Incident platform with AI agents for investigation and retrospectives.
- [Kagent](https://github.com/kagent-dev/kagent) - CNCF Kubernetes-native framework for building and operating agents with tools for Kubernetes, Prometheus, Grafana, Istio, Helm, and other cloud-native systems.
- [incident.io](https://incident.io) - On-call and incident platform with AI summaries and investigation copilots.
- [PagerDuty AIOps](https://www.pagerduty.com) - AI-driven alert noise reduction and incident automation.
- [Sentry](https://sentry.io) - AI-assisted root-cause analysis with an MCP server for agent queries.

### Local development

- [Portless](https://github.com/vercel-labs/portless) - Stable named URLs for localhost services, worktree-aware (Vercel Labs).
- [Aspire](https://aspire.dev/) - Isolated multi-service local dev/test stacks; now language-agnostic (formerly .NET Aspire).

### Voice input

- [Wispr Flow](https://wisprflow.ai) - AI dictation app for macOS and Windows.
- [Superwhisper](https://superwhisper.com) - macOS voice-to-text built on Whisper-family models.

### Token consumption

- [ccusage](https://github.com/ccusage/ccusage) - Local usage and cost analysis for Claude Code and other coding agents.
- [agenttrace](https://github.com/luoyuctl/agenttrace) - Local-first TUI for inspecting AI coding agent session cost, tokens, time, and slow-run diagnostics.
- [Headroom](https://github.com/headroomlabs-ai/headroom) - Local-first, reversible compression for agent context, tool outputs, logs, files, RAG chunks, and conversation history; available as a library, proxy, wrapper, or MCP server.
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
