---
description: Draft a Stack Overflow question about a technical problem encountered during development
allowed-tools: [Read, Glob, Grep, Bash]
---

Help me draft a Stack Overflow question about a technical problem I've encountered.

**Topic/error (optional):** $ARGUMENTS

**Process:**

1. **Understand the problem context**
   - If topic provided, research it in the current codebase
   - Look at recent errors, code changes, or discussions in our conversation
   - Identify the specific technical issue (error message, unexpected behavior, architectural question)

2. **Gather environmental context**
   - Check language/framework versions (package.json, build.gradle, pom.xml, MODULE.bazel, etc.)
   - Identify relevant dependencies and their versions
   - Note any monorepo or build system constraints

3. **Create minimal reproduction**
   - Extract the specific code that demonstrates the problem
   - Remove project-specific details that aren't relevant
   - Include configuration files if relevant (application.yml, etc.)

4. **Write the question in a local markdown file**

   **File location:** Write to the `/tmp/` directory (yes, the global tmp directory). Use naming pattern `stackoverflow-{topic-slug}-question.md`.

   **Structure the question with these sections:**

   ```markdown
   # [Descriptive title as a question]

   ## Tags
   `tag1` `tag2` `tag3` (5 tags max, most specific first)

   ## Question

   [Opening paragraph: What you're trying to do and what's going wrong]

   ### Environment
   - Language/framework version
   - Relevant library versions
   - Build system (if relevant)
   - OS/platform (if relevant)

   ### Code

   **[File or component name]:**
   ```language
   // Minimal code example
   ```

   **[Config file if relevant]:**
   ```yaml
   # Relevant configuration
   ```

   ### Error/Behavior

   ```
   [Exact error message or description of unexpected behavior]
   ```

   ### What I've Tried

   1. [Attempt 1 and result]
   2. [Attempt 2 and result]
   3. [Attempt 3 and result]

   ### Questions

   1. [Specific question 1]
   2. [Specific question 2 - optional]
   3. [Specific question 3 - optional]

   ### Broader Context

   [Brief explanation of why this matters - the business/project context that helps answerers understand the constraints and suggest appropriate solutions. Mention any hard constraints like "monorepo-wide version X" or "must use technology Y".]
   ```

5. **Quality checklist before finishing**
   - [ ] Title is a specific question (not "Problem with X")
   - [ ] Code is minimal but complete (can be copy-pasted to reproduce)
   - [ ] Error message is exact (not paraphrased)
   - [ ] "What I've tried" shows due diligence
   - [ ] Questions are specific and answerable
   - [ ] No sensitive info (credentials, internal URLs, company names in paths)
   - [ ] Tags are accurate (check they exist on SO)
   - [ ] Broader context explains constraints without unnecessary detail

**Writing style guidelines:**
- Be concise but complete
- Use "I" not "we" (SO convention)
- Show the problem, don't just describe it
- Anticipate follow-up questions and address them preemptively
- Include version numbers - they matter!
- If asking about alternatives, explain what you've already considered and why each might not work

**After writing:**
- Tell the user where the file was saved
- Note that after posting on SO and getting an answer, expect that they will save the answer to a `stackoverflow-{topic-slug}-answer.md`) companion file
