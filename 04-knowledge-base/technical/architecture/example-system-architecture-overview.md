---
title: TaskFlow System Architecture Overview
type: technical-doc
date: 2025-11-05
last-updated: 2025-11-15
status: active
owner: Maria Chen
stakeholders: [Engineering Team, DevOps]
tags: [architecture, system-design, overview, backend, frontend]
summary: |
  High-level architecture overview of the TaskFlow platform including
  frontend SPA, API server, WebSocket service, and data layer.
  Covers component responsibilities, data flow, and deployment model.
related-docs:
  - example-authentication-service-architecture.md
  - ../../../02-decisions/2025-11-03-adopt-postgresql-as-primary-database.md
  - ../infrastructure/example-database-infrastructure.md
  - ../apis-and-integrations/example-rest-api-documentation.md
---

# TaskFlow System Architecture Overview

## Overview

**Purpose:**
This document describes the high-level architecture of the TaskFlow platform - a real-time project management SaaS application targeting small-to-medium technical teams.

**Scope:**
Covers the production system architecture including frontend, backend API, real-time service, and data layer. Does not cover CI/CD pipeline or monitoring infrastructure.

**Key Design Principles:**
- Real-time first: All state changes propagate to connected clients via WebSockets
- API-first: Every feature is accessible via REST API before building UI
- Simplicity: Monolithic API server (not microservices) until scale demands otherwise

---

## System Context

**External Dependencies:**
- Google OAuth API - Social login authentication
- GitHub OAuth API - Social login and future repo integration
- SendGrid - Transactional emails (verification, password reset, notifications)
- Cloudflare - CDN and DDoS protection

**Internal Dependencies:**
- PostgreSQL 16 (primary database)
- Redis 7 (session cache, WebSocket pub/sub, rate limiting)

**Consumers:**
- TaskFlow web app (React SPA)
- Future: TaskFlow mobile app (React Native)
- Future: Public REST API for third-party integrations

---

## High-Level Architecture

```
┌──────────────────┐     ┌───────────────┐     ┌──────────────────┐
│  React SPA       │────>│  Cloudflare   │────>│  API Server      │
│  (Vite + React)  │     │  CDN / WAF    │     │  (Node/Express)  │
└──────────────────┘     └───────────────┘     └──────────────────┘
        │                                              │
        │  WebSocket                            ┌──────┴──────┐
        │                                       │             │
        v                                       v             v
┌──────────────────┐                    ┌──────────┐  ┌──────────┐
│  WebSocket       │<──── Redis ───────>│PostgreSQL│  │  Redis   │
│  Service         │      Pub/Sub       │  (RDS)   │  │ (Cache)  │
└──────────────────┘                    └──────────┘  └──────────┘
```

**Components:**
- **React SPA**: Single-page application built with Vite, React 18, and TanStack Query. Handles all client-side rendering, state management, and WebSocket connection.
- **API Server**: Node.js/Express application handling REST API requests. Stateless, horizontally scalable. Handles authentication, authorization (Casbin), business logic, and database access (Prisma ORM).
- **WebSocket Service**: Handles persistent WebSocket connections for real-time updates. Shares the same Node.js process as the API server in v1. Uses Redis pub/sub to broadcast events across multiple server instances.
- **PostgreSQL**: Primary data store for all application data (users, workspaces, projects, tasks). Managed via Amazon RDS.
- **Redis**: Used for three purposes: session token cache, WebSocket pub/sub for multi-instance broadcasting, and rate limiting counters.

---

## Data Flow

**Typical Request Flow (REST API):**
1. Client sends HTTPS request to Cloudflare edge
2. Cloudflare forwards to API server (rate limiting at edge)
3. Express middleware validates JWT from Authorization header
4. Casbin middleware checks user permissions for the requested resource
5. Route handler executes business logic, queries PostgreSQL via Prisma
6. Response returned to client
7. If state changed: event published to Redis pub/sub channel

**Real-Time Event Flow:**
1. API server writes task update to PostgreSQL
2. API server publishes event to Redis pub/sub channel `workspace:{id}:events`
3. All WebSocket service instances subscribed to that channel receive the event
4. Each instance forwards the event to connected clients in that workspace
5. Client receives event, TanStack Query cache is updated, UI re-renders

**Data Persistence:**
All application data stored in PostgreSQL. Redis is ephemeral (cache/pub-sub only). Loss of Redis means temporary loss of real-time updates and cached sessions, but no data loss.

---

## Scalability & Performance

**Scaling Strategy:**
- Horizontal: API server runs behind a load balancer. Stateless design allows adding instances. Redis pub/sub ensures WebSocket events reach all instances.
- Vertical: PostgreSQL (RDS) can be scaled vertically. Read replicas added when read load exceeds single-instance capacity.

**Performance Targets:**
- API response time: < 200ms at p95
- WebSocket message delivery: < 500ms from write to client
- Page load (SPA): < 2 seconds on 4G connection
- Concurrent WebSocket connections per instance: 500

---

## Deployment

**Environment Strategy:**
- Local: Docker Compose (PostgreSQL + Redis + API server)
- Staging: AWS (single-instance RDS, single API server, ElastiCache Redis)
- Production: AWS (multi-AZ RDS, auto-scaling API servers behind ALB, ElastiCache Redis cluster)

**Deployment Method:**
GitHub Actions CI/CD pipeline. Docker images pushed to ECR, deployed to ECS Fargate.

---

## Revision History

| Date | Author | Changes |
|------|--------|---------|
| 2025-11-05 | Maria Chen | Initial architecture document |
| 2025-11-15 | Maria Chen | Added WebSocket data flow and Redis pub/sub details |
