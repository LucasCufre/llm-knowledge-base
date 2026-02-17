---
description: Unified maintenance workflow - Process, validate, and cross-reference repository content
---

# Maintenance Command

You are being asked to perform comprehensive maintenance on the knowledge base repository.

## Command Syntax

```bash
/maintenance [timeframe]
/maintenance           # Interactive selection
```

**Timeframe Options:**
- `1d` or `1` - Last 1 day (quick daily check, ~5-8 min)
- `5d` or `5` - Last 5 days (weekly scope, ~10-15 min)
- `15d` or `15` - Last 15 days (biweekly scope, ~15-25 min)
- `30d` or `30` - Last 30 days (monthly scope, ~25-40 min)
- `all` - Full repository scan (~40-90 min)
- `status` - Quick status check only

---

## Interactive Prompt (No Timeframe Provided)

If user runs `/maintenance` without parameters, present this choice:

```
Select maintenance scope:

1. Quick (1 day)     - Process new files + validate recent changes (~5-8 min)
2. Weekly (5 days)   - Comprehensive review of recent work (~10-15 min)
3. Biweekly (15 days) - Extended review period (~15-25 min)
4. Monthly (30 days)  - Deep dive into last month (~25-40 min)
5. Full Repository   - Complete repo analysis (~40-90 min)
6. Status Only       - View recent activity (< 1 min)

Enter choice (1-6):
```

Wait for user input, then proceed with selected timeframe.

---

## Status-Only Mode

If user selects `status` or option 6:

### Step 1: Check Logs Directory

```bash
ls -lt logs/ | head -10
```

### Step 2: List Files Awaiting Processing

```bash
find 00-inbox/ -name "*.md" -o -name "*.txt" -o -name "*.docx" | head -20
find 00-inbox/review-needed/ -type f | head -20
```

### Step 3: Generate Status Report

```
## Maintenance Status Report

### Recent Activity
- Last maintenance run: [DATE/TIME from most recent log, or "Never run"]
- Total log files: [count]

### Recent Log Files (Last 5)
1. [filename] - [date]
2. [filename] - [date]
...

### Current Status
- ✅ Files in parse folder: [count]
  [List up to 5 filenames if any]

- ⚠️ Files needing review: [count]
  [List up to 5 filenames if any]

### Recommendations
[Based on counts:]
- Run `/maintenance 1d` to process files in parse folder
- Review files in review-needed/ subfolder
- All clear - no action needed
```

**Then EXIT** - do not proceed to full maintenance.

---

## Full Maintenance Workflow

If timeframe is specified (not status), execute these 8 phases:

---

## PHASE 1: Process New Documents (ALWAYS RUNS)

**Duration:** ~2-5 minutes

### Step 1.1: Scan Parse Folder

```bash
find 00-inbox/ -maxdepth 1 -type f \( -name "*.md" -o -name "*.txt" -o -name "*.docx" \)
```

### Step 1.2: For Each File Found

**A. Read Content**
- Use Read tool for .md and .txt files
- For .docx: Note limitation and recommend conversion to .txt first

**B. Detect Document Type**

Check for these indicators in order:

1. **Meeting Transcript:**
   - Filename contains: "sync", "meeting", "meet", "standup"
   - **OR** Content has 2+ timestamps: `(14:30)` or `Name (9:15):`

2. **Decision:**
   - Content contains: "we decided", "we chose", "we agreed", "decision was made", "consensus was"

3. **Requirement:**
   - Content has: "acceptance criteria", "user story", "requirement", "specification"
   - OR discusses features, functionality, behavior

4. **User Research:**
   - Content about: "user interview", "usability test", "survey", "user feedback", "customer insight"

5. **Market Analysis:**
   - Content about: "competitive analysis", "market trend", "industry report", "competitor"

6. **Technical Documentation:**
   - Content about: "architecture", "API", "infrastructure", "deployment", "system design"

7. **Research:**
   - Content has: "research question", "methodology", "findings", "analysis"

**C. Search for Existing Similar Documents**

**CRITICAL: ALWAYS search before creating new documents**

1. Extract key topics/keywords from content (3-5 main topics)
2. Search relevant category using Grep:
   - For decisions: `grep -ri "keyword" 02-decisions/ --include="*.md"`
   - For requirements: `grep -ri "keyword" 04-knowledge-base/business/requirements/ --include="*.md"`
   - For meetings: `grep -ri "keyword" 06-meetings/ --include="*.md"`
   - For research: `grep -ri "keyword" 05-research/ --include="*.md"`
   - For technical: `grep -ri "keyword" 04-knowledge-base/technical/ --include="*.md"`
   - For user research: `grep -ri "keyword" 04-knowledge-base/business/user-research/ --include="*.md"`
   - For market analysis: `grep -ri "keyword" 04-knowledge-base/business/market-analysis/ --include="*.md"`

