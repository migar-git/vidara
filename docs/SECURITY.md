# Security — Vidara

## Overview

Vidara is a UI component library with no server-side execution or network access. Security considerations are primarily around supply chain and dependency hygiene.

## Dependency Security

- Dependabot configured for automated vulnerability PRs
- `uv.lock` lockfile ensures reproducible, auditable builds
- Pin all dev dependencies in `pyproject.toml`

## No Runtime Secrets

Vidara components do not handle authentication, credentials, or network requests. No secrets management required.

## Supply Chain

- Use only well-maintained, widely-adopted dependencies
- Review Dependabot PRs promptly
- Prefer uv/pip-audit for vulnerability scanning

## Reporting

Open a GitHub issue with the `security` label. If sensitive, contact the maintainer directly via GitHub.
