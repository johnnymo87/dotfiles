---
description: Create a new Claude Code skill with proper structure and location
argument-hint: [skill-name]
allowed-tools: [Bash, Write, Read, Edit]
---

# Create Skill

**Skill name:** $ARGUMENTS

## Locations

| Location | Use for | Git |
|----------|---------|-----|
| `~/.claude/skills/` | Portable, cross-company | In dotfiles, symlinked |
| `~/.claude/skills.private/` | Company-specific | Not in git |
| `<project>/.claude/skills/` | Team-shared | In project repo |

## Frontmatter Requirements

```yaml
---
name: processing-pdfs
description: Extracts text from PDF files. Use when working with PDFs or document extraction.
---
```

**`name`** (required):
- Max 64 characters
- **Lowercase letters, numbers, hyphens only**
- Gerund form preferred: `processing-pdfs`, `analyzing-data`

**`description`** (required):
- Max 1024 characters
- **Third person** (injected into system prompt)
- Include WHAT it does AND WHEN to use it

**`allowed-tools`** (optional): `[Bash, Read, Write, Edit]`

## Structure

```
skill-name/
├── SKILL.md              # Required, <500 lines
├── REFERENCE.md          # Optional, loaded on demand
└── scripts/              # Optional, executed not loaded
```

Progressive disclosure: SKILL.md is the overview; separate files load only when needed.

## Authoring Principles

1. **Claude is smart** - Only add context Claude doesn't already have
2. **Concise is key** - Every token competes with conversation history
3. **Test with real usage** - Create evaluations before extensive documentation
4. **One level deep** - Reference files link from SKILL.md, not from each other

## Creation

```bash
# 1. Choose location
cd ~/.claude/skills  # or skills.private, or project/.claude/skills

# 2. Create
mkdir my-skill-name && cd my-skill-name

# 3. Write SKILL.md with frontmatter + concise instructions

# 4. For dotfiles: symlink to ~/.claude/skills/
ln -s ~/Code/dotfiles/.claude/skills/my-skill-name ~/.claude/skills/
```
