# Test Strategy — Vidara

## Overview

Vidara uses a layered test pyramid: unit tests for component logic, integration tests for renderer pipelines, and visual/accessibility tests for output correctness.

## Test Layers

### Unit Tests (`tests/unit/`)
- Test individual component props validation (Pydantic models).
- Test design token resolution and theme switching.
- Fast — no I/O, no rendering pipeline.
- Target: > 90% line coverage.

### Integration Tests (`tests/integration/`)
- Test full render pipelines (HTML renderer, terminal renderer).
- Test component composition (nested components, slot injection).
- Test theme propagation through component trees.

### Accessibility Tests (`tests/` — marked `@pytest.mark.a11y`)
- Validate rendered HTML against WCAG 2.1 AA rules.
- Run axe-core or equivalent against rendered output.
- Every component must have at least one a11y test.

### Visual Tests (`tests/visual/`)
- Snapshot comparisons of rendered HTML output.
- Catch unintended visual regressions in component markup.

## Running Tests

```bash
pytest                          # all tests
pytest tests/unit/              # unit only
pytest tests/integration/       # integration only
pytest -m a11y                  # accessibility only
pytest -m "not slow"            # skip slow tests in local dev
pytest --cov=src/vidara --cov-report=term-missing
```

## CI Policy

- All tests must pass before merge.
- Coverage gate: 80% minimum (enforced in CI).
- A11y tests run on every PR — failures block merge.
- Slow tests (`@pytest.mark.slow`) run in CI but not in pre-commit.

## Markers

| Marker | Usage |
|--------|-------|
| `slow` | Long-running tests (skip in pre-commit) |
| `a11y` | Accessibility validation tests |
