# Editing documentation

## Golden rule

**Product-specific docs live in the product repo.** This repo only owns cross-product pages and the assembly pipeline.

## Product developer docs

Each product has `developer-docs/` at its repository root:

1. Edit Markdown there in the same PR as code changes when behavior changes
2. Merge to `main` (or `opensource-prep` during OSS prep)
3. Product repos can dispatch a rebuild of [dev.researchanddesire.com](https://dev.researchanddesire.com) (see `trigger-dev-docs.yml` workflows)

## Cross-product docs

Edit files under `docs/meta/` and `docs/contributing/` **in this repo** for ecosystem-wide content:

- How products interact (OSSM ↔ RADR)
- Shared `rad-json` schema
- MQTT topology

## Do not edit assembled folders

Paths like `docs/lockbox/` (except placeholder stubs before first CI run) are **overwritten** by `scripts/assemble-docs.sh`. Your PR should target the product repo's `developer-docs/` instead.
