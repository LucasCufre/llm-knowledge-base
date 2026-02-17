---
title: Implement RBAC Using Casbin Authorization Library
type: decision-record
decision-id: ADR-002
date: 2025-11-10
status: accepted
owner: James Park
stakeholders: [Engineering Team, Security, Product]
tags: [architecture, security, authorization, rbac]
summary: |
  Decided to implement Role-Based Access Control using the Casbin library
  rather than building a custom authorization layer. Provides a policy-based
  model that supports our multi-tenant workspace requirements.
related-docs:
  - ../04-knowledge-base/business/requirements/example-user-authentication-requirement.md
  - ../04-knowledge-base/technical/architecture/example-authentication-service-architecture.md
  - ../05-research/example-authorization-framework-comparison.md
---

# Implement RBAC Using Casbin Authorization Library

## Context and Problem Statement

TaskFlow workspaces need granular access control: workspace owners, admins, members, and guests each have different permissions for projects, tasks, and settings. We need a system that is flexible enough to support future permission models (e.g., project-level roles) without a full rewrite. Building this from scratch would be error-prone and time-consuming.

## Decision

We will use [Casbin](https://casbin.org/) (Node.js adapter) as our authorization engine, with policies stored in PostgreSQL. The RBAC model will define four workspace roles: Owner, Admin, Member, and Guest.

## Rationale

- Casbin's policy model separates authorization logic from business code, making it easier to audit and modify
- Supports RBAC, ABAC, and hybrid models - we can start with RBAC and evolve to attribute-based rules later
- PostgreSQL adapter keeps policies in our existing database (no new infrastructure)
- Well-maintained open-source project with active community and good documentation
- Middleware integration is straightforward for our Express.js API

## Consequences

### Positive
- Clean separation of authorization policies from application code
- Easy to add new roles or modify permissions without code changes
- Audit-friendly: policies are stored as data, not scattered across codebase
- Future-proof: can extend to project-level or resource-level permissions

### Negative
- Additional dependency in the stack
- Team needs to learn Casbin's policy language and model syntax
- Policy evaluation adds a small latency overhead per request (~2-5ms)

### Neutral
- Need to build an admin UI for managing roles and policies
- Policies need to be seeded as part of workspace creation

## Alternatives Considered

### Option 1: Custom middleware with role checks
- Simple if-else or switch statements in route handlers
- Easy to understand initially but becomes unmaintainable as roles/resources grow
- Rejected due to scalability and auditability concerns

### Option 2: CASL (JavaScript library)
- More JavaScript-native API than Casbin
- Less flexible policy model - primarily designed for frontend ability checks
- Rejected because Casbin's model flexibility better suits our multi-tenant backend needs

### Option 3: Open Policy Agent (OPA)
- Very powerful policy engine used by large enterprises
- Requires running a separate sidecar service (Rego policy language)
- Rejected as overengineered for our current scale; could revisit later

## Implementation Notes

1. Define Casbin model file with RBAC roles: Owner > Admin > Member > Guest
2. Create PostgreSQL adapter for policy storage
3. Build middleware that checks `(user, resource, action)` on each API request
4. Seed default policies when a new workspace is created
5. Add role management endpoints to the API (`POST /workspaces/:id/members`)

## References
- [Casbin Documentation](https://casbin.org/docs/overview)
- [Node-Casbin GitHub](https://github.com/casbin/node-casbin)
- Authorization framework comparison research document

## Revision History
- 2025-11-10: Initial decision accepted after security review
