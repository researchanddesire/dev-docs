---
title: "Authentication"
description: "Create and manage API tokens to authenticate your requests"
---

All API requests require a valid API token passed in the `Authorization` header. Tokens are JWTs signed with your account's identity, so all data access respects your account permissions automatically.

!!! info
    Creating API tokens requires an **Ultra** subscription. If you don't have one
    yet, visit [Subscription](/dashboard/subscription) to upgrade.

## Creating a Token

### Step 1: Navigate to API Keys

Go to **Settings > API Keys** in the dashboard sidebar.

### Step 2: Click Create Token

Click the **Create Token** button and give your token a descriptive name
(e.g., "Home Assistant Integration" or "Python Script").

### Step 3: Copy your token

Your token will be displayed exactly once. Copy it and store it securely.

!!! warning
    You will not be able to see this token again. If you lose it, you'll need to create a new one.

## Using Your Token

Include the token as a Bearer token in the `Authorization` header:

**Request**

```bash
curl -X GET \
  https://dashboard.researchanddesire.com/api/v1/users \
  -H "Authorization: Bearer YOUR_API_TOKEN"
```

```python
import requests

headers = {"Authorization": "Bearer YOUR_API_TOKEN"}
response = requests.get(
    "https://dashboard.researchanddesire.com/api/v1/users",
    headers=headers,
)
data = response.json()
```

```javascript
const response = await fetch(
  "https://dashboard.researchanddesire.com/api/v1/users",
  {
    headers: { Authorization: "Bearer YOUR_API_TOKEN" },
  },
);
const data = await response.json();
```

## Managing Tokens

### Viewing Tokens

The **API Keys** settings page shows all your active tokens with:

- **Name** — the label you assigned
- **Created** — when the token was created
- **Last Used** — the last time the token was used to make a request

### Revoking Tokens

Click the trash icon next to any token to revoke it. Revocation is immediate — any requests using that token will start receiving `401 Unauthorized` responses right away.

!!! tip
    Revoke and recreate tokens periodically as a security best practice.

### Token Limits

You can have up to **5 active tokens** at a time. If you need more, revoke an unused token first.

## Error Responses

| Status | Meaning                                                      |
| ------ | ------------------------------------------------------------ |
| `401`  | Missing, invalid, expired, or revoked token                  |
| `403`  | Token is valid but you don't have permission for this action |
| `404`  | Resource not found (or not accessible with your permissions) |

**Response**

```json
{
  "ok": false,
  "error": "Missing or invalid Authorization header"
}
```

```json
{
  "ok": false,
  "error": "Token has been revoked"
}
```
