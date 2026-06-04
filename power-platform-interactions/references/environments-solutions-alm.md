# Environments, Solutions, and ALM

## Environment Orientation

Always identify:

- tenant;
- environment display name and environment ID;
- Dataverse URL;
- environment type and criticality;
- current authenticated `pac` profile;
- current Microsoft 365 CLI account;
- solution name and unique name;
- publisher and prefix;
- managed or unmanaged state;
- target operation.

Safe inspection commands:

```bash
pac auth list
pac solution list
m365 status --output json
git status --short
```

If a command output can include tenant-private values, summarize only what is needed.

## Solution Boundaries

Prefer solution-aware work for:

- cloud flows;
- Dataverse tables, choices, forms, views, roles, apps;
- connection references;
- environment variables;
- custom connectors;
- Copilot Studio agents when solution-backed;
- AI Builder components.

Do not create default-solution components unless the project explicitly uses that pattern.

## Export and Unpack

For solution artifact review:

```bash
export PP_SOLUTION_NAME="<solution-name>"
export PP_WORK_DIR="tmp/power-platform/<change-name>"

mkdir -p "$PP_WORK_DIR"
pac solution export --name "$PP_SOLUTION_NAME" --path "$PP_WORK_DIR/before.zip" --managed false --overwrite
pac solution unpack --zipfile "$PP_WORK_DIR/before.zip" --folder "$PP_WORK_DIR/unpacked" --packagetype Unmanaged --allowWrite --clobber
```

Keep exports in ignored folders unless the project intentionally versions sanitized unpacked sources.

## Deployment Settings

Create deployment settings when imports need environment-specific values:

```bash
pac solution create-settings --solution-zip "$PP_WORK_DIR/after.zip" --settings-file "$PP_WORK_DIR/deployment-settings.json"
```

Review and protect:

- connection reference IDs;
- environment variable current values;
- tenant URLs;
- service account bindings.

Do not commit deployment settings with real tenant values.

## Import and Publish

Tenant-impacting commands require explicit authorization in the current task:

```bash
pac solution import --path "$PP_WORK_DIR/after.zip" --publish-changes
pac solution publish
m365 flow enable
m365 flow disable
```

Before import:

- confirm target environment and solution;
- re-export if another maker may have edited in the portal;
- compare against the initial baseline;
- identify rollback or recovery;
- state whether the flow/app should remain enabled after import.

Do not use generic instructions as a TEST/PROD managed release process. Follow the customer's ALM pipeline and managed-solution policy.

## Managed vs Unmanaged

Use unmanaged solutions for DEV authoring. Use managed solutions for controlled downstream promotion when the project has ALM in place.

Do not patch managed production components directly unless the customer explicitly accepts the emergency procedure and rollback risk.

## Component Ownership

Document:

- maker or service account owner;
- connection owner;
- flow run-only users if any;
- app sharing groups;
- gateway connection owner;
- solution publisher.

Connection ownership issues are a common cause of imports that succeed but flows that cannot run.
