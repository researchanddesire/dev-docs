# Product repo template

New Research and Desire hardware or firmware product repos should start from
the private
[`researchanddesire/rad-project-template`](https://github.com/researchanddesire/rad-project-template)
GitHub template repo.

The template establishes the product-repo contract used by the shared docs
sites:

| Content | Source of truth | Published by |
| --- | --- | --- |
| Assembly guide, BOM page prose, assembly images, PCB overview, cable harness pages | `assembly-docs/` in the product repo | `assembly-docs` |
| BOM data | `hardware/bom.csv` in the product repo | Rendered by `assembly-docs` |
| Hardware source assets | `hardware/cad/`, `hardware/pcb/`, `hardware/cables/` | Linked by assembly docs and BOM source fields |
| Developer notes, architecture, tests, integration behavior | `developer-docs/docs/` in the product repo | `dev-docs` |
| End-user quick starts, support docs, FAQs | `simple-docs` repo | `simple-docs` |

## What the template includes

- `assembly-docs/` starter pages with `site.yml`, `nav.yml`, PCB overview,
  cable harness page, and generated BOM markers.
- `developer-docs/docs/` starter pages with `.pages`.
- `hardware/bom.csv`, `hardware/cad/`, `hardware/pcb/`, and
  `hardware/cables/` starters.
- BOM linting and schema sync workflows.
- Dispatch workflows that ask `assembly-docs` and `dev-docs` to rebuild.
- `AGENTS.md`, `CONTRIBUTING.md`, and a Cursor BOM rule.

## Setup checklist

1. Use the GitHub **Use this template** flow from `rad-project-template`.
2. Replace `PRODUCT_NAME`, `PRODUCT_REPO`, `PRODUCT_SLUG`, and
   `PRODUCT_LICENSE`.
3. Replace `assembly-docs/site.yml` with real `slug`, `title`, `license`, and
   `nav_order` values.
4. Configure `DOCS_DISPATCH_TOKEN` in the product repo.
5. Add the `ohai-assembly-docs` GitHub topic only after placeholders are gone
   and local assembly/build checks pass.
6. Add user-facing docs directly to `simple-docs` when the product needs
   customer-facing guidance.

## Required secret

`DOCS_DISPATCH_TOKEN` must be a fine-grained PAT or organization secret with
permission to send `repository_dispatch` events to:

- `researchanddesire/assembly-docs`
- `researchanddesire/dev-docs`

The product repo's default `GITHUB_TOKEN` is scoped to that product repo and
cannot reliably start workflows in sibling repositories.

## Keep ownership clear

The rendered BOM belongs only in the assembly docs site. Developer docs may
document the BOM workflow and link to the BOM standard, but should not embed the
rendered BOM table. User-facing instructions belong in `simple-docs`.

Cable harnesses are product-level BOM assemblies. Detailed child cable BOMs
belong to Wireviz output such as generated `.bom.tsv` artifacts linked from the
assembly docs cable page.
