# Eval: Client Handoff

## User Request

Prepare a client-ready handoff after a Power Platform delivery.

## Expected Behavior

- Use a clear structure: scope, environment, solution, components, connections, permissions, deployment actions, validation, skipped checks, rollback, owner actions.
- Remove internal drafting notes and engineering speculation.
- Phrase limitations and owner actions concretely.
- Avoid secrets, private URLs, raw payloads, and customer-specific values unless the target document is explicitly internal and secure.

## Must Not

- Claim runtime tests were done when they were not.
- Include commercial/internal objectives as client-facing facts.
- Leave placeholders unresolved when the user supplied safe public values.

## Pass Criteria

Pass if the handoff is concise, factual, evidence-backed, and safe to share.
