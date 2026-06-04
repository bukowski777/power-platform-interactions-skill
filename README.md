# Power Platform Interactions Skill [![Validate skill](https://github.com/bukowski777/power-platform-interactions-skill/actions/workflows/validate.yml/badge.svg)](https://github.com/bukowski777/power-platform-interactions-skill/actions/workflows/validate.yml) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

Agent skill for safe, practical Microsoft Power Platform work across environments, solutions, Power Automate, Dataverse, Power Apps, Copilot Studio, SharePoint, SQL gateway, AI Builder, governance, and client delivery.

It helps an agent behave like a careful Power Platform consultant: orienting in the tenant, respecting solution boundaries, preserving connector contracts, separating DEV validation from runtime proof, and producing handover notes that an operator can actually use.

## Why It Exists

Power Platform tasks often cross maker portals, solution exports, Dataverse metadata, SharePoint, gateway SQL, service accounts, and business processes. Generic coding habits are not enough: a safe agent needs environment awareness, explicit impact gates, and evidence-backed completion notes.

This skill sits above more specialized skills such as `power-automate-authoring`. Use it to frame the whole Power Platform interaction, then route to deeper procedures for cloud-flow JSON, Dataverse, Copilot Studio, connectors, security, troubleshooting, and client delivery.

## Source Patterns

The skill was distilled from anonymized local project patterns in the freelance workspace, especially:

- SQL gateway synchronization: SQL Server via Power Platform gateway, Power Automate batch sync, target-store upserts, stable SQL contracts, TRY/CATCH flow operations, and production smoke checks.
- Document automation: SharePoint document libraries, Power Automate solution exports, OCR and AI Builder flows, SQL lookup via gateway, review UI, and runbook-driven deployment.
- Copilot Studio synchronization: local/remote Copilot Studio synchronization, `.mcs.yml` validation, connector actions, SharePoint-to-SQL pivots, and topic guardrails.
- Code app delivery: Power Apps Code Apps constraints, connector-first data access, Node standardization, generated-file boundaries, and build gates.

## Use It For

- Power Platform project discovery, audit, reproduction, or stabilization.
- Environment and solution orientation before tenant changes.
- Power Automate, Dataverse, Power Apps, Copilot Studio, SharePoint, SQL gateway, AI Builder, or connector work.
- Tenant-safe ALM handoff, deployment settings, connection references, and environment variables.
- Production-sensitive sync flows, OCR ingestion, app sharing, roles, DLP, or service-account decisions.
- Client-ready runbooks, handoff notes, integration requests, and verification reports.

## What It Enforces

- Identify tenant, environment, solution, source of truth, owner, and connection account before impact.
- Keep tenant-impacting commands explicit: import, publish, enable, disable, delete, reconnect, permission changes.
- Preserve project naming, publisher prefixes, connection references, and component boundaries.
- Treat connector payloads, SQL result sets, watermarks, app screens, and Copilot actions as contracts.
- Keep exports, deployment settings, run payloads, secrets, and screenshots with personal data out of Git.
- Separate checks actually run from checks skipped.

## Repository Layout

```text
power-platform-interactions/
  SKILL.md
  agents/openai.yaml
  references/
  templates/
scripts/
  validate-skill.sh
  test-install.sh
  package-skill.sh
docs/
examples/
evals/
```

## Install

Install for Codex user skills:

```bash
./install.sh
```

Install for Claude Code:

```bash
./install.sh --target claude-code
```

Install across Codex and Claude Code:

```bash
./install.sh --target all
```

Targets:

```text
~/.agents/skills/power-platform-interactions      # Codex user skills
~/.claude/skills/power-platform-interactions      # Claude Code personal skills
~/.codex/skills/power-platform-interactions       # legacy/local fallback only
```

See:

- [Codex installation](docs/installation-codex.md)
- [Claude Code installation](docs/installation-claude-code.md)
- [Examples](docs/examples.md)
- [Use cases](docs/use-cases.md)

## Usage Examples

```text
Use $power-platform-interactions to audit this Power Platform solution before any import.
Focus on environment, solution boundaries, connection references, deployment settings, runtime checks, and rollback.
```

```text
Use $power-platform-interactions to design a SQL Server gateway sync to Dataverse.
Include SQL contract requirements, flow structure, batches, watermarks, error handling, and verification evidence.
```

```text
Use $power-platform-interactions to review this Copilot Studio workspace change.
Check local/remote source of truth, topic routing, connector actions, variables, schema validation, and test prompts.
```

More examples:

- [Basic usage](examples/basic-usage.md)
- [Before / after](examples/before-after.md)
- [Real-world prompts](examples/real-world-prompts.md)

## Included

| Path | Purpose |
| --- | --- |
| `power-platform-interactions/SKILL.md` | Main skill, first checks, operating principles, risk gates, and reference router. |
| `power-platform-interactions/references/` | Detailed guidance for ALM, flows, Dataverse, Power Apps, Copilot Studio, connectors, governance, verification, and delivery. |
| `power-platform-interactions/templates/` | Reusable handoff, solution audit, connector contract, and incident report structures. |
| `docs/` | Installation, examples, and use cases. |
| `examples/` | Prompt examples and before/after usage. |
| `evals/` | Scenario-based evaluation prompts and rubric. |
| `scripts/validate-skill.sh` | Local package validation and obvious secret-pattern checks. |
| `scripts/package-skill.sh` | Builds a release zip containing the installable skill directory. |
| `install.sh` | Local installer with Codex, Claude Code, dry-run, backup, and custom target support. |

## Validate

```bash
bash scripts/validate-skill.sh
./install.sh --dry-run
bash scripts/test-install.sh
```

The validation script checks required files, `SKILL.md` frontmatter, router links, Markdown links, shell syntax, optional shell lint, package size, metadata files, and obvious secret-like patterns.

## Package

```bash
scripts/package-skill.sh --version v0.1.0
```

The archive is written to `dist/`.

To publish a hosted release, push a version tag:

```bash
git tag v0.1.0
git push origin v0.1.0
```

The release workflow validates the skill, creates the zip, and attaches it to the GitHub release.

## Security

This repository must not contain secrets, customer credentials, tenant tokens, private run payloads, exported solution ZIPs, or screenshots with personal data. Use placeholders in reusable examples and keep customer-specific values in ignored local files or the target tenant.

Use placeholders such as `<TENANT_NAME>`, `<ENVIRONMENT_ID>`, `<DATAVERSE_URL>`, `<SOLUTION_NAME>`, `<CONNECTION_REFERENCE>`, `<SHAREPOINT_SITE_URL>`, and `<SECRET_NAME>`.
