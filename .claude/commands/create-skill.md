---
description: Create a new Claude Code skill with proper structure, frontmatter, and organization
argument-hint: [skill-name]
allowed-tools: [Bash, Write, Read, Edit, Glob, Grep]
---

# Creating Claude Code Skills

This command guides you through creating well-structured Claude Code skills.

**Skill name (optional):** $ARGUMENTS

## What are Claude Code Skills?

Skills are packaged sets of instructions that extend Claude's capabilities for specific tasks. They are:
- **Filesystem-based**: Stored as directories with a `SKILL.md` file
- **Automatically discovered**: Claude loads them when relevant to tasks
- **Progressive**: Content loaded in stages (metadata -> instructions -> resources)

## Skill Locations

Choose the appropriate location based on portability:

### Personal Skills (`~/.claude/skills/`)
- **Use for**: Portable skills that work across any company or project
- **Examples**: Generic coding patterns, tool workflows (git, docker), debugging techniques
- **Version control**: In dotfiles repo, symlinked to ~/.claude/skills/
- **Portability**: Follow you across all companies and projects

### Company Skills (`~/.claude/skills.private/`)
- **Use for**: Company-specific workflows and infrastructure
- **Examples**: Internal tool access, company infrastructure patterns, cross-project company workflows
- **Version control**: NOT in git (excluded via .gitignore)
- **Portability**: Specific to current employer, not portable

### Project Skills (`<project>/.claude/skills/`)
- **Use for**: Team-shared, project-specific procedures
- **Examples**: Deployment procedures, project conventions, architecture-specific patterns
- **Version control**: In project repo, shared with team
- **Portability**: Available to all team members

## Decision Tree: Where Should My Skill Go?

```
Is it company/employer-specific?
|- Yes: Does the team need it?
|  |- Yes: Project skills (project/.claude/skills/)
|  +- No: Company skills (~/.claude/skills.private/)
+- No: Personal skills (~/.claude/skills/)
```

## Skill File Structure

Every skill requires this structure:

```
skill-name/
+-- SKILL.md           # Required: Main skill definition
```

Optional supporting files:

```
skill-name/
|-- SKILL.md           # Required
|-- script.py          # Optional: Supporting scripts
|-- reference.md       # Optional: Additional documentation
+-- examples/          # Optional: Example files
    +-- sample.csv
```

## SKILL.md Anatomy

### Required Structure

```markdown
---
name: Skill Name Here
description: Clear, specific description of what this skill does and when to use it
---

# Skill Content

Instructions and documentation go here...
```

### YAML Frontmatter Fields

#### Required Fields

**`name`** (max 64 characters):
- Use gerund form (verb + -ing): "Processing PDFs", "Refreshing TNM Data"
- Be specific and descriptive
- Avoid vague names like "Helper" or "Utility"

**`description`** (max 1024 characters):
- Written in third person
- Be specific about what the skill does
- Include key terms and usage contexts
- Explain when to use it
- Example: "This skill refreshes TNM configuration data from BA production to local FES development environments"

#### Optional Fields

**`allowed-tools`**: Restrict which tools Claude can use within this skill
```yaml
allowed-tools: [Bash, Read, Write, Edit]
```

### Content Structure Best Practices

Organize your skill content with these sections:

1. **Overview** - Brief description of capabilities
2. **What This Skill Does** - Specific capabilities list
3. **Prerequisites** - Required tools, access, environment setup
4. **Usage** - Step-by-step instructions
5. **Examples** - Concrete use cases with quotes
6. **Verification** - How to check success
7. **Troubleshooting** - Common issues and solutions
8. **Related Skills** - Links to complementary skills
9. **Best Practices** - Guidelines for effective use

## Naming Conventions

### Directory Names
- Use kebab-case: `my-skill-name`
- Be descriptive and specific
- Avoid generic names

### Examples by Type

**Personal skills**:
- `debugging-with-printf`
- `git-bisect-workflow`
- `analyzing-performance-profiles`

**Company skills**:
- `refreshing-ba-tnm-data`
- `accessing-wonder-kubernetes`
- `deploying-to-freshrealm-staging`

**Project skills**:
- `fes-local-development-setup`
- `running-integration-tests`
- `generating-api-documentation`

## Step-by-Step Creation Process

### 1. Decide on Location

```bash
# Personal skill (portable)
cd ~/Code/dotfiles/.claude/skills

# Company skill (company-specific)
cd ~/.claude/skills.private

# Project skill (team-shared)
cd ~/Code/project/.claude/skills
```

### 2. Create Directory

```bash
mkdir my-skill-name
cd my-skill-name
```

### 3. Create SKILL.md

