# Inbox - Document Processing Queue

This folder serves as the **automated processing queue** for new, unstructured documents that need to be organized into the knowledge base.

## Purpose

The inbox is the entry point for all raw, unstructured content that should be processed and organized into the structured knowledge base. Drop files here and let the automated maintenance system detect document types, extract content, and file everything appropriately.

## How It Works

1. **Drop files here** - Add any document (meeting transcripts, notes, specs, research)
2. **Run maintenance** - Execute `/maintenance` or let scheduled processing run
3. **Automatic processing** - System detects type, structures content, updates indexes
4. **Auto-cleanup** - Successfully processed files are automatically deleted
5. **Review flagged items** - Check `review-needed/` subfolder for ambiguous content

## Supported File Types

- **Markdown** (`.md`) - Best for processing
- **Text files** (`.txt`) - Plain text documents
- **Word documents** (`.docx`) - Will be converted
- **PDFs** (`.pdf`) - Text-based PDFs

## What Gets Processed

The system automatically detects and processes:

### Meeting Transcripts
- **Detection**: Filename contains "sync", "meeting", or "meet" OR content has 2+ timestamps like `(14:30)`
- **Output**: Structured meeting note + extracted decision records (ADRs)
- **Location**: `06-meetings/YYYY-MM/`

### Decisions
- **Detection**: Contains phrases like "we decided", "we chose", "we agreed"
- **Output**: Architecture Decision Record (ADR) with next sequential number
- **Location**: `02-decisions/`

### Requirements
- **Detection**: Feature descriptions, user stories, specifications
- **Output**: Structured requirement with 4-section format (Executive Summary, Technical Considerations, Acceptance Criteria, Permissions)
- **Location**: `04-knowledge-base/business/requirements/`

### User Research
- **Detection**: User interviews, surveys, usability tests, customer feedback
- **Output**: Structured research document
- **Location**: `04-knowledge-base/business/user-research/`

### Market Analysis
- **Detection**: Competitive analysis, market trends, industry reports
- **Output**: Structured analysis document
- **Location**: `04-knowledge-base/business/market-analysis/`

### Technical Documentation
- **Detection**: Architecture, APIs, infrastructure details
- **Output**: Structured technical document
- **Location**: `04-knowledge-base/technical/[subcategory]/`

### Research
- **Detection**: Investigation findings, analysis, recommendations
- **Output**: Structured research document
- **Location**: `05-research/`

## Processing Workflow

```
00-inbox/
  ├── your-document.md          ← You place file here
  │
  ↓ Run /maintenance
  │
  ├── [Processing]               ← System analyzes content
  │   ├── Detect document type
  │   ├── Search for duplicates
  │   ├── Extract key information
  │   ├── Apply appropriate template
  │   └── Update indexes
  │
  ↓
  │
  ├── [Success]                  ← File processed
  │   ├── Deleted from inbox
  │   └── Structured doc created in proper location
  │
  OR
  │
  └── review-needed/             ← Ambiguous content flagged
      └── your-document.md       ← Needs human review
```

## Review Needed Subfolder

Files that can't be automatically categorized are moved to `review-needed/` for human review. This happens when:

- Document type is unclear
- Multiple possible destinations
- Missing critical information
- Unusual format or structure

Check this folder regularly and manually process flagged items.

## Best Practices

### ✅ Do This

- Use descriptive filenames (e.g., `weekly-sync-2026-02-16.md`, `user-login-feature-spec.md`)
- Provide clear content structure
- Include dates in meeting transcripts
- Use markdown format when possible
- Run maintenance regularly (daily is best)
- Check `review-needed/` folder weekly

### ❌ Avoid This

- Don't leave files here indefinitely - process them
- Don't use cryptic filenames (e.g., `doc1.md`, `notes.txt`)
- Don't mix multiple topics in one file (split them first)
- Don't manually edit files after dropping them (use `00-wip/` for drafts instead)
- Don't forget to check processing logs for errors

## Comparison with WIP Folder

| Aspect | `00-wip/` | `00-inbox/` |
|--------|-----------|-------------|
| **Purpose** | Work in progress, drafting | Ready for processing |
| **Processing** | No automation, manual only | Fully automated |
| **Status** | Incomplete, still editing | Complete, ready to file |
| **Workflow** | Create → Edit → Finish → Move to inbox | Drop → Auto-process → Delete |
| **Use for** | Drafts, reviews, multi-stage docs | Completed documents |

## Commands

Process files in this folder using:

```bash
/maintenance        # Smart unified workflow
/maintenance 1d     # Quick daily check
/maintenance 5d     # Weekly comprehensive review
/maintenance status # Just check what's here
```

## Troubleshooting

### Files Not Being Processed

**Check:**
- File format is supported
- Filename is descriptive
- Content is in supported format (markdown preferred)
- No file permissions issues

**Solution:**
- Review processing logs in `logs/` folder
- Check if file was moved to `review-needed/`
- Try renaming with more descriptive name
- Ensure content has clear signals (timestamps for meetings, decision language for ADRs)

### Wrong Document Type Detected

**Solution:**
- Move file to `review-needed/`
- Manually create structured document in correct location
- Update detection rules in maintenance command if pattern is common

### Duplicate Documents Created

**Prevention:**
- System searches for duplicates automatically
- Use consistent naming and tagging

**Fix:**
- Consolidate duplicates manually
- Update cross-references
- Archive obsolete version

## File Retention

- **Successfully processed files**: Deleted immediately after processing
- **Flagged files**: Remain in `review-needed/` until manually resolved
- **Processing logs**: Kept in `logs/` folder for audit trail

---

**Next Steps:**
1. Place documents in this folder
2. Run `/maintenance` to process them
3. Check `review-needed/` for flagged items
4. Review processing logs for details

**For drafts and work in progress**, use [`00-wip/`](../00-wip/) instead.
