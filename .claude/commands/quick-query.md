---
description: Quick factual lookup without comprehensive research
---

You are being asked to quickly find a specific fact or piece of information.

This is a **lightweight version** of `/query` for simple factual lookups. Use this for:
- Quick status checks
- Simple fact retrieval
- Specific field values
- Direct document lookups

For complex questions requiring research across multiple documents, use `/query` instead.

## Your Task

1. **Identify the specific information** being requested
2. **Search likely locations** based on question type
3. **Return the answer** with a single source citation
4. **Keep it brief** - no comprehensive analysis needed

## Quick Search Strategy

### For Status Questions
→ Check `03-active-work/_current-status.md` first

### For Recent Decisions
→ Check `02-decisions/_decisions-index.md` and recent ADRs

### For Definitions/Terms
→ Check `01-foundation/glossary.md`

### For Feature Details
→ Check `04-knowledge-base/business/requirements/`

### For Technical Specs
→ Check `04-knowledge-base/technical/`

### For Process Info
→ Check `04-knowledge-base/operational/processes/`

## Answer Format

Keep it simple:

```
**Answer:** [Direct answer to the question]

**Source:** [path/to/document.md]
```

If you can't find it quickly:

```
**Answer:** Not found in a quick search.

**Suggestion:** Use `/query [your question]` for a comprehensive search.
```

## Question

{QUESTION}

---

**Provide a quick answer with minimal research.**