3. For each potential match:
   - Read the existing document
   - Calculate similarity based on:
     - Title similarity
     - Topic overlap
     - Content similarity (first 500 chars)

4. Make decision:
   - **High confidence match (>80% similar):** UPDATE existing document
   - **Moderate confidence (50-80%):** MOVE to `review-needed/` for human review
   - **Low confidence (<50%):** CREATE new document

**D. Process Document**

Based on type detected:

### Meeting Transcript Processing

1. **Detect language** - If non-English, note in metadata (translate if needed)
2. **Extract metadata:**
   - Date (from filename or content)
   - Attendees/participants
   - Meeting type
3. **Parse content into sections:**
   - Executive Summary (2-3 sentences)
   - Topics Discussed (list)
   - Decisions Made (list)
   - Action Items (with owners and due dates)
   - Blockers/Issues Raised
4. **Create meeting note** in `06-meetings/YYYY-MM/` (create month folder if needed)
   - Use template: `06-meetings/_template-meeting.md`
   - Filename: `YYYY-MM-DD-meeting-title.md`
5. **Extract significant decisions to ADRs:**
   - For each decision in "Decisions Made"
   - Check if already documented as ADR
   - If not, create new ADR (see Phase 4 for details)
6. **Update active work docs if needed:**
   - If meeting mentions blockers → update `03-active-work/blockers-and-risks.md`
   - If meeting mentions priorities → check `03-active-work/priorities.md`
7. **Add new terms to glossary** if domain-specific terms found
8. **Update `06-meetings/_meetings-index.md`**

### Decision Processing

1. **Extract decision components:**
   - Context: What led to this decision?
   - Decision: What was decided?
   - Rationale: Why was this chosen?
   - Alternatives: What else was considered?
   - Consequences: What are the implications?

2. **Get next ADR ID:**
   - Read `02-decisions/_decisions-index.md`
   - Find "Next Available IDs" section
   - Determine category (Architecture/Technical/Business/Process/Security/Infrastructure)
   - Use appropriate ID range:
     - 001-099: Architecture
     - 100-199: Technical
     - 200-299: Business
     - 300-399: Process
     - 400-499: Security
     - 500-599: Infrastructure

3. **Create ADR:**
   - Use template: `02-decisions/_template-decision.md`
   - Filename: `YYYY-MM-DD-decision-title.md`
   - Fill all sections from extracted components
   - Set status: "Accepted" (if already implemented) or "Proposed"

4. **Update `02-decisions/_decisions-index.md`:**
   - Add entry to appropriate category table
   - Update "Next Available IDs" section
   - Update statistics
   - Update last-updated date

### Requirement Processing

**CRITICAL: Use mandatory 4-section structure**

1. **Extract ONLY explicitly stated information** - NO assumptions

2. **Create sections:**

   **Section 1: Executive Summary**
   - Business value
   - User impact
   - Rationale
   - If not in source: "Not specified in source document"

   **Section 2: Technical Considerations**
   - Implementation notes
   - Dependencies
   - Constraints
   - API endpoints
   - If not in source: "Not specified in source document"

   **Section 3: Acceptance Criteria**
   - Testable conditions
   - Error states
   - Edge cases
   - If not in source: "Not specified in source document"

   **Section 4: Permissions**
   - RBAC roles
   - Access control
   - If not in source: "Not specified in source document"

3. **Create document:**
   - Location: `04-knowledge-base/business/requirements/`
   - Use template: `04-knowledge-base/business/requirements/_template-requirement.md`
   - Filename: `requirement-name.md` (lowercase-with-hyphens)

4. **Update `04-knowledge-base/business/_index.md`**

### User Research Processing

1. **Extract components:**
   - Methodology
   - Participant details
   - Key findings
   - Insights
   - Recommendations

2. **Create document:**
   - Location: `04-knowledge-base/business/user-research/`
   - Use template: `04-knowledge-base/business/user-research/_template-user-research.md`

3. **Link to related requirements** if applicable

4. **Update `04-knowledge-base/business/_index.md`**

### Market Analysis Processing

1. **Extract components:**
   - Data sources
   - Methodology
   - Findings
   - Recommendations
   - Competitive insights

2. **Create document:**
   - Location: `04-knowledge-base/business/market-analysis/`
   - Use template: `04-knowledge-base/business/market-analysis/_template-market-analysis.md`

3. **Update `04-knowledge-base/business/_index.md`**

### Technical Documentation Processing

