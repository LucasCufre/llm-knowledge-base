# Claude Code Instructions for Product Knowledge Base

This document provides comprehensive instructions for operating this knowledge repository effectively. Use these guidelines when working with documentation, querying information, updating existing documents, or processing new content.

## Repository Purpose

This is a structured project knowledge database optimized for AI-powered discovery and context retrieval. It contains comprehensive documentation about product development, business requirements, and market intelligence, including:

- Product requirements and specifications
- Architecture decisions (ADRs)
- User research and customer insights
- Market analysis and competitive intelligence
- Feature prioritization and roadmaps
- Meeting notes and transcripts
- Research and analysis documents
- Technical documentation

## Core Operations

### 1. Querying for Information

When asked to find or answer questions about project information:

**Use the `/query` slash command** for comprehensive research tasks:

```bash
/query [your question here]
```

The query command will:
- Search across all documentation categories
- Prioritize recent and relevant sources
- Check index files for navigation
- Follow cross-references
- Provide cited answers with source links

**For quick factual lookups, use `/quick-query`**:

```bash
/quick-query [simple factual question]
```

**Search Strategy** (when not using slash commands):

1. **Start with navigation documents**:
   - `00-PROJECT-INDEX.md` - Overview and recent activity
   - `03-active-work/_current-status.md` - Current state
   - Category index files (`_decisions-index.md`, `_meetings-index.md`, etc.)

2. **Use parallel searches**:
   - Search metadata: `grep -r "tags:.*[keyword]" --include="*.md"`
   - Search titles: `grep -r "^title:.*[keyword]" --include="*.md"`
   - Search content: `grep -ri "[keyword]" --include="*.md"`

3. **Check domain-specific locations**:
   - **Product questions** → `04-knowledge-base/business/requirements/`
   - **User research** → `04-knowledge-base/business/user-research/`
   - **Market data** → `04-knowledge-base/business/market-analysis/`
   - **Feature specs** → `04-knowledge-base/business/requirements/`
   - **Technical questions** → `04-knowledge-base/technical/`
   - **Process questions** → `04-knowledge-base/operational/processes/`

4. **For complex queries**, use Task tool with `subagent_type=general-purpose`

**Answer Format**:
- Provide direct answer first (TL;DR)
- Include supporting details with quotes/examples
- Cite sources with markdown links
- Note confidence level and information gaps
- Suggest related documents or next steps

### 2. Updating Existing Documentation

When information becomes outdated or needs correction:

**Use the `/update` slash command** to analyze conversation and update docs:

```bash
/update
```

This will:
- Identify what needs updating based on conversation
- Find relevant documents
- Make necessary updates
- Update indexes
- Report changes made

**Manual Update Process**:

1. **Read the current document** first using Read tool
2. **Make changes** using Edit tool
3. **Update metadata**:
   - Change `last-updated` to today's date (YYYY-MM-DD)
   - Add revision history entry if significant change
   - Preserve original `date` and `owner` fields
4. **Update related indexes** if document location or status changed
5. **Update cross-references** in related documents

**Critical Rules**:
- NEVER delete original metadata (date, owner)
- ALWAYS update `last-updated` field
- ALWAYS check for documents that link to this one
- For requirements: maintain 4-section structure (Executive Summary, Technical Considerations, Acceptance Criteria, Permissions)
- For decisions: update status field if superseded

### 3. Processing New Information

When you receive new unstructured content (meeting transcripts, notes, documents):

**Use the `/maintenance-daily` slash command**:

```bash
/maintenance-daily
```

**Alternative: Manual workflow**:

1. **Place files** in `00-inbox/` directory
2. **Run `/maintenance-daily`** to auto-process
3. **Review results** in processing log
4. **Check** `00-inbox/review-needed/` for flagged items

**Automated Processing Does**:
- Detects document type (meetings, decisions, requirements, technical docs)
- Searches for existing similar documents
- Updates existing docs or creates new ones
- Uses appropriate templates and structures
- Updates all relevant indexes
- **Deletes successfully processed files** from parse folder
- Flags ambiguous content for human review

**Document Type Detection**:

- **Meeting Transcripts**:
  - Filename contains "sync", "meeting", or "meet"
  - **OR content has 2+ timestamps** like `(14:30)` or `Name (9:15):`
  - Translated to English if needed
  - Creates meeting note + extracts ADRs

