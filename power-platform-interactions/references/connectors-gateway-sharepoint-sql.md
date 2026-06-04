# Connectors, Gateway, SharePoint, SQL, HTTP, and AI Builder

## Connector Contract First

Before changing an action, identify:

- connector name and operation;
- connection reference logical name;
- authenticated account;
- tenant/environment;
- API permission or license implication;
- input schema, output schema, pagination, throttling, retry, and timeout behavior;
- whether metadata is cached by the designer.

Preserve `connectionName`, `apiId`, `operationId`, connection references, and trigger shape unless changing them is the requested work.

## SQL Server via Gateway

Assume on-premises SQL Server may use a Power Platform gateway.

Use:

- `Get rows (V2)` for simple read-only views;
- `Execute stored procedure (V2)` for controlled business sync, incremental reads, or complex contracts.

Avoid:

- `Execute a SQL query (V2)` for on-premises SQL Server;
- `SELECT *` in integration views;
- multiple result sets from stored procedures consumed by Power Automate;
- long-running procedures and large response bodies.

Stored procedures used by Power Automate should:

- use `SET NOCOUNT ON`;
- return one predictable result set;
- expose stable column names;
- accept explicit batch and cursor parameters;
- remain below gateway timeout;
- use explicit schemas.

Required permissions usually include:

```sql
GRANT SELECT ON SCHEMA::<schema> TO [<gateway-user>];
GRANT EXECUTE ON SCHEMA::<schema> TO [<gateway-user>];
```

Do not apply grants blindly. Validate with the SQL owner.

## SharePoint

For SharePoint lists and libraries:

- distinguish display name, internal field name, list title, list ID, drive ID, and item ID;
- preserve internal names after creation;
- prefer idempotent provisioning scripts for columns and views;
- test with long file names, duplicate names, missing metadata, and library thresholds when relevant;
- handle Choice clearing deliberately. Some connector actions ignore `null`; an empty string may be required by the specific operation;
- keep OData filters simple and compatible with the connector.

For document ingestion:

- filter inline email images, signatures, and tiny attachments before creating files;
- make file names unique when triggers depend on item creation;
- store source message/file identifiers for traceability;
- avoid putting raw attachments or OCR dumps in logs.

## HTTP and External APIs

When using HTTP actions:

- keep base URLs and keys in environment variables or secure references;
- use idempotency keys or upsert semantics for writes;
- verify headers such as `Content-Type`, `Authorization`, and API-specific preferences;
- avoid logging full request/response bodies if they contain personal or customer data;
- document rate limits and retry behavior.

For Supabase/PostgREST-style upserts, prefer a stable conflict key and explicit `Prefer` behavior, but do not hardcode service keys in examples.

## Outlook, Teams, and Mailbox Flows

- Confirm mailbox permissions separately from connector runtime behavior.
- A CLI Graph `403` does not automatically prove the Power Automate connector will fail.
- Use unique identifiers for attachments and messages.
- Avoid sending raw TRY results or personal data in alert emails by default.

## AI Builder and OCR

Treat OCR output as unreliable input:

- normalize amounts before numeric conversion;
- support decimal comma, currency symbols, spaces, and missing fields;
- avoid date conversion on raw non-ISO strings such as AM/PM OCR snippets;
- keep raw OCR text only when operationally justified and protected;
- test with clean, skewed, image, multi-page, and edge-case documents.

## Custom Connectors

For custom connectors:

- identify the OpenAPI source, authentication type, policy templates, and environment;
- avoid editing generated connector definitions without tracking the source;
- validate operation IDs and schemas after import;
- document DLP classification and data exfiltration risk.
