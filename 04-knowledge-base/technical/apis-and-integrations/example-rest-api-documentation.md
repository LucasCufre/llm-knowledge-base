---
title: TaskFlow REST API Documentation
type: technical-doc
date: 2025-11-10
last-updated: 2025-11-15
status: active
owner: Maria Chen
stakeholders: [Engineering Team, Frontend, QA]
tags: [api, rest, endpoints, http, backend]
summary: |
  REST API reference for the TaskFlow backend covering authentication,
  workspace, project, and task endpoints. Includes request/response
  formats, error codes, and authentication requirements.
related-docs:
  - ../architecture/example-system-architecture-overview.md
  - ../architecture/example-authentication-service-architecture.md
  - example-github-integration-api.md
---

# TaskFlow REST API Documentation

## Base URL

```
Production:  https://api.taskflow.example.com/v1
Staging:     https://api-staging.taskflow.example.com/v1
Local:       http://localhost:3000/v1
```

## Authentication

All endpoints except `/auth/register`, `/auth/login`, and `/auth/oauth/*` require a valid JWT in the Authorization header:

```
Authorization: Bearer <access_token>
```

---

## Error Format

All errors follow a consistent format:

```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Human-readable error description",
    "details": [
      { "field": "email", "message": "Must be a valid email address" }
    ]
  }
}
```

**Common Error Codes:**

| HTTP Status | Code | Description |
|------------|------|-------------|
| 400 | VALIDATION_ERROR | Request body or parameters invalid |
| 401 | UNAUTHORIZED | Missing or invalid JWT |
| 403 | FORBIDDEN | Valid JWT but insufficient permissions |
| 404 | NOT_FOUND | Resource does not exist |
| 409 | CONFLICT | Resource already exists (e.g., duplicate email) |
| 429 | RATE_LIMITED | Too many requests |
| 500 | INTERNAL_ERROR | Unexpected server error |

---

## Endpoints

### Authentication

#### POST /auth/register

Create a new user account.

**Request:**
```json
{
  "email": "user@example.com",
  "password": "securePass123",
  "name": "Jane Doe"
}
```

**Response (201):**
```json
{
  "user": {
    "id": "usr_abc123",
    "email": "user@example.com",
    "name": "Jane Doe",
    "emailVerified": false,
    "createdAt": "2025-11-10T14:30:00Z"
  },
  "accessToken": "eyJhbGciOiJSUzI1NiIs...",
  "refreshToken": "rt_x7k9m2..."
}
```

#### POST /auth/login

Authenticate with email and password.

**Request:**
```json
{
  "email": "user@example.com",
  "password": "securePass123"
}
```

**Response (200):** Same shape as register response.

---

### Workspaces

#### POST /workspaces

Create a new workspace. The authenticated user becomes the Owner.

**Request:**
```json
{
  "name": "Acme Engineering",
  "slug": "acme-eng"
}
```

**Response (201):**
```json
{
  "id": "ws_def456",
  "name": "Acme Engineering",
  "slug": "acme-eng",
  "ownerId": "usr_abc123",
  "createdAt": "2025-11-10T14:35:00Z"
}
```

#### GET /workspaces/:workspaceId/members

List all members of a workspace with their roles.

**Response (200):**
```json
{
  "members": [
    {
      "userId": "usr_abc123",
      "name": "Jane Doe",
      "email": "jane@example.com",
      "role": "owner",
      "joinedAt": "2025-11-10T14:35:00Z"
    }
  ],
  "total": 1
}
```

---

### Tasks

#### POST /workspaces/:workspaceId/projects/:projectId/tasks

Create a new task within a project.

**Request:**
```json
{
  "title": "Implement login form",
  "description": "Build the email/password login form with validation",
  "status": "todo",
  "assigneeId": "usr_abc123",
  "priority": "high",
  "metadata": {
    "estimate": "3h",
    "labels": ["frontend", "auth"]
  }
}
```

**Response (201):**
```json
{
  "id": "task_ghi789",
  "title": "Implement login form",
  "description": "Build the email/password login form with validation",
  "status": "todo",
  "assigneeId": "usr_abc123",
  "priority": "high",
  "metadata": {
    "estimate": "3h",
    "labels": ["frontend", "auth"]
  },
  "version": 1,
  "createdBy": "usr_abc123",
  "createdAt": "2025-11-10T15:00:00Z",
  "updatedAt": "2025-11-10T15:00:00Z"
}
```

#### PATCH /workspaces/:workspaceId/projects/:projectId/tasks/:taskId

Update a task. Supports partial updates. Triggers real-time broadcast to connected workspace clients.

**Request:**
```json
{
  "status": "in_progress",
  "version": 1
}
```

The `version` field enables optimistic concurrency control. If the current version doesn't match, a 409 Conflict is returned.

---

## Rate Limits

| Endpoint | Limit | Window |
|----------|-------|--------|
| POST /auth/login | 5 requests | 1 minute |
| POST /auth/register | 3 requests | 1 minute |
| All other endpoints | 100 requests | 1 minute |

Rate limit headers are included in all responses:
```
X-RateLimit-Limit: 100
X-RateLimit-Remaining: 95
X-RateLimit-Reset: 1699620000
```

---

## Pagination

List endpoints support cursor-based pagination:

```
GET /workspaces/:id/projects/:id/tasks?cursor=task_ghi789&limit=25
```

**Response includes:**
```json
{
  "data": [...],
  "pagination": {
    "nextCursor": "task_xyz999",
    "hasMore": true
  }
}
```

---

## Revision History

| Date | Author | Changes |
|------|--------|---------|
| 2025-11-10 | Maria Chen | Initial API documentation |
| 2025-11-15 | Maria Chen | Added task versioning and pagination |