- **Decisions**:
  - Contains "we decided", "we chose", "we agreed"
  - Creates ADR with next sequential number

- **Requirements**:
  - Feature descriptions, user stories, specifications
  - **Uses mandatory 4-section structure**
  - Extracts ONLY explicitly stated information

- **User Research**:
  - User interviews, surveys, usability tests
  - Customer feedback and insights
  - Routes to `04-knowledge-base/business/user-research/`

- **Market Analysis**:
  - Competitive analysis, market trends, industry reports
  - Routes to `04-knowledge-base/business/market-analysis/`

- **Technical Docs**:
  - Architecture, APIs, infrastructure details
  - Routes to appropriate `04-knowledge-base/technical/` subcategory

- **Research**:
  - Investigation findings, analysis, recommendations

**Quality Standards**:
- All dates in ISO format (YYYY-MM-DD)
- Complete metadata with summary
- Proper file naming (lowercase-with-hyphens.md)
- Cross-references to related docs
- No broken internal links

### 4. Creating New Documents

When creating new structured documentation:

**For Decisions**:
1. Copy `02-decisions/_template-decision.md`
2. Name: `YYYY-MM-DD-decision-title.md`
3. Assign next ADR number from decisions index
4. Fill all sections (Context, Decision, Rationale, Alternatives, Consequences)
5. Update `02-decisions/_decisions-index.md`
6. Link from related documents

**For Meeting Notes**:
1. Copy `06-meetings/_template-meeting.md`
2. Name: `YYYY-MM-DD-meeting-title.md`
3. Place in appropriate month folder (create `YYYY-MM/` if needed)
4. Fill structure (Executive Summary, Topics, Action Items, Decisions)
5. Extract significant decisions to separate ADRs
6. Update `06-meetings/_meetings-index.md`

**For Requirements**:
1. Create in `04-knowledge-base/business/requirements/`
2. **MUST use 4-section structure**:
   - **Section 1: Executive Summary** - Business value and user impact
   - **Section 2: Technical Considerations** - Implementation notes, dependencies, constraints
   - **Section 3: Acceptance Criteria** - Testable conditions for "done"
   - **Section 4: Permissions** - RBAC and access control
3. **Extract ONLY explicitly stated information** - no assumptions
4. Mark sections as "Not specified in source document" if missing
5. Update `04-knowledge-base/business/_index.md`

**For User Research**:
1. Create in `04-knowledge-base/business/user-research/`
2. Include methodology, participant details, key findings
3. Link to related requirements or features
4. Update business index

**For Market Analysis**:
1. Create in `04-knowledge-base/business/market-analysis/`
2. Include data sources, methodology, findings, recommendations
3. Update business index

**For Technical Documentation**:
1. Determine correct subcategory:
   - **Architecture** → `04-knowledge-base/technical/architecture/`
   - **APIs** → `04-knowledge-base/technical/apis-and-integrations/`
   - **Infrastructure** → `04-knowledge-base/technical/infrastructure/`
2. Create with proper metadata
3. Update appropriate index file
4. Add new terms to `01-foundation/glossary.md`

## Maintenance Commands

**Unified Maintenance Workflow**:
```bash
/maintenance [timeframe]
```

The `/maintenance` command provides a single, intelligent workflow that adapts to your chosen scope.

### Timeframe Options

| Timeframe | Alias | Duration | Best For |
|-----------|-------|----------|----------|
| `1d` | `1` | 5-8 min | Daily quick check |
| `5d` | `5` | 10-15 min | Weekly review |
| `15d` | `15` | 15-25 min | Biweekly comprehensive |
| `30d` | `30` | 25-40 min | Monthly deep dive |
| `all` | - | 40-90 min | Full repository analysis |
| `status` | - | <1 min | Quick health check |
| *(none)* | - | - | Interactive selection |

### What It Does

The maintenance workflow runs in **8 phases**:

1. **Process New Documents** (always runs)
   - Scans `00-inbox/` for unprocessed files
   - Auto-detects document types (meetings, decisions, requirements, etc.)
   - Searches for existing similar documents to avoid duplicates
   - Creates or updates structured documents
   - Updates all indexes
   - Deletes successfully processed files

2. **Find Target Documents**
   - Locates all documents modified in your selected timeframe
   - Builds list of documents to validate

3. **Validate Quality**
   - Checks metadata completeness (auto-fixes: dates, last-updated)
   - Validates document structure (requirements, ADRs)
   - Finds and repairs broken links
   - Flags critical issues for manual review

