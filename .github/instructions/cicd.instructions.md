---
applyTo: ".github/workflows/**"
---

# CI/CD Instructions

## Workflow Overview

| Workflow                | Trigger                  | Purpose                          |
| ----------------------- | ------------------------ | -------------------------------- |
| `ci.yml`                | Push/PR to main, develop | Lint, typecheck, test, a11y      |
| `cd.yml`                | Tag `v*` or manual       | Build, publish PyPI, deploy docs |
| `codeql.yml`            | Push to main, PR, weekly | Security scanning                |
| `dependency-review.yml` | PR to main               | Dependency vulnerability check   |

## CI Pipeline Stages

1. **Lint & Format** — `ruff check` + `ruff format --check`
2. **Type Check** — `mypy --strict`
3. **Test** — pytest across Python 3.11, 3.12, 3.13 with coverage
4. **A11y Audit** — pytest -m a11y (accessibility-specific tests)
5. **Status Gate** — All jobs must pass for merge

## CD Pipeline Stages

1. **Validate** — Full lint + typecheck + test suite
2. **Build** — `uv build` (sdist + wheel)
3. **Publish** — Trusted publishing to PyPI (OIDC, no tokens)
4. **Release** — GitHub Release with auto-generated notes
5. **Docs** — Sphinx build + deploy to GitHub Pages

## Conventions

- Use `uv` for dependency installation in CI (faster than pip)
- Pin action versions to major tags (`@v4`, `@v5`)
- Enable concurrency cancellation for CI to avoid redundant runs
- Use matrix strategy for Python version testing
- Upload coverage only from the latest Python version
