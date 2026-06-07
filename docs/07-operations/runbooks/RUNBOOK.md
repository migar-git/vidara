# Runbook — Vidara

## Overview

Operational reference for maintaining and releasing the Vidara component library.

## Local Development

```bash
git clone https://github.com/migar-git/vidara.git
cd vidara
python -m venv .venv && source .venv/bin/activate
pip install -e ".[dev]"
pre-commit install
pytest           # verify all tests pass
```

## Running the Test Suite

```bash
pytest                                 # all tests
pytest --cov=src/vidara                # with coverage
pytest -m a11y                         # accessibility tests only
black src/ tests/ && ruff check src/ tests/   # lint + format
```

## Releasing a New Version

1. Update `CHANGELOG.md` — move `[Unreleased]` items to a new version section.
2. Bump `version` in `pyproject.toml`.
3. Commit: `git commit -m "chore: release v0.x.y"`.
4. Tag: `git tag v0.x.y && git push origin main --tags`.
5. CI/CD (`cd.yml`) publishes to PyPI automatically on tag push.

## CI Failure Triage

| Failure | Likely Cause | Fix |
|---------|-------------|-----|
| `ruff` lint error | Code style violation | Run `ruff check --fix src/ tests/` |
| `mypy` type error | Missing annotation or wrong type | Add/fix type hints |
| `pytest` failure | Broken test or component regression | Run `pytest -x -v` locally |
| `a11y` test failure | Component violates WCAG 2.1 AA | Fix ARIA attributes or markup |
| `codecov` drop | New code lacks test coverage | Add tests for new code paths |

## Dependency Updates

```bash
pip list --outdated        # check for outdated packages
pip install -e ".[dev]"   # re-install after pyproject.toml changes
```

Run full test suite after any dependency update before committing.

## Rollback a Release

1. Yank the bad version on PyPI: `pip install twine && twine yank vidara==0.x.y`.
2. Tag a patch release with the fix.
