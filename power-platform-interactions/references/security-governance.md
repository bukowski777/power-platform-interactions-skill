# Security and Governance

## Secrets

Never store in reusable docs or versioned files:

- passwords;
- API keys;
- bearer tokens;
- Supabase service-role keys;
- SQL connection strings;
- private keys;
- connection IDs tied to a tenant;
- exported run payloads;
- screenshots containing personal data or secrets.

Use environment variables, deployment settings, Power Platform current values, Azure Key Vault, GitHub Actions secrets, or the customer's approved secret store.

## Service Accounts and Connections

Document:

- account purpose;
- license needs;
- mailbox/shared mailbox access;
- gateway data source access;
- Dataverse role;
- SharePoint permissions;
- flow ownership;
- break-glass or transfer process.

Avoid personal user connections for critical production flows when a service account is expected.

## DLP and Managed Environments

Before introducing connectors, check:

- environment DLP policy;
- connector business/non-business classification;
- premium connector licensing;
- AI Builder capacity;
- custom connector approvals;
- data residency and customer policy;
- managed environment restrictions.

Do not design around blocked DLP with shadow APIs unless the customer explicitly approves an governed alternative.

## Permissions

Use least privilege:

- Dataverse: table privileges and depth aligned to business role;
- SharePoint: site/list/library permissions aligned to owner and operators;
- SQL gateway: `SELECT` and `EXECUTE` only on required schemas or objects;
- Power Automate: maker/admin rights only where needed;
- Copilot Studio: authoring and publishing permissions separated when possible.

## Data Protection

Classify data before logging or moving it:

- public/reference;
- internal;
- confidential business;
- personal data;
- credentials/secrets.

For personal or confidential data:

- minimize payload;
- truncate debug logs;
- avoid email alerts with raw bodies;
- avoid exporting runs into Git;
- sanitize examples.

## Tenant-Impacting Operations

Require explicit authorization before:

- import/publish;
- enable/disable/delete flow;
- change DLP/security roles/permissions;
- add connection reference or reconnect;
- change gateway data source;
- publish Copilot Studio changes;
- share apps broadly;
- change production environment variables.

State target environment and expected impact before running the command.
