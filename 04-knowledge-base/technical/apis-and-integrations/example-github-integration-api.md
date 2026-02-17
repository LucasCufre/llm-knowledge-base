---
title: GitHub Integration API
type: technical-doc
date: 2025-11-15
last-updated: 2025-11-15
status: draft
owner: Alex Torres
stakeholders: [Engineering Team, Product]
tags: [api, github, integration, webhooks, developer-tools]
summary: |
  Technical specification for TaskFlow's GitHub integration, enabling
  automatic task status updates from pull requests and branch activity.
  Uses GitHub webhooks and REST API for bidirectional sync.
related-docs:
  - example-rest-api-documentation.md
  - ../architecture/example-system-architecture-overview.md
  - ../../../02-decisions/2025-11-03-adopt-postgresql-as-primary-database.md
---

# GitHub Integration API

## Overview

The GitHub integration connects TaskFlow workspaces to GitHub repositories, enabling:
- Automatic task status updates when PRs are opened, merged, or closed
- Linking commits and PRs to TaskFlow tasks via task ID in branch names or PR descriptions
- Viewing linked GitHub activity directly in the task detail view

## Architecture

```
GitHub.com                          TaskFlow
┌──────────┐   Webhook POST    ┌──────────────────┐
│ Repo     │──────────────────>│ /webhooks/github  │
│ Events   │                   │ (verify signature)│
└──────────┘                   └────────┬─────────┘
                                        │
     ┌──────────────────────────────────┘
     v
┌──────────────────┐    ┌─────────────┐
│ Event Processor  │───>│ Task Update │───> WebSocket broadcast
│ (match task IDs) │    │ Service     │
└──────────────────┘    └─────────────┘
```

## Task Linking Convention

Tasks are linked to GitHub activity via a naming convention:

- **Branch name:** `feature/TASK-ghi789-implement-login`
- **PR description:** Contains `Closes TASK-ghi789` or `Fixes TASK-ghi789`
- **Commit message:** Contains `[TASK-ghi789]`

The integration extracts task IDs matching the pattern `TASK-[a-z0-9]+` and creates links.

## Webhook Events

### Pull Request Events

| GitHub Event | TaskFlow Action |
|-------------|-----------------|
| `pull_request.opened` | Link PR to task, add "PR Open" activity |
| `pull_request.closed` (merged) | Move task to "Done" status, add "PR Merged" activity |
| `pull_request.closed` (not merged) | Add "PR Closed" activity (no status change) |
| `pull_request.review_submitted` | Add review activity to task |

### Push Events

| GitHub Event | TaskFlow Action |
|-------------|-----------------|
| `push` (to linked branch) | Add commit summary to task activity feed |

## API Endpoints

### POST /integrations/github/install

Connect a GitHub repository to a TaskFlow workspace. Requires workspace Admin or Owner role.

**Request:**
```json
{
  "workspaceId": "ws_def456",
  "repositoryOwner": "acme-eng",
  "repositoryName": "taskflow-app",
  "installationId": "gh_inst_12345"
}
```

### GET /integrations/github/tasks/:taskId/activity

Fetch GitHub activity linked to a specific task.

**Response (200):**
```json
{
  "activity": [
    {
      "type": "pull_request",
      "title": "Implement login form",
      "url": "https://github.com/acme-eng/taskflow-app/pull/42",
      "status": "merged",
      "author": "janedev",
      "createdAt": "2025-11-14T10:00:00Z",
      "mergedAt": "2025-11-15T09:30:00Z"
    }
  ]
}
```

## Webhook Security

All incoming webhooks are verified using GitHub's HMAC-SHA256 signature:

1. Compute HMAC-SHA256 of the raw request body using the webhook secret
2. Compare with the `X-Hub-Signature-256` header
3. Reject requests with invalid or missing signatures (return 401)
4. Process valid requests asynchronously (return 200 immediately, queue processing)

## Configuration

Workspace settings page allows:
- Installing/removing GitHub connection
- Selecting which repositories to link
- Configuring auto-status-update rules (which task status maps to which PR event)
- Enabling/disabling specific event types

---

## Revision History

| Date | Author | Changes |
|------|--------|---------|
| 2025-11-15 | Alex Torres | Initial specification draft |
