---
title: Sprint Planning - Week 1 November
type: meeting-note
date: 2025-11-01
attendees: [Sarah Kim, Maria Chen, James Park, Alex Torres, Kevin Oduya, Lisa Nguyen]
meeting-type: planning
tags: [sprint-planning, mvp, authentication, database]
summary: |
  First sprint planning for the MVP phase. Committed to database migration
  (SQLite to PostgreSQL) and authentication system implementation.
  Sprint goal: Core infrastructure ready for feature development.
related-docs:
  - ../../02-decisions/2025-11-03-adopt-postgresql-as-primary-database.md
  - ../../04-knowledge-base/business/requirements/example-user-authentication-requirement.md
  - ../../03-active-work/priorities.md
---

# Sprint Planning - Week 1 November

**Date:** 2025-11-01
**Time:** 10:00 - 11:00 ET
**Attendees:** Sarah Kim (PM), Maria Chen (Tech Lead), James Park, Alex Torres, Kevin Oduya, Lisa Nguyen (UX)
**Facilitator:** Sarah Kim

## Agenda

1. Review MVP feature priorities
2. Database migration planning
3. Authentication system kickoff
4. Sprint commitment

## Key Discussion Points

### MVP Feature Priorities

(10:03) Sarah presented the prioritized MVP feature list based on user research findings. Authentication and real-time collaboration are the two highest-priority features. The team agreed that authentication is the prerequisite for everything else.

- Maria: "We need to solve the database problem first. SQLite won't work for multi-user access."
- Sarah: "Agreed. Let's make this sprint about infrastructure: database migration and auth."

### Database Migration (SQLite to PostgreSQL)

(10:15) Maria proposed migrating from SQLite to PostgreSQL before building any new features. Kevin shared his experience with RDS setup from a previous project.

- Kevin: "I can have an RDS instance running in staging by Wednesday. The data migration script is the bigger task."
- Maria: "Let's write the migration script as a Prisma migration. We need to change the schema anyway to add JSONB for task metadata."
- James: "Should we also set up Redis now, or defer that?"
- Maria: "Now. We'll need it for session caching and later for WebSocket pub/sub. Better to set it up once."

### Authentication Approach

(10:35) James presented his research on authorization frameworks. The team discussed whether to build auth in-house or use a service like Auth0.

- James: "I've been evaluating Casbin, CASL, and OPA. I'll share the full comparison document, but short version: Casbin for authorization, and we build our own JWT auth layer."
- Sarah: "Why not Auth0? It would be faster."
- Maria: "At our stage, the cost of Auth0 scaling per-user is significant, and we'd lose control over the login UX. Let's build it ourselves - it's well-understood territory."
- Lisa: "From the onboarding research, we need Google and GitHub OAuth. Whatever we build needs to support that from day one."

## Decisions Made

1. **Migrate to PostgreSQL this sprint** - Blocking all other features, must be done first. See ADR-001.
2. **Build authentication in-house** - Using JWT + bcrypt + Casbin, not a third-party auth service. Cost and UX control were the deciding factors.
3. **Set up Redis alongside PostgreSQL** - One infrastructure setup, not two separate efforts.

## Action Items

- [x] **Set up RDS PostgreSQL in staging** - Assigned to: Kevin Oduya - Due: 2025-11-05
- [x] **Write SQLite-to-PostgreSQL migration script** - Assigned to: Maria Chen - Due: 2025-11-07
- [x] **Complete authorization framework research doc** - Assigned to: James Park - Due: 2025-11-06
- [x] **Draft authentication requirement doc** - Assigned to: Sarah Kim - Due: 2025-11-05
- [ ] **Update Prisma schema for PostgreSQL types** - Assigned to: Alex Torres - Due: 2025-11-07

## Sprint Goal

**"Core infrastructure ready: PostgreSQL and Redis running, authentication system designed and implementation started."**

**Capacity:** 5 engineers x 4 days effective = 20 person-days
**Committed:** 16 person-days (80% capacity, 20% buffer for unplanned work)

## Next Steps

- Kevin starts RDS setup Monday afternoon
- James shares auth framework comparison by Wednesday
- Maria writes migration script, Alex updates Prisma schema in parallel
- Sprint review: Friday November 7 at 3:00 PM

## References

- [Onboarding Friction Study](../../04-knowledge-base/business/user-research/example-onboarding-friction-study.md) - Lisa's research informing OAuth requirements
- [MVP priorities spreadsheet](../../03-active-work/priorities.md)
