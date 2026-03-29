---
type: task_prompt
template: build_feature
version: "1.0"
---

# Task Prompt: Build Feature

> Reusable template for feature development tasks. Fill in the variables and assign to an agent.

---

```
Task: Implement [FEATURE_NAME]
Goal: [WHAT_THE_FEATURE_DOES] — [USER_FACING_OUTCOME]
Constraints:
  - Files: [TARGET_DIRECTORY or "scope to relevant module"]
  - Patterns: Follow existing code patterns in the module
  - Libraries: Use only existing dependencies unless justified
  - Interfaces: Preserve backward compatibility
  - Performance: No degradation to existing functionality
  - Security: Follow rules/rule_001_security.md
Validation:
  - Write tests alongside implementation
  - Run: pytest tests/ --tb=short -q
  - Run: ruff check .
  - Smoke test the feature manually if applicable
Definition of done:
  - Feature works as specified
  - Tests written and passing
  - Lint clean
  - Documentation updated if user-facing
  - Conventional commit: feat(scope): description
  - PR ready for Final Arbiter review
```

## Usage

1. Copy template above
2. Replace `[PLACEHOLDERS]` with actual values
3. Systems Architect reviews scope first (if complex)
4. Assign to repo_executor
5. Final arbiter reviews the PR
