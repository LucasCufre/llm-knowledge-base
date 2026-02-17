# Project Knowledge Base

**A structured, LLM-optimized project documentation system**

This repository uses a comprehensive knowledge management structure designed to make all project information easily discoverable by both humans and AI assistants like Claude Code.

## Start Here

**New to this project?** Read the [Master Project Index](00-PROJECT-INDEX.md)

**Looking for specific information?** Use the quick links below

**Want to set up your own instance?** See the [Setup Guide](SETUP.md)

**Want to contribute?** Check the [Contributing Guide](CONTRIBUTING.md)

## Quick Navigation

### Current Project State

- [Current Status](03-active-work/_current-status.md) - Weekly project status updates
- [Priorities](03-active-work/priorities.md) - What we're working on now
- [Blockers & Risks](03-active-work/blockers-and-risks.md) - Current issues and risks

### Foundation

- [Project Charter](01-foundation/project-charter.md) - Project purpose and authority
- [Objectives & Scope](01-foundation/objectives-and-scope.md) - What we're building
- [Stakeholders](01-foundation/stakeholders.md) - Who's involved and their roles
- [Constraints & Assumptions](01-foundation/constraints-and-assumptions.md) - Project boundaries
- [Glossary](01-foundation/glossary.md) - Project terminology

### Decisions & Knowledge

- [Decision Records](02-decisions/_decisions-index.md) - All project decisions
- [Knowledge Base](04-knowledge-base/_index.md) - Technical, business, and operational docs
- [Research](05-research/_research-index.md) - Research and investigations

### Content Processing

- [Inbox](00-inbox/) - Drop completed documents here for automatic processing
- [Work in Progress](00-wip/) - Draft and edit documents before they're ready for processing

## Directory Structure

```
project-root/
├── 00-PROJECT-INDEX.md              # Central navigation hub
├── 00-inbox/                        # Completed documents ready for processing
│   └── review-needed/               # Flagged for human review
├── 00-wip/                          # Work in progress - drafts being edited
├── 01-foundation/                   # Project charter, glossary, scope
│   ├── _index.md
│   ├── project-charter.md
│   ├── objectives-and-scope.md
│   ├── glossary.md
│   ├── stakeholders.md
│   └── constraints-and-assumptions.md
├── 02-decisions/                    # Architecture Decision Records (ADRs)
│   ├── _decisions-index.md
│   ├── _template-decision.md
│   └── YYYY-MM-DD-decision-*.md
├── 03-active-work/                  # Current status, priorities, blockers
│   ├── _current-status.md
│   ├── priorities.md
│   └── blockers-and-risks.md
├── 04-knowledge-base/               # Organized knowledge
│   ├── _index.md
│   ├── business/                    # Product & business docs
│   │   ├── _index.md
│   │   ├── requirements/            # Feature specs, PRDs, user stories
│   │   ├── user-research/           # User interviews, surveys, feedback
│   │   └── market-analysis/         # Competitive analysis, market data
│   ├── technical/                   # Technical documentation
│   │   ├── _index.md
│   │   ├── architecture/
│   │   ├── apis-and-integrations/
│   │   └── infrastructure/
│   └── operational/                 # Processes and runbooks
│       ├── _index.md
│       ├── processes/
│       └── runbooks/
├── 05-research/                     # Research and investigations
│   ├── _research-index.md
│   └── _template-research.md
├── 06-meetings/                     # Meeting notes by month
│   ├── _meetings-index.md
│   ├── _template-meeting.md
│   └── YYYY-MM/                     # Organized by month
├── 07-archive/                      # Archived content by quarter
│   ├── _archive-log.md
│   └── YYYY-QX/
├── .claude/                         # Claude Code configuration
│   ├── commands/                    # Slash commands
│   ├── instructions.md
│   └── maintenance-guide.md
├── .github/                         # GitHub templates and configuration
│   ├── ISSUE_TEMPLATE/              # Bug report, feature request, docs improvement
│   ├── PULL_REQUEST_TEMPLATE.md
│   └── SECURITY.md
├── logs/                            # Maintenance and processing logs
├── CLAUDE.md                        # AI assistant instructions
├── CONTRIBUTING.md                  # Contribution guidelines
├── LICENSE                          # MIT License
├── SETUP.md                         # Setup guide for new instances
└── README.md                        # This file
```

## Key Principles

### 1. Everything Has Metadata

All documents include YAML frontmatter with:

- Title, type, date, status
- Summary for quick context
- Tags for discoverability
- Related documents for navigation

### 2. Decisions Are Documented

Significant decisions use the Architecture Decision Record (ADR) format to capture:

- What was decided
- Why it was decided
- What alternatives were considered
- What the implications are

