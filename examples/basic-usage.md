# Basic Usage

## Prompt

```text
Use $power-platform-interactions to orient in this Power Platform repo.
Do not change tenant state. Identify solution boundaries, likely components, risks, and the first safe verification commands.
```

## Expected Agent Behavior

- Reads project docs and current worktree.
- Identifies Power Platform components and source of truth.
- Separates safe inspection from tenant-impacting commands.
- Recommends narrow next steps.
- Does not run import, publish, enable, disable, delete, or connection changes.

## Good Completion Shape

```text
Found:
- solution sources under <path>
- flow exports under <path>
- docs mention <environment-placeholder>

Safe next checks:
- pac auth list
- pac solution list
- inspect Workflows/*.json with jq

Blocked before impact:
- need explicit target environment and import authorization
```