4. **Cross-Reference Analysis** ⭐ *NEW - The Core Feature*
   - **Extracts missing decisions:** Scans documents for decision language and creates ADRs
   - **Finds missing cross-references:** Links related documents (requirements ↔ decisions, research ↔ requirements)
   - **Updates indexes:** Ensures all documents are properly indexed
   - **Enforces bidirectional links:** Makes all links go both ways

5. **Duplicate Detection**
   - 1d/5d: Checks within timeframe
   - 15d/30d/all: Compares against entire repository
   - Identifies canonical versions
   - Flags for review

6. **Orphan Detection** (30d and all only)
   - Finds documents with no incoming/outgoing links
   - Categorizes by value (high/low)
   - Recommends integration or archival

7. **Stale Content** (30d and all only)
   - Finds documents not updated in >1 year
   - Checks for active references
   - Recommends archive, keep, or update

8. **Generate Report**
   - Creates comprehensive log in `logs/`
   - Provides actionable recommendations
   - Shows statistics and metrics

### Examples

**Quick daily check:**
```bash
/maintenance 1d
```
Processes new files, validates recent changes, extracts decisions, adds cross-references.

**Weekly comprehensive review:**
```bash
/maintenance 5d
```
All phases except orphan/stale detection. Perfect for regular maintenance.

**Monthly deep dive:**
```bash
/maintenance 30d
```
Complete analysis including orphan detection and stale content identification.

**Just check status:**
```bash
/maintenance status
```
View recent activity and files awaiting processing, no actual maintenance.

**Interactive:**
```bash
/maintenance
```
Presents a menu to choose your scope.

## Product-Specific Commands

**PRD & User Story Generator**:
```bash
/prd-bot
```
Transform vague ideas into development-ready Product Requirements Documents (PRDs) and User Stories with:
- Rigorous business value analysis
- Technical feasibility validation
- Complete acceptance criteria
- RBAC permissions specification

**Daily Standup TL;DR**:
```bash
/standup-tldr
```
Generate executive summaries of daily standup meetings organized by team/squad structure

## File Organization

```
project-root/
├── 00-PROJECT-INDEX.md          # Central navigation hub
├── 00-inbox/                    # Drop zone for documents ready to process
│   └── review-needed/           # Flagged for human review
├── 00-wip/                      # Work in progress - drafts and documents being edited
├── 01-foundation/               # Project charter, glossary, scope
│   ├── glossary.md
│   ├── project-charter.md
│   └── project-scope.md
├── 02-decisions/                # Architecture Decision Records (ADRs)
│   ├── _decisions-index.md
│   ├── _template-decision.md
│   └── YYYY-MM-DD-decision-*.md
├── 03-active-work/             # Current status, priorities, blockers
│   ├── _current-status.md
│   ├── blockers-and-risks.md
│   └── priorities.md
├── 04-knowledge-base/          # Organized knowledge
│   ├── business/               # Product & business docs
│   │   ├── _index.md
│   │   ├── requirements/       # Feature specs, PRDs, user stories
│   │   ├── user-research/      # User interviews, surveys, feedback
│   │   └── market-analysis/    # Competitive analysis, market data
│   ├── technical/              # Technical documentation
│   │   ├── _index.md
│   │   ├── architecture/
│   │   ├── apis-and-integrations/
│   │   └── infrastructure/
│   └── operational/            # Processes and runbooks
│       ├── _index.md
│       ├── processes/
│       └── runbooks/
├── 05-research/                # Research and investigations
├── 06-meetings/                # Meeting notes by month
│   ├── _meetings-index.md
│   ├── _template-meeting.md
│   └── YYYY-MM/               # Organized by month
├── 07-archive/                 # Archived content by quarter
│   └── YYYY-QX/
├── .claude/                    # Claude Code configuration
│   ├── commands/               # Slash commands
│   ├── CLAUDE.md              # This file
│   └── instructions.md        # Detailed operational guide
└── logs/                       # Maintenance and processing logs
```

## Context Priority

When answering questions, prioritize information in this order:

