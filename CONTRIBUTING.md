# Contributing

Developer documentation lives under `content/docs/` as Markdown and MDX. Sidebar order and section titles are controlled by nearby `meta.json` files.

The easiest path is the pencil beside an editable page title or heading on [dev.researchanddesire.com](https://dev.researchanddesire.com). It opens GitHub's editor on `main` at the exact source line and creates a fork automatically when needed.

Before opening a pull request:

- keep the change focused on supported APIs, firmware, protocols, hardware interfaces, or integrations
- name relevant product, hardware, firmware, and schema versions
- keep images beside the pages that use them
- do not add secrets, application code, build output, or private product information
- run `node scripts/validate-content.mjs` when working locally

Target `main`. A maintainer review and the `validate-content` check are required. Approved content is synchronized into the private renderer automatically.

Contributions use the repository's documented CC BY-SA and product-specific licensing boundaries.
