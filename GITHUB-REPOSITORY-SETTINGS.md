# GitHub Repository Settings Configuration

This document provides step-by-step instructions for configuring your GitHub repository settings to match the recommended setup for this open-source knowledge base template.

## Repository URL
https://github.com/LucasCufre/llm-knowledge-base

## Settings Checklist

### General Settings

Navigate to: **Settings** → **General**

#### Repository Details

- [ ] **Description**: "A structured, LLM-optimized knowledge management system for project documentation, designed for use with AI coding assistants"
- [ ] **Website**: (Optional) Add if you create a documentation site
- [ ] **Topics**: Add the following tags for discoverability:
  - `documentation`
  - `knowledge-base`
  - `claude-code`
  - `ai`
  - `llm`
  - `project-management`
  - `architecture-decision-records`
  - `template`
  - `markdown`
  - `automation`

#### Features

Enable these features:
- [ ] ✅ **Issues** - For bug reports and feature requests
- [ ] ✅ **Discussions** - For community Q&A and general discussions
- [ ] ❌ **Wikis** - Disabled (documentation is in the repo)
- [ ] ❌ **Projects** - Optional (enable if you want to track development)
- [ ] ❌ **Sponsorships** - Optional

#### Pull Requests

- [ ] ✅ **Allow merge commits** - Yes
- [ ] ✅ **Allow squash merging** - Yes
- [ ] ✅ **Allow rebase merging** - Yes
- [ ] ✅ **Always suggest updating pull request branches** - Yes
- [ ] ✅ **Allow auto-merge** - Optional
- [ ] ❌ **Automatically delete head branches** - Optional (recommended)

#### Template Repository

🔑 **IMPORTANT**: Enable this to allow users to create repositories from your template

- [ ] ✅ **Template repository** - **ENABLE THIS**

This allows users to click "Use this template" instead of forking, giving them a clean copy without your git history.

### Branch Protection (Optional but Recommended)

Navigate to: **Settings** → **Branches** → **Add rule**

For the `main` branch:

- [ ] **Branch name pattern**: `main`
- [ ] **Require a pull request before merging** (optional for initial development)
  - Require approvals: 1 (if you have collaborators)
- [ ] **Require status checks to pass** (if you add CI/CD)
- [ ] **Require conversation resolution before merging** (recommended)
- [ ] **Require signed commits** (optional, enhanced security)
- [ ] **Include administrators** (optional)

### Issue Templates

Navigate to: **Settings** → **Issues** → **Set up templates**

Create these issue templates:

#### 1. Bug Report Template

```yaml
---
name: Bug Report
about: Report a bug or issue
title: '[BUG] '
labels: bug
assignees: ''
---

**Describe the bug**
A clear description of what the bug is.

**To Reproduce**
Steps to reproduce the behavior:
1. Go to '...'
2. Do '...'
3. See error

**Expected behavior**
What you expected to happen.

**Screenshots**
If applicable, add screenshots.

**Environment:**
- AI tool: [e.g., Claude Code, Cursor]
- Version: [e.g., 1.0.0]

**Additional context**
Any other context about the problem.
```

#### 2. Feature Request Template

```yaml
---
name: Feature Request
about: Suggest a new feature or enhancement
title: '[FEATURE] '
labels: enhancement
assignees: ''
---

**Is your feature request related to a problem?**
A clear description of the problem.

**Describe the solution you'd like**
A clear description of what you want to happen.

**Describe alternatives you've considered**
Other solutions or features you've considered.

**Additional context**
Any other context, screenshots, or examples.

**Would you like to work on this?**
[ ] Yes, I can submit a PR
[ ] No, just suggesting
```

#### 3. Documentation Improvement

```yaml
---
name: Documentation Improvement
about: Suggest improvements to documentation
title: '[DOCS] '
labels: documentation
assignees: ''
---

**What documentation needs improvement?**
Which file(s) or section(s) need clarification?

**What is unclear or missing?**
Describe what's confusing or absent.

**Suggested improvement**
How would you improve it?

**Additional context**
Any examples or references that would help.
```

