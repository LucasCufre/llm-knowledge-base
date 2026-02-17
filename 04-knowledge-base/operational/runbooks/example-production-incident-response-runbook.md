---
title: Production Incident Response - Runbook
type: runbook
date: 2025-11-10
last-updated: 2025-11-10
status: active
owner: Engineering Team
stakeholders: [On-call engineers, Tech Lead, Product]
tags: [runbook, incident, production, on-call, outage]
summary: |
  General-purpose runbook for responding to production incidents in TaskFlow.
  Covers triage, communication, resolution, and post-mortem procedures.
  Use when alerts fire or users report production issues.
related-docs:
  - example-database-connection-pool-exhaustion-runbook.md
  - ../../technical/infrastructure/example-database-infrastructure.md
  - ../../technical/architecture/example-system-architecture-overview.md
---

# Production Incident Response - Runbook

## Incident Overview

**Symptoms:**
Users report errors, slow responses, or inability to access TaskFlow. Monitoring alerts fire for elevated error rates, high latency, or service unavailability.

**Impact:**
- Severity: Varies (see classification below)
- Affected users: Potentially all users
- Business impact: Service disruption, user trust, potential data concerns

**Expected Resolution Time:**
- P1 (Critical): Target < 1 hour
- P2 (High): Target < 4 hours
- P3 (Medium): Target < 24 hours

---

## Severity Classification

| Priority | Criteria | Example |
|----------|----------|---------|
| P1 - Critical | Service completely down OR data loss/corruption | API returning 500 for all requests, database unreachable |
| P2 - High | Major feature broken for many users | Login failing, real-time updates not working, tasks not saving |
| P3 - Medium | Minor feature degraded, workaround exists | Slow performance, one integration broken, UI rendering issue |

---

## Quick Triage

### Is this a real incident?

**Confirm symptoms:**
- [ ] Check CloudWatch dashboard: Is error rate elevated? (> 1% of requests)
- [ ] Check ECS service: Are tasks running and healthy?
- [ ] Check RDS: Is the database reachable and responding?
- [ ] Try the affected user flow yourself in production

**If symptoms don't match:**
- If it's a single user report: Check if it's a client-side issue or localized network problem
- If monitoring is green: Ask the reporter for screenshots and browser console errors

---

## Prerequisites

**Required Access:**
- AWS Console (IAM role: `taskflow-oncall`)
- CloudWatch dashboards
- GitHub repository (for rollback if needed)
- Slack (#incidents channel)

**Safety Checks BEFORE starting:**
- [ ] Announce in #incidents that you are investigating
- [ ] Check if anyone else is already working on this
- [ ] Note the current time and what triggered the investigation

---

## Investigation Steps

### Step 1: Check Application Health

**Where to look:**
```bash
# Check ECS service status
aws ecs describe-services --cluster taskflow-prod --services taskflow-api

# Check health endpoint
curl -s https://api.taskflow.example.com/health | jq .
```

**What to look for:**
- Health endpoint returning non-200: Application is unhealthy
- ECS tasks in STOPPED state: Container is crashing
- Desired count != running count: Tasks failing to start

---

### Step 2: Check Application Logs

**Where to look:**
```bash
# Recent error logs (CloudWatch Logs Insights)
fields @timestamp, @message
| filter @message like /ERROR/
| sort @timestamp desc
| limit 50
```

**What to look for:**
- Stack traces indicating the root cause
- Database connection errors
- Out of memory errors
- Authentication/authorization failures

---

### Step 3: Check Database and Redis

**Where to look:**
- RDS Performance Insights dashboard
- ElastiCache metrics in CloudWatch

**Key metrics:**
- PostgreSQL active connections > 180 (of 200 max): Connection pool exhaustion
- PostgreSQL CPU > 90%: Expensive query or lock contention
- Redis memory > 90%: Memory pressure, potential evictions
- Redis connection count anomaly: Possible connection leak

---

## Resolution Steps

### If application is crashing (ECS tasks restarting):

1. Check ECS stopped task reason:
```bash
aws ecs describe-tasks --cluster taskflow-prod --tasks <task-arn> | jq '.tasks[0].stoppedReason'
```
2. If OOM: Increase task memory in task definition
3. If code error: Roll back to previous task definition revision
4. If dependency issue: Check database and Redis connectivity

### If database is the issue:

See dedicated runbook: [Database Connection Pool Exhaustion](example-database-connection-pool-exhaustion-runbook.md)

### If the issue is unclear - rollback:

Rolling back is always safe and fast:
```bash
# Deploy previous version
aws ecs update-service --cluster taskflow-prod --service taskflow-api \
  --task-definition taskflow-api:<previous-revision>
```

---

## Communication

### Internal Communication

**Immediately (within 5 minutes of P1/P2):**
- [ ] Post in #incidents: "Investigating [brief description]. Impact: [scope]. I'm on it."
- [ ] Update every 15 minutes during active incident

**After resolution:**
- [ ] Post resolution message: "Resolved: [brief description]. Root cause: [summary]. Post-mortem to follow."

---

## Post-Resolution

### Cleanup Tasks
- [ ] Verify all monitoring is back to normal
- [ ] Check for any data inconsistencies caused by the incident
- [ ] Remove any temporary fixes or workarounds

### Post-Incident Review (required for P1 and P2)
- [ ] Schedule post-mortem within 48 hours
- [ ] Write timeline of events
- [ ] Identify root cause and contributing factors
- [ ] Create action items to prevent recurrence
- [ ] Share learnings with team

---

## Revision History

| Date | Author | Changes | Incident Reference |
|------|--------|---------|-------------------|
| 2025-11-10 | Maria Chen | Initial runbook | N/A - proactive |
