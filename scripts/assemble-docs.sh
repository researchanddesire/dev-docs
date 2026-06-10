#!/usr/bin/env bash
# Assemble product developer-docs into docs/{product}/ for unified MkDocs build.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
WORK="${ROOT}/.assemble-work"
rm -rf "$WORK"
mkdir -p "$WORK"

clone_or_copy() {
  local repo=$1
  local branch=${2:-main}
  local dest=$3
  if [ -n "${ASSEMBLE_LOCAL:-}" ] && [ -d "${ASSEMBLE_LOCAL}/${repo}/developer-docs/docs" ]; then
    echo "Using local ${ASSEMBLE_LOCAL}/${repo}/developer-docs"
    mkdir -p "$dest"
    cp -R "${ASSEMBLE_LOCAL}/${repo}/developer-docs/docs/." "$dest/"
    return
  fi
  echo "Cloning researchanddesire/${repo}@${branch}"
  git clone --depth 1 --branch "$branch" "https://github.com/researchanddesire/${repo}.git" "$WORK/$repo"
  mkdir -p "$dest"
  if [ -d "$WORK/$repo/developer-docs/docs" ]; then
    cp -R "$WORK/$repo/developer-docs/docs/." "$dest/"
  else
    echo "WARN: no developer-docs/docs in ${repo}"
  fi
}

LOCKBOX_BRANCH="${LOCKBOX_BRANCH:-opensource-prep}"
clone_or_copy "Lockbox" "$LOCKBOX_BRANCH" "${ROOT}/docs/lockbox"
clone_or_copy "DT_Trainer" "main" "${ROOT}/docs/dtt"
clone_or_copy "radr-wireless-remote" "main" "${ROOT}/docs/radr"
clone_or_copy "ossm" "main" "${ROOT}/docs/ossm"

echo "Assembled product docs into docs/{lockbox,dtt,radr,ossm}"
