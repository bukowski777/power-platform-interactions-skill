#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILL_NAME="power-platform-interactions"
VERSION="dev"

usage() {
  cat <<'EOF'
Package the installable skill.

Usage:
  scripts/package-skill.sh [--version VERSION]
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --version)
      [[ -n "${2:-}" ]] || { echo "ERROR: --version requires a value" >&2; exit 2; }
      VERSION="$2"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "ERROR: unknown option: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

bash "${ROOT_DIR}/scripts/validate-skill.sh"

mkdir -p "${ROOT_DIR}/dist"
ARCHIVE="${ROOT_DIR}/dist/${SKILL_NAME}-${VERSION}.zip"
rm -f "${ARCHIVE}" "${ARCHIVE}.sha256"

(
  cd "${ROOT_DIR}"
  zip -qr "${ARCHIVE}" "${SKILL_NAME}"
)

shasum -a 256 "${ARCHIVE}" >"${ARCHIVE}.sha256"
echo "Wrote ${ARCHIVE}"
