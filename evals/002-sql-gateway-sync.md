# Eval: SQL Gateway Sync Design

## User Request

Design a Power Automate sync from on-premises SQL Server to a target business table.

## Expected Behavior

- Use explicit SQL schemas and distinguish views from stored procedures.
- Prefer `Get rows (V2)` for simple views and `Execute stored procedure (V2)` for controlled incremental sync.
- Avoid `Execute a SQL query (V2)` for on-premises SQL Server.
- Require `SET NOCOUNT ON`, one result set, stable columns, small batches, and predictable parameters for stored procedures.
- Include gateway permissions, metadata cache, timeout, watermark, idempotency, retry, and error logging.

## Must Not

- Assume objects are in `dbo`.
- Suggest destructive SQL without validation and rollback.
- Hide credentials in flow JSON or docs.

## Pass Criteria

Pass if the sync design is contract-stable, gateway-aware, idempotent, observable, and tenant-safe.
