# vidara — Technical Debt Register
**Audit Date:** 2026-03-29

---

## Summary

| Severity | Count | Est. Dev-Days |
|---|---|---|
| Critical | 2 | 4.0 |
| High | 3 | 4.0 |
| Medium | 5 | 7.0 |
| Low | 4 | 2.0 |
| **Total** | **14** | **17.0** |

**Context Note:** The majority of "debt" in `vidara` is implementation debt (features described in the README that don't exist yet) rather than code quality debt. The tooling infrastructure is excellent. The debt register reflects the gap between advertised Alpha capability and actual implementation.

---

## Critical

### DEBT-C1: README Usage Example Raises `ImportError` at Runtime
- **Description:** `README.md:50-57` shows a usage example that imports `Theme`, `Button`, and `Card` — none of which exist. Any user following the documentation gets an immediate `ImportError`. This is a documentation/implementation gap that makes `vidara` non-functional as advertised.
- **File:** `README.md:50-57`, `src/vidara/components/__init__.py` (empty), `src/vidara/tokens/__init__.py` (empty)
- **Effort:** 5+ dev-days to implement the components; 0.25 dev-days to fix the README to reflect reality

### DEBT-C2: All Core Modules Are Empty Scaffolding
- **Description:** `components/`, `tokens/`, `themes/`, `a11y/`, `renderers/` — all `__init__.py` files contain only `from __future__ import annotations`. This is 95% of the advertised library's surface area.
- **File:** All 5 `__init__.py` files in `src/vidara/`
- **Effort:** ~25 dev-days for minimal viable component system (estimate)

---

## High

### DEBT-H1: Runtime Dependencies Added Before Usage (`rich`, `jinja2`)
- **Description:** `rich>=13.0` and `jinja2>=3.1` are in `dependencies` (not `optional-dependencies`). They add ~8MB + ~10MB respectively to installs for zero current functionality.
- **File:** `pyproject.toml:26`
- **Effort:** 0.5 dev-days (move to optional extras)

### DEBT-H2: CD Pipeline May Publish Non-Functional Package to PyPI
- **Description:** If the CD workflow triggers on version tags, it could publish a `vidara` package where all advertised features raise `ImportError`.
- **File:** `.github/workflows/cd.yml`
- **Effort:** 0.5 dev-days (add a pre-publish smoke test that verifies `Button`, `Card`, and `Theme` are importable)

### DEBT-H3: No WCAG Accessibility Implementation Despite Claims
- **Description:** `src/vidara/a11y/__init__.py` is empty. All accessibility claims in the README are aspirational.
- **File:** `src/vidara/a11y/__init__.py`
- **Effort:** 3 dev-days (ContrastChecker + AriaAttributeGenerator + FocusManager)

---

## Medium

### DEBT-M1: Integration and Visual Test Directories Are Empty
- **Description:** `tests/integration/` and `tests/visual/` directories exist but contain only `__init__.py`. No integration or visual regression tests are implemented.
- **File:** `tests/integration/__init__.py`, `tests/visual/__init__.py`
- **Effort:** 3 dev-days (after components are implemented)

### DEBT-M2: `mypy strict` Passing Only Because No Real Code Exists
- **Description:** Strict mypy with `disallow_untyped_defs = true` and `warn_return_any = true` passes trivially on empty files. The first implementation commit will likely break mypy if not carefully typed.
- **File:** `pyproject.toml:76-83`
- **Effort:** 0 dev-days to keep config; requires discipline on every implementation commit

### DEBT-M3: No Rendering Target Architecture Decision
- **Description:** Whether components render to HTML, terminal markup, or an abstract component tree is undecided. This decision blocks implementation of all 5 core modules.
- **File:** `src/vidara/renderers/__init__.py`, `DECISIONS.md` (missing)
- **Effort:** 1 dev-day (write the decision document; implementation follows)

### DEBT-M4: `pydantic>=2.0` May or May Not Be Used for Component Props
- **Description:** `pydantic` is a hard dependency but it's unclear if it will be used for runtime component validation, Pydantic-based tokens, or not at all. This ambiguity signals no architectural decision has been made.
- **File:** `pyproject.toml:26`
- **Effort:** 0 dev-days to decide; implementation costs vary

### DEBT-M5: Sphinx Documentation Setup Without Content
- **Description:** Sphinx is in dev dependencies; a `docs/` directory exists. No documentation source files exist for any module. As soon as components are implemented, doc generation should be automated.
- **File:** `docs/` directory
- **Effort:** 1 dev-day (initial Sphinx setup + autoapi configuration)

---

## Low

### DEBT-L1: `ruff.lint` Enables `ANN` Rules But No Code to Annotate
- **File:** `pyproject.toml:69` — `"ANN"` rules enabled
- **Status:** Correct long-term target; no action needed now

### DEBT-L2: `pytest.ini_options.addopts` Missing `--cov-fail-under`
- **Description:** Coverage threshold not enforced despite `[tool.coverage.report] fail_under = 80`.
- **File:** `pyproject.toml:83-85`
- **Effort:** 0.25 dev-days (add `--cov-fail-under=80` to `addopts`)

### DEBT-L3: `uv.lock` Must Be Kept Current in CI
- **Description:** `uv.lock` provides reproducible builds but must be checked in CI to ensure it's not stale.
- **File:** `.github/workflows/ci.yml`
- **Effort:** 0.25 dev-days (add `uv sync --check` step to CI)

### DEBT-L4: `tests/conftest.py` Missing
- **Description:** No shared fixtures, no plugin configuration, no event loop setup for async tests. Will be needed as soon as real component tests are added.
- **File:** `tests/conftest.py` (missing)
- **Effort:** 0.5 dev-days
