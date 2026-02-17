---
title: Knowledge Base Maintenance Guide
type: operational-guide
date: 2025-10-17
last-updated: 2025-10-17
status: active
owner: Project Team
summary: |
  Comprehensive guide for maintaining the project knowledge database,
  including regular tasks, best practices, and troubleshooting.
---

# Knowledge Base Maintenance Guide

This guide explains how to keep the project knowledge database organized, up-to-date, and useful for both humans and LLMs.

## Automated Maintenance Workflow

The repository now uses a **unified `/maintenance` command** that intelligently adapts to your chosen timeframe. Instead of separate daily/weekly/monthly commands, you simply choose the scope.

### Daily Maintenance (~5-8 minutes)

**Run:**
```bash
/maintenance 1d
```

**What it does:**
- Processes new files in `00-inbox/`
- Validates documents from last 24 hours
- Extracts decisions and creates ADRs
- Adds missing cross-references
- Updates indexes
- Detects recent duplicates

**When to run:** Daily, or whenever you've added files to the parse folder

### Weekly Maintenance (~10-15 minutes)

**Run:**
```bash
/maintenance 5d
```

**What it does:**
- All daily tasks PLUS:
- Comprehensive quality validation of last 5 days
- Broader duplicate detection (compares with full repo)
- Broken link identification and repair
- Metadata completeness checks

**When to run:** Every Friday (or end of your work week)

### Monthly Maintenance (~25-40 minutes)

**Run:**
```bash
/maintenance 30d
```

**What it does:**
- All weekly tasks PLUS:
- **Orphan detection:** Finds documents with no links
- **Stale content identification:** Documents not updated in >1 year
- Comprehensive duplicate analysis
- Archival recommendations

**When to run:** First Monday of each month

### Full Repository Scan (~40-90 minutes)

**Run:**
```bash
/maintenance all
```

**What it does:**
- Complete repository analysis
- All phases at maximum scope
- Useful for quarterly deep dives

**When to run:** Quarterly or when major cleanup is needed

### Quick Status Check (<1 minute)

**Run:**
```bash
/maintenance status
```

**What it does:**
- Shows recent maintenance activity
- Lists files awaiting processing
- No actual processing performed

**When to run:** Anytime you want to check repository health

## Manual Maintenance Tasks

While `/maintenance` automates most tasks, some still benefit from human review:

### As Work Happens
- **Document decisions immediately** - Don't wait; context is fresh now
- **Update blockers** - Add new blockers to [03-active-work/blockers-and-risks.md](../03-active-work/blockers-and-risks.md) as they arise
- **File meeting notes** - Drop unstructured content in [00-inbox/](../00-inbox/), then run `/maintenance 1d`
- **Cross-reference** - The maintenance command now does this automatically!

### Weekly Tasks (Not Automated)

### 1. Update Project Status
**File:** [03-active-work/_current-status.md](../03-active-work/_current-status.md)

- Update report date and period
- Refresh "What Changed This Period" section
- Update metrics and KPIs
- Review and update active blockers
- Update upcoming milestones
- Add links to new decisions made this week

**Time required:** 15-20 minutes

**Note:** Run `/maintenance 5d` BEFORE updating status to ensure all documents are processed

### Monthly Tasks (Not Automated)

### 1. Update Master Index
**File:** [00-PROJECT-INDEX.md](../00-PROJECT-INDEX.md)

- Refresh "Recent Decisions" list with last 5 decisions
- Update "Recent Activity" section
- Update Project Health Dashboard
- Review and update "Key Documents" links
- Verify all navigation links work

**Time required:** 20-30 minutes

### 2. Decision Records Audit
**File:** [02-decisions/_decisions-index.md](../02-decisions/_decisions-index.md)

- Review decision statuses - are any now superseded?
- Update index with new decisions
- Check for decisions that should be archived
- Verify ADR numbering sequence is correct

**Time required:** 15 minutes

### 3. Priorities Review
**File:** [03-active-work/priorities.md](../03-active-work/priorities.md)

- Update current priorities based on recent decisions
- Remove completed priorities
- Add new priorities from planning sessions
- Ensure alignment with project objectives

**Time required:** 15-20 minutes

### 4. Glossary Update
**File:** [01-foundation/glossary.md](../01-foundation/glossary.md)

- Add new terms that have emerged
- Update definitions that have evolved
- Remove deprecated terms
- Alphabetize entries

**Time required:** 10-15 minutes

## Quarterly Maintenance (First Week of Quarter)

### 1. Archive Old Content
**Directory:** [07-archive/](../07-archive/)

