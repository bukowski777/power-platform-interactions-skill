# Contributing

## Development Loop

1. Edit the installable skill under `power-platform-interactions/`.
2. Keep detailed content in `power-platform-interactions/references/`.
3. Add examples, templates, or eval cases when the behavior change affects how agents should use the skill.
4. Run validation:

```bash
bash scripts/validate-skill.sh
./install.sh --dry-run
bash scripts/test-install.sh
```

## Content Rules

- Use stable product concepts, not time-sensitive release claims.
- Link to reference files with relative Markdown links.
- Keep examples tenant-neutral and secret-free.
- Add project lessons only as generalized patterns, never as customer credentials or private runtime evidence.
- Prefer actionable checklists, templates, and scenario tests over broad essays.
- Keep `SKILL.md` compact. Route details to `references/`.
- Keep reusable output structures in `power-platform-interactions/templates/`.

## Good Additions

- A repeated Power Platform failure mode with a narrow prevention checklist.
- A connector-specific contract rule that applies across projects.
- A template that improves handoff or review quality.
- An eval case that catches unsafe tenant behavior or vague verification.

## Avoid

- Customer-specific diary entries.
- Real tenant URLs, connection IDs, user emails, run payloads, or screenshots.
- Time-sensitive licensing or feature claims without a current official source.
- Rules that belong only in one project repository.
