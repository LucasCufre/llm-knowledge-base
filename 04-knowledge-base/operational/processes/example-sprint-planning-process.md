---
title: Sprint Planning Process
type: process
date: 2025-11-05
last-updated: 2025-11-05
status: active
owner: Sarah Kim
stakeholders: [Engineering Team, Product, Design]
tags: [process, sprint, planning, agile, weekly]
summary: |
  Defines the weekly sprint planning process for the TaskFlow team.
  Covers preparation, ceremony structure, capacity planning,
  and output expectations.
related-docs:
  - ../../../03-active-work/priorities.md
  - ../runbooks/example-production-incident-response-runbook.md
---

# Sprint Planning Process

## Purpose

**What:**
A structured weekly ceremony where the team reviews upcoming work, estimates effort, and commits to a sprint goal for the next week.

**Why:**
Ensures the team has a shared understanding of priorities, avoids context-switching from unclear priorities, and creates accountability for delivery commitments.

**When:**
Every Monday at 10:00 AM ET. Duration: 60 minutes maximum.

**Who:**
- **Required:** Product Manager (Sarah), Tech Lead (Maria), all engineers
- **Optional:** Design Lead (Lisa), for sprints with significant UI work

---

## Prerequisites

**Required Access/Permissions:**
- TaskFlow project board (Member role or above)
- Team calendar for availability/PTO check

**Required Knowledge:**
- Current sprint velocity (average tasks completed per sprint)
- Team capacity for the upcoming week (account for PTO, on-call rotation)

**Required Tools:**
- TaskFlow board (our own product)
- Zoom (remote participants)

---

## Process Steps

### Step 1: Review Previous Sprint (10 minutes)

**Objective:**
Understand what was completed, what carried over, and why.

**Actions:**
1. Product Manager shares previous sprint metrics: planned vs. completed tasks
2. Team briefly discusses any tasks that carried over - identify if they were blocked, underestimated, or deprioritized
3. Tech Lead flags any technical debt items that emerged

**Expected Outcome:**
Shared understanding of last sprint's results and any adjustments needed.

**Common Issues:**
- Sprint review takes too long - Timebox strictly to 10 minutes, move deep-dives to separate meetings

---

### Step 2: Present Prioritized Backlog (15 minutes)

**Objective:**
Product Manager presents the top-priority items for the upcoming sprint.

**Actions:**
1. Product Manager presents 8-12 candidate tasks from the prioritized backlog
2. For each task: state the user value, acceptance criteria, and any dependencies
3. Team asks clarifying questions (this is NOT the estimation step)

**Expected Outcome:**
Team understands what could be worked on and why each item matters.

**Common Issues:**
- Tasks are too vague - Push back and ask PM to clarify before the meeting. Do not estimate vague tasks.

---

### Step 3: Estimate and Commit (25 minutes)

**Objective:**
Team estimates effort and selects tasks that fit within sprint capacity.

**Actions:**
1. Tech Lead announces available capacity (total person-days minus PTO, on-call, meetings)
2. For each candidate task: quick round of T-shirt sizing (S/M/L) from engineers
3. Discussion on any sizing disagreements (if gap > 1 size, discuss briefly)
4. Select tasks that fit capacity, leaving 20% buffer for unplanned work
5. Assign owners to each task

**Expected Outcome:**
Sprint backlog finalized with owners and estimates. Sprint goal articulated in one sentence.

**Common Issues:**
- Over-commitment - Enforce the 20% buffer rule. It's better to finish early than carry over

---

### Step 4: Document and Communicate (10 minutes)

**Objective:**
Record the sprint plan and communicate to stakeholders.

**Actions:**
1. Tech Lead updates the TaskFlow board with sprint assignments
2. Product Manager writes a one-sentence sprint goal
3. Product Manager posts sprint summary to #team-updates Slack channel

**Expected Outcome:**
Sprint plan is visible to the entire organization.

---

## Verification & Validation

**How to verify the process completed successfully:**
- [ ] Sprint board is updated with all committed tasks
- [ ] Each task has an owner and size estimate
- [ ] Sprint goal is documented and shared
- [ ] Capacity calculation accounts for known PTO and on-call

**Success Criteria:**
Team can articulate the sprint goal and knows what they're working on Monday afternoon.

---

## Roles & Responsibilities

| Role | Responsibilities | Contact |
|------|-----------------|---------|
| Product Manager | Prioritize backlog, present tasks, write sprint goal | Sarah Kim |
| Tech Lead | Capacity planning, facilitate estimation, update board | Maria Chen |
| Engineers | Estimate effort, commit to tasks, raise concerns | Team |

---

## Revision History

| Date | Author | Changes |
|------|--------|---------|
| 2025-11-05 | Sarah Kim | Initial process documentation |