1. **Determine subcategory:**
   - Architecture → `04-knowledge-base/technical/architecture/`
   - APIs → `04-knowledge-base/technical/apis-and-integrations/`
   - Infrastructure → `04-knowledge-base/technical/infrastructure/`

2. **Create document** in appropriate subfolder

3. **Add new terms to `01-foundation/glossary.md`**

4. **Update `04-knowledge-base/technical/_index.md`**

### Research Processing

1. **Extract components:**
   - Research question
   - Methodology
   - Data sources
   - Findings
   - Recommendations

2. **Create document:**
   - Location: `05-research/`
   - Use template: `05-research/_template-research.md`

3. **Update `05-research/_research-index.md`**

**E. Cleanup**

After successful processing:
- **DELETE original file** from `00-inbox/`
- OR if uncertain/errors: **MOVE to `00-inbox/review-needed/`**
- Report action taken

### Step 1.3: Phase 1 Report

Track and report:
```
[1/8] Processing new documents...
  ✅ Processed: [filename] → [created-doc.md]
     Type: [detected type]
     Language: [language] (translated: yes/no)
     Action: [Created new / Updated existing]
  ✅ Extracted: [ADR-XXX] ([decision title])
  🗑️ Deleted: [filename]

  ⚠️ Flagged for review: [filename] → review-needed/
     Reason: [why flagged]

Summary:
- Files processed: [count]
- Documents created: [count]
- Documents updated: [count]
- ADRs extracted: [count]
- Files deleted: [count]
- Files flagged: [count]
```

---

## PHASE 2: Find Target Documents

**Duration:** <1 minute

Based on selected timeframe, find documents modified in that period:

### Map Timeframe to Days

```
1d or 1   → 1 day
5d or 5   → 5 days
15d or 15 → 15 days
30d or 30 → 30 days
all       → all files (don't use mtime filter)
```

### Find Documents

```bash
# For timeframes with days (not "all")
find . -name "*.md" -mtime -[DAYS] -not -path "./07-archive/*" -not -path "./00-inbox/*" -not -name "_template-*.md" -not -name "_*-index.md"

# For "all"
find . -name "*.md" -not -path "./07-archive/*" -not -path "./00-inbox/*" -not -name "_template-*.md" -not -name "_*-index.md"
```

### Phase 2 Report

```
[2/8] Finding documents ([timeframe])...
  📄 Found [count] documents to validate
  📅 Date range: [YYYY-MM-DD] to [YYYY-MM-DD]
```

---

## PHASE 3: Validate Document Quality

**Duration:** ~5-10 minutes (depends on document count)

For each document found in Phase 2:

### Step 3.1: Metadata Validation

Read document and check YAML frontmatter:

**Required Fields:**
- `title` (string)
- `type` (one of: decision-record, meeting-note, requirement, user-research, market-analysis, technical-doc, research, process, runbook)
- `date` (YYYY-MM-DD)
- `last-updated` (YYYY-MM-DD)
- `status` (active, draft, proposed, accepted, rejected, superseded, deprecated, archived)
- `owner` (string)
- `tags` (array, non-empty)
- `summary` (string, non-empty)
- `related-docs` (array, can be empty)

**Auto-Fix Actions:**

1. **Missing `last-updated`:**
   - Get file modification time using Bash: `stat -f "%Sm" -t "%Y-%m-%d" [filepath]`
   - Add field to frontmatter with that date
   - Update document

2. **Wrong date format:**
   - Convert to YYYY-MM-DD
   - Update document

3. **Empty `related-docs` field:**
   - If field is missing, add: `related-docs: []`

**Flag for Review:**
- Missing `title`, `owner`, or `summary`
- Empty `summary`
- Empty `tags` array
- Invalid `type` value
- Invalid `status` value

### Step 3.2: Structure Validation

**For Requirements (`type: requirement`):**

Check for 4-section structure:
1. Executive Summary
2. Technical Considerations
3. Acceptance Criteria
4. Permissions

**Flag if:**
- Missing any of the 4 sections
- Contains assumed information (look for phrases like "probably", "should", "might", "likely")

**For Decisions (`type: decision-record`):**

Check for ADR structure:
- Context
- Decision
- Rationale
- Alternatives Considered
- Consequences

**Flag if:**
- Missing any required section
- No ADR number in title or filename

### Step 3.3: Link Validation

Extract all markdown links: `[text](path.md)` or `[text](path.md#anchor)`

For each link:
1. Parse the path (relative to current document)
2. Resolve to absolute path
3. Check if target file exists using Read tool (attempt read, if fails → broken)

**Auto-Fix:**
- If path starts with `../` but file is in same directory → fix to `./`
- If path is wrong by one directory level → attempt to find and fix

