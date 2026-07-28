# Research and Desire — Developer Documentation

Everything you need to **develop** across RAD open-hardware products.

## Products

<div class="rad-doc-grid">
  <a class="rad-doc-card" href="lockbox/">
    <span class="rad-doc-kicker">Developer Docs</span>
    <strong>Chastity Lockbox</strong>
    <span>Firmware, hardware interfaces, architecture notes, and product-specific development references.</span>
  </a>
  <a class="rad-doc-card" href="dtt/">
    <span class="rad-doc-kicker">Developer Docs</span>
    <strong>Deep Throat Trainer</strong>
    <span>Product development notes and implementation references for the DTT platform.</span>
  </a>
  <a class="rad-doc-card" href="radr/">
    <span class="rad-doc-kicker">Developer Docs</span>
    <strong>RADR Wireless Remote</strong>
    <span>Remote firmware, protocol, integration, and hardware development context.</span>
  </a>
  <a class="rad-doc-card" href="ossm/">
    <span class="rad-doc-kicker">Developer Docs</span>
    <strong>OSSM</strong>
    <span>Open-source development references for firmware, hardware, and integration work.</span>
  </a>
</div>

## Source Packages

| Product | Developer docs source | Published section |
|---------|----------------------|-------------------|
| Chastity Lockbox | [Lockbox/developer-docs/](https://github.com/researchanddesire/Lockbox/tree/main/developer-docs) | [Lockbox](lockbox/index.md) |
| Deep Throat Trainer | DT_Trainer/developer-docs/ | [DTT](dtt/index.md) |
| RADR Wireless Remote | radr-wireless-remote/developer-docs/ | [RADR](radr/index.md) |
| OSSM | [ossm/developer-docs/](https://github.com/researchanddesire/ossm/tree/main/developer-docs) | [OSSM](ossm/index.md) |

User-facing guides live at [docs.researchanddesire.com](https://docs.researchanddesire.com).

!!! note "How this site is built"
    Product-specific pages are **copied from each product repo** at deploy time (`scripts/assemble-docs.sh`). Edit docs in the product repo, not in the assembled paths here.
