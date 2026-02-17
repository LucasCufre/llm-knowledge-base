# Work In Progress (WIP)

This folder contains documents that are currently being drafted, edited, or reviewed before they're ready for automated processing.

## Purpose

Use this folder for:

- **Draft documents** - New content being written or refined
- **Documents under review** - Content waiting for stakeholder approval
- **Multi-stage documents** - Complex documents being built incrementally
- **Content requiring manual editing** - Documents that need human touch before automation

## Workflow

1. **Create/Edit** - Place draft documents here while working on them
2. **Review/Refine** - Iterate on the content until it's complete
3. **Move to Inbox** - When finished, move the document to `00-inbox/` for automated processing

## Important Notes

- Documents in this folder are **NOT automatically processed**
- This is a **staging area** for human-created content
- Once a document is complete and ready for structured processing, move it to `00-inbox/`
- The automated maintenance system will then detect, process, and organize it appropriately

## Example Use Cases

### Drafting a Product Requirements Document
1. Create `feature-spec-draft.md` in `00-wip/`
2. Write and refine the content over multiple sessions
3. Once complete, move to `00-inbox/feature-spec.md`
4. Run `/maintenance` to process it into structured format

### Preparing Meeting Notes
1. Start notes in `00-wip/team-sync-notes.md`
2. Add details during/after the meeting
3. Clean up and finalize
4. Move to `00-inbox/team-sync-2026-02-16.md`
5. Automated processing extracts decisions, action items, etc.

### Working on Research Documents
1. Gather research in `00-wip/competitive-analysis.md`
2. Add findings incrementally
3. Review and structure the content
4. Move to `00-inbox/` when ready for final processing

## Tips

- Keep filenames descriptive but not final - you can rename when moving to inbox
- Use markdown format for best processing results
- Don't worry about metadata here - it will be added during processing
- This folder can have subfolders if you need to organize multiple WIP items

---

**Next Step:** When your document is complete, move it to [`00-inbox/`](../00-inbox/) for automated processing.
