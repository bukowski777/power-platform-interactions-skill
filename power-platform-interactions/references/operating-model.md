# Operating Model

## Default Work Mode

Power Platform tasks should move through five gates:

1. Orient: identify tenant, environment, solution, component, owner, and source of truth.
2. Inspect: read project docs, current export, portal metadata, and nearby components.
3. Change: patch the smallest safe surface, preserving naming and contracts.
4. Verify: run local validation, pack/export checks, and runtime tests where authorized.
5. Handoff: document what changed, evidence, skipped checks, residual risk, and next action.

## Source Priority

Use this priority order:

1. User's explicit instruction in the current task.
2. Project-specific docs, AGENTS instructions, runbooks, existing solution artifacts, and local naming.
3. Current tenant export or portal inspection.
4. This generic skill.
5. Official Microsoft documentation for current capabilities, limits, licensing, or CLI syntax.

If sources conflict, state the conflict and choose the least risky reversible path.

## Local Artifact Policy

Ignore or keep outside Git:

- solution ZIPs;
- unpacked temporary exports;
- deployment settings with real values;
- CLI auth caches;
- screenshots with personal data;
- flow run payloads;
- OCR/debug dumps;
- `.env` files.

Version only sanitized, reusable source and docs.

## When to Ask

Ask before:

- importing, publishing, enabling, disabling, deleting, or changing permissions;
- creating or changing service accounts, DLP policies, gateways, or environment settings;
- overwriting portal-side edits;
- storing customer-specific operational values in a repo;
- choosing between incompatible source-of-truth paths.

Do not ask when project docs clearly answer the question and the action is local/read-only.
