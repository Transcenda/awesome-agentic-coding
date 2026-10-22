# Contributing

Thanks for helping keep Awesome AI-Native Engineering practical and current.

## What Belongs Here

Roadmap additions should describe a concrete engineering practice that is not already covered. Each roadmap item needs:

- A short body: what to do and why, in three to five sentences.
- An **In practice** line that names something the reader can point to, such as a file, a config, or a run.
- A clear distinction from existing roadmap items.

Toolbox additions must meet all of these:

- Supports one or more roadmap items.
- Has a public repository with an open-source license, at least 200 GitHub stars, and a commit in the last 6 months, and is not archived.
- Adds coverage rather than duplicating an existing entry.

A commercial tool without a public repository is included only when it is widely used, directly relevant, and has no comparable open-source option.

Maintainers can waive the star minimum for a tool that covers part of a roadmap item no other Toolbox entry covers. Waived entries are listed in `star_exceptions` in [check-toolbox.sh](.github/scripts/check-toolbox.sh) and must still meet the other rules.

The [Toolbox freshness](.github/workflows/toolbox-freshness.yml) workflow checks the repository rules on every pull request and once a month, and entries that stop meeting them are removed.

## Writing Style

The readers are engineers on international teams, so write plain, technical English and keep it short.

- No em dashes. Use a comma, a period, or parentheses.
- No marketing language, warm-up sentences, or summary sentences.
- No "not X but Y" or "not just X" phrasing, and no lists of three added for rhythm.
- Name the tool, file, or command instead of describing it.

## Before Opening a Pull Request

1. Search the roadmap and Toolbox for duplicates.
2. Confirm every new link resolves.
3. Use the existing one-line entry format: `- [Name](URL) - Description.`
4. Add entries to the most specific existing category.
5. Run `npx awesome-lint`.

For a new roadmap item, explain why the use case is not already covered. For a Toolbox entry, name the roadmap item or items it supports.

## Pull Requests

Keep pull requests focused. In the description, include:

- What you are adding or changing.
- Why it belongs in the roadmap or Toolbox.
- Evidence that the resource is maintained and useful.

By contributing, you agree that your contribution is licensed under the [Creative Commons Attribution 4.0 International License](LICENSE).

## Reporting Problems

Issues are disabled. Open a pull request to suggest a resource or to fix a broken or outdated link. Security vulnerabilities should be reported privately through GitHub's security advisory feature rather than a public issue.
