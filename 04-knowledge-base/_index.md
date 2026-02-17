---
title: Knowledge Base Index
type: index
date: 2025-10-17
last-updated: 2025-10-17
status: active
summary: |
  Central index for all technical, business, and operational knowledge
  accumulated throughout the project lifecycle.
---

# Knowledge Base

This directory contains the core knowledge accumulated during the project, organized by domain.

## Directory Structure

### [Technical Knowledge](technical/_index.md)
Architecture, APIs, infrastructure, and technical implementation details.
- **[Architecture](technical/architecture/)** - System design, patterns, and architectural decisions
- **[APIs and Integrations](technical/apis-and-integrations/)** - API documentation, integration guides
- **[Infrastructure](technical/infrastructure/)** - Deployment, hosting, DevOps documentation

### [Business Knowledge](business/_index.md)
Requirements, user research, and business context.
- **[Requirements](business/requirements/)** - Detailed feature requirements and specifications
- **[User Research](business/user-research/)** - User studies, personas, journey maps
- **[Market Analysis](business/market-analysis/)** - Competitive analysis, market research

### [Operational Knowledge](operational/_index.md)
Processes, procedures, and operational guidelines.
- **[Processes](operational/processes/)** - Team processes, workflows, ceremonies
- **[Runbooks](operational/runbooks/)** - Operational procedures, troubleshooting guides

## How to Use This Knowledge Base

### Finding Information
1. Start with the appropriate domain index (technical/business/operational)
2. Browse the category that best fits your need
3. Use tags in document metadata for cross-cutting concerns

### Adding New Knowledge
1. Determine the appropriate domain and category
2. Create document with proper metadata (see templates)
3. Update the relevant `_index.md` file
4. Cross-link to related documents
5. Add tags for discoverability

### Keeping It Current
- Review and update documents when they become outdated
- Mark deprecated content clearly
- Archive obsolete content to `07-archive/`
- Update indexes when adding/removing content

## Document Types in This Area

- **Technical Specifications:** Detailed technical designs
- **API Documentation:** Endpoint references, integration guides
- **Architecture Documents:** System design, patterns, principles
- **Requirements Documents:** Detailed feature specifications
- **User Research:** Studies, findings, personas
- **Process Documents:** How we work, team agreements
- **Runbooks:** Step-by-step operational procedures

## Metadata Standards

All knowledge base documents should include:
```yaml
---
title: [Descriptive Title]
type: [technical-doc | api-doc | requirement | research | process | runbook]
date: YYYY-MM-DD
last-updated: YYYY-MM-DD
status: [active | draft | deprecated | archived]
owner: [Person responsible]
tags: [relevant, searchable, keywords]
summary: |
  2-3 sentence summary for LLM context and human scanning
related-docs:
  - [relative/path/to/related/doc.md]
---
```

## Related Documents
- [Foundation Documents](../01-foundation/) - Project objectives and scope
- [Decisions](../02-decisions/) - Why certain approaches were chosen
- [Research](../05-research/) - Exploratory research and spikes
