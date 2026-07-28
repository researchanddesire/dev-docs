---
title: "LKBX Sessions"
description: "View, create, modify, and complete lock sessions"
---

## List Sessions

`GET /api/v1/lkbx/session`

Returns a summary list of all lock sessions you have access to (past and present).

- **`limit`** — `number`, *default: `50`*

  Number of records to return (max 100).

- **`offset`** — `number`, *default: `0`*

  Number of records to skip for pagination.

- **`data.data`** — `object[]`, *required*

  Array of session summary objects.

- **`id`** — `number`

  Session ID.

- **`name`** — `string`

  Session name (from the lock template).

- **`lockState`** — `string`

  Current state: `pending`, `locked`, `completed`, `abandoned`, or `break`.

- **`duration`** — `number`

  Lock duration in seconds.

- **`startDate`** — `string`

  ISO 8601 timestamp when the session started.

- **`endDate`** — `string`

  ISO 8601 timestamp when the session ended (null if active).

  - **`isActive`** — `boolean`

    Whether this session is currently active.

- **`data.pagination`** — `object`, *required*

  Pagination metadata.

- **`limit`** — `number`

  Number of records returned.

  - **`offset`** — `number`

    Number of records skipped.

**Request**

```bash
curl -H "Authorization: Bearer YOUR_TOKEN" \
  "https://dashboard.researchanddesire.com/api/v1/lkbx/session?limit=50&offset=0"
```

**Response**

```json
{
  "ok": true,
  "data": {
    "data": [
      {
        "id": 7,
        "name": "Weekend Lock",
        "lockState": "locked",
        "duration": 172800,
        "startDate": "2026-02-16T18:00:00Z",
        "endDate": null,
        "isActive": true
      },
      {
        "id": 5,
        "name": "Test Lock",
        "lockState": "completed",
        "duration": 3600,
        "startDate": "2026-02-15T10:00:00Z",
        "endDate": "2026-02-15T11:00:00Z",
        "isActive": false
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

## Get Session Details

`GET /api/v1/lkbx/session/{id}`

Returns full details of a specific lock session, including the complete activity history (lock segments).

- **`id`** — `number`, *required*

  The session ID.

- **`data`** — `object`, *required*

  Full session object with nested segment history.

  - **`LockSegment`** — `object[]`

    Array of activity segments in chronological order.

    - **`type`** — `string`

      Segment type: `start`, `locked`, `break`, `unlocked`, etc.

    - **`createdAt`** — `string`

      ISO 8601 timestamp.

    - **`isLocked`** — `boolean`

      Whether the device was locked during this segment.

**Request**

```bash
curl -H "Authorization: Bearer YOUR_TOKEN" \
  https://dashboard.researchanddesire.com/api/v1/lkbx/session/7
```

---

## Get Active Session

`GET /api/v1/lkbx/session/current`

Returns the currently active lock session for your account, including segment history. Returns `null` in the `data` field if no session is active.

**Request**

```bash
curl -H "Authorization: Bearer YOUR_TOKEN" \
  https://dashboard.researchanddesire.com/api/v1/lkbx/session/current
```

**Response**

```json
{
  "ok": true,
  "data": {
    "id": 7,
    "lockState": "locked",
    "duration": 172800,
    "startDate": "2026-02-16T18:00:00Z",
    "isActive": true,
    "LockSegment": [
      { "type": "start", "createdAt": "2026-02-16T18:00:00Z", "isLocked": true }
    ]
  }
}
```

```json
{
  "ok": true,
  "data": null
}
```

---

## Lock / Unlock

`POST /api/v1/lkbx/session/current`

Start a new lock session or complete (unlock) the active session. User IDs (target and keyholders) are validated against your accessible users before the action is performed.

- **`action`** — `string`, *required*

  Either `"lock"` to start a new session, or `"unlock"` to complete the active
  session.

- **`lockSettingsId`** — `number`

  The ID of a lock template to use. If omitted, default settings are
  applied. Only used with `"lock"` action.

- **`keyholderIds`** — `number[]`

  Array of user IDs to assign as keyholders. Empty array or omitted means
  self-lock. Only used with `"lock"` action. All IDs must be users you have
  access to.

- **`targetUserId`** — `number`

  The user to lock/unlock. Defaults to the authenticated user. Must be a user
  you have access to.

- **`isTestLock`** — `boolean`

  Override the test lock setting from the lock template. When `true`, the lock owner can unlock without a keyholder. Only used with `"lock"` action.

### Lock Action

Creates a new lock session. Fails if a session is already active.

**Request**

```bash
curl -X POST \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"action": "lock", "lockSettingsId": 3}' \
  https://dashboard.researchanddesire.com/api/v1/lkbx/session/current
```

```bash
curl -X POST \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"action": "lock", "lockSettingsId": 3, "isTestLock": true}' \
  https://dashboard.researchanddesire.com/api/v1/lkbx/session/current
```

```bash
curl -X POST \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"action": "unlock"}' \
  https://dashboard.researchanddesire.com/api/v1/lkbx/session/current
```

**Response**

```json
{
  "ok": true,
  "data": {
    "lockSessionId": 8
  }
}
```

```json
{
  "ok": true,
  "data": {
    "message": "Lock session completed"
  }
}
```

```json
{
  "ok": false,
  "error": "You already have an active lock."
}
```

```json
{
  "ok": false,
  "error": "targetUserId contains inaccessible user IDs: 123"
}
```

### Unlock Action

Completes the active lock session. Only keyholders or test lock owners can unlock.

!!! warning
    The unlock action is **permanent**. Once a session is completed, it cannot be
    restarted — you must create a new lock session.

---

## Modify Active Session

`PATCH /api/v1/lkbx/session/current`

Modify the duration of the active lock session. Only keyholders or test lock owners can modify sessions.

- **`duration`** — `number`

  New lock duration in seconds. Must be a positive number. The end date will be
  recalculated based on the session's start date.

- **`targetUserId`** — `number`

  The user whose session to modify. Defaults to the authenticated user.

**Request**

```bash
curl -X PATCH \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"duration": 86400}' \
  https://dashboard.researchanddesire.com/api/v1/lkbx/session/current
```

**Response**

```json
{
  "ok": true,
  "data": {
    "id": 7,
    "duration": 86400,
    "endDate": "2026-02-17T18:00:00Z",
    "lockState": "locked",
    "isActive": true
  }
}
```

```json
{
  "ok": false,
  "error": "Only keyholders or test locks can modify the active session"
}
```
