# OSS staging & weekly rebase

While the products are being prepared for open source, structural changes (Opulo-style
layout, license headers, secret externalization, docs moves) land on an `opensource-prep`
branch in each product's OSS staging fork, **not** on the canonical `main`. The canonical
`main` branches stay active for day-to-day development.

| Product | Canonical repo | OSS staging fork |
| --- | --- | --- |
| Lockbox | `researchanddesire/Lockbox` | `researchanddesire/Lockbox-OSS` |
| Deep Throat Trainer | `researchanddesire/DT_Trainer` | `researchanddesire/DT_Trainer-OSS` |
| RADR | `researchanddesire/radr-wireless-remote` | `researchanddesire/RADR-OSS` |
| OSSM | `researchanddesire/ossm` | — (already public) |

Each staging fork carries a `STAGING.md` runbook at its repo root. The weekly cadence keeps
the OSS branch current with upstream development:

```bash
git remote add upstream https://github.com/researchanddesire/<PRODUCT>.git
git fetch upstream main
git checkout opensource-prep
git rebase upstream/main
```

At cutover, the `opensource-prep` branch becomes the public `main`, the OTA/Pages workflows are
enabled, and the legacy Mintlify docs are retired. See the [cutover runbook](https://github.com/researchanddesire/dev-docs/blob/main/CUTOVER.md).