Content to archive:
- Meeting notes older than 6 months
- Superseded decision records
- Completed research that's no longer active
- Outdated technical documentation

**Process:**
1. Create new quarter folder: `07-archive/YYYY-QQ/`
2. Move old content to appropriate subfolder
3. Update [07-archive/_archive-log.md](../07-archive/_archive-log.md)
4. Update source documents with `status: archived`
5. Remove from active indexes

**Time required:** 1-2 hours

### 2. Link Health Check
- Run link checker on all markdown files
- Fix broken internal links
- Update external links that have changed
- Remove links to archived content (or update to archive location)

**Tools:** VS Code Markdown Link Checker or similar

**Time required:** 30-45 minutes

### 3. Metadata Audit
Check random sample of documents (20-30) for:
- Complete YAML frontmatter
- Accurate `last-updated` dates
- Proper `status` values
- Meaningful summaries
- Appropriate tags

**Time required:** 30 minutes

### 4. Structure Review
- Are documents in the right categories?
- Do we need new categories?
- Are templates still appropriate?
- Is the folder structure still serving us well?

**Time required:** 30 minutes

### 5. User Feedback Integration
- Review feedback from team about knowledge base
- Identify pain points or missing content
- Plan improvements
- Update templates if needed

**Time required:** 30-60 minutes

## Cross-Referencing Algorithm

The `/maintenance` command includes **intelligent cross-referencing** that automatically discovers and creates knowledge connections. Here's how it works:

### 1. Decision Extraction

**Problem:** Decisions are often documented in meeting notes or documents but never formalized as ADRs.

**Solution:** The maintenance workflow scans all documents for decision patterns:
- "we decided to..."
- "we chose... because..."
- "decision was made to..."
- "we agreed to..."

When found, it:
1. Extracts the decision context (±500 characters)
2. Checks if an ADR already exists (75% similarity threshold)
3. If not, creates a new ADR with the next available ID
4. Links the ADR ↔ source document bidirectionally
5. Updates the decisions index

**Example:**
```
Meeting note contains: "We decided to use PostgreSQL instead of MongoDB
for user data because we need ACID compliance."

→ Creates ADR-015: Database Selection for User Data
→ Links: Meeting note ↔ ADR-015
→ Updates decisions index
```

### 2. Semantic Cross-Referencing

**Problem:** Related documents don't link to each other, making knowledge discovery difficult.

**Solution:** The workflow applies relationship rules to find documents that should link:

**Requirements → Decisions:**
- When: Requirement mentions a technical choice that has an ADR
- How: Checks for 2+ common topics AND requirement date >= decision date
- Action: Adds bidirectional link

**Requirements → User Research:**
- When: Requirement addresses a user pain point from research
- How: Matches user-centric keywords
- Action: Adds bidirectional link

**Meetings → Decisions:**
- When: ADR created within ±7 days of meeting
- How: Checks date proximity and owner overlap
- Action: Adds bidirectional link

**Research → Requirements:**
- When: Requirement based on research findings
- How: Matches 3+ common keywords
- Action: Adds bidirectional link

**Example:**
```
Requirement "user-authentication.md" mentions "JWT tokens" and "OAuth"
ADR-012 is about "Authentication Strategy using JWT"

→ Detects: 2+ common topics (JWT, authentication)
→ Requirement date (2025-02-10) >= ADR date (2025-02-05)
→ Adds: user-authentication.md ↔ ADR-012
```

### 3. Index Synchronization

**Problem:** Documents aren't added to appropriate indexes, making them hard to find.

**Solution:** The workflow:
1. Checks each document's type
2. Determines which index should contain it
3. Searches the index for the document
4. If missing, adds an entry
5. Updates the index's last-updated field

**Index Mapping:**
- `decision-record` → `02-decisions/_decisions-index.md`
- `meeting-note` → `06-meetings/_meetings-index.md`
- `requirement` → `04-knowledge-base/business/_index.md`
- `user-research` → `04-knowledge-base/business/_index.md`
- `technical-doc` → `04-knowledge-base/technical/_index.md`
- And more...

### 4. Bidirectional Link Enforcement

**Problem:** Document A links to B, but B doesn't link back to A.

**Solution:** For every link A → B:
1. Opens document B
2. Checks B's `related-docs` for A
3. If missing, adds A to B's `related-docs`
4. Updates B's `last-updated`

This ensures the knowledge graph is fully connected and bidirectional.

