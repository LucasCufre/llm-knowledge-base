# Claude Code Instructions for This Project

This repository contains a structured project knowledge database optimized for LLM discovery and context retrieval.

## How to Use This Structure

### When Asked About Project Information
1. **Always start** by checking [00-PROJECT-INDEX.md](../00-PROJECT-INDEX.md) for navigation
2. **Check current status** in [03-active-work/_current-status.md](../03-active-work/_current-status.md) for latest updates
3. **Review relevant decisions** in [02-decisions/_decisions-index.md](../02-decisions/_decisions-index.md)
4. **Consult the glossary** in [01-foundation/glossary.md](../01-foundation/glossary.md) for domain terms

### When Creating New Content

#### For Decisions
1. Copy [02-decisions/_template-decision.md](../02-decisions/_template-decision.md)
2. Name it: `YYYY-MM-DD-decision-title.md`
3. Assign next ADR number
4. Fill out all sections
5. Update [02-decisions/_decisions-index.md](../02-decisions/_decisions-index.md)
6. Link from relevant docs

#### For Meeting Notes
1. Copy [06-meetings/_template-meeting.md](../06-meetings/_template-meeting.md)
2. Name it: `YYYY-MM-DD-meeting-title.md`
3. Place in appropriate month folder
4. Update [06-meetings/_meetings-index.md](../06-meetings/_meetings-index.md)
5. Extract any decisions to decision records

#### For Technical Documentation
1. Determine correct category in `04-knowledge-base/`
2. Create document with proper metadata
3. Update relevant `_index.md` file
4. Cross-link to related documents

### When Updating Existing Content
1. Update `last-updated` field in frontmatter
2. Add entry to "Revision History" if significant change
3. If superseding a document, update `supersedes` field
4. Update any indexes that reference the document

### File Naming Conventions
- Use lowercase with hyphens: `my-document-name.md`
- Date prefix for chronological items: `YYYY-MM-DD-title.md`
- Template files start with underscore: `_template-name.md`
- Index files: `_index.md` or `_category-index.md`

### Metadata Standards
Every document must have:
- `title`: Descriptive title
- `type`: Document type from standard list
- `date`: Creation date
- `summary`: 2-3 sentence description
- `tags`: Relevant keywords for discovery

### When Archiving Content
1. Move to `07-archive/YYYY-QQ/`
2. Update [07-archive/_archive-log.md](../07-archive/_archive-log.md)
3. Update source document with `status: archived`
4. Update any linking documents
5. Remove from active indexes

### Cross-Referencing Rules
- Use relative paths: `../../folder/document.md`
- Always bi-directional: if A links to B, B should link to A
- Link to specific sections with anchors when relevant
- Keep "Related Documents" section updated

## Context Priority for LLMs
When answering questions, prioritize information in this order:
1. Current status and active work (`03-active-work/`)
2. Recent decisions (`02-decisions/`) - most recent first
3. Foundation documents (`01-foundation/`)
4. Knowledge base (`04-knowledge-base/`)
5. Research (`05-research/`)
6. Meeting notes (`06-meetings/`) - for specific details

## Red Flags to Watch For
- Documents without metadata
- Outdated status information (>1 week old)
- Broken internal links
- Decisions without ADR numbers
- Files in wrong locations
- Missing summaries in frontmatter

## Helpful Commands
- Find all documents of a type: `grep -r "type: decision-record" --include="*.md"`
- Find documents by tag: `grep -r "tags:.*architecture" --include="*.md"`
- Find recent updates: `find . -name "*.md" -mtime -7`
- Check for broken links: Use VS Code's markdown link checker or similar tools

## Regular Maintenance Tasks
- Weekly: Update [03-active-work/_current-status.md](../03-active-work/_current-status.md)
- Weekly: Review and file new content
- Monthly: Update [00-PROJECT-INDEX.md](../00-PROJECT-INDEX.md)
- Monthly: Review decision statuses
- Quarterly: Archive outdated content
- Quarterly: Audit and update glossary

## Parsing Unstructured Content

### Check for Documents to Parse
**IMPORTANT:** Always check the [00-inbox/](../00-inbox/) folder for new content that needs to be processed and structured.

When you find documents in this folder:
1. Read each document completely
2. Analyze and parse the content (see detailed workflow below)
3. Create properly structured documents in appropriate locations
4. Update all relevant indexes
5. **Delete the original file** from `00-inbox/` after successful processing

### Document Analysis Decision Tree

For each unstructured document, determine its type(s):

**Meeting Record** → Create in `06-meetings/YYYY-MM/`
- Look for: Date, attendees, discussion topics, action items
- Extract decisions to separate ADRs
- Update meeting index

**Decision** → Create in `02-decisions/`
- Look for: "We decided", "we chose", "we agreed"
- Assign next ADR number
- Document context, alternatives, rationale
- Update decisions index

**Research/Investigation** → Create in `05-research/`
- Look for: Research question, methodology, findings
- Include raw data references
- Update research index

