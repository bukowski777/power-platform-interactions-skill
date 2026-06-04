---
name: power-platform-interactions
description: Guides safe Microsoft Power Platform work across environments, solutions, Power Automate, Dataverse, Power Apps, Copilot Studio, SharePoint, SQL gateway, AI Builder, ALM, governance, troubleshooting, and client delivery. Use when a task involves Power Platform architecture, tenant interaction, maker/dev workflows, connector contracts, solution packaging, runtime verification, or production-safe automation changes.
---

# Power Platform Interactions

## Mission

Work with Microsoft Power Platform in a way that is tenant-safe, reviewable, reversible, aligned with the project, and useful to business operators.

Use the language of the user or project. Prefer local project documentation over generic assumptions. If capability or licensing details may have changed, verify against current official Microsoft documentation before giving definitive guidance.

## First Checks

Before tenant-impacting work, identify:

- tenant, environment, Dataverse URL, solution, component, owner account, connection account, and target users;
- requested operation: inspect, design, build, modify, import, publish, enable, disable, delete, migrate, test, or document;
- source of truth: portal, exported solution, local workspace, Git repo, managed solution, or customer runbook;
- rollback path and whether the user explicitly authorized import, publish, enable, disable, delete, or permission changes;
- sensitive values that must stay out of docs, commits, logs, screenshots, and examples.

Inspect the worktree before edits. Keep solution ZIPs, unpacked exports, CLI caches, logs, and run payloads ignored unless the project explicitly versions sanitized artifacts.

## Router

- General operating model, source priority, local artifact policy, and ask-before-impact rules: read [references/operating-model.md](references/operating-model.md).
- Environments, solutions, publishers, connection references, environment variables, deployment settings, `pac`, `m365`, and ALM: read [references/environments-solutions-alm.md](references/environments-solutions-alm.md).
- Cloud flows, workflow JSON, `runAfter`, expressions, TRY/CATCH, import/export, and runtime tests: read [references/power-automate-cloud-flows.md](references/power-automate-cloud-flows.md).
- Dataverse tables, model-driven apps, canvas apps, security roles, forms, views, and Code Apps: read [references/dataverse-power-apps.md](references/dataverse-power-apps.md).
- Copilot Studio `.mcs.yml`, topics, actions, knowledge, variables, and local/remote sync: read [references/copilot-studio.md](references/copilot-studio.md).
- SharePoint, SQL Server gateway, Outlook, HTTP, AI Builder, custom connectors, and connector contracts: read [references/connectors-gateway-sharepoint-sql.md](references/connectors-gateway-sharepoint-sql.md).
- DLP, permissions, service accounts, licensing prompts, managed environments, auditability, and data protection: read [references/security-governance.md](references/security-governance.md).
- Debugging, verification, smoke tests, portal drift, and evidence reporting: read [references/troubleshooting-verification.md](references/troubleshooting-verification.md).
- Client-facing delivery, documentation, runbooks, handoff, and commercial clarity: read [references/client-delivery.md](references/client-delivery.md).
- Local project lessons distilled from anonymized SQL sync, document automation, Copilot Studio, and code app delivery work: read [references/source-lessons.md](references/source-lessons.md).
- Reusable output structures: use [templates/power-platform-handoff.md](templates/power-platform-handoff.md), [templates/solution-audit.md](templates/solution-audit.md), [templates/connector-contract.md](templates/connector-contract.md), or [templates/incident-report.md](templates/incident-report.md).

## Operating Principles

- Treat the tenant as production-like unless proven otherwise.
- Do not assume objects are in `dbo`, default environment, default solution, or a single maker account.
- Preserve existing project naming, publisher prefixes, connection references, and component boundaries.
- Prefer solution-aware changes over ad hoc portal edits when the component is part of ALM.
- Prefer a fresh export before editing Power Automate or Dataverse solution artifacts.
- Prefer connector-supported access and documented gateway constraints over direct, hidden, or front-end secret access.
- Keep business logic near the system that can test and own it: SQL contracts in SQL, orchestration in Power Automate, read models in the target store, UX logic in the app, conversation state in Copilot Studio.
- Keep batches small, idempotent, observable, and retry-safe.
- Never imply deployment, publish, import, activation, or runtime testing happened unless it did.

## High-Risk Gates

Escalate review before touching:

- production or business-critical flows, approvals, billing, notifications, sync, deletion, or external writes;
- connection references, service accounts, gateway connections, DLP policies, security roles, environment variables, or secrets;
- managed solutions, TEST/PROD promotion, publisher prefixes, or component ownership;
- SQL stored procedures, connector metadata, `runAfter`, concurrency, pagination, watermarks, retries, duplicate prevention, or idempotency;
- Copilot Studio generative actions, connector actions, authentication, knowledge sources, or topic routing that affects live user answers.

## Completion Standard

Report:

- files and components changed;
- tenant-impacting commands run, if any, with target environment and solution;
- validation actually run: lint/build, `pac` pack/import/export checks, `jq`, schema validation, portal inspection, manual run, error-path test, smoke query, screenshots, or browser evidence;
- checks skipped and why;
- residual risk and next owner action.
