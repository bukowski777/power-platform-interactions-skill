#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMP_ROOT="$(mktemp -d "${TMPDIR:-/tmp}/power-platform-interactions-install.XXXXXX")"
trap 'rm -rf "${TMP_ROOT}"' EXIT

SKILL_TARGET_DIR="${TMP_ROOT}/skills/power-platform-interactions" \
  "${ROOT_DIR}/install.sh" --dry-run >/dev/null

SKILL_TARGET_DIR="${TMP_ROOT}/skills/power-platform-interactions" \
  "${ROOT_DIR}/install.sh" >/dev/null

test -f "${TMP_ROOT}/skills/power-platform-interactions/SKILL.md"
test -f "${TMP_ROOT}/skills/power-platform-interactions/references/environments-solutions-alm.md"

echo "Test install passed."