**Technical Documentation** → Create in `04-knowledge-base/technical/`
- Look for: Architecture, APIs, infrastructure details
- Add new terms to glossary
- Update technical index

**Requirements** → Create in `04-knowledge-base/business/requirements/`
- Look for: User stories, acceptance criteria, specifications
- Link to related decisions
- Update business index

**Status Update** → Update `03-active-work/_current-status.md`
- Look for: Progress reports, metrics, blockers
- Update priorities and risks as needed
- Note significant changes in project index

### Parsing Workflow

#### Step 1: Extract Key Information
- **Dates:** Convert all dates to YYYY-MM-DD format
- **People:** Identify participants, owners, stakeholders
- **Decisions:** Any conclusions or choices made
- **Action Items:** Tasks with owners and due dates
- **Technical Terms:** New terminology to add to glossary
- **Blockers:** Impediments or risks identified

#### Step 2: Create Structured Documents
For each piece of content identified:

1. **Use appropriate template** from the relevant directory
2. **Generate complete metadata:**
   ```yaml
   ---
   title: [Specific, descriptive title]
   type: [Standard type from our list]
   date: [Content creation date]
   last-updated: [Today's date]
   status: active
   owner: [Primary responsible person]
   stakeholders: [All involved parties]
   tags: [relevant, keywords, for, search]
   summary: |
     Clear 2-3 sentence summary explaining what this document
     contains and why it matters for context and discovery.
   related-docs:
     - [../path/to/related.md]
   ---
   ```

3. **Structure the content** with clear headings and sections
4. **Follow naming conventions:** `YYYY-MM-DD-descriptive-title.md`
5. **Assign ADR numbers** for decisions (check index for next number)

#### Step 3: Handle Multi-Type Documents
If a document contains multiple types of information (common with meetings):

1. Create primary document (e.g., meeting note)
2. Extract significant decisions into separate ADRs
3. Extract action items and update relevant docs
4. Add new terms to glossary
5. Cross-link all created documents

#### Step 4: Update All Indexes
**Always update relevant indexes:**

- `02-decisions/_decisions-index.md` - Add new decisions
- `06-meetings/_meetings-index.md` - Add new meetings
- `05-research/_research-index.md` - Add new research
- `04-knowledge-base/[domain]/_index.md` - Add new knowledge docs
- `01-foundation/glossary.md` - Add new terms
- `00-PROJECT-INDEX.md` - Update if significant

#### Step 5: Quality Checks
Before finishing, verify:
- [ ] All dates in ISO format (YYYY-MM-DD)
- [ ] Complete metadata with summary
- [ ] Related documents cross-linked
- [ ] Indexes updated
- [ ] File naming follows conventions
- [ ] ADR numbers assigned and unique
- [ ] Action items have owners and dates
- [ ] New terms added to glossary
- [ ] No broken internal links

#### Step 6: Clean Up
**After successful processing:**
- Delete the original file from `00-inbox/`
- Confirm all content has been properly structured
- Verify no information was lost in translation

### Content Extraction Patterns

**Meetings:**
- Opening usually has: date, time, attendees, agenda
- Look for: "discussed", "reviewed", "decided"
- Action items often marked: "TODO", "action item", "follow up"
- Blockers indicated by: "blocked by", "waiting on", "can't proceed"

**Decisions:**
- Indicated by: "we decided to...", "after discussion we agreed...", "going forward we will..."
- Should have context explaining why
- May mention alternatives considered
- Often includes implications or next steps

**Technical Content:**
- Contains: system names, technical terms, code examples
- Describes: architecture, APIs, configurations
- May include: diagrams, specifications, procedures
- Often has: dependencies, constraints, requirements

**Research:**
- States: research question or hypothesis
- Describes: methodology and data sources
- Presents: findings with evidence
- Concludes: recommendations or next steps

### Handling Ambiguity

**If date is unclear:**
- Use best estimate from context
- Add note: "Date estimated based on context"
- Check surrounding documents for clues

**If owner is unclear:**
- Use participants mentioned in content
- Mark as "TBD" if truly unknown
- Check previous related documents

**If document type is unclear:**
- Choose primary purpose
- Create multiple documents if needed
- Use tags to capture secondary topics

**If categorization is unclear:**
- Default to best fit based on content
- Use cross-references liberally
- When in doubt, ask for clarification

### Reporting After Parsing

After processing documents, provide:

1. **Summary of created documents:**
   ```
   Created:
   - [path/to/doc1.md] - Brief description
   - [path/to/doc2.md] - Brief description

   Updated:
   - [path/to/index.md]
   ```

2. **Any questions or ambiguities:**
   ```
   Questions:
   - [Specific question needing clarification]
   ```

3. **Deleted files:**
   ```
   Processed and removed:
   - 00-inbox/original-file.md
   ```

## Need Help?
- Template examples in each category's `_template-*.md`
- Category-specific guides in `README.md` files
- Maintenance procedures in [maintenance-guide.md](./maintenance-guide.md)
- Parsing workflow details above
