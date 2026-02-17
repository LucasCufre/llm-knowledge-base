---
title: CI/CD Deployment Pipeline
type: technical-doc
date: 2025-11-12
last-updated: 2025-11-12
status: active
owner: Kevin Oduya
stakeholders: [Engineering Team, DevOps]
tags: [infrastructure, ci-cd, deployment, github-actions, docker, aws]
summary: |
  Documents the CI/CD pipeline for TaskFlow using GitHub Actions,
  Docker, and AWS ECS Fargate. Covers build, test, and deployment
  stages for staging and production environments.
related-docs:
  - ../architecture/example-system-architecture-overview.md
  - example-database-infrastructure.md
---

# CI/CD Deployment Pipeline

## Overview

TaskFlow uses GitHub Actions for CI/CD, deploying Docker containers to AWS ECS Fargate. The pipeline ensures all code is tested, built, and deployed consistently across environments.

## Pipeline Stages

```
┌──────────┐   ┌──────────┐   ┌──────────┐   ┌──────────┐   ┌──────────┐
│   Lint   │──>│   Test   │──>│  Build   │──>│  Deploy  │──>│  Verify  │
│ (ESLint, │   │ (Vitest, │   │ (Docker) │   │ (ECS)    │   │ (Health) │
│ Prettier)│   │ Playwright)  │          │   │          │   │          │
└──────────┘   └──────────┘   └──────────┘   └──────────┘   └──────────┘
```

## Trigger Rules

| Event | Branch | Pipeline |
|-------|--------|----------|
| Push | `main` | Lint + Test + Build + Deploy to Staging |
| Push | `feature/*` | Lint + Test only |
| Pull Request | any -> `main` | Lint + Test + Build (no deploy) |
| Manual dispatch | `main` | Full pipeline with optional production deploy |
| Tag | `v*` | Full pipeline + Deploy to Production |

## Stage Details

### 1. Lint (~ 1 minute)

```yaml
- ESLint with project config
- Prettier formatting check
- TypeScript type checking (tsc --noEmit)
```

Runs on: Every push and PR. Fast feedback loop.

### 2. Test (~3 minutes)

```yaml
- Unit tests: Vitest (targeting > 80% coverage)
- Integration tests: Vitest with PostgreSQL test container
- E2E tests: Playwright (critical paths only - login, create task, board view)
```

Test database: PostgreSQL 16 Docker container spun up in CI. Migrations run automatically before tests.

### 3. Build (~2 minutes)

```yaml
- Docker multi-stage build
- Stage 1: Install dependencies + build TypeScript
- Stage 2: Production image with compiled JS only
- Push to Amazon ECR
- Tag: git SHA + "latest" for main branch
```

Image size target: < 200 MB (Node.js Alpine base).

### 4. Deploy (~3 minutes)

**Staging (automatic on main):**
- Update ECS service with new task definition
- Rolling deployment: 1 new task starts, health check passes, old task drains
- Zero-downtime deployment

**Production (manual trigger or tag):**
- Same rolling deployment strategy
- Requires manual approval in GitHub Actions
- Deployment window: Weekdays 10am-4pm ET (soft policy)

### 5. Verify (~1 minute)

Post-deployment health checks:
- `GET /health` returns 200 with `{ "status": "ok", "version": "<git-sha>" }`
- `GET /health/db` confirms PostgreSQL connectivity
- `GET /health/redis` confirms Redis connectivity

If health check fails within 5 minutes, automatic rollback to previous task definition.

## Environment Variables

Managed via AWS Systems Manager Parameter Store:

| Variable | Staging | Production |
|----------|---------|------------|
| `DATABASE_URL` | SSM: `/taskflow/staging/db-url` | SSM: `/taskflow/prod/db-url` |
| `REDIS_URL` | SSM: `/taskflow/staging/redis-url` | SSM: `/taskflow/prod/redis-url` |
| `JWT_PRIVATE_KEY` | SSM: `/taskflow/staging/jwt-key` | SSM: `/taskflow/prod/jwt-key` |
| `SENDGRID_API_KEY` | SSM: `/taskflow/staging/sendgrid` | SSM: `/taskflow/prod/sendgrid` |

## Rollback Procedure

**Automatic:** Failed health checks trigger ECS rollback to previous task definition revision.

**Manual:** Run the GitHub Actions "Deploy" workflow with a specific Docker image tag (previous git SHA).

---

## Revision History

| Date | Author | Changes |
|------|--------|---------|
| 2025-11-12 | Kevin Oduya | Initial pipeline documentation |