**Flag:**
- Broken links where target is not found
- Links to archived documents (in `07-archive/`)

### Step 3.4: Phase 3 Report

```
[3/8] Validating quality...

Metadata Issues:
  ✅ Auto-fixed: [count]
     - [path/to/doc.md] - Added missing last-updated
     - [path/to/doc.md] - Fixed date format

  ⚠️ Critical issues: [count]
     - [path/to/doc.md] - Missing: title, owner
     - [path/to/doc.md] - Empty summary

Structure Issues:
  ⚠️ [path/to/requirement.md] - Missing Permissions section
  ⚠️ [path/to/decision.md] - No ADR number

Broken Links:
  ⚠️ [source.md] → [target.md] (File not found)
  ⚠️ [source.md] → [archived.md] (Links to archived content)

Summary:
- Documents validated: [count]
- Issues auto-fixed: [count]
- Issues flagged: [count]
```

---

## PHASE 4: Cross-Reference Analysis (CORE FEATURE)

**Duration:** ~10-20 minutes

This phase automatically discovers and creates missing knowledge connections.

### Step 4.1: Extract Missing Decisions

**Goal:** Find decisions in documents that aren't captured as ADRs

**Decision Patterns to Search:**
```regex
we decided to (.+?)[\.\n]
we chose (.+?) because
decision was made to (.+?)[\.\n]
we agreed to (.+?)[\.\n]
consensus was to (.+?)[\.\n]
we will use (.+?)[\.\n]
we selected (.+?)[\.\n]
```

**Process:**

1. **For each document** in target list (from Phase 2):
   - Skip if document type is already `decision-record`
   - Read full content
   - Search for decision patterns using Grep

2. **For each decision pattern match:**
   - Extract decision text
   - Extract context (±500 characters around match)
   - Extract potential decision title

3. **Check if decision already captured:**
   - Read all ADRs in `02-decisions/`
   - Compare decision text to each ADR content
   - Calculate similarity (simple word overlap):
     - Common words / total unique words
     - Threshold: >75% = duplicate

