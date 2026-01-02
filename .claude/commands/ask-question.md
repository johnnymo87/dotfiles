---
description: Draft a Stack Exchange question about a technical problem encountered during development
argument-hint: [draft]
allowed-tools: [Read, Glob, Grep, Bash]
---

Help me draft a Stack Exchange question about a technical problem I've encountered, then send it to ChatGPT for research.

**Arguments:** $ARGUMENTS

- If first word is `draft`: Only write the question file, skip sending to ChatGPT
- Otherwise: Write question, send to ChatGPT, read answer, and discuss

**Process:**

1. **Determine the appropriate Stack Exchange site**

   Based on the nature of the problem, recommend one of:

   | Site | Best For | Not For |
   |------|----------|---------|
   | **Stack Overflow** | Specific coding problems, debugging, "how do I do X in language Y" | Design opinions, code review |
   | **Code Review** | Working code that could be improved (style, performance, idioms) | Broken code, hypotheticals |
   | **Software Engineering** | Architecture, design patterns, methodology, trade-offs | Implementation details, debugging |
   | **DevOps** | CI/CD, infrastructure, deployment, containers | Application code issues |
   | **DBA** | Database design, query optimization, administration | ORM/application-level DB code |

   State your recommendation and brief rationale before proceeding.

2. **Understand the problem context**
   - If topic provided, research it in the current codebase
   - Look at recent errors, code changes, or discussions in our conversation
   - Identify the specific technical issue (error message, unexpected behavior, architectural question)

3. **Gather environmental context**
   - Check language/framework versions (package.json, build.gradle, pom.xml, MODULE.bazel, etc.)
   - Identify relevant dependencies and their versions
   - Note any monorepo or build system constraints

4. **Create minimal reproduction**
   - Extract the specific code that demonstrates the problem
   - Remove project-specific details that aren't relevant
   - Include configuration files if relevant (application.yml, etc.)

5. **Write the question in a local markdown file**

   **File location:** Write to the `/tmp/` directory (yes, the global tmp directory). Use naming pattern `stackexchange-{site}-{topic-slug}-question.md` (e.g., `stackexchange-codereview-caching-strategy-question.md`).

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

6. **Quality checklist before finishing**
   - [ ] Title is a specific question (not "Problem with X")
   - [ ] Code is minimal but complete (can be copy-pasted to reproduce)
   - [ ] Error message is exact (not paraphrased)
   - [ ] "What I've tried" shows due diligence
   - [ ] Questions are specific and answerable
   - [ ] No sensitive info (credentials, internal URLs, company names in paths)
   - [ ] Tags are accurate (check they exist on the target site)
   - [ ] Broader context explains constraints without unnecessary detail
   - [ ] Question fits the chosen site's scope (see step 1)

**Writing style guidelines:**
- Be concise but complete
- Use "I" not "we" (Stack Exchange convention)
- Show the problem, don't just describe it
- Anticipate follow-up questions and address them preemptively
- Include version numbers - they matter!
- If asking about alternatives, explain what you've already considered and why each might not work

7. **Send to ChatGPT (unless draft mode)**

   If $ARGUMENTS starts with `draft`, skip this step - just tell the user where the file was saved.

   Otherwise, send the question to ChatGPT using the ask-question CLI:

   ```bash
   ask-question -f /tmp/stackexchange-{site}-{topic-slug}-question.md \
                -o /tmp/stackexchange-{site}-{topic-slug}-answer.md
   ```

   This will block for 30-360 seconds while ChatGPT generates a response.

   After ask-question returns successfully, read the answer file and discuss it with the user. Summarize key insights and recommendations from the response.
