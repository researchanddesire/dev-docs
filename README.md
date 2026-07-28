# Research and Desire Developer Docs

This repository is the public content mirror for the [Research and Desire Developer Docs](https://dev.researchanddesire.com), built with [Fumadocs](https://fumadocs.dev/) from the private `researchanddesire/rad-app` monorepo.

## Contribute

1. Fork this repository and create a branch from `main`.
2. Edit Markdown or MDX under `content/`.
3. Open a focused pull request.

After review, automation proposes public changes in `rad-app`. Approved private-source changes are proposed back to this mirror as reviewed pull requests. The `[docs-sync]` commit marker prevents reciprocal loops.

This repository no longer assembles or deploys an independent MkDocs site. Application code, deployment configuration, credentials, generated schemas, and generated build output do not belong here.
