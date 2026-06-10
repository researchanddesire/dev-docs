# OSS fork staging — weekly rebase cadence

Canonical product repos **`main` branches are never frozen**. OSS prep uses parallel forks:

| Canonical | OSS staging fork |
| --------- | ---------------- |
| `Lockbox` | [`Lockbox-OSS`](https://github.com/researchanddesire/Lockbox-OSS) |
| `DT_Trainer` | [`DT_Trainer-OSS`](https://github.com/researchanddesire/DT_Trainer-OSS) |
| `radr-wireless-remote` | [`RADR-OSS`](https://github.com/researchanddesire/RADR-OSS) |

## Minimum cadence

Rebase each OSS fork's `opensource-prep` branch onto upstream `main` **weekly**, and again immediately before cutover.

```bash
git fetch upstream main
git checkout opensource-prep
git rebase upstream/main
```

Conflicts are usually OSS-only: `LICENSE`, `ota/`, `developer-docs/`, `.github/pages.yml`.

See [CUTOVER.md](CUTOVER.md) for the coordinated switch window.
