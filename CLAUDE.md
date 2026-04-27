# CLAUDE.md — Vidara

> Vidara — Python package (src-layout).

## Language & Framework

- **Language:** Python 3.10+
- **Build:** pyproject.toml (PEP 621)
- **Package layout:** `src/`
- **Scale:** 7 source files (small package)

## Quick Start

```bash
pip install -e ".[dev]"
pytest
ruff check src/ tests/
black src/ tests/
```

## Project Structure

```
src/               # Core package (7 files)
tests/             # Test suite
pyproject.toml     # Package metadata and dependencies
```

## Key Conventions

- src-layout packaging
- Use `ruff` for linting, `black` for formatting
- Type hints on all public APIs
- Google-style docstrings
- Small codebase — keep it focused and clean

## Testing

```bash
pytest                       # Run all tests
pytest -x                    # Stop on first failure
pytest -k "test_name"        # Run specific test
```
