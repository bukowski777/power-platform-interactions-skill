# Install for Claude Code

Install into Claude Code personal skills:

```bash
./install.sh --target claude-code
```

Target:

```text
~/.claude/skills/power-platform-interactions
```

Install across Codex and Claude Code:

```bash
./install.sh --target all
```

Claude Code installs omit the Codex-specific `agents/openai.yaml` file.

Invoke in Claude Code:

```text
/power-platform-interactions
```

Or ask naturally:

```text
Use the Power Platform interactions skill to review this solution import plan.
```
