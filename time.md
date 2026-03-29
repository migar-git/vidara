---
schema_version: "1.0"
repo: vidara
updated: "2026-03-29"
---

# time.md - Temporal Rules

All timestamps UTC ISO 8601: YYYY-MM-DDTHH:MM:SSZ

| Operation | Max |
|-----------|-----|
| Task | 5 min |
| LLM response | 2 min |
| API call | 10 sec |
| Session | 30 min |
| Force commit | 10 min |
| File edits/session | 50 |
| Commands/session | 100 |

Violation: 3 timeouts/hour = kill + 30 min cooldown.
