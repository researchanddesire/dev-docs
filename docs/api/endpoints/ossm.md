---
title: "OSSM (Sex Machine)"
description: "List and retrieve OSSM device information"
---

## List OSSM Devices

`GET /api/v1/ossm`

Returns all OSSM devices you have access to.

- **`limit`** — `number`, *default: `50`*

  Number of records to return (max 100).

- **`offset`** — `number`, *default: `0`*

  Number of records to skip for pagination.

- **`data.data`** — `object[]`, *required*

  Array of OSSM device objects.

- **`id`** — `number`

  Device ID.

- **`bubbleId`** — `string`

  Unique device identifier.

- **`macAddress`** — `string`

  Device MAC address.

- **`chip`** — `string`

  Hardware chip identifier.

- **`ownerId`** — `number`

  ID of the device owner.

- **`lastVisited`** — `string`

  ISO 8601 timestamp of the last device connection.

  - **`OSSMFirmwareId`** — `number`

    ID of the currently installed firmware version.

- **`data.pagination`** — `object`, *required*

  Pagination metadata.

- **`limit`** — `number`

  Number of records returned.

  - **`offset`** — `number`

    Number of records skipped.

**Request**

```bash
curl -H "Authorization: Bearer YOUR_TOKEN" \
  "https://dashboard.researchanddesire.com/api/v1/ossm?limit=50&offset=0"
```

**Response**

```json
{
  "ok": true,
  "data": {
    "data": [
      {
        "id": 1,
        "bubbleId": "ossm-xyz",
        "macAddress": "11:22:33:44:55:66",
        "chip": "ESP32-S3",
        "ownerId": 42,
        "lastVisited": "2026-02-17T09:15:00Z",
        "OSSMFirmwareId": 5
      }
    ],
    "pagination": {
      "limit": 50,
      "offset": 0
    }
  }
}
```

---

## Get OSSM Device

`GET /api/v1/ossm/{id}`

Returns full details for a specific OSSM device.

- **`id`** — `number`, *required*

  The OSSM device ID.

**Request**

```bash
curl -H "Authorization: Bearer YOUR_TOKEN" \
  https://dashboard.researchanddesire.com/api/v1/ossm/1
```

**Response**

```json
{
  "ok": true,
  "data": {
    "id": 1,
    "bubbleId": "ossm-xyz",
    "macAddress": "11:22:33:44:55:66",
    "chip": "ESP32-S3",
    "ownerId": 42,
    "lastVisited": "2026-02-17T09:15:00Z",
    "OSSMFirmwareId": 5,
    "pairingCode": null,
    "pairingExpires": null
  }
}
```

```json
{
  "ok": false,
  "error": "OSSM device not found"
}
```
