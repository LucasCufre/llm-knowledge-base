---
title: Authorization Framework Comparison
type: research
date: 2025-11-06
status: completed
researcher: James Park
tags: [technical-research, authorization, rbac, security, frameworks]
summary: |
  Compared three authorization frameworks (Casbin, CASL, OPA) for TaskFlow's
  RBAC needs. Casbin recommended for its policy flexibility, PostgreSQL adapter,
  and ability to evolve from RBAC to ABAC without rewrite.
related-docs:
  - ../02-decisions/2025-11-10-implement-rbac-with-casbin.md
  - ../04-knowledge-base/business/requirements/example-user-authentication-requirement.md
---

# Research: Authorization Framework Comparison

## Research Question

Which authorization framework best fits TaskFlow's needs for workspace-level RBAC today, with the ability to scale to project-level and resource-level permissions in the future?

## Methodology

- Evaluated three frameworks: Casbin, CASL, and Open Policy Agent (OPA)
- Built a proof-of-concept with each using a simplified TaskFlow data model (workspace > project > task, with 4 roles)
- Evaluated on: ease of integration, policy flexibility, performance overhead, and team learning curve
- POC code available in `experiments/auth-poc/` branch

## Key Findings

### Finding 1: Casbin offers the best flexibility-to-complexity ratio

- Supports RBAC, ABAC, and hybrid models through configurable policy models
- Node.js adapter is mature and well-documented
- PostgreSQL adapter stores policies alongside our application data
- POC implementation took 4 hours; role hierarchy works out of the box
- Performance: ~3ms per authorization check (acceptable for our scale)

### Finding 2: CASL is simpler but limited

- More JavaScript-idiomatic API (feels natural in Express middleware)
- Great for frontend ability checks (`can(user, 'read', 'Task')`)
- Policies defined in code, not data - harder to modify at runtime
- No built-in role hierarchy; would need custom implementation
- Better suited as a complementary frontend library, not the primary backend engine

### Finding 3: OPA is powerful but overengineered for our needs

- Requires learning Rego (a dedicated policy language)
- Runs as a separate sidecar process, adding operational complexity
- Designed for large-scale microservice architectures
- Would be excellent at 100+ microservices; overkill for our monolithic API
- POC implementation took 12 hours (mostly learning Rego)

## Comparison Matrix

| Criteria | Casbin | CASL | OPA |
|----------|--------|------|-----|
| RBAC support | Excellent | Good | Excellent |
| ABAC support | Good | Limited | Excellent |
| Node.js integration | Good | Excellent | Fair |
| Policy storage | DB or file | Code only | File or bundle |
| Runtime policy changes | Yes | No (redeploy) | Yes |
| Learning curve | Medium | Low | High |
| Performance overhead | ~3ms | ~1ms | ~5ms + network |
| Operational complexity | Low | Low | High (sidecar) |
| **Overall fit for TaskFlow** | **Best** | Good for FE | Overkill |

## Recommendations

1. **Use Casbin** as the primary authorization engine for the backend API
2. Consider **CASL** as a complementary library for frontend permission checks (hiding UI elements the user can't access)
3. Revisit **OPA** if TaskFlow moves to a microservices architecture in the future

## Next Steps

- Draft ADR for Casbin adoption (assigned to James)
- Define the initial RBAC policy model (4 workspace roles)
- Build middleware integration into Express.js API

## Raw Data & Sources

- POC code: `experiments/auth-poc/` branch
- [Casbin documentation](https://casbin.org/docs/overview)
- [CASL documentation](https://casl.js.org/v6/en/)
- [OPA documentation](https://www.openpolicyagent.org/docs/latest/)
- Performance benchmarks: Ran 10,000 authorization checks in POC, measured p50/p95/p99

## Related Documents

- [ADR-002: Implement RBAC with Casbin](../02-decisions/2025-11-10-implement-rbac-with-casbin.md)
- [User Authentication Requirement](../04-knowledge-base/business/requirements/example-user-authentication-requirement.md)
