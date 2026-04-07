# Deployment — Vidara

## Distribution

Vidara is distributed as a Python package via PyPI.

## Release Process

1. Increment version in `pyproject.toml` following SemVer
2. Update `CHANGELOG.md` with release notes
3. Commit and tag: `git tag v1.x.x`
4. Push tag: `git push --tags`
5. GitHub Actions CD workflow builds and publishes to PyPI automatically

## Manual Publish

```bash
python -m build
twine upload dist/*
```

Requires PyPI API token configured as GitHub secret `PYPI_API_TOKEN`.

## Installation by End Users

```bash
pip install vidara       # stable release
pip install vidara==1.x  # pinned version
```

## CI/CD

- CI: runs on every push (lint, test, type check)
- CD: runs on tag push (build, publish to PyPI)

See `.github/workflows/ci.yml` and `.github/workflows/cd.yml`.
