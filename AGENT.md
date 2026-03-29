---
schema_version: "1.0"
---

# Agent Manifest: vidara

```yaml
repo: vidara
type: python-lib
description: "Vidara Python library — UV-managed, src layout, pyproject.toml packaging"
owner: migar-git
```

## Authority

```yaml
authority:
  max_auto_level: 1
  always_open_pr: true
  protected_paths:
    - .env*
    - scripts/deploy*
  notify_on: [2, 3]
  allowed_machines: []
```

## Commands

```yaml
commands:
  test:   "uv run pytest -q"
  lint:   "uv run ruff check src/ tests/"
  format: "uv run ruff format src/ tests/"
  build:  "uv sync"
  deploy: ""
```

## LLM Routing

```yaml
llm:
  local_model: "qwen2.5-coder:7b"
  escalate_on:
    - cross_repo_change
    - architecture_decision
    - security_related
    - confidence_below: 0.75
```

## Dependencies

```yaml
dependencies: []
```

## CI / Analytics

```yaml
ci:
  push_results: true
  min_pass_rate: 0.95
  track:
    - test_pass_rate
    - coverage_pct
    - lint_errors
```

## Notes

```yaml
notes: |
  - UV-managed Python library with src/ layout
  - Uses uv.lock — always use uv for package management, never pip directly
  - vidara.code-workspace VSCode workspace present
```
