#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILL_NAME="power-platform-interactions"
SKILL_DIR="${ROOT_DIR}/${SKILL_NAME}"
SKILL_FILE="${SKILL_DIR}/SKILL.md"
AGENT_FILE="${SKILL_DIR}/agents/openai.yaml"
failures=0

fail() {
  echo "ERROR: $*" >&2
  failures=$((failures + 1))
}

require_file() {
  [[ -f "${ROOT_DIR}/$1" ]] || fail "missing required file: $1"
}

required_files=(
  ".editorconfig"
  ".gitattributes"
  ".gitignore"
  "AGENTS.md"
  "CHANGELOG.md"
  "CONTRIBUTING.md"
  "LICENSE"
  "MAINTENANCE.md"
  "package.json"
  "README.md"
  "SECURITY.md"
  "install.sh"
  "scripts/package-skill.sh"
  "scripts/test-install.sh"
  "scripts/validate-skill.sh"
  "docs/installation-codex.md"
  "docs/installation-claude-code.md"
  "docs/examples.md"
  "docs/use-cases.md"
  "examples/basic-usage.md"
  "examples/before-after.md"
  "examples/real-world-prompts.md"
  "evals/rubric.md"
  "evals/001-solution-import-review.md"
  "evals/002-sql-gateway-sync.md"
  "evals/003-copilot-studio-apply-changes.md"
  "evals/004-secret-and-run-payload.md"
  "evals/005-client-handoff.md"
  ".github/CODEOWNERS"
  ".github/workflows/validate.yml"
  ".github/workflows/release.yml"
  "${SKILL_NAME}/SKILL.md"
  "${SKILL_NAME}/agents/openai.yaml"
  "${SKILL_NAME}/references/client-delivery.md"
  "${SKILL_NAME}/references/connectors-gateway-sharepoint-sql.md"
  "${SKILL_NAME}/references/copilot-studio.md"
  "${SKILL_NAME}/references/dataverse-power-apps.md"
  "${SKILL_NAME}/references/environments-solutions-alm.md"
  "${SKILL_NAME}/references/operating-model.md"
  "${SKILL_NAME}/references/power-automate-cloud-flows.md"
  "${SKILL_NAME}/references/security-governance.md"
  "${SKILL_NAME}/references/source-lessons.md"
  "${SKILL_NAME}/references/troubleshooting-verification.md"
  "${SKILL_NAME}/templates/connector-contract.md"
  "${SKILL_NAME}/templates/incident-report.md"
  "${SKILL_NAME}/templates/power-platform-handoff.md"
  "${SKILL_NAME}/templates/solution-audit.md"
)

for file in "${required_files[@]}"; do
  require_file "${file}"
done

if [[ -f "${SKILL_FILE}" ]]; then
  frontmatter_lines="$(grep -n '^---$' "${SKILL_FILE}" | cut -d: -f1 || true)"
  first_frontmatter_line="$(printf '%s\n' "${frontmatter_lines}" | sed -n '1p')"
  second_frontmatter_line="$(printf '%s\n' "${frontmatter_lines}" | sed -n '2p')"
  [[ "${first_frontmatter_line}" == "1" && -n "${second_frontmatter_line}" ]] || fail "SKILL.md must start with YAML frontmatter"
  grep -Eq '^name: power-platform-interactions$' "${SKILL_FILE}" || fail "SKILL.md must define name: power-platform-interactions"
  grep -Eq '^description: .+Use when .+' "${SKILL_FILE}" || fail "SKILL.md description must include Use when"
  description="$(grep -E '^description: ' "${SKILL_FILE}" | sed 's/^description: //')"
  [[ "${#description}" -le 1024 ]] || fail "SKILL.md description is too long"

  while IFS= read -r ref; do
    [[ -f "${SKILL_DIR}/${ref}" ]] || fail "missing SKILL.md reference: ${ref}"
  done < <(grep -Eo '\[[^]]+\]\((references|templates)/[^)]+\.md\)' "${SKILL_FILE}" | sed -E 's/^.*\(((references|templates)\/[^)]+)\)$/\1/' | sort -u)