4. **If NOT a duplicate:**

   **A. Determine ADR category from content keywords:**
   - Keywords → Category:
     - "architecture", "system", "design", "component" → Architecture (001-099)
     - "technology", "library", "framework", "language", "tool" → Technical (100-199)
     - "feature", "product", "user", "business" → Business (200-299)
     - "process", "workflow", "methodology", "procedure" → Process (300-399)
     - "security", "authentication", "authorization", "encryption" → Security (400-499)
     - "infrastructure", "deployment", "hosting", "server" → Infrastructure (500-599)
   - Default to Technical if ambiguous

   **B. Get next ADR ID:**
   - Read `02-decisions/_decisions-index.md`
   - Find "Next Available IDs" section
   - Get ID for determined category
   - Increment for next time

   **C. Create ADR:**
   - Use template: `02-decisions/_template-decision.md`
   - Title: `ADR-[ID]: [Decision Title]`
   - Filename: `YYYY-MM-DD-[decision-title].md` (today's date)
   - Fill sections:
     - **Context:** From extracted context
     - **Decision:** From extracted decision text
     - **Rationale:** From surrounding text (extract "because", "since", "as" clauses)
     - **Alternatives Considered:** Mark as "Not documented" if not found
     - **Consequences:** Extract if mentioned, else "To be determined"
   - Status: "Accepted" (if decision is past tense) or "Proposed"
   - Related-docs: Include source document

   **D. Add bidirectional link:**
   - Add source document to ADR's `related-docs`
   - Add ADR to source document's `related-docs`
   - Update both documents' `last-updated`

   **E. Update decisions index:**
   - Add entry to appropriate category table in `02-decisions/_decisions-index.md`
   - Update "Next Available IDs" section
   - Update statistics
   - Update `last-updated`

### Step 4.2: Find Missing Cross-References

**Goal:** Link documents that should reference each other but don't

**Relationship Rules:**

#### Rule 1: Requirement → Decision
**When:** Requirement mentions a technical choice that has an ADR

**How to detect:**
1. For each requirement in target documents
2. Extract technical terms/choices (database, framework, architecture, etc.)
3. Search decisions for matching terms
4. For each matching decision:
   - Check if requirement date >= decision date (requirement comes after)
   - Count common topics/keywords (need 2+)
   - If match AND not already linked → add cross-reference

#### Rule 2: Requirement → User Research
**When:** Requirement addresses a user pain point from research

**How to detect:**
1. For each requirement in target documents
2. Extract user-centric terms (pain point, user need, feedback, etc.)
3. Search user research documents
4. For matches with 2+ common user-focused keywords → add cross-reference

#### Rule 3: Meeting → Decision
**When:** ADR was created on same date as meeting or shortly after (within 7 days)

**How to detect:**
1. For each meeting note in target documents
2. Get meeting date
3. Find ADRs with date within ±7 days of meeting
4. Check if meeting attendees overlap with ADR owner
5. If match AND not already linked → add cross-reference

#### Rule 4: Research → Requirement
**When:** Requirement is based on research findings

**How to detect:**
1. For each research document in target documents
2. Extract key findings/recommendations
3. Search requirements for matching topics
4. For matches with 3+ common keywords → add cross-reference

**Implementation:**

For each matching pair (Doc A should link to Doc B):

1. **Check if already linked:**
   - Read Doc A's `related-docs` array
   - Check if Doc B is listed
   - Read Doc B's `related-docs` array
   - Check if Doc A is listed

2. **If missing link:**
   - Add Doc B to Doc A's `related-docs`
   - Add Doc A to Doc B's `related-docs`
   - Update both `last-updated` fields
   - Report action

### Step 4.3: Update Indexes

**Goal:** Ensure all documents are in appropriate indexes

**Index Mapping:**
```
decision-record    → 02-decisions/_decisions-index.md
meeting-note       → 06-meetings/_meetings-index.md
requirement        → 04-knowledge-base/business/_index.md
user-research      → 04-knowledge-base/business/_index.md
market-analysis    → 04-knowledge-base/business/_index.md
technical-doc      → 04-knowledge-base/technical/_index.md (by subcategory)
research           → 05-research/_research-index.md
process            → 04-knowledge-base/operational/_index.md
runbook            → 04-knowledge-base/operational/_index.md
```

**Process:**

1. **For each document** in target list:
   - Get document type from metadata
   - Look up target index from mapping
   - Read target index file

2. **Check if document is listed:**
   - Search index content for document filename
   - OR search for document title

3. **If NOT found in index:**

   **For decisions index:**
   - Determine category from ADR ID range
   - Add row to appropriate table:
     - Format: `| ADR-XXX | [Title](filepath) | YYYY-MM-DD | Status | Owner |`
   - Update statistics section

   **For meetings index:**
   - Add to chronological list or month-based section

   **For business/technical indexes:**
   - Add bullet point in appropriate section

   **For research index:**
   - Add entry with title, date, status

4. **Update index file:**
   - Update `last-updated` field
   - Save changes

### Step 4.4: Enforce Bidirectional Links

**Goal:** Ensure all links go both ways (A→B means B→A)

**Process:**

1. **For each document** in target list:
   - Read `related-docs` array (or empty array if missing)
   - For each related document path:

2. **Open related document:**
   - Resolve path to absolute
   - Read related document
   - Read its `related-docs` array

3. **Check if backlink exists:**
   - Calculate relative path from related doc back to original doc
   - Check if that path is in related doc's `related-docs`

4. **If backlink missing:**
   - Add original doc to related doc's `related-docs`
   - Update related doc's `last-updated`
   - Report action

### Step 4.5: Phase 4 Report

```
[4/8] Analyzing cross-references...

New Decisions Extracted: [count]
  ✅ ADR-015: Database Selection
     Source: 2025-02-10-product-sync.md
     Decision: "Use PostgreSQL for user data"
     Links: Meeting ↔ ADR (bidirectional)

Missing Cross-References Added: [count]
  ✅ [requirement.md] ↔ [ADR-012.md]
     Relationship: Requirement implements decision
     Common topics: authentication, JWT, OAuth

  ✅ [research.md] ↔ [requirement.md]
     Relationship: Requirement based on research
     Common topics: user onboarding, pain points

Index Updates: [count]
  ✅ Added [doc1.md] to 02-decisions/_decisions-index.md
  ✅ Added [doc2.md] to 04-knowledge-base/business/_index.md

Bidirectional Links Enforced: [count]
  ✅ [doc-A.md] now links back to [doc-B.md]
  ✅ [doc-C.md] now links back to [doc-D.md]

Summary:
- ADRs created: [count]
- Cross-references added: [count]
- Indexes updated: [count]
- Backlinks enforced: [count]
```

---

## PHASE 5: Duplicate Detection

**Duration:** ~5-15 minutes

**Execution depends on timeframe:**
- **1d:** Limited scope (only within target documents)
- **5d, 15d, 30d:** Target documents vs. entire repository
- **all:** Full repository scan

### Step 5.1: Build Document List

**For 1d timeframe:**
- Compare only documents from Phase 2 with each other

**For 5d, 15d, 30d timeframes:**
- Set A: Documents from Phase 2 (target timeframe)
- Set B: All documents in repository
- Compare A vs B

**For all timeframe:**
- Compare all documents with all documents (n² comparison)

### Step 5.2: Calculate Similarity

For each pair of documents (A, B):

**Skip if:**
- Same file
- One is a template (`_template-*.md`)
- One is an index (`*-index.md` or `*_index.md`)
- Both in archive folder

**Similarity Metrics:**

1. **Title Similarity:**
   - Extract titles from metadata
   - Remove common words (the, a, an, for, to, of)
   - Calculate word overlap: `common_words / min(words_A, words_B)`
   - Threshold: >85% = very similar titles

2. **Tag Similarity:**
   - Get tags arrays from both documents
   - Calculate overlap: `common_tags / min(tags_A, tags_B)`
   - Threshold: >70% = very similar tags

3. **Content Similarity (first 500 chars):**
   - Read first 500 characters of content (after frontmatter)
   - Remove whitespace and normalize
   - Calculate character overlap (simple ratio)
   - Threshold: >80% = very similar content

**Overall Similarity:**
- If ANY metric exceeds threshold → potential duplicate
- If ALL THREE exceed thresholds → high-confidence duplicate

### Step 5.3: Identify Canonical Version

For each duplicate set:

**Canonical = most complete and recent:**
1. Most recent `last-updated` date
2. Longest content (more comprehensive)
3. More links in `related-docs` (better integrated)
4. Status is "active" vs "draft"

### Step 5.4: Phase 5 Report

```
[5/8] Checking for duplicates...

Duplicate Sets Found: [count]

High-Confidence Duplicates:
  📋 Duplicate Set 1:
     Canonical: [path/to/doc1.md]
       - Last updated: 2025-02-15
       - Length: 2400 chars
       - Links: 5
       - Status: active
     Duplicates:
       - [path/to/doc2.md] (older, 2025-01-10)
       - [path/to/doc3.md] (draft status)
     Similarity: Title 90%, Tags 85%, Content 88%
     Recommendation: Archive duplicates, add redirect notes

Potential Duplicates (Review Needed):
  ⚠️ Potential Set 2:
     - [path/to/docA.md]
     - [path/to/docB.md]
     Similarity: Title 87%, Tags 60%, Content 70%
     Recommendation: Manual review - may cover different aspects

Summary:
- Duplicate sets found: [count]
- High-confidence: [count]
- Needs review: [count]
```

---

## PHASE 6: Orphan Detection

**Only runs for:** 30d, all

**Skip for:** 1d, 5d, 15d

**Duration:** ~10-20 minutes

### Step 6.1: Build Full Document List

```bash
find . -name "*.md" -not -path "./07-archive/*" -not -path "./00-inbox/*" -not -name "_template-*.md" -not -name "_*-index.md" -not -name "README.md"
```

### Step 6.2: Calculate Connectedness

For each document:

**A. Count Incoming Links:**
```bash
# Search entire repo for links to this document
grep -r "filename.md" --include="*.md" . | wc -l
```

**B. Count Outgoing Links:**
- Read document's `related-docs` array
- Count entries

**C. Check Index Presence:**
- Determine which index should contain this doc (by type)
- Read index file
- Search for document filename or title

**D. Calculate Score:**
```
Connectedness = Incoming Links + Outgoing Links + (In Index ? 1 : 0)
```

**Orphan if:**
- Connectedness = 0
- OR (Incoming = 0 AND Outgoing = 0 AND Not in index)

### Step 6.3: Categorize Orphans

For each orphaned document:

**Value Assessment:**
- Recent (last-updated < 90 days) → High value
- Has comprehensive content (>1000 chars) → Medium/High value
- Status is "active" → High value
- Status is "draft" → Low value
- Old (last-updated > 180 days) → Low value

**Recommendations:**
- **High value:** Integrate (add to index, link from related docs)
- **Low value:** Archive

### Step 6.4: Phase 6 Report

```
[6/8] Detecting orphans...

Orphaned Documents Found: [count]

High Value - Recommend Integration:
  📄 [path/to/doc.md]
     Last updated: 2025-01-20 (recent)
     Length: 1500 chars
     Status: active
     Recommendation: Add to [index.md], link from [related-doc.md]

Low Value - Recommend Archive:
  📄 [path/to/old-doc.md]
     Last updated: 2024-03-10 (>11 months)
     Length: 300 chars
     Status: draft
     Recommendation: Archive to 07-archive/2024-Q1/

Summary:
- Orphans found: [count]
- High value: [count]
- Low value: [count]
```

If Phase 6 skipped:
```
[6/8] Detecting orphans... [SKIPPED - run with 30d or all]
```

---

## PHASE 7: Stale Content Detection

**Only runs for:** 30d, all

**Skip for:** 1d, 5d, 15d

**Duration:** ~5-10 minutes

### Step 7.1: Find Stale Documents

```bash
# Documents not modified in over 365 days
find . -name "*.md" -mtime +365 -not -path "./07-archive/*" -not -path "./00-inbox/*" -not -name "_template-*.md"
```

### Step 7.2: Assess Each Stale Document

Read document metadata:

**Check Status:**
- If `status: archived` → Skip (already archived)
- If `status: active` → Flag for review
- If `status: draft` → Recommend archive
- If `status: superseded` → Should already be in archive

**Check Incoming References:**
```bash
grep -r "filename.md" --include="*.md" . | wc -l
```

**Determine Recommendation:**

| Status | Recent Links | Recommendation |
|--------|--------------|----------------|
| active | Yes (>2) | KEEP - still referenced |
| active | No (0-2) | UPDATE - refresh content |
| draft | Any | ARCHIVE - incomplete and old |
| superseded | Any | ARCHIVE - should be historical |
| Any | No | ARCHIVE - not referenced |

**Foundational Documents (ALWAYS KEEP):**
- In `01-foundation/`
- Project charter, glossary, objectives
- These are stable by nature

### Step 7.3: Phase 7 Report

```
[7/8] Finding stale content...

Stale Documents Found (>1 year): [count]

Recommend Archive:
  📅 [path/to/doc.md]
     Last updated: 2024-01-15 (>13 months)
     Status: draft
     Incoming links: 0
     Recommendation: Archive to 07-archive/2024-Q1/

Recommend Keep (Still Active):
  📅 [path/to/doc.md]
     Last updated: 2023-12-01 (>14 months)
     Status: active
     Incoming links: 5
     Recommendation: Keep - frequently referenced foundational doc

Recommend Update:
  📅 [path/to/doc.md]
     Last updated: 2024-02-01 (>12 months)
     Status: active
     Incoming links: 1
     Recommendation: Refresh content with current information

Summary:
- Stale documents: [count]
- Recommend archive: [count]
- Recommend keep: [count]
- Recommend update: [count]
```

If Phase 7 skipped:
```
[7/8] Finding stale content... [SKIPPED - run with 30d or all]
```

---

## PHASE 8: Generate Comprehensive Report

**Duration:** ~1 minute

### Step 8.1: Create Log File

**Filename:** `logs/maintenance-YYYY-MM-DD-HHmmss.md`

**Content:**

```markdown
---
title: Maintenance Report
type: maintenance-log
date: YYYY-MM-DD
time: HH:mm:ss
scope: [1d|5d|15d|30d|all]
duration: [HH:MM:SS]
---

# Maintenance Report - [DATE] [TIME]

**Scope:** Last [X] days / Full Repository
**Duration:** [HH:MM:SS]

---

## Phase 1: New Document Processing

### Files Processed: [count]

[Detailed list of each file processed]

#### File: [filename]
- **Type Detected:** [type]
- **Language:** [language] (Translated: yes/no)
- **Action:** [Created new / Updated existing / Flagged for review]
- **Output:** [path/to/created-doc.md]
- **Extracted:** [ADRs: X, action items: Y]
- **Cleanup:** ✅ Original deleted / ⚠️ Moved to review-needed

### Phase 1 Summary
- ✅ Files processed: [count]
- ✅ Documents created: [count]
- ✅ Documents updated: [count]
- ✅ ADRs extracted: [count]
- 🗑️ Files deleted: [count]
- ⚠️ Files flagged: [count]

---

## Phase 2: Document Discovery

- 📄 Documents in timeframe: [count]
- 📅 Date range: [YYYY-MM-DD] to [YYYY-MM-DD]

---

## Phase 3: Quality Validation

### Metadata Issues

#### Auto-Fixed: [count]
[List of each fix]

#### Critical Issues: [count]
[List requiring manual intervention]

### Structure Issues

[List of structure problems]

### Broken Links

[List of broken links]

### Phase 3 Summary
- Documents validated: [count]
- Issues auto-fixed: [count]
- Critical issues: [count]
- Broken links: [count]

---

## Phase 4: Cross-Reference Analysis

### New Decisions Extracted: [count]

[For each ADR created:]
#### ADR-XXX: [Title]
- **Source:** [source-document.md]
- **Decision:** [brief description]
- **Links Added:** Source ↔ ADR

### Missing Cross-References Added: [count]

[For each cross-reference added:]
- ✅ [docA.md] ↔ [docB.md]
  - **Relationship:** [type]
  - **Reason:** [why they should link]

### Index Updates: [count]

[For each index update:]
- ✅ Added [document.md] to [index-file.md]

### Bidirectional Links Enforced: [count]

[For each backlink added:]
- ✅ [docA.md] → [docB.md] (backlink added)

### Phase 4 Summary
- ADRs extracted: [count]
- Cross-references added: [count]
- Indexes updated: [count]
- Backlinks enforced: [count]

---

## Phase 5: Duplicate Detection

### Duplicate Sets Found: [count]

[For each duplicate set:]
#### Duplicate Set [N]: [Topic]
- **Canonical:** [path/to/doc1.md]
  - Last updated: [date]
  - Length: [chars]
  - Status: [status]
- **Duplicates:**
  - [path/to/doc2.md] - [reason]
  - [path/to/doc3.md] - [reason]
- **Similarity:** Title X%, Tags Y%, Content Z%
- **Recommendation:** [action to take]

### Phase 5 Summary
- Duplicate sets: [count]
- High-confidence: [count]
- Needs review: [count]

---

## Phase 6: Orphan Detection

[If run:]

### Orphaned Documents: [count]

#### High Value - Integrate:
[List with recommendations]

#### Low Value - Archive:
[List with recommendations]

### Phase 6 Summary
- Orphans found: [count]
- High value: [count]
- Low value: [count]

[If skipped:]
Phase 6 skipped - run with `/maintenance 30d` or `/maintenance all`

---

## Phase 7: Stale Content

[If run:]

### Stale Documents (>1 year): [count]

#### Recommend Archive:
[List]

#### Recommend Keep:
[List]

#### Recommend Update:
[List]

### Phase 7 Summary
- Stale documents: [count]
- Recommend archive: [count]
- Recommend keep: [count]
- Recommend update: [count]

[If skipped:]
Phase 7 skipped - run with `/maintenance 30d` or `/maintenance all`

---

## Overall Summary

| Metric | Count |
|--------|-------|
| Documents in scope | [count] |
| Files processed (new) | [count] |
| Documents created | [count] |
| Documents updated | [count] |
| Issues auto-fixed | [count] |
| Issues requiring review | [count] |
| ADRs extracted | [count] |
| Cross-references added | [count] |
| Indexes updated | [count] |
| Broken links found | [count] |
| Duplicates found | [count] |
| Orphans found | [count] |
| Stale documents | [count] |

---

## Recommended Actions

### Immediate (High Priority)
1. [Action 1]
2. [Action 2]

### Soon (Medium Priority)
1. [Action 1]
2. [Action 2]

### Eventually (Low Priority)
1. [Action 1]
2. [Action 2]

---

## Files Needing Review

### In parse folder review-needed/:
[List files moved to review with reasons]

### Critical metadata issues:
[List files with missing required fields]

### Broken links:
[List files with broken links]

### Potential duplicates:
[List duplicate sets needing manual review]

---

**Maintenance completed at:** [YYYY-MM-DD HH:MM:SS]
**Total duration:** [HH:MM:SS]
```

### Step 8.2: Console Summary

Display to user:

```
✨ Maintenance Complete!

📊 Summary:
- Scope: Last [X] days / Full repository
- Duration: [HH:MM:SS]
- Documents validated: [count]
- Issues auto-fixed: [count]
- ADRs extracted: [count]
- Cross-references added: [count]
- Duplicates found: [count]

⚠️ Action Required:
- [count] critical issues need review
- [count] files in review-needed/ folder
- [count] duplicate sets to resolve

📁 Full report saved to:
   logs/maintenance-YYYY-MM-DD-HHmmss.md

💡 Next Steps:
[Top 3 recommended actions from report]
```

---

## Quality Checks

Before completing, verify:

- [ ] All dates in ISO format (YYYY-MM-DD)
- [ ] All new documents have complete metadata
- [ ] All cross-references are bidirectional
- [ ] All indexes updated with new documents
- [ ] All new ADRs have unique IDs
- [ ] All successfully processed files deleted from parse folder
- [ ] All problematic files moved to review-needed/
- [ ] Log file created with complete information
- [ ] No broken internal links created

---

## Critical Rules

**ALWAYS:**
- Process new files in Phase 1 (even for status-only)
- Search for existing documents before creating new ones
- Use templates for structured documents
- Update indexes when creating/updating documents
- Create bidirectional links (A→B means B→A)
- Delete successfully processed files from parse folder
- Preserve original `date` and `owner` in metadata
- Update `last-updated` when modifying documents

**NEVER:**
- Skip Phase 1 (new document processing)
- Leave files in parse folder after processing
- Create ADRs without checking for duplicates
- Overwrite original metadata fields
- Create one-way links
- Delete documents (archive instead)
- Make assumptions in requirements (only explicit info)

---

**Begin maintenance workflow based on selected timeframe.**
