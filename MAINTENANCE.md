# Maintenance

## Release

1. Run validation:

```bash
bash scripts/validate-skill.sh
./install.sh --dry-run
bash scripts/test-install.sh
```

2. Package locally when needed:

```bash
bash scripts/package-skill.sh --version v0.1.0
```

3. Push a tag to publish a GitHub release:

```bash
git tag v0.1.0
git push origin v0.1.0
```

## Review Cadence

Review the skill when:

- Microsoft changes Power Platform CLI, solution ALM, Copilot Studio workspace, Code Apps, or connector behavior.
- A project uncovers a recurring runtime failure pattern.
- A project adds a new class of Power Platform work such as custom connectors, managed environments, Power BI delivery, or governance automation.

Keep the generic skill tenant-neutral. Put customer-specific operational runbooks in the customer repository.

## File Ownership

- `power-platform-interactions/SKILL.md`: mission, first checks, operating principles, gates, and router.
- `power-platform-interactions/references/`: detailed domain guidance.
- `power-platform-interactions/templates/`: reusable output structures.
- `docs/`: installation and usage documentation.
- `examples/`: prompt examples and before/after examples.
- `evals/`: scenario prompts and pass/fail rubrics.
- `scripts/`: repository validation, packaging, and install tests.

## Pre-Commit Verification

```bash
bash scripts/validate-skill.sh
./install.sh --dry-run
bash scripts/test-install.sh
scripts/package-skill.sh --version test-package
find power-platform-interactions -maxdepth 3 -type f | sort
sed -n '1,180p' power-platform-interactions/SKILL.md
```

## Review Checklist

- `SKILL.md` stays compact and router-oriented.
- New references are linked from the router when relevant.
- Templates contain placeholders, not real client data.
- Evals cover unsafe tenant actions, skipped verification, and source-of-truth confusion.
- CI can validate without external services.
- Release packaging creates an installable zip and checksum.
- The change improves future agent behavior, not only documentation aesthetics.
