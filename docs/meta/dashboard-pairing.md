# Dashboard pairing (LKBX, DTT, RADR)

RAD devices pair with a **dashboard** for remote control, templates, and OTA metadata. During OSS prep, the hosted dashboard at `dashboard.researchanddesire.com` remains the default; self-hosted `rad-app` is planned for a later release.

## Lockbox

- QR / BLE pairing flows link to `RAD_SERVER` (build flag)
- Device publishes MQTT state on `<MAC_ADDRESS>` topics
- User docs: [Lockbox pairing](https://docs.researchanddesire.com/lockbox/quick-start/pairing)

## Deep Throat Trainer

- Pairing uses the dashboard settings URL (`RAD_SERVER/app/settings`)
- Preflight sync before play sessions

## RADR

- OSSM and Lovense device registry under `Software/data/registry.json`
- BLE scanning documented in RADR user guides

## Configuration

Set `RAD_SERVER` in `platformio_private.ini` (see each product repo's `.example` file). Never commit production keys or Wi-Fi credentials.

## Related

- [MQTT topology](mqtt-topology.md)
- [rad-json](rad-json.md)
