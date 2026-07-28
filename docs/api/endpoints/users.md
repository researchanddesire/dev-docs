---
title: "Users"
description: "List and retrieve user information"
---

## List Users

`GET /api/v1/users`

Returns all users you have access to. Results are filtered by your account permissions — you'll see yourself and any users connected to you via partnerships. Includes profile information in a flat structure.

- **`limit`** — `number`, *default: `50`*

  Number of records to return (max 100).

- **`offset`** — `number`, *default: `0`*

  Number of records to skip for pagination.

- **`ok`** — `boolean`, *required*

  Always `true` on success.

- **`data.data`** — `object[]`, *required*

  Array of user objects with profile information.

- **`id`** — `number`

  The user's internal ID.

- **`username`** — `string`

  The user's unique username (from profile).

- **`accountType`** — `string`

  One of `user`, `support`, `admin`, or `superadmin`.

- **`subscriptionTier`** — `string`

  Subscription tier: `ultra`, `pioneer`, `founder`, `employee`, or `null` if no
  subscription.

- **`league`** — `number`

  The user's current league tier.

- **`rank`** — `number`

  The user's leaderboard rank.

- **`totalPoints`** — `number`

  Lifetime points earned.

- **`matchPoints`** — `number`

  Points earned in the current match period.

- **`profileImage`** — `string`

  URL to the user's profile image (nullable).

- **`profileDescription`** — `string`

  User's profile bio/description (nullable).

  - **`profileTitle`** — `string`

    User's profile title (nullable).

- **`data.pagination`** — `object`, *required*

  Pagination metadata.

- **`limit`** — `number`

  Number of records returned.

  - **`offset`** — `number`

    Number of records skipped.

**Request**

```bash
curl -H "Authorization: Bearer YOUR_TOKEN" \
  "https://dashboard.researchanddesire.com/api/v1/users?limit=50&offset=0"
```

**Response**

```json
{
  "ok": true,
  "data": {
    "data": [
      {
        "id": 42,
        "username": "alice_trainer",
        "accountType": "user",
        "subscriptionTier": "ultra",
        "league": 3,
        "rank": 150,
        "totalPoints": 12500,
        "matchPoints": 800,
        "profileImage": "https://example.com/avatar.jpg",
        "profileDescription": "Hello world",
        "profileTitle": "Expert Trainer"
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

## Get User by ID

`GET /api/v1/users/{id}`

Returns detailed information about a specific user, including their profile data. You can only access users you have a connection with.

- **`id`** — `number`, *required*

  The user's internal ID.

- **`data`** — `object`, *required*

  User object with extended fields.

- **`id`** — `number`

  The user's internal ID.

- **`username`** — `string`

  The user's unique username.

- **`accountType`** — `string`

  Account type.

- **`subscriptionTier`** — `string`

  Subscription tier.

- **`totalPoints`** — `number`

  Lifetime points earned.

- **`matchPoints`** — `number`

  Points earned in the current match period.

  - **`Profile`** — `object`

    The user's public profile, if accessible.

**Request**

```bash
curl -H "Authorization: Bearer YOUR_TOKEN" \
  https://dashboard.researchanddesire.com/api/v1/users/42
```

**Response**

```json
{
  "ok": true,
  "data": {
    "id": 42,
    "username": "alice_trainer",
    "accountType": "user",
    "subscriptionTier": "ultra",
    "league": 3,
    "rank": 150,
    "totalPoints": 12500,
    "matchPoints": 800,
    "profileImage": "https://example.com/avatar.jpg",
    "profileDescription": "Hello world",
    "profileTitle": "Expert Trainer"
  }
}
```

```json
{
  "ok": false,
  "error": "User not found"
}
```
