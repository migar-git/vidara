# Runbook — Vidara

## Development Setup

```bash
git clone https://github.com/migar-git/vidara
cd vidara
pip install -e ".[dev]"
```

## Running Tests

```bash
pytest                         # all tests
pytest --cov=src               # with coverage report
pytest tests/unit/ -v          # verbose unit tests
```

## Building

```bash
python -m build                # creates dist/ artifacts
```

## Publishing (PyPI)

```bash
# Build
python -m build

# Upload to TestPyPI first
twine upload --repository testpypi dist/*

# Upload to PyPI
twine upload dist/*
```

## Releasing

1. Update version in `pyproject.toml`
2. Update `CHANGELOG.md`
3. Tag: `git tag v1.x.x && git push --tags`
4. GitHub Actions CD workflow handles PyPI publish automatically

## Common Issues

### Import errors after editable install
Re-install: `pip install -e ".[dev]"`

### Test failures on Windows
Some visual tests may behave differently. Run canonical tests on Linux (CI).
