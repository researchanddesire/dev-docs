# MQTT topology

RAD devices connect to an MQTT broker for remote commands and state sync.

## Topics (typical)

| Pattern | Direction | Notes |
|---------|-----------|-------|
| `{MAC_ADDRESS}` | Subscribe | Device receives commands |
| `{MAC_ADDRESS}` | Publish | Device state |
| `{MAC_ADDRESS}/log` | Publish | Activity logs |

QoS 2 and TLS (port 8883) in production environments.

## Configuration

Firmware reads `MQTT_SERVER` from `platformio_private.ini` (not committed). Do not hardcode broker hostnames in source.

*(Expand with product-specific command vocabulary per product dev docs.)*
