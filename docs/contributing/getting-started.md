# Getting started

## Which repository?

| You want to… | Open a PR in… |
|--------------|----------------|
| Change Lockbox firmware or its dev docs | [Lockbox](https://github.com/researchanddesire/Lockbox) |
| Change DTT firmware or its dev docs | [DT_Trainer](https://github.com/researchanddesire/DT_Trainer) |
| Change RADR firmware or its dev docs | [radr-wireless-remote](https://github.com/researchanddesire/radr-wireless-remote) |
| Change OSSM firmware or its dev docs | [ossm](https://github.com/researchanddesire/ossm) |
| Start a new product repo | [rad-project-template](product-repo-template.md) |
| Document cross-product protocols (MQTT, rad-json) | [dev-docs](https://github.com/researchanddesire/dev-docs) `docs/meta/` |
| Change end-user guides | [simple-docs](https://github.com/researchanddesire/simple-docs) |

## Toolchain

Most firmware repos use **PlatformIO** (ESP32-S3, Arduino + ESP-IDF):

```bash
cp platformio_private.ini.example platformio_private.ini
pio run -e development
pio test -e test
```

## Canonical `main` keeps moving

Product teams ship to **`main` continuously**. OSS prep uses **`opensource-prep`** branches and rebases weekly. You do not need a special branch for normal feature work.

## Preview developer docs locally

In a product repo:

```bash
cd developer-docs
pip install mkdocs mkdocs-material
mkdocs serve
```

The unified site (all products) is built from this repo after `scripts/assemble-docs.sh`.