1. **Current status and active work** (`03-active-work/`) - What's happening now
2. **Recent decisions** (`02-decisions/`) - Most recent first
3. **Foundation documents** (`01-foundation/`) - Core project context
4. **Business knowledge** (`04-knowledge-base/business/`) - Requirements, research, market data
5. **Technical knowledge** (`04-knowledge-base/technical/`) - Architecture, APIs, infrastructure
6. **Research** (`05-research/`) - Investigations and analysis
7. **Meeting notes** (`06-meetings/`) - For specific details and context

## Critical Rules

### For Requirements Documents

**MUST follow 4-section structure**:
1. **Executive Summary** - Business value, user impact, rationale
2. **Technical Considerations** - Implementation notes, dependencies, constraints, API endpoints
3. **Acceptance Criteria** - Testable conditions, error states, edge cases
4. **Permissions** - RBAC roles, access control

**ONLY include explicitly stated information**:
- NO assumptions or inferences
- NO placeholder content
- Use "Not specified in source document" for missing sections
- Extract exact wording when possible

### For Meeting Transcripts

**Content-based detection**:
- Check for timestamps in parentheses `(HH:MM)`
- 2+ timestamps = meeting transcript (regardless of filename)

**Processing requirements**:
- Translate to English if needed (note in metadata)
- Create structured meeting note with topics breakdown
- Extract significant decisions to ADRs
- Professional, clear tone throughout

### For All Updates

**When updating existing documents**:
- ALWAYS preserve original `date` and `owner`
- ALWAYS update `last-updated` to today
- Add revision history entry for significant changes
- Update related indexes
- Maintain document structure

**When creating new documents**:
- Use appropriate template
- Complete all metadata fields
- Follow naming conventions
- Update relevant indexes
- Create bidirectional cross-references

### For File Processing

**After successful processing**:
- **ALWAYS delete original files** from `00-inbox/`
- Move problematic files to `review-needed/` subfolder
- Report what was processed and deleted
- Flag ambiguous content for review

## Metadata Standards

Every document must have:

```yaml
---
title: Descriptive Title
type: [decision-record | meeting-note | requirement | user-research | market-analysis | technical-doc | research | process | runbook]
date: YYYY-MM-DD
last-updated: YYYY-MM-DD
status: [active | draft | archived | superseded]
owner: [Primary responsible person]
stakeholders: [Involved parties]
tags: [relevant, keywords, for, discovery]
summary: |
  Clear 2-3 sentence description of what this document
  contains and why it matters.
related-docs:
  - [../path/to/related-doc.md]
---
```

## Common Workflows

### Workflow 1: Answer a Product Question

1. User asks: "What are the acceptance criteria for the user login feature?"
2. Run `/query What are the acceptance criteria for the user login feature?`
3. OR manually:
   - Check `00-PROJECT-INDEX.md` for navigation
   - Search `04-knowledge-base/business/requirements/` for login-related docs
   - Check glossary for terminology
   - Use Explore agent for complex topics
4. Provide answer with sources cited

### Workflow 2: Draft Document in WIP Then Process

1. Create draft document in `00-wip/` (e.g., "feature-spec-draft.md")
2. Edit and refine content over multiple sessions
3. Once complete, move to `00-inbox/feature-spec.md`
4. Run `/maintenance` to process it into structured format
5. System processes and organizes the completed document

**Use 00-wip/ for:**
- Documents being drafted incrementally
- Content requiring multiple review cycles
- Collaborative documents not yet finalized
- Complex documents needing careful construction

**Use 00-inbox/ for:**
- Completed documents ready for processing
- Received documents from others (emails, transcripts)
- Final versions ready to be structured and filed

### Workflow 3: Process a Product Requirements Document

1. File appears in `00-inbox/` (e.g., "new-feature-spec.docx")
2. Run `/maintenance`
3. System:
   - Detects it's a requirement document
   - Searches for existing similar features
   - Creates structured requirement with 4-section format
   - Extracts ONLY explicitly stated information
   - Updates business index
   - Deletes original file
4. Review processing log for results

### Workflow 4: Transform Idea into PRD

1. User provides vague feature idea in conversation
2. Run `/prd-bot` with the idea
3. System:
   - Analyzes the input thoroughly
   - Searches existing docs for conflicts/dependencies
   - Challenges assumptions and asks clarifying questions
   - After confirmation, generates complete PRD with:
     - Business rationale
     - Technical considerations
     - Detailed acceptance criteria
     - RBAC permissions
4. Creates structured document in requirements folder

### Workflow 5: Process Meeting with User Research Insights

