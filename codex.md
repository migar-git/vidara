---
schema_version: "1.0"
repo: vidara
---

# codex.md - Agentic Coding Protocol: vidara

> Read this file FIRST before any task.

## Identity

| Property | Value |
|----------|-------|
| Repo | migar-git/vidara |
| Type | python |
| Language | Python |
| Description | Vidara video intelligence |
| Owner | Michael Carlo Gargano (Aresmax LLC) |
| Agency | ClawMedia Digital |

## Primary Objective

Complete the user's request end-to-end with safe, minimal, high-confidence changes.

## Workflow

1. Inspect - Read codex.md, AGENTS.md, relevant rules/. Identify smallest scope.
2. Plan - Build a short plan before editing. Reference commands/.
3. Execute - Incremental changes following existing conventions.
4. Validate - Run targeted validation (see commands/).
5. Handoff - Changed files, rationale, validation, risk.

## Rules (Immutable)

- Minimize blast radius.
- Do not rewrite unaffected code.
- Prefer patching root cause over cosmetic edits.
- Reuse existing utilities and patterns.
- Preserve backward compatibility.
- Never invent success or requirements.
- Never expose secrets.
- All timestamps UTC ISO 8601.

## Definition of Done

- Implementation complete
- Code internally consistent
- Tests/checks run or limitations stated
- No secrets in code
- Conventional commit message

## Cross-References

| File | Purpose |
|------|---------|
| AGENT.md | Authority manifest |
| AGENTS.md | Swarm assignment |
| .github/copilot-instructions.md | Copilot conventions |
| agents/ | Role definitions |
| commands/ | Available operations |
| rules/ | Governance rules |
| skills/ | Skill definitions |
| time.md | Temporal rules |
| learnings.md | Knowledge base |
| prompts/ | Prompt templates |