### Pull Request Template

Navigate to: **Settings** → **Pull Request** → Create `.github/PULL_REQUEST_TEMPLATE.md`

```markdown
## Description

<!-- Provide a clear description of what this PR does -->

## Type of Change

- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Template improvement
- [ ] Slash command addition
- [ ] Other (please describe)

## Related Issues

<!-- Link to any related issues: Fixes #123, Relates to #456 -->

## Changes Made

<!-- List the main changes -->

-
-
-

## Checklist

- [ ] I have read the [CONTRIBUTING.md](CONTRIBUTING.md) guidelines
- [ ] My changes follow the file naming conventions
- [ ] I have updated relevant documentation
- [ ] All metadata fields are complete
- [ ] Internal links are working
- [ ] I have updated index files if needed
- [ ] No personal or sensitive information is included
- [ ] I have tested my changes with an AI coding assistant

## Screenshots (if applicable)

<!-- Add screenshots of directory structure, templates, or other visual changes -->

## Additional Notes

<!-- Any additional information that reviewers should know -->
```

### Discussions Categories

Navigate to: **Discussions** → **Categories** → **Edit**

Create these categories:

- [ ] **Announcements** - Official updates and news (read-only)
- [ ] **General** - General discussion about the knowledge base
- [ ] **Q&A** - Questions about setup, usage, or features
- [ ] **Ideas** - Feature ideas and brainstorming
- [ ] **Show and Tell** - Share how you're using the system

### Labels

Navigate to: **Issues** → **Labels**

Add these labels (in addition to defaults):

- [ ] `template` - Related to document templates
- [ ] `slash-command` - Related to slash commands
- [ ] `automation` - Related to automated workflows
- [ ] `ai-integration` - AI assistant integration issues
- [ ] `maintenance` - Maintenance workflow related
- [ ] `good first issue` - Good for newcomers
- [ ] `help wanted` - Extra attention needed
- [ ] `question` - Further information requested

### Security Policy

Create: `.github/SECURITY.md`

```markdown
# Security Policy

## Reporting a Vulnerability

If you discover a security vulnerability in this template, please report it by:

1. **Email**: [your-email@example.com]
2. **Private Security Advisory**: Use GitHub's private vulnerability reporting

Please do not open public issues for security vulnerabilities.

## Scope

This is a documentation template. Security concerns might include:
- Injection vulnerabilities in automation scripts
- Sensitive data exposure in templates or examples
- Malicious code in suggested workflows

## Response Time

We aim to respond to security reports within 48 hours.

## Disclosure Policy

We follow responsible disclosure practices. Please allow us time to address the issue before public disclosure.
```

### GitHub Actions (Optional)

Create workflow for link checking: `.github/workflows/link-check.yml`

```yaml
name: Check Markdown Links

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]
  schedule:
    - cron: '0 0 * * 0'  # Weekly on Sunday

jobs:
  markdown-link-check:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - uses: gaurav-nelson/github-action-markdown-link-check@v1
      with:
        config-file: '.github/markdown-link-check-config.json'
```

Create config: `.github/markdown-link-check-config.json`

```json
{
  "ignorePatterns": [
    {
      "pattern": "^https://github.com"
    }
  ],
  "replacementPatterns": [],
  "httpHeaders": [],
  "timeout": "20s",
  "retryOn429": true,
  "retryCount": 3,
  "fallbackRetryDelay": "30s",
  "aliveStatusCodes": [200, 206]
}
```

### README Badges (Optional)

Add badges to top of README.md:

```markdown
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GitHub Stars](https://img.shields.io/github/stars/LucasCufre/llm-knowledge-base?style=social)](https://github.com/LucasCufre/llm-knowledge-base/stargazers)
[![GitHub Issues](https://img.shields.io/github/issues/LucasCufre/llm-knowledge-base)](https://github.com/LucasCufre/llm-knowledge-base/issues)
[![Last Commit](https://img.shields.io/github/last-commit/LucasCufre/llm-knowledge-base)](https://github.com/LucasCufre/llm-knowledge-base/commits/main)
```

