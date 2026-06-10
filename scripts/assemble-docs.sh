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
  local clone_url="https://github.com/researchanddesire/${repo}.git"
  if [ -n "${ASSEMBLE_GITHUB_TOKEN:-}" ]; then
    clone_url="https://x-access-token:${ASSEMBLE_GITHUB_TOKEN}@github.com/researchanddesire/${repo}.git"
  fi
  git clone --depth 1 --branch "$branch" "$clone_url" "$WORK/$repo"
  mkdir -p "$dest"
  if [ -d "$WORK/$repo/developer-docs/docs" ]; then
    cp -R "$WORK/$repo/developer-docs/docs/." "$dest/"
  else
    echo "WARN: no developer-docs/docs in ${repo}"
  fi
}

LOCKBOX_REPO="${LOCKBOX_REPO:-Lockbox-OSS}"
DTT_REPO="${DTT_REPO:-DT_Trainer-OSS}"
RADR_REPO="${RADR_REPO:-RADR-OSS}"
OSSM_REPO="${OSSM_REPO:-ossm}"

# During OSS prep, assemble from public *-OSS forks (main = opensource-prep content).
# At cutover, set LOCKBOX_REPO=Lockbox etc. to canonical public repos.
LOCKBOX_BRANCH="${LOCKBOX_BRANCH:-main}"
DTT_BRANCH="${DTT_BRANCH:-main}"
RADR_BRANCH="${RADR_BRANCH:-main}"

clone_or_copy "$LOCKBOX_REPO" "$LOCKBOX_BRANCH" "${ROOT}/docs/lockbox"
clone_or_copy "$DTT_REPO" "$DTT_BRANCH" "${ROOT}/docs/dtt"
clone_or_copy "$RADR_REPO" "$RADR_BRANCH" "${ROOT}/docs/radr"
clone_or_copy "$OSSM_REPO" "main" "${ROOT}/docs/ossm"

echo "Assembled product docs into docs/{lockbox,dtt,radr,ossm}"
