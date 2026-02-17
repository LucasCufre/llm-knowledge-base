---
description: Generate a TL;DR report for the latest daily standup pair (AM/PM or Frontend/Backend)
---

You are being asked to generate an executive TL;DR summary for the most recent daily standup meetings, organized by team/squad structure.

## Team/Squad Structure

**IMPORTANT:** Customize this section based on your team organization.

Example squad structure (update with your actual team):
- **Squad Alpha**: [Team Member 1, Team Member 2]
- **Squad Beta**: [Team Member 3, Team Member 4]
- **Squad Gamma**: [Team Member 5, Team Member 6]

**Note:** List any team members who participate in multiple squads.

---

## Your Task

Generate a concise, executive-level summary document that captures the essential information from the latest daily standup pair (either AM/PM sessions or Frontend/Backend sessions from the same day), organized by your team structure.

## Steps

### 1. Identify the Latest Standup Pair

Search for the most recent daily standup meetings:

- Check `06-meetings/YYYY-MM/` for the current month
- Look for pairs with matching dates:
  - `YYYY-MM-DD-daily-standup-frontend.md` + `YYYY-MM-DD-daily-standup-backend.md`
  - `YYYY-MM-DD-daily-standup-am.md` + `YYYY-MM-DD-daily-standup-pm.md`
  - OR a single `YYYY-MM-DD-daily-standup.md` if only one exists
- Use the most recent date available

### 2. Read the Standup Documents

Read the full content of both standup meetings (or the single meeting if only one exists).

### 3. Extract Key Information

Map each team member to their squad(s) and organize updates accordingly. For each squad, identify:

**Key Updates (per team member):**

- Most significant progress made (1-2 sentences max per person)
- Focus on completed work and current focus areas
- Filter out minor details or routine tasks

**Blockers:**

- Active blockers preventing progress
- Required resources or decisions needed
- Impact level (High/Medium/Low)

**Action Items:**

- Critical action items with high priority
- Owner assignments
- Due dates

**Cross-Squad Items:**

- Decisions that affect multiple squads
- Dependencies between squads
- Coordination needs

### 4. Synthesize Executive Summary

Write a 2-3 paragraph narrative that answers:

- How is the overall team progressing?
- What are the most critical issues that need leadership attention?
- Were any important decisions or pivots made?
- What does leadership need to know or decide?

### 5. Generate the TL;DR Document

Create the document with this structure:

**File name:** `YYYY-MM-DD-daily-standup-tldr.md`
**Location:** Same month folder as the source standups (e.g., `06-meetings/YYYY-MM/`)

**Important formatting rules:**

- Keep individual updates to 1-2 sentences maximum
- Only include HIGH priority action items in the TL;DR
- Only list blockers that require escalation or cross-team coordination
- Make the executive summary focused on actionable insights
- Link to the full standup documents for details

### 6. Update Metadata

Ensure the frontmatter includes:

- Correct date
- Links to source standup documents in `related-docs`
- Proper tags: `[tldr, daily-standup, executive-summary]`
- Squads represented in the summary

### 7. Report Completion

After creating the TL;DR, provide the user with:

- The file path where it was saved
- A brief overview of key highlights
- Any critical blockers or decisions that need immediate attention

## Example Output Structure

```markdown
---
title: Daily Standup TL;DR - YYYY-MM-DD
type: meeting-note
date: YYYY-MM-DD
last-updated: YYYY-MM-DD
status: active
owner: [Your Name]
stakeholders: [Leadership Team]
tags: [tldr, daily-standup, executive-summary]
summary: |
  Executive summary of daily standup meetings for YYYY-MM-DD,
  organized by squad with key updates, blockers, and action items.
related-docs:
  - [./YYYY-MM-DD-daily-standup-frontend.md]
  - [./YYYY-MM-DD-daily-standup-backend.md]
---

# Daily Standup TL;DR - YYYY-MM-DD

**Generated from:** [Frontend Standup + Backend Standup / AM + PM / Combined]
**Squads Represented:** [List all squads]

---

## Squad Alpha

**Members:** [Member 1, Member 2]

### Key Updates

- **[Member 1]**: [1-2 sentence summary of most important progress]
- **[Member 2]**: [1-2 sentence summary of most important progress]

### Blockers

- [Blocker description] - Owner: [Name] - Impact: [High/Medium/Low]

### Action Items

- [ ] **[Task description]** - Owner: [Name] - Due: YYYY-MM-DD

---

## Squad Beta

**Members:** [Member 3, Member 4]

### Key Updates

- **[Member 3]**: [1-2 sentence summary of most important progress]
- **[Member 4]**: [1-2 sentence summary of most important progress]

### Blockers

- [Blocker description] - Owner: [Name] - Impact: [High/Medium/Low]

### Action Items

- [ ] **[Task description]** - Owner: [Name] - Due: YYYY-MM-DD

---

## Cross-Squad Coordination

### Important Decisions Made

1. **[Decision]** - [Brief context and impact]

### Critical Blockers Requiring Leadership Attention

- **[Blocker]** - Impact: High - Requires: [What's needed]

### Dependencies & Handoffs

- **[Squad A] → [Squad B]**: [Description of dependency]

---

## Executive Summary

[2-3 paragraph narrative synthesizing the key information:
- Overall progress assessment
- Critical blockers requiring escalation
- Important decisions or pivots
- Cross-squad coordination points
- What leadership needs to know or decide]

---

## Links to Full Standups

- [Standup Document 1](./path-to-standup-1.md)
- [Standup Document 2](./path-to-standup-2.md)
```

## Quality Standards

The TL;DR should:

- Be readable in under 3 minutes
- Focus on executive-level insights, not implementation details
- Highlight blockers that need escalation
- Make cross-squad dependencies visible
- Provide context for decision-making
- Link to full standups for details

## Best Practices

- **Be ruthless with brevity**: If it's not critical, leave it out
- **Highlight blockers early**: Make them impossible to miss
- **Show team velocity**: Are things moving forward?
- **Surface decisions**: What changed that affects the project?
- **Maintain objectivity**: Report facts, not opinions
- **Preserve urgency levels**: Don't downplay critical issues

---

Now generate the TL;DR for the most recent standup pair.
