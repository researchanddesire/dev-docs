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

## CI access to private forks (during prep)

The OSS staging forks (`Lockbox-OSS`, `DT_Trainer-OSS`, `RADR-OSS`) and `ossm` are **private** until cutover. The default `GITHUB_TOKEN` cannot clone sibling private repos, so CI authenticates with **per-repo read-only deploy keys** (machine credentials — no personal token):

| Repo | Deploy key secret |
| ---- | ----------------- |
| `Lockbox-OSS` | `ASSEMBLE_SSH_KEY_LOCKBOX` |
| `DT_Trainer-OSS` | `ASSEMBLE_SSH_KEY_DTT` |
| `RADR-OSS` | `ASSEMBLE_SSH_KEY_RADR` |
| `ossm` | `ASSEMBLE_SSH_KEY_OSSM` |

To rotate a key:

```bash
ssh-keygen -t ed25519 -N "" -C "dev-docs-assemble-<repo>" -f ./key
gh api -X POST repos/researchanddesire/<repo>/keys -f title="dev-docs-assemble (read-only)" -f key="$(cat ./key.pub)" -F read_only=true
gh secret set ASSEMBLE_SSH_KEY_<NAME> --repo researchanddesire/dev-docs < ./key
```

The script also accepts `ASSEMBLE_GITHUB_TOKEN` (HTTPS) and `ASSEMBLE_LOCAL` (local checkout) as fallbacks. At cutover the repos become public and no credentials are required.
