# Before and After

## Weak Prompt

```text
Fix the Power Automate flow and import it.
```

## Strong Prompt

```text
Use $power-platform-interactions to fix the DEV Power Automate flow in this solution export.
First identify environment, solution, flow, connection references, and rollback.
Patch only the broken expression.
Run JSON validation and pack the solution.
Do not import or publish until I approve.
```

## Weak Completion

```text
Fixed and imported. It should work now.
```

## Strong Completion

```text
Changed:
- Workflows/<flow>.json: updated 2 references from Old_action to New_action

Validated:
- jq empty passed
- pac solution pack passed

Not run:
- import/publish, because approval was not given
- runtime test, because no tenant impact was authorized

Residual risk:
- connector designer may still cache old SQL metadata; verify after import with one manual DEV run
```