```bash
cat > SKILL.md << 'EOF'
---
name: My Skill Name
description: This skill does X by doing Y. Use this skill when you need to accomplish Z.
allowed-tools: [Bash, Read, Write]
---

# My Skill Name

Brief overview of what this skill does.

## What This Skill Does

- Capability 1
- Capability 2
- Capability 3

## Prerequisites

1. **Requirement 1**
   - Details about requirement

2. **Requirement 2**
   - Details about requirement

## Usage

### Step 1: First Action

```bash
command-example
```

Expected behavior:
- What should happen

### Step 2: Second Action

Detailed instructions...

## Verification

How to confirm the skill worked:

```bash
verification-command
```

## Troubleshooting

### Issue: Common Problem

**Cause:** Why this happens

**Solution:**
```bash
fix-command
```

## Best Practices

1. **Practice 1**: Description
2. **Practice 2**: Description

## Related Skills

- **Other Skill Name** - When to use instead
EOF
```

### 4. Test the Skill

```bash
# Restart Claude Code to load new skills
# (Skills are discovered at startup)

# In a new conversation, trigger the skill:
# "Help me with [skill topic]"
```

### 5. Iterate and Refine

- Test with real use cases
- Add troubleshooting sections as issues arise
- Update examples based on actual usage
- Refine prerequisites based on feedback

## Quality Checklist

Before considering a skill complete:

### Content Quality
- [ ] Name is descriptive and uses gerund form
- [ ] Description clearly states what and when
- [ ] Prerequisites are complete and accurate
- [ ] Instructions are step-by-step and clear
- [ ] Examples use concrete commands/code
- [ ] Troubleshooting covers common issues
- [ ] Best practices guide users to success

### Technical Quality
- [ ] YAML frontmatter is valid
- [ ] File size is appropriate (<800 lines recommended)
- [ ] Code blocks use proper syntax highlighting
- [ ] Commands are tested and work
- [ ] No hardcoded credentials or secrets
- [ ] Paths use ~ for home directory

### Organization Quality
- [ ] Skill is in correct location (personal/company/project)
- [ ] Supporting files are in skill directory
- [ ] Related skills are cross-referenced
- [ ] Version control status is correct

## Common Patterns

### Multi-Step Process Skills

For complex workflows:

```markdown
## Process Overview
Brief summary of the entire flow

## Step 1: Preparation
Detailed instructions

## Step 2: Execution
Detailed instructions

## Step 3: Verification
How to check success

## Step 4: Cleanup
Post-execution tasks
```

### Reference Data Skills

For skills with lookup tables or reference data:

```markdown
## Quick Reference

| Item | Value | Description |
|------|-------|-------------|
| A    | 1     | Details     |
| B    | 2     | Details     |

## Usage
How to use the reference data
```

### Troubleshooting-Heavy Skills

For error-prone operations:

```markdown
## Common Issues

### Issue 1: [Error Message]
**Symptoms**: What you see
**Cause**: Why it happens
**Solution**: Step-by-step fix

### Issue 2: [Error Message]
[Same structure]
```

## Tips and Tricks

### Keep Skills Focused
- One skill = one job
- If a skill tries to do too much, split it
- Link related skills instead of combining them

### Use Concrete Examples
- Show actual commands, not placeholders
- Include expected output
- Use real file paths (with ~ for portability)

### Document Edge Cases
- What doesn't work
- Known limitations
- Workarounds for common blockers

### Update Skills Over Time
- Add new troubleshooting as issues arise
- Update commands when tools change
- Refine instructions based on usage

## File Size Guidelines

**Target**: <800 lines per file (~5000 tokens)
**Acceptable**: 800-1000 lines
**Time to refactor**: >1000 lines

If your SKILL.md exceeds 800 lines, consider splitting into:
- **REFERENCE.md** - Lookup tables, API docs, config options
- **ENVIRONMENTS.md** - Environment-specific workflows
- **TROUBLESHOOTING.md** - Detailed error diagnosis

## Version Control Best Practices

### For Personal Skills (in dotfiles)
```bash
cd ~/Code/dotfiles/.claude/skills/my-skill
git add SKILL.md
git commit -m "Add [skill name] skill"
git push
```

### For Company Skills (not in git)
```bash
# No git operations - these stay local
# Backup strategy recommended (Time Machine, etc.)
```

### For Project Skills (in project repo)
```bash
cd ~/Code/project/.claude/skills/my-skill
git add SKILL.md
git commit -m "Add [skill name] skill for team"
# Follow project's PR process
```

## Example: Simple Tool Workflow Skill

```markdown
---
name: Running Git Bisect
description: This skill guides you through using git bisect to find the commit that introduced a bug using binary search. Use this when you know a bug exists but don't know which commit caused it.
allowed-tools: [Bash]
---

# Git Bisect Workflow

Binary search through git history to find bug-introducing commits.

## What This Skill Does

- Starts git bisect session
- Tests commits interactively
- Identifies the breaking commit
- Provides commit hash and details

## Prerequisites

1. **Git repository** with history
2. **Known good commit** (working state)
3. **Known bad commit** (broken state, usually HEAD)
4. **Reproducible test** to identify bug

## Usage

[Rest of skill content...]
```
