# AGENTS

Repository-specific instructions for this skill.

- Keep the installable skill in `power-platform-interactions/`.
- Keep `SKILL.md` short enough to act as a router. Put detailed procedures in `references/`.
- Keep reusable output structures in `power-platform-interactions/templates/`.
- Keep scenario tests in `evals/` and usage examples in `examples/`.
- Do not add tenant secrets, connection IDs, private URLs, run payloads, exported solution ZIPs, screenshots with personal data, or customer credentials.
- Use placeholders for tenant-specific values: `<environment-id>`, `<dataverse-url>`, `<solution-name>`, `<connection-reference>`, `<sharepoint-site-url>`.
- Prefer project-specific conventions over this generic skill when applying it in a real customer repository.
- Before commit or release, run `bash scripts/validate-skill.sh`.
