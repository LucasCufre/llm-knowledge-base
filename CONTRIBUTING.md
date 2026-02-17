# Contributing to Project Knowledge Base

Thank you for your interest in contributing to this LLM-optimized knowledge management system! This document provides guidelines for contributing.

## How to Contribute

### Reporting Issues

- **Documentation Bugs**: Typos, broken links, unclear instructions
- **Feature Requests**: New templates, automation improvements, structural enhancements
- **Questions**: How-to questions, clarification requests

Please use GitHub Issues and provide:
- Clear description of the issue/request
- Steps to reproduce (for bugs)
- Expected vs. actual behavior
- Your use case (for feature requests)

### Submitting Changes

1. **Fork the repository**
2. **Create a feature branch** from `main`:
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. **Make your changes** following our standards (see below)
4. **Test thoroughly** - ensure all links work, metadata is valid
5. **Commit with clear messages**:
   ```bash
   git commit -m "Add: New template for X"
   git commit -m "Fix: Broken link in Y"
   git commit -m "Docs: Clarify Z process"
   ```
6. **Push to your fork**:
   ```bash
   git push origin feature/your-feature-name
   ```
7. **Open a Pull Request** with:
   - Clear title and description
   - Link to related issues
   - Screenshots (if UI/structure changes)
   - Checklist of what was changed

## Contribution Standards

### File Naming
- Use lowercase with hyphens: `my-document-name.md`
- Date prefix for chronological items: `YYYY-MM-DD-title.md`
- Underscore prefix for special files: `_index.md`, `_template.md`

### Document Structure
Every document should have:

```yaml
---
title: Descriptive Title
type: [appropriate-type]
date: YYYY-MM-DD
last-updated: YYYY-MM-DD
status: [active | draft | archived]
owner: [Role or placeholder like "Product Manager"]
tags: [relevant, keywords]
summary: |
  Clear 2-3 sentence description
related-docs:
  - [../path/to/related.md]
---
```

### Metadata Guidelines
- **No personal information**: Use role placeholders like `[Product Manager]`, not actual names
- **Keep dates current**: Update `last-updated` when modifying
- **Use meaningful tags**: Help with discovery
- **Write clear summaries**: Enable quick scanning
- **Link related docs**: Build the knowledge graph

### Templates
When creating new templates:
- Follow existing template patterns
- Include comprehensive YAML frontmatter
- Add inline comments explaining sections
- Provide examples where helpful
- Add to appropriate README

### Slash Commands
When contributing slash commands (`.claude/commands/`):
- Follow the YAML frontmatter structure
- Write clear descriptions
- Test with Claude Code
- Document any dependencies
- Add usage examples

### Testing Your Changes

Before submitting:

1. **Validate Markdown**: Ensure proper formatting

2. **Check Metadata**: All required fields present
   ```bash
   # Search for documents missing required metadata
   grep -L "^title:" **/*.md
   ```

3. **Test Links**: All internal links work
   ```bash
   # Manually verify cross-references work
   ```

4. **Review Indexes**: Update any affected index files

## What We're Looking For

### High-Priority Contributions
- **New templates** for common document types
- **Improved automation** for processing and maintenance
- **Better examples** showing real-world usage
- **Documentation clarity** improvements
- **Bug fixes** for broken links, invalid metadata
- **Index improvements** for better navigation

### Medium-Priority Contributions
- **New slash commands** for common workflows
- **Structure refinements** based on usage experience
- **Cross-tool compatibility** enhancements
- **Accessibility improvements**

### Please Avoid
- Adding organization-specific content (use as examples only)
- Overly complex automation that's hard to maintain
- Breaking changes without discussion
- Personal information or credentials
- Large binary files

## Community Guidelines

- **Be respectful** and constructive
- **Assume good intent** from others
- **Focus on the system**, not individuals
- **Help others** learn and improve
- **Document your reasoning** for significant changes

## Questions?

- **General questions**: Open a Discussion on GitHub
- **Bug reports**: Open an Issue
- **Feature ideas**: Open an Issue with the "enhancement" label
- **Security concerns**: Email [security contact]

## Recognition

Contributors will be recognized in:
- GitHub contributor list
- Release notes for significant contributions
- Special thanks section (if applicable)

Thank you for helping make this knowledge management system better for everyone!

---

**Note**: By contributing, you agree that your contributions will be licensed under the same license as this project (see LICENSE file).
