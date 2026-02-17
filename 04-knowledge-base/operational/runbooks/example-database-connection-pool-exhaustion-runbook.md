---
title: Database Connection Pool Exhaustion - Runbook
type: runbook
date: 2025-11-12
last-updated: 2025-11-12
status: active
owner: Engineering Team
stakeholders: [On-call engineers, DevOps]
tags: [runbook, database, postgresql, connection-pool, pgbouncer]
summary: |
  Specific runbook for diagnosing and resolving PostgreSQL connection pool
  exhaustion in TaskFlow. Triggered when PgBouncer or RDS connection
  limits are approaching capacity.
related-docs:
  - example-production-incident-response-runbook.md
  - ../../technical/infrastructure/example-database-infrastructure.md
  - ../../../../02-decisions/2025-11-03-adopt-postgresql-as-primary-database.md
---

# Database Connection Pool Exhaustion - Runbook

## Incident Overview

**Symptoms:**
API requests returning 500 errors with "connection pool timeout" or "too many clients" messages in logs. Users experience slow loading or failed task operations.

**Impact:**
- Severity: P2 (High) - Core functionality degraded
- Affected users: All users experiencing intermittent failures
- Business impact: Users cannot create or update tasks reliably

**Expected Resolution Time:**
15-30 minutes for mitigation, root cause may require follow-up investigation.

---

## When to Use This Runbook

**Triggers:**
- CloudWatch alarm: "RDS Active Connections > 180"
- Application logs contain: "Cannot acquire connection from pool"
- PgBouncer logs: "no more connections allowed"

**Alert Example:**
```
ALARM: taskflow-prod-rds-connections
Current value: 192 connections (threshold: 180)
```

---

## Quick Triage

### Is this REALLY connection pool exhaustion?

**Confirm symptoms:**
- [ ] Check RDS active connections in CloudWatch (> 180 of 200 max)
- [ ] Check PgBouncer stats: `SHOW POOLS;` shows many waiting clients
- [ ] Application logs confirm "pool timeout" or "connection refused" errors

**If symptoms don't match:**
- If connections are normal but queries are slow: This is a query performance issue, not connection exhaustion
- If only one API instance is affected: Possible PgBouncer issue on that instance

---

## Prerequisites

**Required Access:**
- AWS Console with RDS access
- SSH/ECS exec to application containers (for PgBouncer inspection)

**Safety Checks BEFORE starting:**
- [ ] Confirm this is not during a planned deployment
- [ ] Note the current connection count and when the spike started

---

## Investigation Steps

### Step 1: Identify Connection Sources

**Check which queries are holding connections:**
```sql
-- Run against RDS directly (not through PgBouncer)
SELECT pid, now() - pg_stat_activity.query_start AS duration, query, state
FROM pg_stat_activity
WHERE state != 'idle'
ORDER BY duration DESC;
```

**What to look for:**
- Long-running queries (duration > 30 seconds): Likely cause of connection buildup
- Many identical queries in "active" state: Possible N+1 query or missing index
- Queries in "idle in transaction" state: Transaction not properly closed

---

### Step 2: Check PgBouncer Status

```bash
# Connect to PgBouncer admin console
psql -h localhost -p 6432 -U pgbouncer pgbouncer

# Check pool status
SHOW POOLS;
SHOW CLIENTS;
SHOW SERVERS;
```

**Key metrics:**
- `cl_waiting` > 0: Clients waiting for a connection (bad)
- `sv_active` close to `pool_size`: Pool is saturated
- `sv_idle` = 0: No available connections for new requests

---

## Resolution Steps

### Immediate Mitigation: Kill Long-Running Queries

```sql
-- Find and terminate queries running longer than 60 seconds
SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE state = 'active'
  AND query_start < now() - interval '60 seconds'
  AND pid != pg_backend_pid();
```

**Expected outcome:** Connections freed, pool pressure reduces within seconds.

### If that doesn't help: Restart PgBouncer

```bash
# On each API instance, restart the PgBouncer sidecar
# In ECS, this means restarting the task
aws ecs update-service --cluster taskflow-prod --service taskflow-api --force-new-deployment
```

**Expected outcome:** Fresh connection pool established. Rolling restart means no downtime.

### Verify Resolution

- [ ] RDS active connections dropping below 100
- [ ] Application logs no longer showing pool timeout errors
- [ ] API response times returning to normal (< 200ms p95)

**Wait time:** 5 minutes for metrics to stabilize after mitigation.

---

## Root Cause Investigation (post-mitigation)

After the immediate issue is resolved, investigate the root cause:

1. **Check for missing indexes:** Slow queries often cause connection buildup
```sql
SELECT schemaname, tablename, seq_scan, seq_tup_read
FROM pg_stat_user_tables
WHERE seq_scan > 1000
ORDER BY seq_tup_read DESC;
```

2. **Check for transaction leaks:** Look for code paths that open transactions without closing them (search for `BEGIN` without matching `COMMIT/ROLLBACK`)

3. **Check for sudden traffic spike:** CloudWatch ALB request count - was there a spike that exceeded normal capacity?

---

## Common Mistakes to Avoid

- Do NOT increase `max_connections` on RDS as a first response - this masks the root cause and can lead to OOM
- Do NOT restart the entire ECS service unless PgBouncer restart alone doesn't help
- Do NOT skip the root cause investigation after mitigation

---

## Revision History

| Date | Author | Changes | Incident Reference |
|------|--------|---------|-------------------|
| 2025-11-12 | Kevin Oduya | Initial runbook | N/A - proactive |
