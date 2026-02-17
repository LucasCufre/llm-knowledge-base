---
title: Project Master Index
type: project-index
date: 2025-10-17
last-updated: 2025-10-17
status: active
summary: |
  Central navigation hub for all project knowledge and documentation.
  Start here to find any information about the project.
---

# Project Master Knowledge Index

**Last Updated:** 2025-10-17
**Project Status:** 🟢 Active Development

## Quick Navigation
- 📊 [Current Status](03-active-work/_current-status.md) - Updated weekly
- 🎯 [Current Priorities](03-active-work/priorities.md)
- 🚧 [Active Blockers](03-active-work/blockers-and-risks.md)
- 📋 [Recent Decisions](02-decisions/_decisions-index.md)
- 🏗️ [Project Charter](01-foundation/project-charter.md)
- 📥 [Inbox](00-inbox/) - Drop completed documents here for automatic processing
- ✏️ [Work in Progress](00-wip/) - Draft and edit documents before they're ready

## Project Overview
This is a new project using a structured knowledge base system designed to make all project information easily discoverable by both team members and AI assistants. The knowledge base follows best practices for documentation, decision tracking, and knowledge management.

Start by reviewing the [Project Charter](01-foundation/project-charter.md) to understand the project's purpose, and check the [Current Status](03-active-work/_current-status.md) for the latest updates.

## Project Health Dashboard
| Dimension | Status | Last Updated |
|-----------|--------|--------------|
| Schedule | 🟢 On Track | 2025-10-17 |
| Budget | 🟢 On Track | 2025-10-17 |
| Scope | 🟢 On Track | 2025-10-17 |
| Quality | 🟢 On Track | 2025-10-17 |
| Team | 🟢 Healthy | 2025-10-17 |

**Legend:** 🟢 Green (Healthy) | 🟡 Yellow (At Risk) | 🔴 Red (Critical)

## Key Documents by Category

### Foundation & Strategy
- [Project Charter](01-foundation/project-charter.md) - Why this project exists and what we aim to achieve
- [Objectives & Scope](01-foundation/objectives-and-scope.md) - What we're building and what's out of scope
- [Stakeholders](01-foundation/stakeholders.md) - Who's involved and their roles
- [Glossary](01-foundation/glossary.md) - Domain terminology and definitions
- [Constraints & Assumptions](01-foundation/constraints-and-assumptions.md) - Project boundaries and assumptions

### Architecture & Technical
- [Technical Index](04-knowledge-base/technical/_index.md) - Overview of technical documentation
- [Architecture](04-knowledge-base/technical/architecture/) - System design and architecture decisions
- [APIs & Integrations](04-knowledge-base/technical/apis-and-integrations/) - API documentation and integration points
- [Infrastructure](04-knowledge-base/technical/infrastructure/) - Infrastructure and deployment documentation

### Business & Requirements
- [Business Index](04-knowledge-base/business/_index.md) - Overview of business documentation
- [Requirements](04-knowledge-base/business/requirements/) - Product requirements and specifications
- [User Research](04-knowledge-base/business/user-research/) - User studies and research findings
- [Market Analysis](04-knowledge-base/business/market-analysis/) - Market research and competitive analysis

### Operational Knowledge
- [Operational Index](04-knowledge-base/operational/_index.md) - Overview of operational documentation
- [Processes](04-knowledge-base/operational/processes/) - Team processes and workflows
- [Runbooks](04-knowledge-base/operational/runbooks/) - Operational procedures and guides

### Decisions (Most Recent)
*No decisions recorded yet. Use the [template](02-decisions/_template-decision.md) to create your first decision record.*

See [all decisions](02-decisions/_decisions-index.md).

### Active Research
*No active research yet. Use the [template](05-research/_template-research.md) to document research activities.*

See [all research](05-research/_research-index.md).

## Recent Activity
### This Week (Week of 2025-10-17)
- Project knowledge base structure created
- Templates and indexes established
- Ready for team to begin documentation

### Last 30 Days
- Project knowledge base initialization

## Key Contacts
| Role | Name | Responsibility |
|------|------|----------------|
| Project Lead | [To be assigned] | Overall delivery and coordination |
| Tech Lead | [To be assigned] | Architecture & technical decisions |
| Product Owner | [To be assigned] | Requirements & priorities |

