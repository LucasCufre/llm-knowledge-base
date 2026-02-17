# Decision Records - How to Use

This directory contains Architecture Decision Records (ADRs) and other significant project decisions.

## What Goes Here?

Document decisions that:
- Have lasting impact on the project
- Affect architecture, technology choices, or design patterns
- Influence multiple teams or systems
- Set precedents for future work
- Are difficult or expensive to reverse
- Stakeholders need to understand

## What Doesn't Go Here?

Don't create ADRs for:
- Routine implementation details
- Temporary workarounds
- Decisions easily reversed
- Personal coding style preferences (unless team standard)
- Obvious choices with no alternatives

## How to Create a New Decision Record

### Step 1: Copy the Template
```bash
cp _template-decision.md YYYY-MM-DD-decision-title.md
```

Use today's date and a brief, descriptive title in lowercase-with-hyphens.

### Step 2: Assign an ADR Number
Check [_decisions-index.md](_decisions-index.md) for the next available ID in the appropriate range:
- 001-099: Architecture
- 100-199: Technical implementation
- 200-299: Business/product
- 300-399: Process/operational
- 400-499: Security/compliance
- 500-599: Infrastructure/DevOps

### Step 3: Fill Out the Template

#### Title
Make it descriptive and action-oriented:
- Good: "Use PostgreSQL for Primary Database"
- Bad: "Database Decision"

#### Context and Problem Statement
Explain:
- What situation led to this decision
- What problem you're solving
- Why this needs a decision now
- Relevant background information

#### Decision
State clearly what you decided to do. Be specific.

#### Rationale
Explain WHY you made this choice:
- What factors were most important
- What constraints influenced the decision
- What data or research informed it
- Who was consulted

#### Consequences
Be honest about tradeoffs:
- **Positive:** What benefits does this bring?
- **Negative:** What are the downsides or costs?
- **Neutral:** What other implications exist?

#### Alternatives Considered
For each alternative:
- Describe it clearly
- List pros and cons
- Explain why it was rejected

Include at least 2-3 alternatives to show you considered options.

#### Implementation Notes
Practical guidance:
- How to implement this decision
- What needs to change
- Any gotchas or special considerations
- Timeline or phasing if applicable

#### References
Link to:
- Related ADRs
- Technical documentation
- Research or data
- External resources
- Prototypes or POCs

### Step 4: Review and Approval

1. **Draft Status:** Create the document with `status: proposed`
2. **Share for Review:** Share with relevant stakeholders
3. **Incorporate Feedback:** Update based on discussions
4. **Get Approval:** Obtain approval from decision maker
5. **Update Status:** Change to `status: accepted` or `status: rejected`
6. **Communicate:** Share the decision with affected teams

### Step 5: Update the Index

Add your decision to [_decisions-index.md](_decisions-index.md):
- Add to appropriate category table
- Update statistics
- Update next available ID
- Add to "Recent Decisions" if within last 30 days

### Step 6: Cross-Reference

Link to your decision from:
- Related technical documentation
- Relevant meeting notes
- Project status updates
- Other related decisions

## Decision Statuses

### Proposed
Decision is under consideration but not yet approved.
- Still gathering input
- Actively being discussed
- May change based on feedback

### Accepted
Decision is approved and should be implemented.
- This is the current direction
- Teams should follow this decision
- Implementation should proceed

### Rejected
Decision was considered but not approved.
- Keep the record for historical context
- Explains why this approach wasn't chosen
- Helps avoid revisiting the same question

### Superseded
Decision has been replaced by a newer decision.
- Update the `supersedes` field in the new decision
- Link to the replacement decision
- Move to "Superseded Decisions" in index
- Keep for historical reference

### Deprecated
Decision is no longer recommended but not fully replaced.
- Use when phasing out gradually
- Indicates direction is changing
- Eventually may become superseded

## Best Practices

### Be Concise
- Focus on the decision and its rationale
- Don't include unnecessary background
- Link to detailed docs rather than duplicating

### Be Specific
- Vague: "Use a database"
- Specific: "Use PostgreSQL 14+ with TimescaleDB extension for time-series data"

### Be Honest
- Document the real tradeoffs
- Don't oversell the chosen option
- Acknowledge limitations and costs

### Update When Needed
If circumstances change:
1. Don't delete or heavily edit the original
2. Add to "Revision History"
3. If fundamentally changing, create a new ADR that supersedes it

### Link Generously
- Reference related decisions
- Link to implementation
- Connect to affected documentation
- Build a web of knowledge

## Examples of Good Decision Titles

- "Use React with TypeScript for Frontend Development"
- "Implement Event Sourcing for Order Processing"
- "Choose Kubernetes over AWS ECS for Container Orchestration"
- "Require Code Review Approval Before Merging"
- "Use Semantic Versioning for API Releases"

## Examples of Poor Decision Titles

- "Frontend Framework" (not specific)
- "Database" (not specific)
- "The Best Approach" (subjective, unclear)
- "What We're Doing" (vague)

## Common Mistakes to Avoid

1. **Too Late:** Don't document after implementation. Write the ADR when making the decision.

2. **Too Vague:** Be specific about what you decided and why.

3. **No Alternatives:** Always show you considered other options.

4. **Missing Context:** Future readers won't have your current knowledge. Provide context.

5. **Forgetting to Update Index:** Keep the index current.

6. **No Cross-References:** Link to and from related documents.

7. **Treating as Immutable:** Update when you learn new information.

## When to Revisit a Decision

Revisit decisions when:
- New information emerges
- Assumptions prove wrong
- Technology landscape changes significantly
- Business requirements shift
- Performance or scale needs change
- Better alternatives become available

Don't constantly second-guess accepted decisions, but do remain open to new information.

## Questions?

If you're unsure whether something needs an ADR, ask:
- Will this decision affect others?
- Will future team members need to understand why we did this?
- Is this decision hard to reverse?
- Are there meaningful alternatives?

If you answered yes to any of these, write an ADR.

---

**Template:** [_template-decision.md](_template-decision.md)
**Index:** [_decisions-index.md](_decisions-index.md)
**Guidance:** [.claude/instructions.md](../.claude/instructions.md)
