---
description: Ask questions about the project and get researched answers
---

You are being asked to research and answer a question about this project.

## Your Task

1. **Understand the question**: Analyze what information is being requested
2. **Research the documentation**: Use the project structure to find relevant information
3. **Prioritize sources** according to the instructions:
   - Current status and active work (`03-active-work/`)
   - Recent decisions (`02-decisions/`)
   - Foundation documents (`01-foundation/`)
   - Knowledge base (`04-knowledge-base/`)
   - Research (`05-research/`)
   - Meeting notes (`06-meetings/`)
4. **Provide a comprehensive answer**: Based on the documentation found
5. **Cite your sources**: Link to the specific documents you referenced

## Research Strategy

### Step 1: Extract Keywords and Concepts
- Identify key terms, technical concepts, feature names, or domain-specific language in the question
- Consider synonyms and related terms
- Note any proper nouns, system names, or specific components mentioned

### Step 2: Check High-Priority Navigation Documents FIRST
**ALWAYS start here** - these provide context and direct pointers:
1. `00-PROJECT-INDEX.md` - Overview and recent activity
2. `03-active-work/_current-status.md` - Current state and priorities
3. Relevant index files:
   - `02-decisions/_decisions-index.md` - Decision records index
   - `06-meetings/_meetings-index.md` - Meeting notes index
   - `04-knowledge-base/technical/_index.md` - Technical docs index
   - `04-knowledge-base/business/_index.md` - Business docs index
   - `04-knowledge-base/operational/_index.md` - Operational docs index

### Step 3: Multi-Strategy Search
Use **parallel searches** for efficiency:

**Strategy A - Metadata Search:**
- Search in frontmatter: `grep -r "tags:.*[keyword]" --include="*.md"`
- Search titles: `grep -r "^title:.*[keyword]" --include="*.md"`
- Search summaries: `grep -r "summary:.*[keyword]" --include="*.md"`

**Strategy B - Content Search:**
- Search for exact phrases from the question
- Search for headers/sections: `grep -r "^## .*[keyword]" --include="*.md"`
- Search with context: Use `-B 2 -A 2` flags to see surrounding lines

**Strategy C - Related Terms:**
- Check `01-foundation/glossary.md` first to find official terminology
- Search for related terms discovered in the glossary
- Look for cross-references in found documents

### Step 4: Use the Task Tool for Complex Questions
**CRITICAL**: For questions that require understanding relationships, architecture, or workflows:
- Use `Task` tool with `subagent_type=general-purpose` instead of manual searching
- Let the agent navigate the structure intelligently
- Provide clear research objectives

### Step 5: Follow the Breadcrumbs
Documents are heavily cross-linked:
- Check `related-docs` in frontmatter of found documents
- Follow links in "Related Information" sections
- Look for ADR references in meeting notes
- Check `supersedes` fields for newer versions

### Step 6: Time-Based Context
Consider when information was created:
- Recent decisions (last 30 days) override older ones
- Check `last-updated` field to find freshest information
- For status questions, prioritize `03-active-work/` over archives
- Check `07-archive/` only if current docs don't have the answer

### Step 7: Domain-Specific Shortcuts

**For business/product questions:**
- Requirements → `04-knowledge-base/business/requirements/`
- User research → `04-knowledge-base/business/user-research/`
- Market data → `04-knowledge-base/business/market-analysis/`

**For technical questions:**
- Architecture → `04-knowledge-base/technical/architecture/`
- APIs/Integrations → `04-knowledge-base/technical/apis-and-integrations/`
- Infrastructure → `04-knowledge-base/technical/infrastructure/`

**For process questions:**
- Workflows → `04-knowledge-base/operational/processes/`
- Troubleshooting → `04-knowledge-base/operational/runbooks/`

**For decision history:**
- Check ADR numbers in `02-decisions/_decisions-index.md`
- Sort by date - most recent first
- Check decision `status` field (some may be superseded)

### Step 8: Verify Information Quality
Before citing a source:
- Check the `status` field (prefer `active` over `draft` or `archived`)
- Verify `last-updated` is recent for time-sensitive info
- Look for `supersedes` field indicating newer versions exist
- Cross-reference with multiple sources when possible

## Answer Format

Your answer should:
- **Start with a direct answer** (TL;DR style)
- **Provide details** with context from the documentation
- **Include specific quotes or examples** when relevant
- **Cite sources** with markdown links to documents
- **Show confidence level**:
  - "According to [source]..." (high confidence)
  - "Based on [source], it appears..." (medium confidence)
  - "No direct documentation found, but related info suggests..." (low confidence)
- **Note information gaps**: What's missing or unclear
- **Suggest next steps**: Related documents to read, or who to ask for more info

### Answer Structure Template

```
## Answer

[Direct, concise answer to the question]

## Details

[Comprehensive explanation with context]

## Sources

- [Document 1](path/to/doc1.md) - [What it says about the topic]
- [Document 2](path/to/doc2.md) - [What it adds]
- [Document 3](path/to/doc3.md) - [Additional context]

## Related Information

[Optional: Related topics, decisions, or documents that provide additional context]

## Confidence & Gaps

- Confidence: [High/Medium/Low]
- Information gaps: [What's missing or unclear]
- Last updated: [Date of most recent source]
```

## Question

{QUESTION}

---

## Final Checklist

Before providing your answer:
- [ ] Did I check the index files first?
- [ ] Did I search using multiple strategies (metadata, content, related terms)?
- [ ] Did I verify the information is current (check dates and status fields)?
- [ ] Did I follow cross-references to related documents?
- [ ] Did I cite all sources with links?
- [ ] Did I note any information gaps or uncertainties?
- [ ] For complex questions, did I consider using the Task tool?

**Note**: If the question cannot be fully answered from existing documentation, state what information is missing and suggest where it might be documented or who might have the answer.
