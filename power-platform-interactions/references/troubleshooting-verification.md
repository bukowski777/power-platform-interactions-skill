# Troubleshooting and Verification

## Diagnosis Loop

1. State the failing behavior and expected behavior.
2. Identify component, environment, solution, owner, connection, and last known good state.
3. Gather evidence from the narrowest useful source: run history, export diff, connector output, app checker, schema validator, SharePoint item, Dataverse row, SQL result, or browser probe.
4. Form one hypothesis at a time.
5. Test with the smallest reversible change or read-only probe.
6. Record result and next action.

## Common Power Automate Failures

| Symptom | Likely causes |
| --- | --- |
| Flow imports but is Draft/Off | unresolved connection reference, missing permission, import behavior |
| SQL procedure not visible | missing `EXECUTE`, wrong database, metadata cache, unsupported signature |
| `ResultSets` empty | no final `SELECT`, missing `SET NOCOUNT ON`, parameter mismatch, no rows |
| Run succeeds but data missing | blank expression fallback, wrong upsert key, skipped branch, pagination off |
| Flow disabled after days | repeated failures without remediation |
| Designer lost mappings | connector metadata cache or new designer issue |
| Duplicate records | missing idempotency key or non-unique filename/business key |
| CATCH did not run | wrong `runAfter` statuses or TRY action outside scope |

## Verification Matrix

Use the checks that match the change:

| Change | Local check | Tenant/runtime check |
| --- | --- | --- |
| Flow JSON | `jq empty`, action reference review | pack/import/re-export, manual run |
| SQL gateway | SQL contract review | `Get rows (V2)` or stored procedure small batch |
| SharePoint columns/views | script dry-run or idempotent run | list metadata and sample item view |
| Dataverse schema | solution diff | app/form/view/role smoke test |
| Canvas/model-driven app | app checker/build when available | non-admin user scenario |
| Copilot Studio | schema validation | preview and remote test |
| Code App | lint/build | deployed app smoke test |

## Evidence Reporting

Do not overstate. Report exactly:

- command or UI check run;
- target environment;
- component checked;
- observed result;
- date/time if operationally useful;
- checks skipped and why.

For private tenant data, summarize rather than paste raw payloads.

## Portal Drift

Before overwriting exported artifacts:

- re-export current target;
- compare the component against your baseline;
- stop if another maker changed it;
- ask the owner whether to merge, overwrite, or restart from the newer export.

## Rollback and Recovery

For every impact change, know one of:

- previous solution package can be re-imported;
- previous component version can be restored from Git/export;
- flow can be disabled safely;
- environment variable can be reverted;
- connection can be re-bound;
- data repair script exists;
- customer accepts manual recovery.
