---
title: [Feature/Component Name] - Requirement
type: requirement
date: YYYY-MM-DD
last-updated: YYYY-MM-DD
status: draft
owner: [Product Manager Name]
stakeholders: [Engineering, Design, QA, etc.]
tags: [feature-name, product-area, priority-level]
summary: |
  Brief 2-3 sentence description of what this requirement covers,
  the user need it addresses, and the expected business value.
related-docs:
  - [Link to related ADR if applicable]
  - [Link to user research if applicable]
  - [Link to market analysis if applicable]
---

# [Feature/Component Name] - Requirement

## 1. Executive Summary

**Business Value:**
[Why are we building this? What problem does it solve? What value does it provide to users and the business?]

**User Impact:**
[Which users are affected? What pain point does this address? What will users be able to do that they couldn't before?]

**Success Metrics:**
[How will we measure success? What KPIs or metrics will indicate this feature is achieving its goals?]

---

## 2. Technical Considerations

**Suggested API Endpoints:**
- `POST /api/[endpoint]` - [Brief description]
- `GET /api/[endpoint]` - [Brief description]

**Database Schema Impacts:**
- New tables/collections: [List]
- New fields: [List with table/collection names]
- Relationships: [Describe new or modified relationships]

**Dependencies:**
- External services: [List any 3rd party APIs or services]
- Internal dependencies: [Other features or systems this depends on]
- Prerequisites: [What must exist before this can be built]

**Performance Constraints:**
- Response time: [Target latency, e.g., < 200ms at p95]
- Throughput: [Expected load, e.g., 1000 requests/second]
- Data volume: [Expected data size and growth]

**Security Considerations:**
- Authentication requirements
- Data encryption needs
- Compliance requirements (GDPR, CCPA, etc.)

---

## 3. Acceptance Criteria

### Happy Path
- [ ] [Criterion 1 - specific, testable condition]
- [ ] [Criterion 2 - specific, testable condition]
- [ ] [Criterion 3 - specific, testable condition]

### Error States
- [ ] If [error condition], display [specific error message]
- [ ] If [network failure], [specific fallback behavior]
- [ ] If [validation error], [specific user feedback]

### Empty States
- [ ] When [no data condition], display [specific empty state message/UI]

### Edge Cases
- [ ] [Specific edge case scenario and expected behavior]
- [ ] [Another edge case and expected handling]

---

## 4. Permissions

### Role-Based Access Control (RBAC)

| Action | Allowed Roles | Notes |
|--------|---------------|-------|
| [Action 1] | `ADMIN`, `USER` | [Any special conditions] |
| [Action 2] | `ADMIN` only | [Any special conditions] |
| [Action 3] | All authenticated users | [Any special conditions] |

**Special Permissions:**
- [Describe any special permission logic, row-level security, or conditional access]

**Unauthenticated Access:**
- [Describe what unauthenticated users can/cannot do]

---

## Open Questions

- [ ] [Question 1 that needs clarification]
- [ ] [Question 2 that needs decision]
- [ ] [Question 3 requiring stakeholder input]

---

## Revision History

| Date | Author | Changes |
|------|--------|---------|
| YYYY-MM-DD | [Name] | Initial draft |
