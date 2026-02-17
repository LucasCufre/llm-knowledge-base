# Setup Guide

Complete guide for setting up your own instance of this knowledge management system.

## Quick Start

1. **Clone or fork this repository**
   ```bash
   git clone https://github.com/[your-username]/project-knowledge-base.git
   cd project-knowledge-base
   ```

2. **Customize for your project**
   - Update [01-foundation/project-charter.md](01-foundation/project-charter.md)
   - Update [01-foundation/objectives-and-scope.md](01-foundation/objectives-and-scope.md)
   - Update [01-foundation/glossary.md](01-foundation/glossary.md) with your terminology
   - Update [01-foundation/stakeholders.md](01-foundation/stakeholders.md)

3. **Configure for your AI assistant**
   - The repository works with multiple AI coding assistants
   - All configuration is in [CLAUDE.md](CLAUDE.md)
   - Symlinks are already configured for popular tools

4. **Start documenting**
   - Add decisions to [02-decisions/](02-decisions/)
   - Update current status in [03-active-work/](03-active-work/)
   - Add requirements to [04-knowledge-base/business/requirements/](04-knowledge-base/business/requirements/)

## Directory Structure

The repository is organized into these main sections:

```
├── 00-PROJECT-INDEX.md          # Start here - master navigation
├── 00-inbox/                    # Drop zone for auto-processing (gitignored)
├── 00-wip/                      # Work in progress drafts (gitignored)
├── 01-foundation/               # Project charter, scope, glossary
├── 02-decisions/                # Architecture Decision Records
├── 03-active-work/              # Current status and priorities
├── 04-knowledge-base/           # Organized knowledge
│   ├── business/                # Requirements, research, market analysis
│   ├── technical/               # Architecture, APIs, infrastructure
│   └── operational/             # Processes and runbooks
├── 05-research/                 # Investigations and research
├── 06-meetings/                 # Meeting notes by month
├── 07-archive/                  # Archived content by quarter
├── .claude/                     # AI assistant configuration
└── logs/                        # Automated workflow logs (gitignored)
```

## Using with AI Assistants

### Claude Code (Recommended)

This system is optimized for Claude Code with built-in slash commands:

```bash
/query [question]          # Research questions with citations
/update                    # Update outdated documentation
/maintenance [timeframe]   # Run maintenance workflows
/prd-bot                   # Generate PRDs and user stories
```

### Other AI Tools

The system works with:
- **Cursor** - Uses `.cursorrules` symlink
- **Cline** - Uses `.clinerules` symlink
- **Windsurf** - Uses `.windsurfrules` symlink
- **Continue** - Uses `.continue/instructions.md` symlink
- **Gemini** - Uses `.gemini/instructions.md` symlink

All tools share the same instructions from [CLAUDE.md](CLAUDE.md).

## Automated Workflows

### Processing New Documents

1. **Place files** in `00-inbox/`
2. **Run** `/maintenance 1d` (or any timeframe)
3. **System automatically**:
   - Detects document type
   - Searches for existing similar docs
   - Creates or updates structured documents
   - Updates all indexes
   - Deletes processed files

### Maintenance

Regular maintenance keeps the knowledge base healthy:

```bash
# Daily (5-8 minutes)
/maintenance 1d

# Weekly (10-15 minutes)
/maintenance 5d

# Monthly (25-40 minutes)
/maintenance 30d
```

## Customization

### Templates

Modify templates in their respective directories:
- Decision records: [02-decisions/_template-decision.md](02-decisions/_template-decision.md)
- Meeting notes: [06-meetings/_template-meeting.md](06-meetings/_template-meeting.md)
- Requirements: [04-knowledge-base/business/requirements/_template-requirement.md](04-knowledge-base/business/requirements/_template-requirement.md)

### Slash Commands

Add custom commands in `.claude/commands/`:

```yaml
---
name: my-command
description: "Description of what it does"
---

[Command prompt/instructions here]
```

### Metadata Fields

Customize the standard metadata in templates to match your needs. Keep these core fields:
- `title`, `type`, `date`, `status`, `summary`

## Best Practices

### Daily Workflow

1. **Morning**: Check `03-active-work/_current-status.md`
2. **During work**: Drop notes/transcripts in `00-inbox/`
3. **End of day**: Run `/maintenance 1d` to process

### Weekly Workflow

1. **Update status**: Edit `03-active-work/_current-status.md`
2. **Review priorities**: Check `03-active-work/priorities.md`
3. **Process content**: Run `/maintenance 5d`
4. **Update indexes**: Automated by maintenance workflow

### Monthly Workflow

1. **Deep review**: Run `/maintenance 30d`
2. **Archive old content**: Move to `07-archive/YYYY-QX/`
3. **Update glossary**: Add new terms to `01-foundation/glossary.md`
4. **Review structure**: Adjust organization as needed

## Troubleshooting

### Documents Not Processing

- Check `00-inbox/review-needed/` for flagged items
- Review most recent log in `logs/`
- Ensure file is valid markdown or plain text

### Broken Links

- Run `/maintenance 30d` to find and fix
- Check that relative paths are correct
- Ensure linked documents exist

### Missing Metadata

- Use templates to create new documents
- Run maintenance to auto-fix dates and basic metadata
- Check `logs/` for validation warnings

## Migration from Existing Docs

If you have existing documentation:

1. **Audit content** for sensitive information
2. **Place in** `00-inbox/` one category at a time
3. **Run** `/maintenance 1d` to process
4. **Review** processed documents in their new locations
5. **Manually fix** any issues flagged in `review-needed/`

## Security Considerations

When using this for internal projects:

### What to Commit
- Structure and templates
- Generic processes and procedures
- Architecture decisions (sanitized)
- Public-facing documentation

### What NOT to Commit
- API keys, credentials, tokens
- Personal information (names, emails, phones)
- Proprietary business data
- Internal URLs and systems
- Actual meeting transcripts with sensitive discussions

### Privacy Settings

For internal use:
1. Set repository to **private**
2. Use `.gitignore` for sensitive directories
3. Add `*.local.md` pattern for personal notes
4. Review commits before pushing

For open-source:
1. Thoroughly audit all content
2. Use placeholder names and examples
3. Sanitize all real data
4. Consider a separate private fork for actual project use

## Getting Help

- **Documentation**: Check README files in each directory
- **Issues**: Use GitHub Issues for bugs and questions
- **Contributing**: See [CONTRIBUTING.md](CONTRIBUTING.md)
- **Discussions**: Use GitHub Discussions for general questions

## What's Next?

1. **Read** [00-PROJECT-INDEX.md](00-PROJECT-INDEX.md) for navigation overview
2. **Review** [CLAUDE.md](CLAUDE.md) for detailed AI instructions
3. **Customize** foundation documents for your project
4. **Start** adding your own content
5. **Run** regular maintenance to keep everything organized

---

**Ready to get started?** Head to [00-PROJECT-INDEX.md](00-PROJECT-INDEX.md) to begin!
