# Claude Code Skills

This directory contains personal skills that are portable across all projects and companies.

## Directory Structure

```
dotfiles/.claude/
├── skills/              (version controlled personal skills)
└── skills.private/      (NOT version controlled company skills)

~/.claude/
└── skills/              (real directory containing symlinks to individual skills from both sources)
    ├── skill-name-1 → ~/Code/dotfiles/.claude/skills/skill-name-1
    └── skill-name-2 → ~/Code/dotfiles/.claude/skills.private/skill-name-2
```

## Decision Tree: Where Should My Skill Go?

```
Is it company/employer-specific?
├─ Yes: dotfiles/.claude/skills.private/ (NOT version controlled)
└─ No:  dotfiles/.claude/skills/ (version controlled, this directory)
```

Both types get symlinked to `~/.claude/skills/` so Claude Code can discover them.

## Quick Skill Creation

1. **Choose location**:
   - Personal: `cd ~/Code/dotfiles/.claude/skills`
   - Company: `cd ~/Code/dotfiles/.claude/skills.private`

2. **Create directory**: `mkdir skill-name`

3. **Create SKILL.md**:
   ```markdown
   ---
   name: Skill Name (gerund form)
   description: What this skill does and when to use it
   ---

   # Skill Content
   ```

4. **Symlink to ~/.claude/skills/**:
   ```bash
   ln -sf ~/Code/dotfiles/.claude/skills/skill-name ~/.claude/skills/skill-name
   # or for company skills:
   ln -sf ~/Code/dotfiles/.claude/skills.private/skill-name ~/.claude/skills/skill-name
   ```

5. **Add to git** (if personal skill):
   ```bash
   cd ~/Code/dotfiles
   git add .claude/skills/skill-name/
   git commit -m "Add skill-name skill"
   ```

## Skill Types

### Personal Skills (This Directory)
- **Source Location**: `~/Code/dotfiles/.claude/skills/`
- **Symlinked To**: `~/.claude/skills/skill-name/`
- **Version Control**: YES - committed to dotfiles repo
- **Portability**: Follow you everywhere
- **Examples**:
  - Generic coding patterns
  - Tool workflows (git, docker, debugging)
  - Language-agnostic techniques

### Company Skills (skills.private)
- **Source Location**: `~/Code/dotfiles/.claude/skills.private/`
- **Symlinked To**: `~/.claude/skills/skill-name/`
- **Version Control**: NO - excluded via `.gitignore`
- **Portability**: Backup to work-provided cloud storage before machine migration
- **Examples**:
  - Company infrastructure access
  - Internal tool workflows
  - Company-specific procedures

## Naming Conventions

- Use kebab-case: `my-skill-name`
- Be specific and descriptive
- Avoid generic names like "helper" or "utility"
- Use gerund form in skill name: "Debugging with Printf", "Creating Claude Code Skills"

## Best Practices

1. **Keep skills focused**: One skill = one job
2. **Use concrete examples**: Real commands, not placeholders
3. **Test with fresh eyes**: Have someone try your instructions
4. **Update over time**: Add troubleshooting as issues arise
5. **Cross-reference**: Link related skills

## Creating Your First Skill

For comprehensive guidance on creating skills, use the meta-skill:
- **Skill Location**: `.claude/skills/creating-claude-code-skills/SKILL.md`
- **Covers**: Anatomy, frontmatter format, content structure, quality checklist

Or trigger it in Claude Code by asking:
> "Help me create a new Claude Code skill"

## Resources

- **Meta-Skill**: [creating-claude-code-skills/SKILL.md](creating-claude-code-skills/SKILL.md)
- **Claude Code Docs**: https://docs.claude.com/en/docs/claude-code/