### Social Preview Image (Optional)

Create a social preview image (1280x640px) showing:
- Repository name
- Key features
- Visual of directory structure

Upload at: **Settings** → **Social Preview** → **Edit**

## Release Configuration

Navigate to: **Releases** → **Draft a new release**

### v1.0.0 Release

- [ ] **Tag**: `v1.0.0` (already created and pushed)
- [ ] **Release title**: "v1.0.0 - Initial Release"
- [ ] **Description**:

```markdown
## 🎉 Initial Release

The first stable release of the LLM-optimized knowledge base template!

### ✨ Features

- **📁 Complete Directory Structure** - Organized system for all project documentation
- **📝 Comprehensive Templates** - Ready-to-use templates for decisions, meetings, requirements, and more
- **🤖 AI Assistant Integration** - Built-in support for Claude Code with powerful slash commands
- **🔄 Automated Workflows** - Automatic document processing and maintenance
- **🔗 Cross-Reference Tracking** - Intelligent linking and knowledge graph building
- **📚 Extensive Documentation** - Complete setup guides and contributor guidelines
- **🌐 Multi-Tool Support** - Works with Claude Code, Cursor, Cline, Windsurf, Continue, and Gemini

### 📦 What's Included

**Slash Commands:**
- `/query` - Comprehensive research with cited sources
- `/update` - Update outdated documentation
- `/maintenance` - Run maintenance workflows
- `/prd-bot` - Generate PRDs and user stories

**Directory Structure:**
- `00-inbox/` - Drop zone for automatic processing
- `01-foundation/` - Project charter and glossary
- `02-decisions/` - Architecture Decision Records
- `03-active-work/` - Current status and priorities
- `04-knowledge-base/` - Organized knowledge (business, technical, operational)
- `05-research/` - Research and investigations
- `06-meetings/` - Meeting notes
- `07-archive/` - Archived content

### 🚀 Getting Started

1. Click "Use this template" to create your own repository
2. Follow the [SETUP.md](SETUP.md) guide
3. Customize foundation documents for your project
4. Start documenting with the provided templates

### 📖 Documentation

- [README.md](README.md) - Overview and quick navigation
- [SETUP.md](SETUP.md) - Complete setup guide
- [CONTRIBUTING.md](CONTRIBUTING.md) - Contribution guidelines
- [CLAUDE.md](CLAUDE.md) - AI assistant instructions

### 🙏 Acknowledgments

Built with Claude Sonnet 4.5 to make project knowledge management easy and AI-accessible.

---

**Ready to organize your project knowledge?** Click "Use this template" above to get started!
```

- [ ] **Set as latest release**: ✅ Yes
- [ ] **Pre-release**: ❌ No

## Post-Configuration Checklist

After configuring all settings:

- [ ] Verify "Use this template" button appears on repository home page
- [ ] Test creating an issue with the new templates
- [ ] Test discussions if enabled
- [ ] Verify all links in README work
- [ ] Check that social preview image displays correctly
- [ ] Test "Use this template" flow end-to-end

## Recommended Next Steps

1. **Create announcement** in Discussions
2. **Pin important issues** or discussions
3. **Set up GitHub Projects** (optional) for tracking improvements
4. **Add CODEOWNERS** file (optional) if you have collaborators
5. **Enable Dependabot** (optional) for security updates
6. **Create a GitHub Pages site** (optional) for documentation

## Maintenance Schedule

- **Weekly**: Review new issues and PRs
- **Monthly**: Check for broken links, update dependencies
- **Quarterly**: Review and update templates based on community feedback

---

**Repository**: https://github.com/LucasCufre/llm-knowledge-base
**Version**: 1.0.0
**Last Updated**: 2026-02-17
