# Copilot Studio

## Source of Truth

For Copilot Studio workspaces, identify whether the portal remote or local workspace is authoritative.

Default:

- use the official VS Code Copilot Studio extension workflow for day-to-day sync;
- run `Preview` and `Get Changes` before local edits when remote drift is possible;
- run project pre-apply checks before `Apply Changes`;
- test in Copilot Studio after applying changes.

Do not manually edit connection files that bind the local workspace to a remote agent unless the project runbook explicitly allows it.

## Local Workspace Objects

Common files:

- `agent.mcs.yml`: instructions, generative settings, sources, and high-level behavior;
- `settings.mcs.yml`: published agent settings and IDs;
- `topics/*.mcs.yml`: deterministic dialog routes and system topics;
- `actions/*.mcs.yml`: connector actions called from topics or generative actions;
- `knowledge/*.mcs.yml`: knowledge sources;
- `variables/*.mcs.yml`: persisted variables;
- `.mcs/conn.json`: remote binding.

## Validation

Use project-provided scripts or Microsoft skill tooling when present:

```bash
node .agents/scripts/schema-lookup.bundle.js validate "<file>.mcs.yml"
node .agents/scripts/connector-lookup.bundle.js list
node .agents/scripts/connector-lookup.bundle.js operation "<connector>" "<operationId>"
```

Run local validation before `Apply Changes`. After sync, verify behavior in the Copilot Studio test surface.

## Topic and Action Guardrails

- Keep conversation start minimal. It should initialize context, not trigger blocking business lookups.
- Use deterministic topics for sensitive routing, identity pivots, or known business workflows.
- Avoid referencing caller-local `Topic.*` variables from reusable action files unless validation proves they are in scope.
- Prefer explicit inputs to connector actions over hidden context assumptions.
- Keep SharePoint and SQL filters complete and neutral when no real input exists, for example a filter that returns no rows.
- Normalize user text before structured lookup when accents, casing, or phrasing vary.
- Persist pivots deliberately: customer ID, equipment ID, ticket ID, pending request, last result set.
- Clear stale context when the user explicitly changes scope.

## Knowledge and Connectors

Use generative knowledge as fallback, not as the only source for deterministic business facts when a structured connector exists.

For business pivots:

```text
natural language input
-> deterministic normalization
-> structured lookup
-> stable business key
-> SQL/Dataverse/SharePoint action
-> concise answer
```

Do not let the agent answer from stale or partial context when the required key is missing.

## Runtime Risks

Watch for:

- local remote drift;
- missing IDs in settings;
- connection references not matching actual actions;
- generative planner calling actions with empty filters;
- OData filters that are valid in one connector surface but invalid in another;
- markdown links generated from non-canonical or missing fields;
- excessive result volumes.

## Completion

Report:

- files changed;
- validation command result;
- whether `Apply Changes` was run;
- remote environment tested;
- prompts or user scenarios tested;
- any remaining portal-side action needed.
