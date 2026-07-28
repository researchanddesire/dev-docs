---
title: "DTT (Deepthroat Trainer)"
description: "List devices and training templates for the Deepthroat Trainer"
---

## List DTT Devices

`GET /api/v1/dtt`

Returns all Deepthroat Trainer devices you have access to.

- **`limit`** — `number`, *default: `50`*

  Number of records to return (max 100).

- **`offset`** — `number`, *default: `0`*

  Number of records to skip for pagination.

- **`data.data`** — `object[]`, *required*

  Array of DTT device objects.

- **`id`** — `number`

  Device ID.

- **`bubbleId`** — `string`

  Unique device identifier.

- **`ownerId`** — `number`

  ID of the device owner.

- **`macAddress`** — `string`

  Device MAC address.

- **`serialNumber`** — `number`

  Hardware serial number.

- **`softwareVersion`** — `string`

  Currently installed firmware version.

- **`lastVisited`** — `string`

  ISO 8601 timestamp of the last device connection.

  - **`apiHits`** — `number`

    Total API requests made by this device.

- **`data.pagination`** — `object`, *required*

  Pagination metadata.

- **`limit`** — `number`

  Number of records returned.

  - **`offset`** — `number`

    Number of records skipped.

**Request**

```bash
curl -H "Authorization: Bearer YOUR_TOKEN" \
  "https://dashboard.researchanddesire.com/api/v1/dtt?limit=50&offset=0"
```

**Response**

```json
{
  "ok": true,
  "data": {
    "data": [
      {
        "id": 1,
        "bubbleId": "dtt-abc",
        "ownerId": 42,
        "macAddress": "AA:BB:CC:DD:EE:FF",
        "serialNumber": 1001,
        "softwareVersion": "2.1.0",
        "lastVisited": "2026-02-17T12:00:00Z",
        "apiHits": 256
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

## Get DTT Device

`GET /api/v1/dtt/{id}`

Returns full details for a specific DTT device.

- **`id`** — `number`, *required*

  The DTT device ID.

**Request**

```bash
curl -H "Authorization: Bearer YOUR_TOKEN" \
  https://dashboard.researchanddesire.com/api/v1/dtt/1
```

---

## List DTT Templates

`GET /api/v1/dtt/templates`

Returns all training program templates you have access to, **without** segments. Use this for an overview of available programs.

- **`limit`** — `number`, *default: `50`*

  Number of records to return (max 100).

- **`offset`** — `number`, *default: `0`*

  Number of records to skip for pagination.

- **`data.data`** — `object[]`, *required*

  Array of template objects.

- **`id`** — `number`

  Template ID.

- **`name`** — `string`

  Program name.

- **`description`** — `string`

  Program description.

- **`isPublic`** — `boolean`

  Whether the program is publicly shared.

- **`isActive`** — `boolean`

  Whether this is the currently active program.

- **`handsFreeMode`** — `boolean`

  Whether hands-free mode is enabled.

- **`targetDepth`** — `number`

  Target depth setting in millimeters.

  - **`targetWindow`** — `number`

    Tolerance window for depth detection.

- **`data.pagination`** — `object`, *required*

  Pagination metadata.

- **`limit`** — `number`

  Number of records returned.

  - **`offset`** — `number`

    Number of records skipped.

**Request**

```bash
curl -H "Authorization: Bearer YOUR_TOKEN" \
  "https://dashboard.researchanddesire.com/api/v1/dtt/templates?limit=50&offset=0"
```

---

## Get DTT Template with Segments

`GET /api/v1/dtt/templates/{id}`

Returns a specific training program **including all segments**. Segments define the individual phases of a training session.

- **`id`** — `number`, *required*

  The template (program) ID.

- **`data`** — `object`, *required*

  The template object with a nested `Segment` array.

  - **`Segment`** — `object[]`

    Array of training segments in order.

    - **`id`** — `number`

      Segment ID.

    - **`type`** — `string`

      Segment type.

    - **`duration`** — `number`

      Duration in seconds.

    - **`repeat`** — `number`

      Number of times to repeat this segment.

**Request**

```bash
curl -H "Authorization: Bearer YOUR_TOKEN" \
  https://dashboard.researchanddesire.com/api/v1/dtt/templates/5
