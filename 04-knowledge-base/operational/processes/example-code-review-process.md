---
title: Code Review Process
type: process
date: 2025-11-08
last-updated: 2025-11-08
status: active
owner: Maria Chen
stakeholders: [Engineering Team]
tags: [process, code-review, pull-request, engineering, quality]
summary: |
  Defines the code review process for TaskFlow including PR requirements,
  review expectations, approval criteria, and merge rules.
  Aims for reviews completed within 4 business hours.
related-docs:
  - ../../../02-decisions/2025-11-03-adopt-postgresql-as-primary-database.md
  - ../../technical/infrastructure/example-deployment-pipeline.md
---

# Code Review Process

## Purpose

**What:**
A structured process for reviewing all code changes before they are merged to the main branch.

**Why:**
Catches bugs early, maintains code quality and consistency, spreads knowledge across the team, and ensures security best practices are followed.

**When:**
Every pull request targeting `main`. No exceptions for "small changes."

**Who:**
- **Author:** The engineer who wrote the code
- **Reviewer:** At least one other engineer (two required for security-sensitive changes)

---

## Prerequisites

**Required Access/Permissions:**
- GitHub repository write access
- Familiarity with the project's coding standards (ESLint config, Prettier config)

**Required Knowledge:**
- Understanding of the feature or area being changed
- Awareness of project architecture (see System Architecture Overview)

---

## Process Steps

### Step 1: Author Prepares the PR

**Objective:**
Create a reviewable PR with enough context for the reviewer to understand the change.

**Actions:**
1. Create a feature branch from `main`: `feature/TASK-{id}-short-description`
2. Make changes in small, focused commits
3. Run `npm run lint && npm run test` locally before pushing
4. Open PR using the PR template (fills automatically from `.github/PULL_REQUEST_TEMPLATE.md`)
5. Fill in: Summary, Changes Made, Testing Done, Screenshots (if UI)
6. Self-review the diff before requesting review - catch obvious issues yourself
7. Request review from at least one teammate

**Expected Outcome:**
PR is open with clear description, passing CI, and ready for review.

**Common Issues:**
- PR is too large (> 400 lines) - Split into smaller, reviewable chunks. Large PRs get slower, lower-quality reviews.

---

### Step 2: Reviewer Reviews the Code

**Objective:**
Provide constructive, thorough feedback within 4 business hours.

**Actions:**
1. Read the PR description and linked task to understand the context
2. Review the code changes, focusing on:
   - **Correctness:** Does the code do what the task requires?
   - **Security:** Any SQL injection, XSS, or auth bypass risks?
   - **Performance:** Any N+1 queries, missing indexes, or unnecessary computation?
   - **Readability:** Is the code clear? Would you understand it in 6 months?
   - **Tests:** Are edge cases covered? Are tests meaningful (not just for coverage)?
3. Leave comments: use "suggestion" for minor style issues, "comment" for questions, "request changes" for blocking issues
4. Approve or request changes

**Expected Outcome:**
Author receives actionable feedback. Blocker issues are clearly marked.

**Common Issues:**
- Nitpicking style issues that linters should catch - Trust the linter. Only comment on style if it affects readability and isn't covered by ESLint/Prettier.

---

### Step 3: Author Addresses Feedback

**Objective:**
Resolve all review comments and get approval.

**Actions:**
1. Address each comment: fix the code, reply with explanation, or discuss if you disagree
2. Push fixes as new commits (do not force-push during review - it makes re-reviewing harder)
3. Re-request review after addressing all comments
4. Resolve comment threads as you address them

**Expected Outcome:**
All threads resolved, reviewer approves.

---

### Step 4: Merge

**Objective:**
Get the code to `main` safely.

**Actions:**
1. Ensure CI is green (lint + test + build all passing)
2. Squash and merge via GitHub (single commit on main for clean history)
3. Delete the feature branch after merge
4. Verify the change deploys successfully to staging (automatic via CI)

**Expected Outcome:**
Code is on `main`, deployed to staging, feature branch cleaned up.

---

## Review SLAs

| PR Size | Review Target | Escalation |
|---------|---------------|------------|
| Small (< 100 lines) | 2 hours | Ping in Slack after 4 hours |
| Medium (100-400 lines) | 4 hours | Ping in Slack after 6 hours |
| Large (> 400 lines) | Should be split | Tech Lead reviews if split not feasible |

---

## Security-Sensitive Changes

Changes to authentication, authorization, payment processing, or data handling require **two reviewers**, one of whom must be the Tech Lead or a designated security reviewer.

Examples:
- Any changes to `src/auth/*`
- Database migration adding/modifying user data columns
- New API endpoints that accept user input
- Changes to Casbin policies

---

## Revision History

| Date | Author | Changes |
|------|--------|---------|
| 2025-11-08 | Maria Chen | Initial process documentation |
