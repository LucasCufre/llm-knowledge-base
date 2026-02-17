---
title: [System/Issue Name] - Runbook
type: runbook
date: YYYY-MM-DD
last-updated: YYYY-MM-DD
status: active
owner: [Team Name]
stakeholders: [On-call engineers, SRE, DevOps]
tags: [system-name, incident-type, on-call]
summary: |
  Brief 2-3 sentence description of what incident/issue this runbook addresses,
  when to use it, and the expected resolution time.
related-docs:
  - [Link to architecture doc]
  - [Link to monitoring dashboard]
  - [Link to related incidents]
---

# [System/Issue Name] - Runbook

## Incident Overview

**Symptoms:**
[What users/systems experience when this issue occurs]

**Impact:**
- Severity: [Critical/High/Medium/Low]
- Affected users: [Scope of impact]
- Business impact: [Revenue, reputation, compliance]

**Expected Resolution Time:**
[Typical time to resolve - for SLA purposes]

---

## When to Use This Runbook

**Triggers:**
- [Alert condition 1]
- [Alert condition 2]
- [User report pattern]

**Alert Examples:**
```
[Example alert message from monitoring system]
```

---

## Quick Triage

### Is this REALLY the issue?

**Confirm symptoms:**
- [ ] [Check metric/log 1]
- [ ] [Check metric/log 2]
- [ ] [Check system status 1]

**If symptoms don't match:**
[Where to look next or which other runbook to use]

---

## Prerequisites

**Required Access:**
- [System/tool 1] - [Access level]
- [System/tool 2] - [Access level]

**Required Tools:**
- [Tool 1] - [Purpose]
- [Tool 2] - [Purpose]

**Safety Checks BEFORE starting:**
- [ ] [Check 1 - e.g., verify not already being worked on]
- [ ] [Check 2 - e.g., confirm time window is safe for changes]
- [ ] [Check 3 - e.g., backup current state if applicable]

---

## Investigation Steps

### Step 1: Check Logs

**Where to look:**
```bash
# Command to view relevant logs
[command example]
```

**What to look for:**
- [Log pattern 1]
- [Error message pattern]
- [Specific timestamp correlation]

**Example problematic log entry:**
```
[Example log line showing the issue]
```

---

### Step 2: Check Metrics/Monitoring

**Dashboard:**
[Link to monitoring dashboard]

**Key metrics to review:**
- [Metric 1] - Normal range: [value] - Problem indicator: [value]
- [Metric 2] - Normal range: [value] - Problem indicator: [value]

**Commands for checking:**
```bash
# Command to check metric 1
[command]

# Command to check metric 2
[command]
```

---

### Step 3: Check Dependencies

**Upstream dependencies:**
- [Service 1] - How to verify: [command/check]
- [Service 2] - How to verify: [command/check]

**Downstream impacts:**
- [System 1] - How to check: [command/check]
- [System 2] - How to check: [command/check]

---

## Resolution Steps

### Standard Resolution

**Step 1: [Action]**
```bash
# Command or procedure
[detailed command with explanation]
```

**Expected output:**
```
[What you should see if successful]
```

**If this doesn't work:**
[Next step or alternative approach]

---

**Step 2: [Action]**
```bash
# Command or procedure
[detailed command with explanation]
```

**Expected output:**
```
[What you should see if successful]
```

**If this doesn't work:**
[Next step or alternative approach]

---

**Step 3: Verify Resolution**

**Verification steps:**
- [ ] [Check 1 - metric returned to normal]
- [ ] [Check 2 - logs show healthy state]
- [ ] [Check 3 - user-facing functionality works]

**Wait time:**
[How long to wait for verification - e.g., 5 minutes for metrics to stabilize]

---

### Alternative Resolution (If Standard Fails)

**When to use:**
[Conditions indicating standard resolution won't work]

**Steps:**
1. [Alternative step 1]
2. [Alternative step 2]
3. [Alternative step 3]

**Risks:**
[Any risks or side effects of this approach]

---

## Escalation

**When to escalate:**
- Resolution unsuccessful after [X] attempts
- Impact exceeds initial assessment
- Root cause unclear
- [Other escalation criteria]

**Escalation Path:**
1. **Level 1:** [Team/Person] - [Contact method] - [Response SLA]
2. **Level 2:** [Team/Person] - [Contact method] - [Response SLA]
3. **Level 3:** [Team/Person] - [Contact method] - [Response SLA]

**What to include in escalation:**
- Incident ID
- Symptoms observed
- Steps already attempted
- Current system state
- Business impact assessment

---

## Communication

### Internal Communication

**Who to notify:**
- [ ] [Team 1] - [When to notify]
- [ ] [Team 2] - [When to notify]
- [ ] [Leadership] - [When to notify]

**Slack channels:**
- Primary: #[channel-name]
- Incident: #[incident-channel]

---

### External Communication

**When to notify customers:**
[Criteria for customer notification]

**Status page update:**
[When and how to update status page]

**Communication template:**
```
[Template for status update message]
```

---

## Post-Resolution

### Cleanup Tasks

- [ ] [Cleanup task 1]
- [ ] [Cleanup task 2]
- [ ] [Cleanup task 3]

### Monitoring

**Watch for:**
[What to monitor in the hours/days after resolution]

**Duration:**
[How long to maintain heightened monitoring]

---

## Post-Incident Review

**Required for:**
[Severity levels requiring post-incident review]

**Post-incident tasks:**
- [ ] Create incident ticket: [Link to ticket system]
- [ ] Schedule post-mortem: [Within timeframe]
- [ ] Document timeline
- [ ] Identify root cause
- [ ] Create action items for prevention

**Post-mortem template:**
[Link to post-mortem template]

---

## Common Mistakes to Avoid

- ❌ [Common mistake 1] → ✅ [Correct approach]
- ❌ [Common mistake 2] → ✅ [Correct approach]
- ❌ [Common mistake 3] → ✅ [Correct approach]

---

## Related Runbooks

- [Link to related runbook 1]
- [Link to related runbook 2]
- [Link to general troubleshooting guide]

---

## References

- Monitoring Dashboard: [Link]
- Architecture Diagram: [Link]
- Related ADRs: [Links]
- Past Incidents: [Link to incident tracker]

---

## Revision History

| Date | Author | Changes | Incident Reference |
|------|--------|---------|-------------------|
| YYYY-MM-DD | [Name] | Initial runbook | [Incident ID] |
