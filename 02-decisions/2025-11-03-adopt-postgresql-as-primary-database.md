---
title: Adopt PostgreSQL as Primary Database
type: decision-record
decision-id: ADR-001
date: 2025-11-03
status: accepted
owner: Maria Chen
stakeholders: [Engineering Team, DevOps, Product]
tags: [architecture, database, infrastructure, postgresql]
summary: |
  Decided to use PostgreSQL as the primary relational database for TaskFlow,
  replacing the initial prototype's SQLite setup. Driven by need for concurrent
  access, full-text search, and JSONB support for flexible metadata.
related-docs:
  - ../04-knowledge-base/technical/architecture/example-system-architecture-overview.md
  - ../04-knowledge-base/technical/infrastructure/example-database-infrastructure.md
  - ../04-knowledge-base/business/requirements/example-user-authentication-requirement.md
---

# Adopt PostgreSQL as Primary Database

## Context and Problem Statement

TaskFlow's prototype was built with SQLite for rapid iteration. As we prepare for multi-user beta, we need a database that supports concurrent writes, scales beyond a single server, and provides advanced querying capabilities (full-text search, JSONB for task metadata). SQLite's single-writer limitation is a blocker for our collaboration features.

## Decision

We will adopt PostgreSQL 16 as the primary relational database for all TaskFlow services. We will use the managed offering from our cloud provider (Amazon RDS) for production environments and Docker-based PostgreSQL for local development.

## Rationale

- PostgreSQL handles concurrent reads/writes natively, which our real-time collaboration features require
- JSONB support allows flexible task metadata without schema migrations for every custom field
- Built-in full-text search (`tsvector`/`tsquery`) eliminates the need for a separate search engine at our current scale
- Mature ecosystem with well-tested ORMs (Prisma, Drizzle) for our TypeScript backend
- Team has existing PostgreSQL expertise from previous projects

## Consequences

### Positive
- Concurrent multi-user access unblocked
- Rich querying capabilities (JSONB, full-text search, CTEs for hierarchical task data)
- Strong ecosystem for migrations, monitoring, and backups

### Negative
- Higher operational cost vs. SQLite (managed RDS instance)
- Local development now requires Docker or a local PostgreSQL installation
- Team needs to learn PostgreSQL-specific features (JSONB operators, `tsvector`)

### Neutral
- Migration from SQLite requires a one-time data export/import script
- Need to establish connection pooling strategy (PgBouncer or built-in)

## Alternatives Considered

### Option 1: MySQL 8
- Mature and widely used, good performance
- Less powerful JSON support compared to PostgreSQL JSONB
- Rejected because PostgreSQL's JSONB and full-text search are better suited to our flexible metadata model

### Option 2: MongoDB
- Native document model fits flexible task metadata well
- Would require significant backend rewrite (currently SQL-based)
- Rejected due to rewrite cost and team's stronger SQL experience

### Option 3: Keep SQLite with read replicas
- Lowest migration effort
- Still limited to single-writer, which breaks real-time collaboration
- Rejected as it doesn't solve the core concurrency problem

## Implementation Notes

1. Set up RDS PostgreSQL 16 instance in staging environment by Nov 15
2. Write migration script to export SQLite data and import into PostgreSQL
3. Update Prisma schema to use PostgreSQL-specific types (JSONB for `task.metadata`)
4. Configure PgBouncer for connection pooling in production
5. Update CI/CD pipeline to use PostgreSQL Docker container for tests

## References
- [PostgreSQL 16 Release Notes](https://www.postgresql.org/docs/16/release-16.html)
- [Prisma PostgreSQL Connector](https://www.prisma.io/docs/concepts/database-connectors/postgresql)
- Sprint planning meeting 2025-11-01

## Revision History
- 2025-11-03: Initial decision accepted by engineering team
