# BOM standard

The single reference for Bills of Materials across all Research and Desire hardware repos. Every `hardware/<product>/bom.csv` — in `ossm`, `Lockbox`, `DT_Trainer`, and `radr-wireless-remote` — follows this contract so BOMs stay consistent and machine-readable for agents, contributors, and CI.

**Canonical source:** this page (prose) + [`schemas/bom.schema.json`](https://github.com/researchanddesire/dev-docs/blob/main/schemas/bom.schema.json) (machine-readable) live in `dev-docs`. The schema is vendored read-only into each product repo and enforced by the `bom-lint` CI check. Don't fork the standard per repo — edit it here.

## File

- **Location:** `hardware/<product>/bom.csv`
- **Format:** CSV, one row per line item, with the fixed header row below as the first line.

## Editing a BOM

Anyone — human or agent — is welcome to edit `hardware/<product>/bom.csv` directly and push or open a PR. There's no extra gatekeeping: **as long as `bom-lint` passes, the change is good.** The `bom.csv` is human-owned data, not a generated artifact.

Only the schema is locked — `.github/workflows/scripts/bom.schema.json` is vendored read-only from this repo. Don't hand-edit it; changes to the standard itself happen here in `dev-docs`.

## Header row

Use this exact header, in this order:

```
#,Part Name,Category,Description,Qty,UOM,Manufacturer,MFG PN,Vendor,Vendor PN,Design Source,Purchase Source,Notes
```

## Migration from the 12-column header

Existing BOMs using `Source` remain supported by OHAI during migration. Move repository/design paths to `Design Source` and vendor/product URLs to `Purchase Source`; do not infer a missing link. Update validators before migrating a product CSV. Old BOMs retain their original header and row values when imported.

## Columns

The schema tracks both the canonical **field name** (machine identifier) and the **header** it renders as:

| Field name           | Header        | Type    | Required | Notes                                                                 |
| -------------------- | ------------- | ------- | -------- | --------------------------------------------------------------------- |
| `line_item`          | `#`           | integer | yes      | Sequential line number                                                |
| `part_name`          | `Part Name`   | string  | yes      |                                                                       |
| `category`           | `Category`    | string  | yes      | One of the [category codes](#part-category-codes) (closed set)        |
| `description`        | `Description` | string  | no       |                                                                       |
| `qty`                | `Qty`         | number  | yes      | UOM carries the unit; fractions allowed for measured UOMs             |
| `unit_of_measure`    | `UOM`         | string  | no       | Free text (e.g. `each`, `mm`, `ml`, `g`)                              |
| `manufacturer`       | `Manufacturer`| string  | no       |                                                                       |
| `mfg_part_number`    | `MFG PN`      | string  | no       |                                                                       |
| `vendor`             | `Vendor`      | string  | no       |                                                                       |
| `vendor_part_number` | `Vendor PN`   | string  | no       |                                                                       |
| `design_source`      | `Design Source` | string | no      | CAD, PCB or cable design path/URL, else `–` |
| `purchase_source`    | `Purchase Source` | string | no    | Vendor or webstore product URL, else `–` |
| `notes`              | `Notes`       | string  | no       |                                                                       |

## Conventions

- **No blank cells.** An empty value is written as an en-dash `–` (U+2013), never left blank. The schema treats `–` as the "no value" marker.
- **`qty` is a number.** Integers for discrete parts; fractions are fine for measured UOMs (e.g. `412.5` mm of belt). Lint only checks it parses as a number — it does **not** cross-check `qty` against `UOM`.
- **`UOM` is free text.** No closed vocabulary; use sensible units. Kept loose on purpose.
- **`Design Source`** links to the CAD, PCB or cable source that defines the part. Prefer an in-repo relative path; use `–` when no design source is known.
- **`Purchase Source`** links to the vendor or webstore product page. Keep it alongside the design source when both exist. A kit URL is appropriate for parts sold in a kit.
- Mark optional parts explicitly in `Notes`, including the build variant they apply to. Keep their quantity in `Qty`.

## Part category codes

`Category` must be one of these codes — a closed vocabulary. Codes are uppercase. Extend the set only by editing this list (and the schema) here in `dev-docs`; never add codes ad-hoc in a product repo.

| Code | Part Category                   |
| ---- | ------------------------------- |
| ADH  | Adhesive                        |
| ASM  | Assembly                        |
| BTP  | Belt and Pulley                 |
| BTY  | Battery                         |
| CAP  | Capacitor                       |
| CBL  | Cable                           |
| CHA  | Cable Harness Assembly          |
| CON  | Connector                       |
| CSM  | Machined Metal                  |
| EXT  | Extruded Aluminum               |
| FBO  | Fabricated, Other               |
| FDM  | Fused Deposition Modeling Printed Parts |
| FIL  | FDM Filament                    |
| FST  | Fastener                        |
| FUS  | Fuse                            |
| IC   | Integrated Circuit              |
| IND  | Inductor                        |
| INS  | Insulation                      |
| LNM  | Linear Motion                   |
| LUB  | Lubricant                       |
| MCM  | Machined Plastic                |
| MTR  | Motor                           |
| OSC  | Oscillator                      |
| PCA  | Printed Circuit Board Assembly  |
| PCB  | Printed Circuit Board           |
| PCP  | Printed Circuit Board Panel     |
| PKG  | Packaging                       |
| PNU  | Pneumatic                       |
| PPG  | Paper Goods                     |
| PSU  | Power Supply Unit               |
| PWT  | Power Transmission              |
| RES  | Resistor                        |
| SKU  | Stock Keeping Unit              |
| SLA  | Stereolithography Printed Parts |
| SOP  | Standard Operating Procedure    |
| SPR  | Spring                          |
| SWI  | Switch                          |

## How this reaches every repo

- **Humans** read this page at `dev.researchanddesire.com/meta/bom-standard/`; each product repo's `CONTRIBUTING.md` and hardware PR/issue template link here.
- **Agents** get the column contract and category codes inline via each repo's `.cursor/rules/bom.mdc`, which points back here.
- **CI / tooling** validate `bom.csv` against the vendored `bom.schema.json` in `bom-lint`.

The prose + schema are authored once here and fanned out by CI — the same "write once, aggregate, never hand-edit copies" rule used for developer docs.
