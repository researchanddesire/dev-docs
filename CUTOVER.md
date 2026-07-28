# Cutover checklist — unified RAD open source

Coordinate with Lockbox, DT_Trainer, RADR, ossm, simple-docs, and dev-docs maintainers.

## Final rebase (all OSS forks)

- [ ] Lockbox-OSS `opensource-prep` ← upstream `main`
- [ ] DT_Trainer-OSS `opensource-prep` ← upstream `main`
- [ ] RADR-OSS `opensource-prep` ← upstream `main`

## Pre-public audit

- [ ] `git filter-repo` on Lockbox-OSS and DT_Trainer-OSS
- [ ] Secret scan on all public-bound repos
- [ ] OTA URLs validated on `*-OSS` GitHub Pages
- [ ] `workflow_dispatch` deploy dry-run: simple-docs + dev-docs

## Cutover window

1. Rename internal repos → `*-internal`
2. Rename `*-OSS` → canonical public names
3. Enable GitHub Pages (OTA only) on LKBX, DTT, RADR
4. Enable auto-deploy on simple-docs and dev-docs (remove dispatch-only gate)
5. Retire Mintlify (`researchanddesire/docs` archive; remove `dispatch_docs.yml` from public product repos)
6. Firmware releases with updated doc URL constants
7. Rotate MQTT/JWT and dashboard secrets (LKBX/DTT)
8. Archive internal repos when unused

## Post-cutover

- [ ] Org README lists public repos
- [ ] Team remotes + `platformio_private.ini` for all firmware devs
- [ ] KM OSSM-hardware remains operational until human asset migration completes
