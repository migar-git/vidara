---
type: task_prompt
template: fix_bug
version: "1.0"
---

# Task Prompt: Fix Bug

> Reusable template for bug fix tasks. Fill in the variables and assign to an agent.

---

```
Task: Fix [BUG_DESCRIPTION]
Goal: [EXPECTED_BEHAVIOR] instead of [CURRENT_BEHAVIOR]
Constraints:
  - Files: [AFFECTED_FILES or "identify from error trace"]
  - Patterns: Follow existing error handling conventions
  - Security: No new insecure defaults
  - Compatibility: Preserve existing API/interface contracts
Validation:
  - Reproduce the bug first (if possible)
  - Apply fix
  - Run: pytest tests/ --tb=short -q
  - Run: ruff check .
  - Verify fix resolves the original issue
Definition of done:
  - Bug no longer reproduces
  - No regressions in existing tests
  - Conventional commit: fix(scope): description
  - Root cause documented in PR or learnings.md if significant
```

## Usage

1. Copy template above
2. Replace `[PLACEHOLDERS]` with actual values
3. Assign to repo_executor or build_automation agent
4. Final arbiter reviews the PR