```

**Response**

```json
{
  "ok": true,
  "data": {
    "id": 5,
    "name": "Beginner Program",
    "isActive": true,
    "handsFreeMode": false,
    "targetDepth": 50,
    "Segment": [
      {
        "id": 10,
        "type": "warmup",
        "duration": 30,
        "repeat": 1
      },
      {
        "id": 11,
        "type": "training",
        "duration": 60,
        "repeat": 3
      }
    ]
  }
}
```

---

## Update DTT Template

`PATCH /api/v1/dtt/templates/{id}`

Update one or more fields on a training program. Only include the fields you want to change — all fields are optional.

If `Segment` is provided, it **replaces** the entire segment list (existing segments are deleted and recreated).

- **`id`** — `number`, *required*

  The template (program) ID.

### Request Body

- **`name`** — `string`

  Program name (4–128 characters, cannot be blank).

- **`targetDepth`** — `number`

  Target depth percentage.

- **`targetWindow`** — `number`

  Tolerance window for depth detection.

- **`toyId`** — `number | null`

  Associated toy ID. Set to `0` or `null` to unset.

- **`message`** — `string | null`

  Completion message (max 50 characters). Defaults to "Good Work!" if empty.

- **`handsFreeMode`** — `boolean`

  Enable hands-free mode. **Requires Ultra subscription.** Setting to `false` is always allowed.

- **`tagline`** — `string | null`

  Short tagline (max 25 characters). **Requires Ultra subscription.** Setting to `null` is always allowed.

- **`toyTagline`** — `string | null`

  Toy tagline (max 25 characters).

- **`iconId`** — `number | null`

  Icon ID. **Requires Ultra subscription.** Setting to `null` is always allowed.

- **`isPublic`** — `boolean`

  Whether the program is publicly shared.

- **`description`** — `string | null`

  Program description (max 500 characters).

- **`Segment`** — `object[]`

  Full replacement segment list. If provided, **all existing segments are deleted** and replaced.

  Each segment object:

  - **`type`** — `string`, *required*

    One of `repetition`, `endurance`, `freeform`, or `bounce`.

  - **`duration`** — `number`, *required*

    Duration (meaning varies by type).

  - **`speed`** — `number`, *required*

    Speed setting (1–1000).

  - **`repeat`** — `number`, *default: `1`*

    Number of times to repeat this segment.

  - **`passFailEnabled`** — `boolean`, *default: `false`*

    Whether pass/fail grading is enabled for this segment.

  - **`passGradeThreshold`** — `number`, *default: `0`*

    Minimum grade to pass (0–100).

  - **`failureText`** — `string | null`

    Message shown on failure (max 80 characters).

### Error Responses

| Status | Meaning |
|--------|---------|
| `400` | Invalid JSON body or empty request body |
| `401` | Not authenticated |
| `403` | Field requires Ultra subscription |
| `404` | Template not found or not owned by you |
| `422` | Validation failed — see `fieldErrors` array for details |

On a `422` response, the body contains a `fieldErrors` array with per-field error messages:

```json
{
  "ok": false,
  "error": "Validation failed",
  "fieldErrors": [
    { "field": "name", "message": "String must contain at least 4 character(s)" }
  ]
}
```

**Request**

```bash
curl -X PATCH -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"name": "Advanced Program"}' \
  https://dashboard.researchanddesire.com/api/v1/dtt/templates/5
```

```bash
curl -X PATCH -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"Segment": [{"type": "endurance", "duration": 300, "speed": 50, "repeat": 2}]}' \
  https://dashboard.researchanddesire.com/api/v1/dtt/templates/5
```

```bash
curl -X PATCH -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"name": "Pro Program", "targetDepth": 75, "isPublic": true}' \
  https://dashboard.researchanddesire.com/api/v1/dtt/templates/5
```

**Response**

```json
{
  "ok": true,
  "data": {
    "id": 5,
    "bubbleId": "prog-abc",
    "ownerId": 42,
    "name": "Advanced Program",
    "description": null,
    "tagline": null,
    "message": "Good Work!",
    "isPublic": false,
    "isActive": true,
    "handsFreeMode": false,
    "targetDepth": 50,
    "targetWindow": 10,
    "toyId": null,
    "createdDate": "2025-06-01T10:00:00Z",
    "updatedAt": "2026-02-23T10:30:00Z",
    "Segment": [
      {
        "id": 20,
        "type": "endurance",
        "duration": 300,
        "speed": 50,
        "repeat": 2,
        "order": 0,
        "passFailEnabled": false,
        "passGradeThreshold": 0,
        "failureText": null
      }
    ]
  }
}
```

```json
{
  "ok": false,
  "error": "Validation failed",
  "fieldErrors": [
    { "field": "name", "message": "String must contain at least 4 character(s)" },
    { "field": "Segment", "message": "At least one segment is required." }
  ]
}
```

```json
{
  "ok": false,
  "error": "\"handsFreeMode\" requires an Ultra subscription or higher. Your current tier does not include this feature."
}
```
