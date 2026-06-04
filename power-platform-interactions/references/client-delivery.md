# Client Delivery

## Delivery Posture

Power Platform work is often half implementation and half operational clarity. Deliver artifacts that another maker, admin, DBA, or business owner can understand and safely operate.

Separate:

- business objective;
- tenant/environment;
- solution/component list;
- connection accounts and required permissions;
- data contracts;
- deployment steps;
- validation evidence;
- rollback or recovery path;
- open risks.

## Discovery Checklist

Ask or infer from project docs:

- Which tenant and environment are in scope?
- Is the work DEV-only, TEST, PROD, or a reproduction on another tenant?
- Is there an approved solution and publisher?
- Who owns each connection reference?
- Which user or service account must run flows?
- Are premium connectors, AI Builder credits, gateway, or managed environments involved?
- What is the business failure mode if a run fails or duplicates data?
- What must be documented for the customer's operator?

## Documentation Rules

For every significant change, update the nearest project runbook or docs with:

- component names and display names;
- logical names when relevant;
- required permissions;
- environment variables and whether values are sensitive;
- test data used, sanitized if needed;
- validation commands and observed result;
- known limitations.

Do not include internal drafting notes, commercial targets, secrets, private URLs, or raw run payloads in client-facing documents.

## Handoff Template

```text
Scope:
Environment:
Solution:
Components changed:
Connections:
Permissions:
Deployment/import actions:
Validation:
Skipped checks:
Rollback/recovery:
Owner next actions:
```

## Acceptance Evidence

Prefer evidence that matches the change:

- flow import: re-export and workflow status;
- flow logic: successful manual run and error-path run;
- SharePoint: item, metadata, view, or formatting check;
- Dataverse: solution component, table, form, view, role, or app check;
- SQL gateway: `Get rows (V2)` or `Execute stored procedure (V2)` with small batch;
- Copilot Studio: local schema validation, preview test, then remote test after `Apply Changes`;
- app UI: screenshot or browser probe at relevant viewports.
