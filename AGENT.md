---
# AGENT.md - Agency manifest for this repository (canonical resident agent).
# Re-stamped to the portfolio-wide standard on 2026-06-16.
schema_version: "1.0"
---

# Agent Manifest: vidara

## Identity

```yaml
repo: vidara
type: python-lib
description: "Python UI component library and design-system toolkit."
owner: migar-git
```

## Authority

Controls what the resident agency agent may do autonomously in this repo.

```yaml
authority:
  # 0=read-only  1=lint/format on branch  2=bug+test fix via PR  3=cross-repo via PR
  max_auto_level: 1
  always_open_pr: true            # canonical: never auto-commit to default branch
  protected_paths:
    - src/auth/
    - migrations/
    - .env*
    - secrets/
    - credentials/
  notify_on: [2, 3]
  allowed_machines: []
```

## Commands

```yaml
commands:
  test:   "pytest -q"
  lint:   "ruff check ."
  format: "ruff format ."
  build:  ""
  deploy: ""                      # always human-gated
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
dependencies: []                  # other agency repos to re-test if this changes
```

## CI / Analytics

```yaml
ci:
  push_results: true
  min_pass_rate: 0.95
  enforce:
    - pre-commit                  # .pre-commit-config.yaml (agency laws)
    - agency-gate                 # .github/workflows/agency-gate.yml
  track: [test_pass_rate, coverage_pct, lint_errors, build_time_sec]
```

## Notes

```yaml
notes: |
  - Resident agent obeys this manifest + the agency laws enforced by the
    committed pre-commit hooks and the agency-gate CI workflow.
  - Secrets live only in .env (never committed); see protected_paths.
```
