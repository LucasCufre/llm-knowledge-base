---
description: Analyze conversation and update outdated documentation
---

You are being asked to analyze the current conversation and update any documentation that has been identified as outdated, incomplete, or needing modification.

## Your Task

Review the entire conversation history above this command and:

1. **Identify what needs updating** based on the conversation
2. **Find the relevant documents** in the project structure
3. **Make the necessary updates** to keep documentation accurate and current
4. **Update indexes** if new content was added
5. **Report what was changed**

## What to Look For in the Conversation

### Explicit Update Triggers
- "This is outdated"
- "This needs to be updated"
- "This should be documented"
- "We need to add this to the docs"
- "This information is incorrect"
- "This has changed"
- Mentions of missing documentation
- References to deprecated information

### Implicit Update Signals
- New decisions made during the conversation
- Action items assigned
- Blockers or risks identified
- New terminology introduced
- Feature descriptions or requirements discussed
- Technical details that should be captured
- Status changes mentioned
- Priority shifts discussed

### Information Gaps Identified
- "We don't have documentation for..."
- "I couldn't find information about..."
- Questions that revealed missing docs
- Assumptions that should be verified and documented

## Update Workflow

### Step 1: Conversation Analysis
Review the conversation and create a list of:
- **Documents mentioned as outdated** with what needs to change
- **New information shared** that should be documented
- **Decisions made** that need ADRs
- **Action items** that need tracking
- **Status changes** that need reflection in active-work docs
- **New terms** that should go in the glossary
- **Missing documentation** that should be created

### Step 2: Locate Target Documents
For each item identified:
- Determine the correct location based on content type
- Check if document exists or needs to be created
- Verify you have the latest version (check `last-updated` field)
- Check for related documents that may also need updates

### Step 3: Make Updates

**For existing documents:**
- Read the current version
- Make necessary changes using the Edit tool
- Update the `last-updated` field to today's date
- Add entry to "Revision History" if the document has one
- Preserve original `date` and `owner` fields

**For new documents:**
- Use appropriate template from the relevant directory
- Follow naming conventions (YYYY-MM-DD-title.md for dated content)
- Generate complete metadata
- Follow structure rules

**For decisions made in conversation:**
- Create ADR in `02-decisions/`
- Assign next available ADR number
- Link to this conversation/session as source
- Update decisions index

**For action items:**
- Add to appropriate tracking location
- Include owner, due date, priority
- Link to source (this conversation)

**For status changes:**
- Update `03-active-work/_current-status.md`
- Update blockers/risks if mentioned
- Update priorities if they shifted

**For new terminology:**
- Add to `01-foundation/glossary.md`
- Include clear definition based on usage in conversation
- Note source as this conversation/session

### Step 4: Update Indexes

Update all relevant indexes:
- `02-decisions/_decisions-index.md` - For new ADRs
- `06-meetings/_meetings-index.md` - If meeting notes created
- `04-knowledge-base/technical/_index.md` - For new technical docs
- `04-knowledge-base/business/_index.md` - For new business docs
- `04-knowledge-base/operational/_index.md` - For new operational docs
- `00-PROJECT-INDEX.md` - If significant changes made

### Step 5: Cross-Reference

Ensure bidirectional linking:
- New documents link to related existing documents
- Existing documents updated to reference new content
- Decisions link to requirements/features they affect
- Requirements link to relevant decisions

## Document Type Detection

Based on what was discussed in the conversation:

**Decision Record** → `02-decisions/`
- Signals: "we decided", "we're going with", "the decision is"
- Create ADR with context, decision, rationale, alternatives

**Requirement** → `04-knowledge-base/business/requirements/`
- Signals: feature descriptions, user needs, acceptance criteria
- MUST use 4-section structure (Executive Summary, Technical Considerations, Acceptance Criteria, Permissions)
- Extract ONLY what was explicitly stated

**User Research** → `04-knowledge-base/business/user-research/`
- Signals: user feedback, interview insights, usability findings
- Include methodology and key findings

**Market Analysis** → `04-knowledge-base/business/market-analysis/`
- Signals: competitive insights, market trends, industry data
- Include data sources and findings

**Technical Documentation** → `04-knowledge-base/technical/`
- Signals: architecture, APIs, infrastructure details
- Choose subcategory based on content

**Process Documentation** → `04-knowledge-base/operational/processes/`
- Signals: workflows, procedures, standards

**Runbook** → `04-knowledge-base/operational/runbooks/`
- Signals: troubleshooting steps, deployment procedures

**Status Update** → `03-active-work/_current-status.md`
- Signals: progress updates, current priorities, blockers

**Glossary Entry** → `01-foundation/glossary.md`
- Signals: new terms defined or used with specific meaning

## Quality Standards

Before completing updates:
- [ ] All dates in ISO format (YYYY-MM-DD)
- [ ] Complete metadata on all documents
- [ ] File naming follows conventions
- [ ] ADR numbers assigned and unique
- [ ] Indexes updated
- [ ] Cross-references added
- [ ] `last-updated` fields current
- [ ] No broken links
- [ ] For requirements: 4-section structure with only stated info
- [ ] For updates: original date/owner preserved

## Report Format

After making updates, provide a report:

```
## Documentation Updates Completed

### Updated Documents
- [path/to/doc1.md] - Updated [what changed]
  - Reason: [Why it needed updating based on conversation]
  - Changes: [Specific changes made]

### New Documents Created
- [path/to/new-doc.md] - [Document type] - [Title]
  - Reason: [Why it was needed]
  - Content: [Brief description]

### Indexes Updated
- [List of index files updated]

### Cross-References Added
- [Document A] now links to [Document B]
- [Document C] updated to reference [Document D]

### Action Items Identified
- [ ] [Action item from conversation] - Owner: [Name] - Due: [Date]

### Information Gaps Remaining
- [Things mentioned that need more info before documenting]
- [Questions that should be answered]

### Recommendations
- [Suggested follow-up documentation]
- [Documents that might need review based on changes]
```

## Important Notes

- **Be conservative**: Only document what was clearly discussed
- **Preserve history**: Don't delete or overwrite, update with revision notes
- **Maintain quality**: Follow all structure and metadata standards
- **Ask if unclear**: If conversation context is ambiguous, note what needs clarification
- **Don't assume**: Only document explicitly stated information

---

**Begin analyzing the conversation above and make necessary documentation updates.**
