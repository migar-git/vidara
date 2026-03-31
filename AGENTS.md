---
schema_version: "1.0"
---

# AGENTS.md — Governed Swarm Assignment: vidara

> Machine-readable agent assignment file for the ClawMedia Digital agency swarm.
> Authority: Claude Judge (Final Arbiter)
> Generated: 2026-03-29
> Protocol: DISCOVER → PROPOSE → VALIDATE → APPLY → VERIFY → REPEAT

---

## Repo Identity

```yaml
repo: vidara
type: python-lib
canonical_purpose: Vidara Python library â€” UV-managed, src layout
authority_ceiling: 2
```

---

## Agent Assignments

```yaml
agents:
  systems_architect:
    agent: claude-opus-4-6
    role: Systems Architect
    handles:
      - architecture
      - api_design
      - cross_repo_analysis
    constraints:
      - proposes_only: true
      - never_commits_to_main: true

  repo_executor:
    agent: github-copilot
    role: Repo Executor
    handles:
      - feature_implementation
      - bug_fix
      - doc_update
    constraints:
      - feature_branch_only: true
      - requires_judge_approval: true

  build_automation:
    agent: codex
    role: Build & Automation Agent
    handles:
      - test_scaffolding
      - packaging
      - dep_update
      - lint_fix
    constraints:
      - feature_branch_only: true
      - ci_must_pass: true
      - requires_judge_approval: true

  final_arbiter:
    agent: claude-sonnet-4-6
    role: Final Arbiter (Judge)
    handles:
      - pr_review
      - merge_approval
      - release_gate
    constraints:
      - sole_merge_authority: true
      - authority_ceiling: 2
      - human_escalation_on_level: 3
```

---

## Shared Memory Objects

```yaml
memory:
  gap_ledger: dev-analytics/analytics/gap_ledger.jsonl
  decision_log: dev-analytics/analytics/agent_decisions.jsonl
  canonical_truth: dev-analytics/analytics/canonical_truth.json
  repo_entry_key: vidara
```

---

## Iteration Protocol

```yaml
iteration:
  loop: [DISCOVER, PROPOSE, VALIDATE, APPLY, VERIFY]
  branch_pattern: "agency/vidara/{gap_id}"
  pr_title_pattern: "swarm(vidara): {gap_id} — {description}"
  max_retries_before_human_escalation: 3
  ci_required_before_judge_review: true
```

---

## Protected Operations (Human Gate — Level 3)

```yaml
human_required:
  - deploy_to_production
  - merge_to_main
  - secret_rotation
  - cross_repo_structural_change
```

---

## Runbook Reference

Full protocol: `dev-analytics/SWARM_RUNBOOK.md`

---

## Time Rules

```yaml
time_rules:
  timezone: UTC
  format: ISO 8601
  examples:
    datetime: "2026-03-30T14:30:00Z"
    date_only: "2026-03-30"
    log_entry: "2026-03-30T14:30:00Z — event description"
  enforcement:
    - all_timestamps_utc: true
    - no_local_timezone_assumptions: true
    - no_relative_dates_in_commits: true
    - session_logs_use_iso_date: true
    - git_commit_messages_use_absolute_date: true
    - memory_files_use_absolute_date: true
  rationale: >
    Agents run across timezones and machines. UTC ISO 8601 is the only unambiguous
    format. Relative dates in logs/memory become meaningless between sessions.
```