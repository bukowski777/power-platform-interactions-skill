# Dataverse and Power Apps

## Dataverse Tables and Model

Before changing Dataverse:

- identify environment, solution, publisher prefix, table logical name, display name, ownership, and managed state;
- inspect dependencies: forms, views, apps, flows, business rules, security roles, columns, relationships, choices, keys, and command bars;
- distinguish schema changes from data changes;
- identify whether the target is DEV authoring or managed ALM promotion.

Use explicit logical names in docs and scripts. Display names are not stable enough for automation.

## Schema Changes

For tables, columns, relationships, and choices:

- preserve publisher prefix;
- avoid renaming logical names after creation;
- document required/optional values and default values;
- define alternate keys for idempotent integration when appropriate;
- avoid putting external secrets or volatile connection details into rows;
- test forms, views, flows, and apps that depend on the changed column.

## Security Roles

When changing security:

- state the business role, table, privilege, depth, and rationale;
- test with a user assigned only the intended role set;
- avoid solving app issues by granting broad admin permissions;
- document required read privileges for lookup tables and related records.

## Model-Driven Apps

Check:

- sitemap;
- table forms and views;
- command behavior;
- business process flows if present;
- role visibility;
- mobile usability when relevant.

Do not hide data-quality or permission problems behind form scripting.

## Canvas Apps

Check:

- data sources and connection ownership;
- delegation warnings;
- formula dependencies;
- screen size and responsiveness;
- error handling for connector failures;
- app checker output;
- environment variables or connection references when solution-aware.

Avoid storing secrets in app formulas or front-end variables.

## Code Apps

For Power Apps Code Apps or pro-code surfaces:

- use the project Node version and package manager;
- do not manually edit generated directories such as `.power` or `src/generated`;
- access data through Power Platform connectors or governed APIs, not direct browser secrets;
- configure CSP deliberately for external APIs;
- run lint and build before push;
- confirm connector support and licensing in the target environment.

## Power BI

If Power BI enters scope, treat it as a separate delivery stream:

- identify workspace, dataset/semantic model, refresh owner, gateway, RLS, and deployment pipeline;
- do not mix confidential report data into Power Apps or flow logs;
- verify refresh and sharing with a non-admin user.
