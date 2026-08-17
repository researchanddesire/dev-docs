# Research and Desire Developer Docs

This repository is the public, editable content mirror for [RAD Developer Docs](https://dev.researchanddesire.com). Rendered page titles and section headings link to their exact source lines under `content/docs/`.

## Contribute

Select a pencil on the rendered site or edit a file under `content/docs/`, then open a focused pull request into `main`. The `validate-content` check verifies frontmatter, metadata, and local assets before maintainer review.

Individual API operation pages are generated from the Dashboard OpenAPI document and cannot be edited here. Use their **Report an API docs issue** link instead.

After an approved merge, the dedicated synchronization app mirrors the byte-identical content into the private application repository. The `[docs-sync]` marker prevents reciprocal loops.

See [CONTRIBUTING.md](CONTRIBUTING.md) for the complete workflow.

## License

Cross-product prose is available under CC BY-SA 4.0. Product developer content and source material retain the respective license identified by that product or file.