### 3. Status Is Current

Active work documents are updated regularly:

- Status reports: Weekly
- Priorities: As needed
- Blockers: Daily

### 4. Knowledge Is Linked

Documents reference each other creating a web of knowledge:

- Decisions link to requirements
- Status updates link to decisions
- Meeting notes link to action items

### 5. Old Content Is Archived

Outdated content is moved to the archive but kept for historical reference:

- Maintains clean active directories
- Preserves institutional knowledge
- Enables historical research

## Templates

Use these templates to create new content:

### Core Templates

- **Decision Record:** [02-decisions/\_template-decision.md](02-decisions/_template-decision.md)
- **Meeting Notes:** [06-meetings/\_template-meeting.md](06-meetings/_template-meeting.md)

### Business/Product Templates

- **Requirement (PRD):** [04-knowledge-base/business/requirements/\_template-requirement.md](04-knowledge-base/business/requirements/_template-requirement.md)
  - 4-section structure: Executive Summary, Technical Considerations, Acceptance Criteria, Permissions
- **User Research:** [04-knowledge-base/business/user-research/\_template-user-research.md](04-knowledge-base/business/user-research/_template-user-research.md)
- **Market Analysis:** [04-knowledge-base/business/market-analysis/\_template-market-analysis.md](04-knowledge-base/business/market-analysis/_template-market-analysis.md)

### Technical Templates

- **Architecture Doc:** [04-knowledge-base/technical/architecture/\_template-architecture-doc.md](04-knowledge-base/technical/architecture/_template-architecture-doc.md)

### Operational Templates

- **Process Documentation:** [04-knowledge-base/operational/processes/\_template-process.md](04-knowledge-base/operational/processes/_template-process.md)
- **Runbook:** [04-knowledge-base/operational/runbooks/\_template-runbook.md](04-knowledge-base/operational/runbooks/_template-runbook.md)

## For Team Members

### Adding a Decision

1. Copy the [decision template](02-decisions/_template-decision.md)
2. Name it: `YYYY-MM-DD-decision-title.md`
3. Fill out all sections
4. Update the [decisions index](02-decisions/_decisions-index.md)

See [detailed instructions](02-decisions/README.md).

### Documenting a Meeting

1. Copy the [meeting template](06-meetings/_template-meeting.md)
2. Name it: `YYYY-MM-DD-meeting-title.md`
3. Document within 24 hours
4. Extract decisions to ADRs
5. Update the [meetings index](06-meetings/_meetings-index.md)

See [detailed instructions](06-meetings/README.md).

### Updating Status

1. Update [\_current-status.md](03-active-work/_current-status.md) weekly
2. Review and update [priorities](03-active-work/priorities.md)
3. Update [blockers and risks](03-active-work/blockers-and-risks.md)

See [detailed instructions](03-active-work/README.md).

### Adding Unstructured Content

Have raw meeting notes, email threads, or research findings? Don't spend time formatting:

1. **Drop files** in [00-inbox/](00-inbox/)
2. **Claude Code automatically:**
   - Analyzes the content
   - Extracts key information (dates, people, decisions, actions)
   - Creates properly formatted documents
   - Updates all relevant indexes
   - Deletes the original file after processing

**What you can drop:**

- Meeting transcripts or notes
- Email threads
- Chat logs (Slack, Teams)
- Research findings
- Requirements drafts
- Technical documentation
- Any text-based project content

See [Documents to Parse README](00-inbox/README.md) for examples and best practices.

## Automated Workflows (Slash Commands)

This knowledge base includes powerful automation through slash commands:

### Query & Research

- `/query [question]` - Comprehensive research with cited sources
- `/quick-query [question]` - Fast factual lookups

### Documentation Management

- `/update` - Analyze conversation and update outdated docs
- `/prd-bot` - Transform vague ideas into development-ready PRDs and User Stories
- `/standup-tldr` - Generate executive summaries of daily standups

### Maintenance

- `/maintenance [timeframe]` - Unified maintenance workflow
  - **Timeframes:** `1d`, `5d`, `15d`, `30d`, or `all`
  - **No parameter:** Interactive selection
  - **What it does:**
    - Processes new documents from inbox
    - Validates document quality (metadata, structure, links)
    - **Cross-references documents** (finds missing links and decisions)
    - Updates all indexes automatically
    - Detects duplicates and orphaned content
    - Identifies stale content (30d/all only)
  - **Examples:**
    - `/maintenance 1d` - Quick daily check (~5-8 min)
    - `/maintenance 5d` - Weekly review (~10-15 min)
    - `/maintenance 30d` - Monthly deep dive (~25-40 min)
    - `/maintenance status` - Quick health check only

### How to Use

