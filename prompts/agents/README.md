# prompts/agents/ — Agent Role Prompts

Specialized prompts for each agent in the multi-agent orchestrator.

| Agent | File | Event Bus Topic |
|-------|------|----------------|
| CodeGenAgent | `codegen_agent.md` | `commands.codegen` |
| ReviewAgent | `review_agent.md` | `commands.review` |
| TestAgent | `test_agent.md` | `commands.test` |
| SecurityAgent | `security_agent.md` | `commands.security` |
| RefactorAgent | `refactor_agent.md` | — |

## Usage

1. Load agent prompt into the orchestrator configuration
2. Agent subscribes to its Event Bus topic
3. Receives task, executes, publishes result
4. Orchestrator coordinates the pipeline

## Pipeline Flow

```
commands.plan → CodeGenAgent → ReviewAgent → TestAgent → SecurityAgent → results.final
                     ↓              ↓             ↓              ↓
                results.task   results.task   results.task   alerts.incident
```

## Cross-References

- `prompts/system/CODEX_MULTI_AGENT_SYSTEM_PROMPT.md` — Orchestrator prompt
- `prompts/system/claude_system_prompt.md` — Claude agent prompt
- `prompts/system/vscode_system_prompt.md` — VSCode/Copilot prompt
- `agents/` (root) — Swarm role definitions (governance level)
