# Vidara

**Modern, accessible UI component library and design system toolkit — built with Python.**

[![CI](https://github.com/migar-git/vidara/actions/workflows/ci.yml/badge.svg)](https://github.com/migar-git/vidara/actions/workflows/ci.yml)
[![CD](https://github.com/migar-git/vidara/actions/workflows/cd.yml/badge.svg)](https://github.com/migar-git/vidara/actions/workflows/cd.yml)
[![codecov](https://codecov.io/gh/migar-git/vidara/branch/main/graph/badge.svg)](https://codecov.io/gh/migar-git/vidara)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Python 3.11+](https://img.shields.io/badge/python-3.11%2B-blue.svg)](https://www.python.org/downloads/)

---

## Overview

Vidara is a Python-powered design system and UI component toolkit that prioritizes **accessibility**, **performance**, and **developer experience**. It provides a structured approach to building consistent, themeable, and WCAG-compliant user interfaces.

### Key Features

- **Accessible by default** — WCAG 2.1 AA compliance baked into every component
- **Themeable** — Token-based design system with light/dark mode support
- **Type-safe** — Full type annotations with runtime validation
- **Tested** — Comprehensive unit, integration, and visual regression tests
- **Documented** — Auto-generated API docs with interactive examples
- **CI/CD automated** — Linting, testing, building, and publishing on every push

---

## Quick Start

### Prerequisites

- Python 3.11+
- [uv](https://docs.astral.sh/uv/) (recommended) or pip

### Installation

```bash
# From PyPI (when published)
pip install vidara

# For development
git clone https://github.com/migar-git/vidara.git
cd vidara
uv sync          # or: pip install -e ".[dev]"
```

### Usage

```python
from vidara.tokens import Theme
from vidara.components import Button, Card

# Create a theme
theme = Theme.from_preset("default")

# Build components
btn = Button(label="Get Started", variant="primary", theme=theme)
card = Card(title="Welcome", children=[btn], theme=theme)

# Render
print(card.render())
```

---

## Project Structure

```
vidara/
├── .github/              # CI/CD workflows, templates, community files
│   ├── workflows/        # GitHub Actions (ci, cd, codeql)
│   ├── ISSUE_TEMPLATE/   # Bug report, feature request templates
│   ├── CONTRIBUTING.md   # Contribution guidelines
│   └── copilot-instructions.md
├── src/
│   └── vidara/           # Main package
│       ├── components/   # UI component definitions
│       ├── tokens/       # Design tokens (colors, spacing, typography)
│       ├── themes/       # Theme presets and configuration
│       ├── a11y/         # Accessibility utilities and validators
│       └── renderers/    # Output renderers (HTML, terminal, etc.)
├── tests/                # Test suite
│   ├── unit/
│   ├── integration/
│   └── visual/           # Visual regression tests
├── docs/                 # Documentation source
├── frontend/             # Web-based component previewer
├── pyproject.toml        # Project metadata and dependencies
└── README.md
```

---

## Development

```bash
# Install dev dependencies
uv sync --extra dev

# Run tests
pytest

# Run tests with coverage
pytest --cov=vidara --cov-report=html

# Lint and format
ruff check src/ tests/
ruff format src/ tests/

# Type check
mypy src/

# Run all checks (pre-commit)
pre-commit run --all-files
```

### Branch Strategy

| Branch    | Purpose               |
| --------- | --------------------- |
| `main`    | Stable release branch |
| `develop` | Integration branch    |
| `feat/*`  | Feature branches      |
| `fix/*`   | Bug fix branches      |
| `docs/*`  | Documentation updates |

---

## Contributing

We welcome contributions! Please read our [Contributing Guide](.github/CONTRIBUTING.md) before submitting a PR.

- Follow the [Code of Conduct](.github/CODE_OF_CONDUCT.md)
- Use [conventional commits](https://www.conventionalcommits.org/)
- Ensure all tests pass and coverage doesn't drop
- Add/update documentation for any new features

---

## Accessibility

Vidara follows [WCAG 2.1 AA](https://www.w3.org/WAI/WCAG21/quickref/) guidelines. Every component includes:

- Proper ARIA attributes
- Keyboard navigation support
- Color contrast validation
- Screen reader compatibility
- Focus management

See the [Accessibility Guide](docs/accessibility.md) for details.

---

## License

[MIT](LICENSE) © Vidara Contributors

---

## Acknowledgements

Built with care by the Vidara community. Inspired by modern design systems like Material, Radix, and Shadcn.
