# Power Automate Cloud Flows

## Scope

Use this reference for cloud flows, solution workflow JSON, expressions, `runAfter`, TRY/CATCH, connector actions, import/export, and runtime verification.

For deep workflow JSON validation, use the dedicated Power Automate authoring skill if available. This reference keeps the broader Power Platform interaction in view.

## Preferred Workflow

1. Identify tenant, environment, solution, flow, owner, connection account, and target behavior.
2. Export a fresh unmanaged solution.
3. Unpack into an ignored working directory.
4. Locate `Workflows/*.json` and associated `.data.xml`.
5. Inspect actions, triggers, connection references, variables, expressions, `runAfter`, concurrency, pagination, retry, and existing naming.
6. Patch narrowly.
7. Validate JSON with `jq empty`.
8. Validate action references, variable references, and `runAfter` targets manually or with a project validator.
9. Pack the solution.
10. If authorized, run a pre-import drift check, import, publish, re-export, and test.

## Naming

Preserve project conventions first. If none exist:

- flow display: `<Domain> - <Event> - <Outcome>`;
- scopes: `INIT_<domain>`, `TRY_<domain>`, `CATCH_<domain>`, `FINALLY_<domain>`;
- variables: `varBusinessMeaning`;
- data actions: `Compose_<meaning>`, `Parse_<payload>`, `Filter_<collection>`, `Select_<shape>`;
- connector actions: `<Verb>_<System>_<Entity>`.

Renaming actions is high risk because expressions and `runAfter` often reference names.

## TRY/CATCH

Production flows should normally include:

- a `TRY_<domain>` scope containing business actions;
- a `CATCH_<domain>` scope running after `Failed` and `TimedOut`;
- structured extraction from `result('TRY_<domain>')`;
- context: flow name, environment, run ID, business key, source item/file/entity, failed action, status, code, message, time, tracking ID if available;
- a durable log destination or project-approved alert;
- a final failure termination unless success-after-catch is an intentional business design.

Do not email full raw payloads by default. Truncate or store details in an approved protected log.

Power Automate does not allow `Initialize variable` inside a scope. Initialize variables at root level before TRY when needed.

## Expressions

Guard expression work:

- protect optional values with `coalesce()` and `empty()`;
- validate arrays before `first()`;
- normalize OCR/user text before `float()`, `int()`, or date parsing;
- prefer `formatNumber(mul(<amount>, 100), '0')` for cent values;
- avoid `formatDateTime()` on non-ISO OCR text;
- avoid silently returning blank business data when a connector fails.

## Batches and Idempotency

For sync flows:

- set trigger concurrency to `1`;
- use small batches;
- store watermarks in a durable state table/list/table row;
- use composite cursors when many rows can share a timestamp;
- use stable upsert keys;
- log both sync state and sync errors;
- activate one flow at a time during first rollout.

## Import Risks

Watch for:

- imported flow left in Draft or Off;
- unresolved connection references;
- metadata cache hiding SQL procedure parameters;
- lost stored-procedure mappings in the designer;
- `InvokerConnectionNotAllowed` or embedded/runtime-source issues;
- flow disabled after repeated failures;
- manual portal edits between export and import.

## Runtime Verification

Minimum useful evidence:

- flow is present in the expected solution;
- state is On/Activated when intended;
- connection references are resolved;
- manual run succeeds on a small sample;
- error path is tested for logging changes;
- target data changed exactly as expected;
- no secrets or personal data were added to versioned files.
