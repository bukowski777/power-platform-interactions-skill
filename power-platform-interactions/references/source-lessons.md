# Source Lessons from Local Projects

This skill was distilled from local repositories in the freelance workspace. These are generalized lessons, not customer-specific runbooks.

## SQL Gateway Sync Pattern

Patterns observed:

- SQL Server remains the source of truth for ERP data.
- Power Automate reads SQL Server through a gateway and writes a target read model.
- SQL contracts are versioned as views and stored procedures with explicit schemas.
- Stored procedures consumed by Power Automate must expose stable columns and one result set.
- Sync flows use small batches, durable state, error rows, and stable upsert keys.
- Composite watermarks prevent losing rows that share a timestamp.
- Supabase/PostgREST upserts need stable conflict keys and backend credentials kept outside Git.
- TRY/CATCH and admin-facing sync health make integration failures visible.
- Direct app reads from the ERP were intentionally avoided.

Reusable rule:

```text
Source system
-> stable integration contract
-> Power Automate orchestration
-> idempotent target write
-> observable read model
-> application UX
```

## Document Automation Pattern

Patterns observed:

- SharePoint provisioning was made idempotent through scripts for libraries, columns, views, and formatting.
- Power Automate solution exports were regenerated from Dataverse before flow edits.
- OCR and AI Builder outputs required normalization, fallback parsing, and error-path testing.
- Email attachment ingestion needed filtering for inline images and unique file names.
- Flow CATCH logs needed actionable details, not only "failed".
- SQL lookup through gateway was separated from document ingestion and tested with small batches.
- SPFx review UI had its own build/package verification, separate from flow import checks.

Reusable rule:

```text
Provision SharePoint deterministically.
Treat OCR as untrusted input.
Keep user review UX separate from flow orchestration.
Verify both happy path and dirty document cases.
```

## Copilot Studio Workspace Pattern

Patterns observed:

- The remote Copilot Studio agent can be the source of truth when local files drift.
- `Preview`, `Get Changes`, pre-apply validation, `Apply Changes`, and remote testing form the safe loop.
- Connection references must match the action files actually used.
- Reusable action files should receive explicit inputs and avoid caller-local variables.
- Structured lookup beats generative guessing for customer, equipment, or ticket pivots.
- Conversation state must be cleared when the user changes scope.

Reusable rule:

```text
Natural language
-> deterministic pivot
-> connector action
-> bounded result
-> concise response
```

## Code App Delivery Pattern

Patterns observed:

- Use one Node standard for the repo.
- Do not edit generated directories manually.
- Use Power Platform connectors or governed APIs instead of browser secrets.
- Run lint and build before push.
- Check connector support, CSP, and licensing before promising architecture.

## Existing Power Automate Skill

The local `power-automate-authoring-skill` repository is a focused deep dive for workflow JSON authoring. This broader skill should route there when the task is specifically about cloud-flow JSON, `runAfter`, TRY/CATCH snippets, or solution pack/import details.
