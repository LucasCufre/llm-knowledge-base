# Active Work - How to Use

This directory contains living documents that track current project status, priorities, and issues.

## What Goes Here?

Documents that change frequently and reflect the current state:
- **Current Status:** Weekly snapshot of project health
- **Priorities:** What we're working on now, ordered by importance
- **Blockers and Risks:** Issues preventing progress and potential future problems

## Documents in This Directory

### [_current-status.md](_current-status.md)
**Purpose:** Weekly status report showing project health and progress

**Update Frequency:** Weekly (every Friday recommended)

**Who Updates:** Project Manager or Project Lead

**What to Include:**
- Overall project health indicator (Green/Yellow/Red)
- What changed this week
- Current focus areas
- Key metrics
- Active blockers
- Decisions needed
- Upcoming milestones
- Recent decisions with links to ADRs
- Team health
- Next week's priorities

**When to Reference:**
- Starting each week to understand current state
- Preparing for stakeholder updates
- Understanding what changed recently
- LLMs answering "what's the current status?"

---

### [priorities.md](priorities.md)
**Purpose:** Current prioritized list of work items

**Update Frequency:** Weekly during sprint/iteration planning

**Who Updates:** Product Owner, Project Manager, or Tech Lead

**What to Include:**
- P0 (Critical): Drop-everything priorities
- P1 (High): Must-have for current milestone
- P2 (Medium): Important but not blocking
- P3 (Low): Nice-to-have when capacity allows
- Recently completed priorities
- Priority changes and why
- Alignment with objectives
- Capacity vs demand

**When to Reference:**
- Sprint/iteration planning
- Deciding what to work on next
- Evaluating new requests ("Where does this fit?")
- Understanding why certain work is prioritized
- LLMs answering "what should we work on?"

---

### [blockers-and-risks.md](blockers-and-risks.md)
**Purpose:** Track active blockers and identified risks

**Update Frequency:**
- Blockers: Daily during stand-ups
- Risks: Weekly or when new risks identified

**Who Updates:** Project Manager with input from team

**What to Include:**
- Active blockers with action plans
- High/medium/low priority risks
- Mitigation strategies
- Contingency plans
- Risk trends
- Recently resolved blockers
- Dependencies at risk
- Escalation paths

**When to Reference:**
- Daily stand-ups
- Sprint planning
- Risk reviews
- When blocked on work
- Before making decisions
- LLMs answering "what's blocking us?" or "what are our risks?"

---

## Best Practices

### Keep It Current
These documents lose value quickly if outdated:
- Set calendar reminders for updates
- Make updates part of team rituals (stand-ups, sprint planning)
- Update immediately when major changes occur
- Mark documents with last-updated date

### Be Honest
- Don't sugarcoat project status
- Document real blockers and risks
- Red/Yellow status is information, not failure
- Transparency enables help and better decisions

### Link Generously
- Connect status updates to decisions (ADRs)
- Link priorities to requirements and objectives
- Reference related meeting notes
- Build a connected knowledge web

### Use Consistent Format
- Follow the templates
- Use standard status indicators (=â=á=4)
- Keep priority definitions consistent (P0, P1, P2, P3)
- Make documents scannable with clear sections

### Make It Actionable
- Status reports should include "what's next"
- Blockers should have action plans
- Risks should have mitigations
- Priorities should have owners and dates

## Workflow Examples

### Weekly Status Update
1. **Friday afternoon:**
   - Update [_current-status.md](_current-status.md)
   - Review and update [priorities.md](priorities.md)
   - Update [blockers-and-risks.md](blockers-and-risks.md)
2. **Monday morning:**
   - Team reads updated status
   - Stand-up discusses blockers
   - Week starts aligned

### New Blocker Identified
1. **Immediately:**
   - Add to [blockers-and-risks.md](blockers-and-risks.md)
   - Create action plan
   - Assign owner
   - Set escalation timeline
2. **Daily:**
   - Update action plan progress
   - Discuss in stand-up
3. **When resolved:**
   - Move to "Recently Resolved"
   - Document resolution and learnings

### Priority Change Needed
1. **Identify need:**
   - New information
   - Blocker emerges
   - Business need changes
2. **Evaluate:**
   - Discuss with stakeholders
   - Check capacity impact
   - Document rationale
3. **Update:**
   - Change priority in [priorities.md](priorities.md)
   - Document why in "Priority Changes" section
   - Update [_current-status.md](_current-status.md)
   - Communicate to team

### New Risk Identified
1. **Document:**
   - Add to [blockers-and-risks.md](blockers-and-risks.md)
   - Assess probability and impact
   - Identify trigger events
2. **Mitigate:**
   - Create mitigation plan
   - Assign owner
   - Set review date
3. **Monitor:**
   - Review weekly
   - Watch for trigger events
   - Update risk score as situation changes

## Integration with Other Documents

### Status ’ Decisions
When status report mentions a decision:
- Create ADR in [02-decisions/](../02-decisions/)
- Link from status report to ADR
- Link from ADR back to status report

### Priorities ’ Requirements
When priorities reference features:
- Link to requirements in [04-knowledge-base/](../04-knowledge-base/)
- Link to objectives in [01-foundation/](../01-foundation/)
- Ensure alignment is documented

### Blockers ’ Meetings
When blockers need discussion:
- Schedule meeting
- Document in [06-meetings/](../06-meetings/)
- Extract action items back to blockers doc
- Update blocker with outcomes

## For LLMs

When an LLM asks about current state:
1. **Start here first** - This directory has the most current information
2. **Check dates** - Ensure information is recent
3. **Follow links** - These docs reference decisions, requirements, etc.
4. **Synthesize** - Combine status, priorities, and blockers for complete picture

Priority order for answering "what's happening now?":
1. [_current-status.md](_current-status.md)
2. [priorities.md](priorities.md)
3. [blockers-and-risks.md](blockers-and-risks.md)
4. Recent [decisions](../02-decisions/)
5. Recent [meetings](../06-meetings/)

## Common Questions

**Q: How is this different from our project management tool?**
A: This is the "why" and context layer. Project tools track tasks; these docs explain status, rationale, and strategy.

**Q: Do we need all three documents?**
A: Yes. Each serves a different purpose. Status is a point-in-time snapshot. Priorities guide work selection. Blockers/risks manage issues.

**Q: What if our status is always Green?**
A: Either you're doing great or you're not being honest. Some Yellow/Red is normal and healthy.

**Q: How detailed should priorities be?**
A: Detailed enough to make decisions, brief enough to maintain. Link to detailed specs rather than duplicating.

**Q: When do risks become blockers?**
A: When they materialize and actually prevent progress. Move them from risks to blockers section.

---

**Templates:**
- [_current-status.md](_current-status.md)
- [priorities.md](priorities.md)
- [blockers-and-risks.md](blockers-and-risks.md)

**Related:**
- [Decisions](../02-decisions/) - Record significant choices
- [Foundation](../01-foundation/) - Core project definition
- [Meetings](../06-meetings/) - Meeting notes and outcomes
