#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_NAME="power-platform-interactions"
SOURCE_DIR="${ROOT_DIR}/${SKILL_NAME}"
DRY_RUN=0
TARGETS=()

usage() {
  cat <<'EOF'
Install the power-platform-interactions skill locally.

Usage:
  ./install.sh [--target TARGET] [--dry-run] [--help]

Targets:
  codex        Install to ~/.agents/skills/power-platform-interactions (default)
  claude-code  Install to ~/.claude/skills/power-platform-interactions
  agents       Alias for codex
  codex-legacy Install to ~/.codex/skills/power-platform-interactions
  all          Install to codex and claude-code

Environment:
  AGENTS_HOME       Override Codex user skills home. Default: ~/.agents
  CLAUDE_HOME       Override Claude Code home. Default: ~/.claude
  CODEX_HOME        Override legacy Codex home. Default: ~/.codex
  SKILL_TARGET_DIR  Override install target directory for one custom install.
  SKILL_BACKUP_DIR  Override backup directory. Default: <target skills root>/.backups
EOF
}

add_target() {
  case "$1" in
    all)
      add_target codex
      add_target claude-code
      ;;
    agents)
      TARGETS+=(codex)
      ;;
    codex|claude-code|codex-legacy)
      TARGETS+=("$1")
      ;;
    *)
      echo "ERROR: unknown target: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --target)
      [[ -n "${2:-}" ]] || { echo "ERROR: --target requires a value" >&2; exit 2; }
      add_target "$2"
      shift 2
      ;;
    --dry-run)
      DRY_RUN=1
      shift
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

[[ -f "${SOURCE_DIR}/SKILL.md" ]] || { echo "ERROR: ${SOURCE_DIR}/SKILL.md not found" >&2; exit 1; }

if [[ -n "${SKILL_TARGET_DIR:-}" ]]; then
  [[ "${#TARGETS[@]}" -eq 0 ]] || { echo "ERROR: SKILL_TARGET_DIR cannot be combined with --target" >&2; exit 2; }
  TARGETS=(custom)
elif [[ "${#TARGETS[@]}" -eq 0 ]]; then
  TARGETS=(codex)
fi

target_root() {
  case "$1" in
    codex) printf '%s/skills' "${AGENTS_HOME:-${HOME}/.agents}" ;;
    claude-code) printf '%s/skills' "${CLAUDE_HOME:-${HOME}/.claude}" ;;
    codex-legacy) printf '%s/skills' "${CODEX_HOME:-${HOME}/.codex}" ;;
    custom) dirname "${SKILL_TARGET_DIR}" ;;
  esac
}

target_dir() {
  case "$1" in
    custom) printf '%s' "${SKILL_TARGET_DIR}" ;;
    *) printf '%s/%s' "$(target_root "$1")" "${SKILL_NAME}" ;;
  esac
}

dedupe_targets() {
  local target
  local result=()
  local seen=""
  for target in "${TARGETS[@]}"; do
    if [[ " ${seen} " != *" ${target} "* ]]; then
      result+=("${target}")
      seen="${seen} ${target}"
    fi
  done
  TARGETS=("${result[@]}")
}

install_target() {
  local target="$1"
  local root target_path parent backup_root staging_dir
  root="$(target_root "${target}")"
  target_path="$(target_dir "${target}")"
  parent="$(dirname "${target_path}")"
  backup_root="${SKILL_BACKUP_DIR:-${root}/.backups}"

  printf '\nTarget: %s\n' "${target_path}"
  if [[ "${DRY_RUN}" -eq 1 ]]; then
    echo "Dry run: no files changed."
    return
  fi

  mkdir -p "${parent}" "${backup_root}"
  staging_dir="$(mktemp -d "${parent}/.${SKILL_NAME}-install.XXXXXX")"
  cp -R "${SOURCE_DIR}/." "${staging_dir}/"
  find "${staging_dir}" \( -name '.DS_Store' -o -name 'Thumbs.db' -o -name '__MACOSX' \) -exec rm -rf {} +

  if [[ "${target}" == "claude-code" ]]; then
    rm -f "${staging_dir}/agents/openai.yaml"
    rmdir "${staging_dir}/agents" 2>/dev/null || true
  fi

  if [[ -d "${target_path}" ]]; then
    mv "${target_path}" "${backup_root}/${SKILL_NAME}.$(date +%Y%m%d%H%M%S)"
  fi

  mv "${staging_dir}" "${target_path}"
  echo "Installed ${SKILL_NAME}"
}

dedupe_targets
for target in "${TARGETS[@]}"; do
  install_target "${target}"
done
