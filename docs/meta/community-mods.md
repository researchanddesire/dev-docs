# Community mods

Research and Desire runs a community mods program for printable upgrades,
accessories, and add-ons across all products — Lockbox, Deep Throat Trainer,
OSSM, and RADR. It works like the [Voron](https://github.com/VoronDesign/VoronUsers)
mods ecosystem: a separate repo for community contributions, with a generated
gallery.

- **Browse mods:** [mods.researchanddesire.com](https://mods.researchanddesire.com)
- **Repo:** [researchanddesire/community-mods](https://github.com/researchanddesire/community-mods)

## Which path is yours?

The deciding question is **what you're changing.**

| Your intent | Where to go | How |
|-------------|-------------|-----|
| **Make a derivative mod** — a new printable part, mount, accessory, or add-on that *layers on top of* a product | [`community-mods`](https://github.com/researchanddesire/community-mods) | Add `mods/<product>/<your-username>/<mod_name>/` and open a PR. See its `CONTRIBUTING.md`. |
| **Change the product itself** — firmware, official hardware (CAD/PCB/cables), or its docs | The **product repo** ([Lockbox](https://github.com/researchanddesire/Lockbox), [DT_Trainer](https://github.com/researchanddesire/DT_Trainer), [ossm](https://github.com/researchanddesire/ossm), [radr-wireless-remote](https://github.com/researchanddesire/radr-wireless-remote)) | Open a PR against that repo's source. |

In short: **if it's a derivative that stands on its own, it's a mod — use `community-mods`. If you want it merged into the main product, open a PR to the product repo.**

A mod can be **hosted** (files live in `community-mods`) or **external / linked**
(it already lives in your own repo and is just *indexed* in the gallery). External
mods keep their own upstream license — see below.

Product repos stay lean — only what's needed to cut a release. Community mods
(and their STLs/print files) live in the separate mods repo so the product
repos don't carry that weight.

## License

**Hosted mods** follow the same unified RAD model as the products they modify —
**CERN-OHL-S v2** for hardware/printable design files, **MPL 2.0** for any
software — with a DCO sign-off. There's no contributor license choice; the
`community-mods` repo enforces it.

**External / linked mods** keep their **upstream license**, declared in
`mod.yml` — it may differ from the default (for example, the
[OSSM M5 Remote](https://github.com/ortlof/OSSM-M5-Remote) is indexed under
CC-BY-SA-4.0). We link to and index these rather than relicensing them.

See `CONTRIBUTING.md` for the full submission rules and the safety-review policy
(mods touching restraint-release, applied force, or electrical get a human
safety pass).

## Standard

The mod metadata contract (`mod.yml`) and its `mod-lint` gate are **self-contained
in the `community-mods` repo** (a single-consumer standard, unlike the
cross-product [BOM standard](bom-standard.md) which is canonical here in dev-docs
and fanned out to every product repo).
