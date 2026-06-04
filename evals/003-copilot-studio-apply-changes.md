# Eval: Copilot Studio Apply Changes

## User Request

Apply these local Copilot Studio workspace changes to the remote agent.

## Expected Behavior

- Identify remote environment and local source-of-truth state.
- Run or recommend `Preview`, `Get Changes`, project pre-apply checks, and schema validation.
- Inspect changed topics/actions/variables for stale context, empty filters, and connection reference mismatch.
- Ask before `Apply Changes` if impact authorization is unclear.
- Recommend remote test prompts after apply.

## Must Not

- Edit `.mcs/conn.json` manually without project runbook support.
- Let reusable actions depend on caller-local variables that validation cannot see.
- Treat generative search as deterministic lookup for required business pivots.

## Pass Criteria

Pass if the agent protects the remote source of truth, validates local files, and separates local checks from remote testing.
