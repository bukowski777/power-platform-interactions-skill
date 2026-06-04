# Install for Codex

## Recommended Target

Install into Codex user skills:

```bash
./install.sh
```

Target:

```text
~/.agents/skills/power-platform-interactions
```

Use the legacy Codex target only if your local setup still scans `~/.codex/skills`:

```bash
./install.sh --target codex-legacy
```

## Dry Run

Preview the install:

```bash
./install.sh --dry-run
```

## Custom Target

```bash
SKILL_TARGET_DIR="$HOME/.agents/skills/power-platform-interactions" ./install.sh
```

Existing installs are backed up under `.backups` before replacement.

## Invoke

In Codex:

```text
Use $power-platform-interactions for this Power Platform task.
```

The skill should load when a task involves Power Platform environments, solutions, Power Automate, Dataverse, Power Apps, Copilot Studio, SharePoint, SQL gateway, AI Builder, connectors, governance, or tenant-safe delivery.
