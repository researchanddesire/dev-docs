# OSS staging — DT_Trainer-OSS

See [STAGING.md](STAGING.md) in Lockbox-OSS for the unified weekly rebase cadence. Replace `Lockbox` with `DT_Trainer` and `Lockbox-OSS` with `DT_Trainer-OSS`.

```bash
git remote add upstream https://github.com/researchanddesire/DT_Trainer.git
git fetch upstream main
git checkout opensource-prep
git rebase upstream/main
```
