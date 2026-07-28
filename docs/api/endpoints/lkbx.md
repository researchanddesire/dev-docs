---
title: "LKBX (Chastity Lockbox)"
description: "Manage lockbox devices, lock templates, and view device status"
---

## List Lockbox Devices

`GET /api/v1/lkbx`

Returns all Chastity Lockbox devices you have access to.

- **`limit`** — `number`, *default: `50`*

  Number of records to return (max 100).

- **`offset`** — `number`, *default: `0`*

  Number of records to skip for pagination.

- **`data.data`** — `object[]`, *required*

  Array of lockbox device objects.

- **`id`** — `number`

  Device ID.

- **`bubbleId`** — `string`

  Unique device identifier.

- **`macAddress`** — `string`

  Device MAC address.

- **`ownerId`** — `number`

  ID of the device owner.

- **`locked`** — `boolean`

  Whether the device is currently in a locked state.

- **`hueShift`** — `number`

  LED color customization value.

  - **`lastVisited`** — `string`

    ISO 8601 timestamp of the last device connection.

- **`data.pagination`** — `object`, *required*

  Pagination metadata.

- **`limit`** — `number`

  Number of records returned.

  - **`offset`** — `number`

    Number of records skipped.

**Request**

```bash
curl -H "Authorization: Bearer YOUR_TOKEN" \
  "https://dashboard.researchanddesire.com/api/v1/lkbx?limit=50&offset=0"
```

**Response**

```json
{
  "ok": true,
  "data": {
    "data": [
      {
        "id": 1,
        "bubbleId": "lkbx-abc",
        "macAddress": "AA:BB:CC:DD:EE:FF",
        "ownerId": 42,
        "locked": true,
        "hueShift": 120,
        "lastVisited": "2026-02-17T10:30:00Z"
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

## Get Lockbox Device

`GET /api/v1/lkbx/{id}`

Returns full details for a specific lockbox device.

- **`id`** — `number`, *required*

  The lockbox device ID.

**Request**

```bash
curl -H "Authorization: Bearer YOUR_TOKEN" \
  https://dashboard.researchanddesire.com/api/v1/lkbx/1
```

---

## List Lock Templates

`GET /api/v1/lkbx/templates`

Returns all lock templates you have access to. These templates define how a lock session behaves.

- **`limit`** — `number`, *default: `50`*

  Number of records to return (max 100).

- **`offset`** — `number`, *default: `0`*

  Number of records to skip for pagination.

- **`data.data`** — `object[]`, *required*

  Array of lock template objects.

- **`id`** — `number`

  Template ID.

- **`name`** — `string`

  Template name.

- **`duration`** — `number`

  Lock duration in seconds.

- **`isRandomDuration`** — `boolean`

  Whether duration is randomized within a range.

- **`isBreakEnabled`** — `boolean`

  Whether periodic breaks are allowed.

- **`isEmergencyUnlockEnabled`** — `boolean`

  Whether emergency unlock is available.

- **`isTestLock`** — `boolean`

  Whether this is a test lock (anyone can unlock).

  - **`isTimeDisplayed`** — `boolean`

    Whether remaining time is shown to the wearer.

- **`data.pagination`** — `object`, *required*

  Pagination metadata.

- **`limit`** — `number`

  Number of records returned.

  - **`offset`** — `number`

    Number of records skipped.

**Request**

```bash
curl -H "Authorization: Bearer YOUR_TOKEN" \
  "https://dashboard.researchanddesire.com/api/v1/lkbx/templates?limit=50&offset=0"
```

**Response**

```json
{
  "ok": true,
  "data": {
    "data": [
      {
        "id": 3,
        "name": "Weekend Lock",
        "duration": 172800,
        "isRandomDuration": false,
        "isBreakEnabled": true,
        "isEmergencyUnlockEnabled": true,
        "isTestLock": false,
        "isTimeDisplayed": true
      }
    ],
    "pagination": {
      "limit": 50,
      "offset": 0
    }
  }
}
```
