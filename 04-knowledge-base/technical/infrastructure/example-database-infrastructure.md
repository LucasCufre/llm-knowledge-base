---
title: Database Infrastructure - PostgreSQL & Redis
type: technical-doc
date: 2025-11-08
last-updated: 2025-11-08
status: active
owner: Kevin Oduya
stakeholders: [Engineering Team, DevOps]
tags: [infrastructure, postgresql, redis, database, aws, rds]
summary: |
  Documents the database infrastructure setup for TaskFlow including
  PostgreSQL (RDS) configuration, Redis (ElastiCache) setup, backup
  strategy, and connection management.
related-docs:
  - ../architecture/example-system-architecture-overview.md
  - ../../../../02-decisions/2025-11-03-adopt-postgresql-as-primary-database.md
---

# Database Infrastructure - PostgreSQL & Redis

## PostgreSQL (Amazon RDS)

### Instance Configuration

| Environment | Instance Type | Storage | Multi-AZ | Read Replicas |
|------------|---------------|---------|----------|---------------|
| Production | db.r6g.large | 100 GB gp3 | Yes | 1 (future) |
| Staging | db.t4g.medium | 20 GB gp3 | No | 0 |
| Local | Docker (postgres:16) | Ephemeral | N/A | N/A |

**Engine:** PostgreSQL 16.1
**Parameter Group:** Custom (see below)

### Key Parameter Overrides

```
shared_buffers = 2GB              # 25% of instance RAM
effective_cache_size = 6GB        # 75% of instance RAM
work_mem = 64MB
maintenance_work_mem = 512MB
max_connections = 200
log_min_duration_statement = 500  # Log queries slower than 500ms
```

### Connection Pooling

PgBouncer runs as a sidecar container alongside the API server:
- Pool mode: Transaction
- Default pool size: 20 per API instance
- Max client connections: 100 per PgBouncer instance
- Connection string: `postgresql://pgbouncer:6432/taskflow`

### Backup Strategy

| Type | Frequency | Retention | Method |
|------|-----------|-----------|--------|
| Automated snapshots | Daily | 7 days | RDS automated backups |
| Point-in-time recovery | Continuous | 7 days | RDS WAL archiving |
| Manual snapshots | Before migrations | 30 days | Manual RDS snapshot |
| Logical backup | Weekly | 4 weeks | pg_dump to S3 |

**Recovery Time Objective (RTO):** < 30 minutes
**Recovery Point Objective (RPO):** < 5 minutes (continuous WAL archiving)

---

## Redis (Amazon ElastiCache)

### Instance Configuration

| Environment | Instance Type | Cluster Mode | Replicas |
|------------|---------------|-------------|----------|
| Production | cache.r6g.large | No | 1 |
| Staging | cache.t4g.micro | No | 0 |
| Local | Docker (redis:7) | N/A | N/A |

### Usage Patterns

| Use Case | Key Pattern | TTL | Eviction |
|----------|-------------|-----|----------|
| Session tokens | `session:{tokenHash}` | 30 days | Explicit delete |
| Rate limiting | `ratelimit:{ip}:{endpoint}` | 60 seconds | Auto-expire |
| WebSocket pub/sub | Channel: `ws:{workspaceId}` | N/A | N/A |
| OAuth state | `oauth_state:{state}` | 5 minutes | Auto-expire |

### Memory Policy

- `maxmemory-policy`: `allkeys-lru`
- Estimated memory usage at 10,000 users: ~500 MB
- Alert threshold: 80% memory utilization

---

## Monitoring

**PostgreSQL:**
- RDS Performance Insights enabled
- CloudWatch alarms: CPU > 80%, free storage < 10 GB, replication lag > 30s
- Slow query log: queries > 500ms logged and reviewed weekly

**Redis:**
- ElastiCache metrics in CloudWatch
- CloudWatch alarms: memory > 80%, evictions > 0/min (unexpected), CPU > 70%

---

## Revision History

| Date | Author | Changes |
|------|--------|---------|
| 2025-11-08 | Kevin Oduya | Initial infrastructure documentation |
