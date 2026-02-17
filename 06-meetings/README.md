# Meeting Notes - How to Use

## Purpose
Document important meetings to preserve context, decisions, and action items.

## What to Document
- Sprint planning and reviews
- Architecture discussions
- Stakeholder meetings
- Retrospectives
- Design reviews
- Major decision meetings

## What NOT to Document
- Daily stand-ups (unless significant)
- 1:1s (private)
- Routine check-ins without outcomes

## How to Create Meeting Notes

1. **Copy the template:**
   ```bash
   cp _template-meeting.md YYYY-MM/YYYY-MM-DD-meeting-title.md
   ```

2. **Create month folder if needed:**
   ```bash
   mkdir -p YYYY-MM
   ```

3. **Fill out the template** within 24 hours of the meeting

4. **Extract key items:**
   - Create ADRs for significant decisions
   - Add blockers to [blockers-and-risks.md](../03-active-work/blockers-and-risks.md)
   - Track action items in project management tool

5. **Update the index:**
   - Add to [_meetings-index.md](_meetings-index.md)

## Template Sections

- **Header:** Date, time, attendees, facilitator
- **Agenda:** What was planned to discuss
- **Discussion Points:** What was actually discussed
- **Decisions Made:** Any decisions (link to ADRs for significant ones)
- **Action Items:** Who's doing what by when
- **Blockers:** Any impediments identified
- **Next Steps:** What happens next

## Best Practices

- **Be Concise:** Capture essence, not transcript
- **Be Actionable:** Clear action items with owners and dates
- **Be Linked:** Reference related documents
- **Be Timely:** Document within 24 hours while fresh

## Related
- [Template](_template-meeting.md)
- [Index](_meetings-index.md)
- [Decisions](../02-decisions/)