1. Meeting transcript added to `00-inbox/`
2. Run `/maintenance`
3. System:
   - Detects meeting transcript (timestamps detected)
   - Creates meeting note in `06-meetings/YYYY-MM/`
   - Extracts user research insights to separate doc in `user-research/`
   - Extracts any decisions to ADRs
   - Updates indexes
   - Deletes original
4. Review extracted content

### Workflow 6: Generate Daily Standup Summary

1. After daily standup meetings (AM/PM or Frontend/Backend)
2. Run `/standup-tldr`
3. System:
   - Finds latest standup pair
   - Organizes updates by squad
   - Identifies blockers and action items
   - Creates executive summary
   - Saves TL;DR in same month folder
4. Share TL;DR with leadership

## Red Flags to Watch For

- Documents without metadata
- Requirements with assumed information not in source
- Outdated status information (>1 week old)
- Broken internal links
- Decisions without ADR numbers
- Files in wrong locations
- Missing summaries in frontmatter
- User research without methodology
- Requirements without acceptance criteria
- Meeting notes without action items or owners
- Market analysis without data sources
- Features without permission specifications

## Best Practices

### For Querying

- Always start with index files
- Use parallel searches for efficiency
- Check metadata first (faster than content search)
- Follow cross-references
- Verify information is current (check dates)
- For product questions, check business folder first

### For Updating

- Read before editing
- Preserve historical metadata
- Update last-updated field
- Add revision notes
- Update all related indexes
- Maintain bidirectional links

### For Processing

- Let automation handle detection
- Review flagged content
- Verify translations
- Check for duplicates before creating
- Use templates consistently
- Update indexes immediately

### For Product Documentation

- Be concise but comprehensive
- Focus on user value and business impact
- Include concrete acceptance criteria
- Document permissions explicitly
- Link to user research where applicable
- Cross-reference related features
- Use professional, clear language
- Keep requirements fact-based (no assumptions)

## Getting Help

### For Documentation Questions

- Check README files in each section
- Review templates for examples
- Consult `.claude/maintenance-guide.md` (if created)
- Check `.claude/instructions.md` for detailed guidance (if created)

### For Product Questions

- Review `03-active-work/_current-status.md`
- Check `03-active-work/priorities.md` for feature prioritization
- Review recent decisions in `02-decisions/_decisions-index.md`
- Search requirements in `04-knowledge-base/business/requirements/`
- Check user research for customer insights

## Quick Reference Commands

### Search Commands

```bash
# Find by document type
grep -r "type: requirement" --include="*.md"
grep -r "type: user-research" --include="*.md"

# Find by tag
grep -r "tags:.*authentication" --include="*.md"
grep -r "tags:.*user-feedback" --include="*.md"

# Find recent updates
find . -name "*.md" -mtime -7

# Case-insensitive content search
grep -ri "user login" --include="*.md"
```

### Maintenance Commands

```bash
/maintenance-status      # Quick status
/maintenance-daily       # Process new files (~5 min)
/maintenance-weekly      # Validate quality (~15 min)
/maintenance-monthly     # Cleanup recommendations (~30 min)
/maintenance-full        # All tasks (~50 min)
```

### Query Commands

```bash
/query [question]        # Comprehensive research
/quick-query [question]  # Quick factual lookup
/update                  # Update docs based on conversation
```

### Product Commands

```bash
/prd-bot                 # Transform ideas into PRDs and User Stories
/standup-tldr            # Generate standup executive summary
```

## Summary

This knowledge repository is designed for efficient AI-powered operation focused on product development and business intelligence. The key principles are:

1. **Structure over chaos** - Everything has a place and format
2. **Automation first** - Use slash commands and automated processing
3. **Metadata matters** - Complete metadata enables discovery
4. **Cross-reference everything** - Bidirectional links create knowledge graph
5. **Preserve history** - Update, don't overwrite
6. **Facts only** - No assumptions in requirements or docs
7. **Process consistently** - Templates and rules ensure quality
8. **User-centric** - Always connect features to user value

When in doubt:
- Check the index files first
- Use the slash commands
- Follow the templates
- Preserve metadata
- Update indexes
- Cite your sources
- Focus on business value and user impact

For detailed instructions on specific operations, see:
- `.claude/instructions.md` - Comprehensive operating instructions (if created)
- `.claude/maintenance-guide.md` - Maintenance procedures (if created)
- `00-PROJECT-INDEX.md` - Navigation and project overview