Simply type the command in Claude Code (e.g., `/query What are our requirements for user authentication?`)

## Cross-Tool Compatibility

This knowledge base works with multiple AI coding assistants:

- **Claude Code** - Uses `CLAUDE.md`
- **Cursor** - Uses `.cursorrules` (symlink to CLAUDE.md)
- **Cline** - Uses `.clinerules` (symlink to CLAUDE.md)
- **Windsurf** - Uses `.windsurfrules` (symlink to CLAUDE.md)
- **Continue** - Uses `.continue/instructions.md` (symlink to CLAUDE.md)
- **Gemini** - Uses `.gemini/instructions.md` (symlink to CLAUDE.md)

A root-level `instructions.md` symlink is also provided for generic tool compatibility.

All tools share the same instructions, ensuring consistent behavior across your team's preferred AI assistants.

## For AI Assistants

### Claude Code and Similar Tools

This knowledge base is optimized for AI assistant discovery:

1. **Start with:** [00-PROJECT-INDEX.md](00-PROJECT-INDEX.md) for navigation
2. **Read:** [CLAUDE.md](CLAUDE.md) for comprehensive instructions
3. **Use commands:** Slash commands for common operations
4. **Prioritize:** Current status and recent decisions
5. **Use:** Metadata summaries for quick context
6. **Follow:** Links between related documents

### Context Priority

When answering questions:

1. Current status ([03-active-work/](03-active-work/))
2. Recent decisions ([02-decisions/](02-decisions/))
3. Foundation docs ([01-foundation/](01-foundation/))
4. Knowledge base ([04-knowledge-base/](04-knowledge-base/))
5. Research ([05-research/](05-research/))
6. Meetings ([06-meetings/](06-meetings/))

## Maintenance

### Weekly Tasks

- Update current status
- File new content in appropriate directories
- Process meeting notes

### Monthly Tasks

- Update master index
- Review decision statuses
- Update glossary
- Review priorities

### Quarterly Tasks

- Archive old content
- Audit structure
- Review and update processes

See the [Maintenance Guide](.claude/maintenance-guide.md) for details.

## Benefits of This Structure

### For Humans

- **Easy to navigate:** Clear hierarchy and indexes
- **Easy to maintain:** Templates and guidelines
- **Easy to find:** Tags, summaries, and cross-linking
- **Easy to onboard:** Clear starting points and documentation standards

### For AI Assistants

- **Semantic search optimized:** Metadata and summaries
- **Context-rich:** Related documents and cross-linking
- **Status-aware:** Current vs. historical content clearly marked
- **Decision-aware:** Rationale and alternatives documented

### For the Project

- **Institutional knowledge preserved:** Nothing is lost
- **Context maintained:** Why decisions were made
- **Onboarding accelerated:** New team members get up to speed quickly
- **Communication improved:** Single source of truth

## Getting Help

### Documentation Questions

- Check README files in each directory
- Review templates for examples
- Consult the [Maintenance Guide](.claude/maintenance-guide.md)

### Project Questions

- Start with [00-PROJECT-INDEX.md](00-PROJECT-INDEX.md)
- Check [Current Status](03-active-work/_current-status.md)
- Review [Recent Decisions](02-decisions/_decisions-index.md)
- Contact project lead or stakeholders

## Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on:

- Reporting issues and requesting features
- Submitting changes via pull request
- Document standards and naming conventions
- Code of conduct

## File Naming Conventions

- Use lowercase with hyphens: `my-document-name.md`
- Date prefix for chronological items: `YYYY-MM-DD-title.md`
- Underscore prefix for special files: `_index.md`, `_template.md`

## Document Structure

1. YAML frontmatter with metadata
2. Clear title (H1)
3. Sections with headers (H2, H3)
4. Links to related documents
5. Update date when modified

## Cross-Referencing

- Use relative paths
- Link bidirectionally (A links to B and B links to A)
- Keep "Related Documents" sections updated

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact

Lucas Cufre - hello@lucascufre.design

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GitHub Stars](https://img.shields.io/github/stars/LucasCufre/llm-knowledge-base?style=social)](https://github.com/LucasCufre/llm-knowledge-base/stargazers)
[![GitHub Issues](https://img.shields.io/github/issues/LucasCufre/llm-knowledge-base)](https://github.com/LucasCufre/llm-knowledge-base/issues)
[![Last Commit](https://img.shields.io/github/last-commit/LucasCufre/llm-knowledge-base)](https://github.com/LucasCufre/llm-knowledge-base/commits/main)

---

**Last Updated:** 2026-02-17

**Ready to get started?** Head to the [Master Project Index](00-PROJECT-INDEX.md) to begin exploring the project knowledge base.