fi

if [[ -f "${AGENT_FILE}" ]]; then
  grep -Eq '^interface:' "${AGENT_FILE}" || fail "openai.yaml must contain interface section"
  grep -Eq '^policy:' "${AGENT_FILE}" || fail "openai.yaml must contain policy section"
fi

while IFS= read -r md_file; do
  while IFS= read -r link; do
    target="${link%%#*}"
    [[ -z "${target}" ]] && continue
    [[ "${target}" =~ ^https?:// ]] && continue
    [[ -f "$(dirname "${md_file}")/${target}" ]] || fail "broken markdown link in ${md_file#"${ROOT_DIR}/"}: ${link}"
  done < <(grep -Eo '\[[^]]+\]\([^)]+\.md(#[^)]+)?\)' "${md_file}" | sed -E 's/^.*\(([^)]+)\)$/\1/' || true)
done < <(find "${ROOT_DIR}" \( -path "${ROOT_DIR}/.git" -o -path "${ROOT_DIR}/.waylog" \) -prune -o -name '*.md' -print)

bash -n "${ROOT_DIR}/install.sh" || fail "install.sh has shell syntax errors"
bash -n "${ROOT_DIR}/scripts/package-skill.sh" || fail "package-skill.sh has shell syntax errors"
bash -n "${ROOT_DIR}/scripts/test-install.sh" || fail "test-install.sh has shell syntax errors"
bash -n "${ROOT_DIR}/scripts/validate-skill.sh" || fail "validate-skill.sh has shell syntax errors"

if command -v shellcheck >/dev/null 2>&1; then
  shellcheck "${ROOT_DIR}/install.sh" "${ROOT_DIR}"/scripts/*.sh || fail "shellcheck failed"
else
  echo "WARN: shellcheck not installed; skipping shell lint" >&2
fi

secret_pattern='(AKIA[0-9A-Z]{16}|-----BEGIN (RSA |EC |OPENSSH |DSA )?PRIVATE KEY-----|ghp_[A-Za-z0-9_]{30,}|github_pat_[A-Za-z0-9_]{30,}|sk-[A-Za-z0-9]{20,}|xox[baprs]-[A-Za-z0-9-]{10,}|[B]earer [A-Za-z0-9._~+/=-]{20,}|[e]yJ[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+|[Pp]assword=|[Ss]ervice[_ -]?[Rr]ole[_ -]?[Kk]ey\s*[:=]\s*[A-Za-z0-9._-]{12,})'
secret_scan_file="$(mktemp "${TMPDIR:-/tmp}/power-platform-interactions-secret-scan.XXXXXX")"
grep -RInIE "${secret_pattern}" \
  --exclude-dir=.git \
  --exclude-dir=.waylog \
  --exclude-dir=dist \
  --exclude-dir=tmp \
  "${ROOT_DIR}" >"${secret_scan_file}" || true

if [[ -s "${secret_scan_file}" ]]; then
  cat "${secret_scan_file}" >&2
  fail "possible secret-like value detected"
fi
rm -f "${secret_scan_file}"

metadata_files="$(find "${ROOT_DIR}" \( -path "${ROOT_DIR}/.git" -o -path "${ROOT_DIR}/.waylog" -o -path "${ROOT_DIR}/dist" -o -path "${ROOT_DIR}/tmp" \) -prune -o \( -name '.DS_Store' -o -name 'Thumbs.db' -o -name '__MACOSX' \) -print || true)"
if [[ -n "${metadata_files}" ]]; then
  printf '%s\n' "${metadata_files}" >&2
  fail "metadata files must not be included"
fi

skill_file_count=$(find "${SKILL_DIR}" -type f | wc -l | tr -d ' ')
if [[ "${skill_file_count}" -gt 40 ]]; then
  fail "skill package has ${skill_file_count} files; expected 40 or fewer"
fi

if [[ "${failures}" -gt 0 ]]; then
  echo "Validation failed with ${failures} error(s)." >&2
  exit 1
fi

echo "Skill validation passed."
