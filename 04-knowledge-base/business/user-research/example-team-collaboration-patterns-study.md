---
title: Team Collaboration Patterns - User Research
type: user-research
date: 2025-11-08
last-updated: 2025-11-08
status: active
owner: Lisa Nguyen
stakeholders: [Product, Design, Engineering]
tags: [collaboration, real-time, workflows, user-interviews, tasks]
summary: |
  Interview study with 8 team leads exploring how small teams coordinate
  task work. Found that real-time visibility and @mentions are the most
  requested collaboration features, while notification fatigue is a key concern.
related-docs:
  - ../requirements/example-real-time-task-collaboration-requirement.md
  - ../../../../05-research/example-authorization-framework-comparison.md
---

# Team Collaboration Patterns - User Research

## Research Objective

**Primary Question:**
How do small teams (5-15 people) currently coordinate task assignments, status updates, and handoffs, and what collaboration features would most improve their workflow?

**Hypotheses:**
- Teams rely heavily on chat tools (Slack/Teams) for task coordination because their PM tool lacks real-time updates
- Task handoff failures (misassignment, duplicate work) are a top pain point
- Users want presence awareness but are wary of surveillance-like features

**Success Criteria:**
Identify the top 3 collaboration features to prioritize and understand user expectations for real-time behavior.

---

## Methodology

**Research Method:**
Semi-structured remote interviews (45 minutes each). Participants described their current workflow, showed their tool setup (screen share), and reacted to mockups of proposed real-time features.

**Participants:**
- **Target Users:** Team leads managing 5-15 person teams using task management tools
- **Sample Size:** 8 participants
- **Recruitment Criteria:** Uses a PM tool daily, leads cross-functional or single-discipline team, team size 5-15
- **Demographics:** 5 male, 3 female; ages 30-42; industries: SaaS (3), agency (3), fintech (2)

**Timeline:**
- Research period: 2025-11-01 to 2025-11-08
- Analysis completed: 2025-11-08

**Tools Used:**
Zoom (recording), Dovetail (transcription and coding)

---

## Key Findings

### Finding 1: Teams use Slack as a "real-time bridge" for their PM tool

**Evidence:**
7 of 8 participants reported posting task links in Slack to notify teammates of changes. "I update the task in Asana, then I go to Slack and say 'hey, I moved this to your column.'" Average: 12 Slack messages per day related to task coordination that could be eliminated with real-time updates.

**Implication:**
Real-time task updates with in-app notifications would directly reduce context-switching between PM tool and chat. This is a strong differentiator opportunity.

**Severity/Priority:**
High - Core value proposition for TaskFlow.

---

### Finding 2: Presence indicators welcomed, but only at the task level

**Evidence:**
6 of 8 participants reacted positively to seeing who is currently viewing a specific task. However, 5 of 8 reacted negatively to a "currently online" indicator at the workspace level, calling it "creepy" or "micromanagement-y." The distinction is important: task-level presence helps coordination, workspace-level presence feels like surveillance.

**Implication:**
Implement presence indicators on task detail views and board cards only. Do not show a general "online users" sidebar or status indicator. This matches the collaborative intent without triggering surveillance concerns.

**Severity/Priority:**
High - Design decision that affects trust and adoption.

---

### Finding 3: Notification fatigue is the #1 collaboration concern

**Evidence:**
All 8 participants mentioned notification overload as a problem with their current tools. "I turned off all Jira notifications because it was drowning out important stuff." Participants want to be notified about: direct @mentions, task assignments to them, and status changes on tasks they own. They do NOT want: all activity in a project, comments on tasks they once viewed, or system/admin notifications.

**Implication:**
Default notification settings should be conservative (only @mentions and direct assignments). Provide granular controls for power users. Use in-app activity feeds for lower-priority updates rather than push/email notifications.

**Severity/Priority:**
Medium - Important for retention but can be iterated on post-launch.

---

## User Quotes

> "I basically use Slack as the notification system for Asana. If TaskFlow just did that automatically, I'd switch tomorrow."
> -- Participant 2, Engineering Lead

> "Seeing who's looking at a task? Yes, love it. Seeing who's online in the workspace? No, that's weird."
> -- Participant 5, Design Lead

> "The number one thing that makes me hate a PM tool is when it spams me with notifications about things I don't care about."
> -- Participant 8, Product Manager

---

## Recommendations

### Immediate Actions
1. Prioritize real-time task updates (status changes, assignments, comments) as the core collaboration feature
2. Implement task-level presence indicators only; explicitly avoid workspace-level "online" status

### Future Considerations
1. Build granular notification preferences with conservative defaults
2. Explore Slack/Teams integration that syncs task updates to channels (replacing manual posting)
3. Consider @mention functionality in task comments as a high-priority v1 feature

### Additional Research Needed
- Quantitative survey to validate notification preference findings with larger sample
- Competitive analysis of real-time features across Asana, Linear, and ClickUp

---

## Data & Artifacts

**Raw Data Location:**
Dovetail project: "Collaboration Patterns Study Nov 2025"

**Analysis Documents:**
Interview coding and theme analysis in Dovetail

**Presentation/Report:**
Summary shared with Product and Engineering leads 2025-11-08

---

## Revision History

| Date | Author | Changes |
|------|--------|---------|
| 2025-11-08 | Lisa Nguyen | Initial research completed |