**Example:**
```
requirement.md has:
  related-docs:
    - ../decisions/ADR-012.md

ADR-012.md has:
  related-docs: []  # Missing backlink!

→ Adds ../knowledge-base/business/requirements/requirement.md to ADR-012
→ Updates ADR-012's last-updated
```

### Benefits

This automated cross-referencing:
- **Reduces manual linking work** - No need to remember to add cross-references
- **Captures tacit knowledge** - Decisions in meeting notes become formal ADRs
- **Improves discoverability** - Related documents are connected
- **Maintains knowledge graph** - All links are bidirectional
- **Ensures completeness** - Nothing gets lost or orphaned

## Best Practices

### Writing Document Summaries
Good summaries for LLM discovery:
- **Be specific:** "Decision to use PostgreSQL for primary database instead of MongoDB"
- **Not vague:** "Database decision"

- **Include impact:** "Architecture decision affecting all backend services and data models"
- **Not generic:** "Technical decision"

- **Use keywords:** Include searchable terms like "authentication", "API", "infrastructure"

### Tagging Strategy
- Use 3-7 tags per document
- Use consistent tag names across documents
- Common useful tags:
  - `architecture`, `infrastructure`, `security`
  - `frontend`, `backend`, `database`, `api`
  - `user-experience`, `requirements`, `research`
  - `high-priority`, `blocked`, `technical-debt`
  - `decision`, `planning`, `retrospective`

### Cross-Referencing
Always link bidirectionally:
```markdown
<!-- In document A -->
Related: See [Database Architecture](../technical/database-architecture.md)

<!-- In document B: database-architecture.md -->
Related: See [ADR-015: Database Selection](../../02-decisions/2025-10-17-database-selection.md)
```

### Status Indicators
Use consistent status values:
- **active** - Current, in use
- **draft** - Work in progress, not yet finalized
- **proposed** - Awaiting approval/decision
- **accepted** - Approved (for decisions)
- **rejected** - Not approved (for decisions)
- **superseded** - Replaced by newer version
- **deprecated** - No longer recommended but not fully replaced
- **archived** - Historical, not current

## Troubleshooting

### "I can't find information I know we documented"
**Solutions:**
1. Check [00-PROJECT-INDEX.md](../00-PROJECT-INDEX.md) navigation
2. Search by tag: `grep -r "tags:.*keyword" --include="*.md"`
3. Search by title: `grep -r "title:.*keyword" --include="*.md"`
4. Check archive: Content may have been moved to `07-archive/`
5. Use VS Code search (Cmd+Shift+F / Ctrl+Shift+F)

### "The knowledge base feels disorganized"
**Solutions:**
1. Run monthly maintenance tasks if overdue
2. Review and move misplaced files
3. Update indexes
4. Consider whether categories need adjustment
5. Schedule time for quarterly structure review

### "People aren't updating documents"
**Solutions:**
1. Make it part of definition of done
2. Add reminders to team rituals
3. Demonstrate value by using it in meetings
4. Simplify templates if they're too complex
5. Recognize and appreciate good documentation

### "Documents are getting stale"
**Solutions:**
1. Set calendar reminders for regular reviews
2. Assign owners to key documents
3. Add "last reviewed" dates to high-value docs
4. Include doc review in sprint planning
5. Archive truly outdated content rather than letting it rot

## Automation Opportunities

Consider automating these tasks:
- **Link checking:** CI/CD pipeline can check for broken links
- **Metadata validation:** Script to verify all docs have required fields
- **Index generation:** Auto-generate parts of index files from metadata
- **Stale content alerts:** Notify owners when docs haven't been updated in X days
- **Template enforcement:** Pre-commit hooks to ensure templates are used

## Questions or Suggestions?

If this maintenance guide doesn't cover something you need:
1. Document your question/need
2. Propose an update to this guide
3. Share with the team for feedback
4. Update the guide with the improvement

## Maintenance Checklist

### Weekly (Every Friday)
- [ ] Update [_current-status.md](../03-active-work/_current-status.md)
- [ ] Process and file new content
- [ ] Clean up meeting notes
- [ ] Update meeting index

### Monthly (First Monday)
- [ ] Update [00-PROJECT-INDEX.md](../00-PROJECT-INDEX.md)
- [ ] Audit decision records
- [ ] Review and update priorities
- [ ] Update glossary

### Quarterly (First Week)
- [ ] Archive old content
- [ ] Check all links
- [ ] Audit metadata sample
- [ ] Review structure
- [ ] Integrate user feedback

---

**Remember:** A well-maintained knowledge base is a force multiplier for the entire team. The time invested in maintenance pays dividends in faster onboarding, better decisions, and reduced context-switching costs.
