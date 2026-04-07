# Contributing to Vidara

## Setup

```bash
git clone https://github.com/migar-git/vidara.git
cd vidara
python -m venv .venv && source .venv/bin/activate  # Windows: .venv\Scripts\activate
pip install -e ".[dev]"
pre-commit install
```

## Running Tests

```bash
pytest                    # all tests
pytest tests/unit/        # unit only
pytest -m a11y            # accessibility tests only
pytest --cov=src/vidara   # with coverage
```

## Code Standards

- **Formatter:** `black src/ tests/`
- **Linter:** `ruff check src/ tests/`
- **Type checker:** `mypy src/`
- All public APIs require type annotations.
- All components must pass WCAG 2.1 AA accessibility checks.

## Adding a Component

1. Create `src/vidara/components/your_component.py` with a Pydantic props model and render method.
2. Add unit tests in `tests/unit/test_your_component.py`.
3. Add accessibility tests marked `@pytest.mark.a11y`.
4. Export from `src/vidara/__init__.py`.
5. Update `CHANGELOG.md` under `[Unreleased]`.

## Pull Requests

- One logical change per PR.
- All CI checks must pass (lint, typecheck, test, a11y).
- Describe the accessibility impact in the PR description.

## Versioning

This project uses Semantic Versioning. Breaking changes bump the major version.