*Update this table with actual team member names.*

## Getting Started
New to this project? Read these documents in order:

1. **[Project Charter](01-foundation/project-charter.md)** - Understand the why and what
2. **[Current Status](03-active-work/_current-status.md)** - Get up to speed on current state
3. **[Glossary](01-foundation/glossary.md)** - Learn the domain language
4. **[Objectives & Scope](01-foundation/objectives-and-scope.md)** - Understand what we're building

For developers, also review:
- [Technical Architecture Overview](04-knowledge-base/technical/architecture/)
- [Recent Technical Decisions](02-decisions/_decisions-index.md)

## Documentation Standards
All documents in this knowledge base follow these conventions:
- **YAML frontmatter** with metadata for easy discovery
- **Date format:** YYYY-MM-DD
- **File naming:** lowercase-with-hyphens.md
- **Decisions:** Use ADR format with sequential IDs (ADR-001, ADR-002, etc.)
- **Summaries:** All documents include a summary for LLM context
- **Cross-linking:** Bidirectional links between related documents

## How to Use This Knowledge Base

### For Team Members
- **Finding information:** Start here at the index, or use VS Code search
- **Adding structured content:** Use templates in each category folder
- **Adding unstructured content:** Drop files in [00-inbox/](00-inbox/) and let Claude Code structure them
- **Making decisions:** Use the [decision template](02-decisions/_template-decision.md)
- **Meeting notes:** Use the [meeting template](06-meetings/_template-meeting.md) or drop raw notes in [00-inbox/](00-inbox/)

### Unstructured Content Workflow
Have meeting notes, email threads, or research findings that need structure?

1. **Drop files** in [00-inbox/](00-inbox/)
2. **Claude Code parses** the content automatically
3. **Structured documents** are created in appropriate locations
4. **Indexes updated** for discoverability
5. **Original file deleted** after successful processing

See [Documents to Parse README](00-inbox/README.md) for details and examples.

### For AI Assistants (Claude Code, etc.)
- See [.claude/instructions.md](.claude/instructions.md) for detailed guidance
- Always check this index first for navigation
- Prioritize recent status and decisions
- Use metadata and summaries for context

## Maintenance Schedule

**Automated** (using `/maintenance` command):
- **Daily:** `/maintenance 1d` - Process new documents, validate recent changes (~5-8 min)
- **Weekly:** `/maintenance 5d` - Comprehensive quality review (~10-15 min)
- **Monthly:** `/maintenance 30d` - Deep dive with orphan/stale detection (~25-40 min)
- **Quarterly:** `/maintenance all` - Full repository analysis (~40-90 min)

**Manual:**
- **Weekly:** Update current status document
- **Monthly:** Update this index, review decisions, update glossary
- **Quarterly:** Review automated archival recommendations

See [Maintenance Guide](.claude/maintenance-guide.md) for detailed procedures.

## Quick Links

### Templates
- [Decision Template](02-decisions/_template-decision.md)
- [Meeting Template](06-meetings/_template-meeting.md)
- [Research Template](05-research/_template-research.md)

### Indexes
- [Decisions Index](02-decisions/_decisions-index.md)
- [Meetings Index](06-meetings/_meetings-index.md)
- [Research Index](05-research/_research-index.md)
- [Archive Log](07-archive/_archive-log.md)

### Guides
- [Claude Code Instructions](.claude/instructions.md)
- [Maintenance Guide](.claude/maintenance-guide.md)
- [How to Add Decisions](02-decisions/README.md)
- [How to File Meetings](06-meetings/README.md)

## Need Help?

### Documentation Questions
- Check the README files in each section
- Review the templates for examples
- Consult the [Maintenance Guide](.claude/maintenance-guide.md)

### Project Questions
- Review [Current Status](03-active-work/_current-status.md)
- Check [Active Blockers](03-active-work/blockers-and-risks.md)
- Review recent [Decisions](02-decisions/_decisions-index.md)
- Contact the project lead or relevant stakeholder

---

**Welcome to the project!** This knowledge base is designed to grow with the project and make information easily accessible to everyone. Start by exploring the foundation documents, and don't hesitate to add new content using the provided templates.
