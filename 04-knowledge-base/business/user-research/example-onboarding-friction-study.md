---
title: Onboarding Friction Points - User Research
type: user-research
date: 2025-10-28
last-updated: 2025-11-05
status: active
owner: Lisa Nguyen
stakeholders: [Product, Design, Engineering]
tags: [onboarding, signup, ux-research, usability-testing, mvp]
summary: |
  Usability study with 12 participants identifying key friction points in
  the TaskFlow registration and workspace setup flow. Found that social login
  and guided onboarding reduce drop-off by approximately 45%.
related-docs:
  - ../requirements/example-user-authentication-requirement.md
  - ../../../../02-decisions/2025-11-10-implement-rbac-with-casbin.md
---

# Onboarding Friction Points - User Research

## Research Objective

**Primary Question:**
Where do new users experience friction during TaskFlow's registration and initial workspace setup, and what changes would improve completion rates?

**Hypotheses:**
- Users who encounter a multi-step registration form are more likely to abandon than those with a single-step flow
- Offering social login (Google/GitHub) will significantly reduce time-to-first-workspace
- Users need contextual guidance during workspace setup, not just an empty board

**Success Criteria:**
Identify the top 3 friction points and propose solutions with measurable impact predictions.

---

## Methodology

**Research Method:**
Moderated remote usability testing. Participants were asked to sign up for TaskFlow and create their first project with 3 tasks. Sessions were screen-recorded with think-aloud protocol.

**Participants:**
- **Target Users:** Project managers and team leads at companies with 10-50 employees
- **Sample Size:** 12 participants
- **Recruitment Criteria:** Currently using a project management tool (Trello, Asana, or Jira), manages a team of 3+ people
- **Demographics:** 7 female, 5 male; ages 28-45; industries: tech (5), marketing (4), consulting (3)

**Timeline:**
- Research period: 2025-10-20 to 2025-10-28
- Analysis completed: 2025-11-03

**Tools Used:**
Zoom (recording), Maze (task analysis), Notion (note-taking), Dovetail (coding/analysis)

---

## Key Findings

### Finding 1: Multi-step registration causes 33% drop-off

**Evidence:**
4 of 12 participants (33%) expressed frustration at the 3-step registration form. Two participants said they would "come back later" (a common abandonment signal). Average registration time was 2 minutes 45 seconds - well above our 90-second target.

**Implication:**
Consolidate registration to a single step (email + password + name) and defer workspace setup to a separate guided flow after account creation.

**Severity/Priority:**
High - Directly impacts conversion funnel.

---

### Finding 2: Social login expected by 10 of 12 participants

**Evidence:**
10 participants looked for Google or GitHub login buttons before attempting email registration. 3 participants explicitly said "I'd normally just click Sign in with Google." When told social login wasn't available, 2 participants expressed mild frustration.

**Implication:**
Google and GitHub OAuth should be available at launch. This aligns with our developer and PM target audience who use these services daily.

**Severity/Priority:**
High - Expected table-stakes feature for our target audience.

---

### Finding 3: Empty workspace is disorienting

**Evidence:**
After creating a workspace, 8 of 12 participants paused for 5+ seconds before taking action. 6 participants said some variation of "What do I do now?" The blank board with no sample content or guidance led to confusion about TaskFlow's mental model (boards vs. lists vs. timeline).

**Implication:**
Provide an interactive onboarding checklist or sample project that demonstrates key features. Consider a "Start with a template" option during workspace creation.

**Severity/Priority:**
Medium - Affects activation but not registration conversion.

---

## User Quotes

> "I always use Google sign-in for work tools. If it's not there, I wonder if this is a serious product."
> -- Participant 4, Marketing Manager

> "I created the workspace but... now what? I don't even know if I should make a board or a list or what."
> -- Participant 7, Team Lead

> "Three steps just to make an account? I haven't even done anything yet and I'm already tired."
> -- Participant 11, Project Manager

---

## Recommendations

### Immediate Actions
1. Reduce registration to a single-page form with email, password, and name fields
2. Add Google and GitHub OAuth login buttons prominently on the registration page

### Future Considerations
1. Build an interactive onboarding checklist that guides users through their first project
2. Offer workspace templates ("Software Sprint", "Marketing Campaign", "Client Project") during setup
3. Consider magic link / passwordless login for even lower friction

### Additional Research Needed
- A/B test onboarding checklist vs. sample project vs. video walkthrough
- Quantitative analysis of registration funnel once social login is live

---

## Data & Artifacts

**Raw Data Location:**
Dovetail project: "TaskFlow Onboarding Study Oct 2025"

**Analysis Documents:**
Affinity map and journey map available in Figma: "Onboarding Research Analysis"

**Presentation/Report:**
Stakeholder presentation delivered 2025-11-05 (Google Slides, shared with Product team)

---

## Revision History

| Date | Author | Changes |
|------|--------|---------|
| 2025-10-28 | Lisa Nguyen | Initial research completed |
| 2025-11-05 | Lisa Nguyen | Added recommendations after stakeholder review |
