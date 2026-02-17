---
title: Constraints and Assumptions
type: constraints-assumptions
date: 2025-10-17
last-updated: 2025-10-17
status: active
owner: [Project Manager]
tags: [foundation, constraints, assumptions, risks]
summary: |
  Documented constraints, limitations, and assumptions that shape the project,
  including technical, resource, timeline, and regulatory factors.
related-docs:
  - project-charter.md
  - objectives-and-scope.md
  - ../03-active-work/blockers-and-risks.md
---

# Constraints and Assumptions

## Overview

This document captures the known constraints (hard limitations) and assumptions (things we're taking as given) that shape how we approach this project.

## Constraints

Constraints are hard limits we must work within. These are non-negotiable unless circumstances change significantly.

### Budget Constraints

#### Constraint: Total Budget Cap
**Limit:** [Dollar amount]
**Impact:** Limits team size, technology choices, and project duration
**Mitigation:** Prioritize ruthlessly, consider phased approach
**Owner:** [Project Sponsor]

#### Constraint: [Additional budget constraint]
**Limit:** [Specific limitation]
**Impact:** [How this affects the project]
**Mitigation:** [How we work within this]
**Owner:** [Name]

---

### Timeline Constraints

#### Constraint: Fixed Launch Date
**Limit:** Must launch by YYYY-MM-DD
**Reason:** [Why this date is fixed - market window, contract, event, etc.]
**Impact:** Scope may need to flex to meet date
**Mitigation:** MVP approach, phased rollout
**Owner:** [Project Sponsor]

#### Constraint: [Additional timeline constraint]
**Limit:** [Specific limitation]
**Reason:** [Why this exists]
**Impact:** [How this affects the project]
**Mitigation:** [How we work within this]
**Owner:** [Name]

---

### Technical Constraints

#### Constraint: Must Use Existing Infrastructure
**Limit:** Cannot procure new infrastructure; must use [existing platform]
**Reason:** [Policy, budget, strategic decision]
**Impact:** Architecture must be compatible with [existing system]
**Mitigation:** [Technical approach to work within this]
**Owner:** [Tech Lead]

#### Constraint: Technology Stack Restrictions
**Limit:** Must use [specific technologies]
**Reason:** [Organizational standards, support agreements, expertise]
**Impact:** Cannot use [alternatives we might have preferred]
**Mitigation:** [How we maximize effectiveness within these limits]
**Owner:** [Tech Lead]

#### Constraint: Integration Requirements
**Limit:** Must integrate with [specific system(s)]
**Reason:** [Business requirement, existing contracts]
**Impact:** [How this affects architecture and timeline]
**Mitigation:** [How we'll handle integration challenges]
**Owner:** [Tech Lead]

#### Constraint: Performance Requirements
**Limit:** Must support [X] concurrent users with <[Y]ms response time
**Reason:** [SLA, user experience requirements]
**Impact:** Architecture and infrastructure decisions
**Mitigation:** [Technical strategies to meet performance targets]
**Owner:** [Tech Lead]

---

### Resource Constraints

#### Constraint: Team Size Limit
**Limit:** Maximum [X] full-time team members
**Reason:** [Budget, availability, organizational limits]
**Impact:** Affects velocity and scope
**Mitigation:** Prioritization, external contractors for specific needs
**Owner:** [Project Manager]

#### Constraint: Skill Availability
**Limit:** Limited availability of [specific skill/expertise]
**Reason:** [Organizational constraints, market scarcity]
**Impact:** May need training or external help
**Mitigation:** [Training plan, contractor plan, knowledge sharing]
**Owner:** [Project Manager]

#### Constraint: Key Resource Availability
**Limit:** [Key person] only available [X]% time
**Reason:** [Other commitments, role constraints]
**Impact:** [How this affects timeline/approach]
**Mitigation:** [How we work around this]
**Owner:** [Project Manager]

---

### Regulatory and Compliance Constraints

#### Constraint: [Regulatory Requirement]
**Limit:** Must comply with [regulation/standard]
**Reason:** Legal requirement
**Impact:** [How this affects design, data handling, etc.]
**Mitigation:** [Compliance strategy]
**Owner:** [Compliance Lead]

#### Constraint: Data Privacy Requirements
**Limit:** Must comply with [GDPR, CCPA, HIPAA, etc.]
**Reason:** Legal requirement, user rights
**Impact:** Data architecture, consent mechanisms, data retention
**Mitigation:** [Privacy by design, legal review, security measures]
**Owner:** [Security/Privacy Lead]

#### Constraint: Security Standards
**Limit:** Must meet [security standard/certification]
**Reason:** [Organizational policy, industry requirement, customer requirement]
**Impact:** [How this affects architecture and development]
**Mitigation:** [Security practices, audits, controls]
**Owner:** [Security Lead]

---

### Operational Constraints

#### Constraint: Support Hours
**Limit:** Support only available [hours/days]
**Reason:** [Resource limitations, budget]
**Impact:** System must be resilient, good monitoring needed
**Mitigation:** [Automation, documentation, escalation procedures]
**Owner:** [Operations Lead]

#### Constraint: Deployment Windows
**Limit:** Can only deploy during [specific time windows]
**Reason:** [Change management policy, business hours constraints]
**Impact:** Release planning and timing
**Mitigation:** [Deployment strategy, rollback plans]
**Owner:** [Tech Lead]

---

## Assumptions

Assumptions are things we're taking as true but haven't fully validated. These carry risk and should be monitored.

### Business Assumptions

#### Assumption: User Adoption
**Assumption:** Users will adopt the new system within [X] months
**Basis:** [Market research, similar projects, user feedback]
**Risk if Wrong:** [What happens if adoption is slower]
**Validation Plan:** [How we'll test this assumption]
**Validation Date:** YYYY-MM-DD
**Status:** =á Not yet validated / =â Validated / =4 Invalidated

#### Assumption: Market Conditions
**Assumption:** [Market condition assumed to hold]
**Basis:** [Current trends, analysis, expert opinion]
**Risk if Wrong:** [Impact on project value]
**Validation Plan:** [Ongoing monitoring approach]
**Validation Date:** Ongoing
**Status:** =á Not yet validated / =â Validated / =4 Invalidated

#### Assumption: Business Priorities
**Assumption:** [This project] will remain a top priority
**Basis:** [Strategic plan, stakeholder commitment]
**Risk if Wrong:** Resource reallocation, project cancellation
**Validation Plan:** Regular check-ins with sponsor
**Validation Date:** Monthly
**Status:** =â Validated

---

### Technical Assumptions

#### Assumption: Technology Scalability
**Assumption:** [Technology X] can scale to meet our needs
**Basis:** [Vendor specs, similar implementations, proof of concept]
**Risk if Wrong:** Major architecture changes needed
**Validation Plan:** [Performance testing, benchmarking]
**Validation Date:** YYYY-MM-DD
**Status:** =á Not yet validated

#### Assumption: Third-Party Service Availability
**Assumption:** [External service] will maintain [uptime/performance]
**Basis:** [SLA, historical data]
**Risk if Wrong:** Service degradation, user impact
**Validation Plan:** Ongoing monitoring, fallback plan
**Validation Date:** Ongoing
**Status:** =â Validated

#### Assumption: Integration Feasibility
**Assumption:** Can integrate with [system] using [approach]
**Basis:** [API documentation, vendor confirmation, prototype]
**Risk if Wrong:** Delayed integration, scope changes
**Validation Plan:** [Integration spike, proof of concept]
**Validation Date:** YYYY-MM-DD
**Status:** =á Not yet validated

#### Assumption: Data Availability
**Assumption:** Required data is available and accessible from [source]
**Basis:** [Data audit, system documentation]
**Risk if Wrong:** Cannot build planned features
**Validation Plan:** [Data discovery, access verification]
**Validation Date:** YYYY-MM-DD
**Status:** =á Not yet validated

---

### Resource Assumptions

#### Assumption: Team Continuity
**Assumption:** Core team members will remain available throughout project
**Basis:** [Commitments from managers, retention indicators]
**Risk if Wrong:** Knowledge loss, delays, rework
**Validation Plan:** Regular 1:1s, retention discussions
**Validation Date:** Ongoing
**Status:** =â Validated

#### Assumption: External Vendor Support
**Assumption:** [Vendor] will provide support within [timeframe]
**Basis:** [Contract, SLA, past experience]
**Risk if Wrong:** Blocked on vendor issues
**Validation Plan:** Establish support relationship early
**Validation Date:** YYYY-MM-DD
**Status:** =á Not yet validated

---

### User Assumptions

#### Assumption: User Capabilities
**Assumption:** Users have [level of technical sophistication]
**Basis:** [User research, existing system usage]
**Risk if Wrong:** Need more training, simpler interface
**Validation Plan:** User testing, early beta feedback
**Validation Date:** YYYY-MM-DD
**Status:** =á Not yet validated

#### Assumption: User Environment
**Assumption:** Users have access to [devices/browsers/connectivity]
**Basis:** [IT standards, user surveys]
**Risk if Wrong:** Accessibility issues, reduced adoption
**Validation Plan:** Environmental survey, beta testing
**Validation Date:** YYYY-MM-DD
**Status:** =á Not yet validated

---

## Dependency Assumptions

### Internal Dependencies

| Dependency | Assumption | Risk if Wrong | Validation | Status |
|------------|-----------|---------------|------------|--------|
| [Team/System] | [What we assume] | [Impact] | [How to verify] | =á/=â/=4 |
| [Team/System] | [What we assume] | [Impact] | [How to verify] | =á/=â/=4 |

### External Dependencies

| Dependency | Assumption | Risk if Wrong | Validation | Status |
|------------|-----------|---------------|------------|--------|
| [Vendor/Partner] | [What we assume] | [Impact] | [How to verify] | =á/=â/=4 |
| [Vendor/Partner] | [What we assume] | [Impact] | [How to verify] | =á/=â/=4 |

---

## Assumption Validation Tracking

### High-Risk Assumptions Requiring Immediate Validation
1. **[Assumption name]** - Target validation: YYYY-MM-DD
2. **[Assumption name]** - Target validation: YYYY-MM-DD
3. **[Assumption name]** - Target validation: YYYY-MM-DD

### Recently Invalidated Assumptions

| Date | Assumption | What Changed | Impact | Response |
|------|-----------|--------------|--------|----------|
| YYYY-MM-DD | [Assumption] | [What we learned] | [Impact on project] | [How we adapted] |

---

## Constraint Change Log

| Date | Constraint | Previous | New | Reason | Impact |
|------|-----------|----------|-----|--------|--------|
| YYYY-MM-DD | [Constraint] | [Old limit] | [New limit] | [Why changed] | [Effect on project] |

---

## Revision History

| Date | Version | Changes | Author |
|------|---------|---------|--------|
| 2025-10-17 | 1.0 | Initial constraints and assumptions | [Name] |

---

**Maintenance Notes:**
- Review assumptions monthly
- Validate high-risk assumptions as early as possible
- Update constraints when circumstances change
- Link to risk register when assumptions are invalidated
- Document how we adapted when constraints or assumptions change
