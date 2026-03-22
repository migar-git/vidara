# Contributing to Vidara

Thank you for your interest in contributing to Vidara! This guide will help you get started.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Workflow](#development-workflow)
- [Commit Conventions](#commit-conventions)
- [Pull Request Process](#pull-request-process)
- [Component Guidelines](#component-guidelines)
- [Accessibility Requirements](#accessibility-requirements)
- [Testing Standards](#testing-standards)

---

## Code of Conduct

This project follows our [Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code.

## Getting Started

1. **Fork** the repository
2. **Clone** your fork:

    ```bash
    git clone https://github.com/<your-username>/vidara.git
    cd vidara
    ```

3. **Install** dependencies:

    ```bash
    uv sync --extra dev
    ```

4. **Set up** pre-commit hooks:

    ```bash
    pre-commit install
    ```

5. **Create** a feature branch:

    ```bash
    git checkout -b feat/your-feature develop
    ```

## Development Workflow

```bash
# Run the full check suite before pushing
uv run ruff check src/ tests/
uv run ruff format src/ tests/
uv run mypy src/
uv run pytest --cov=vidara
```

### Branch Naming

| Prefix      | Purpose               |
| ----------- | --------------------- |
| `feat/`     | New feature           |
| `fix/`      | Bug fix               |
| `docs/`     | Documentation only    |
| `refactor/` | Code refactoring      |
| `test/`     | Adding/updating tests |
| `chore/`    | Maintenance tasks     |

## Commit Conventions

We use [Conventional Commits](https://www.conventionalcommits.org/):

```text
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

### Types

| Type       | Description                 |
| ---------- | --------------------------- |
| `feat`     | New feature                 |
| `fix`      | Bug fix                     |
| `docs`     | Documentation changes       |
| `style`    | Formatting (no code change) |
| `refactor` | Code restructuring          |
| `test`     | Adding/modifying tests      |
| `chore`    | Build process or tooling    |
| `perf`     | Performance improvement     |
| `a11y`     | Accessibility improvement   |

### Scopes

- `components` — UI component changes
- `tokens` — Design token changes
- `themes` — Theme-related changes
- `a11y` — Accessibility utilities
- `renderers` — Renderer changes
- `ci` — CI/CD changes
- `deps` — Dependency updates

**Examples:**

```text
feat(components): add Card component with header and footer slots
fix(a11y): correct ARIA labels on Button component
docs(tokens): document color token naming conventions
```

## Pull Request Process

1. **Update** tests for any new functionality
2. **Ensure** all CI checks pass
3. **Update** documentation if needed
4. **Fill out** the PR template completely
5. **Request** review from at least one maintainer
6. **Squash** commits when merging

### PR Title Format

Follow the same conventional commit format:

```text
feat(components): add Tooltip component
```

### Review Criteria

- [ ] All tests pass
- [ ] Coverage doesn't decrease
- [ ] Code follows project style (ruff passes)
- [ ] Types are correct (mypy passes)
- [ ] Accessibility requirements met
- [ ] Documentation updated

## Component Guidelines

When creating or modifying components:

1. **Define** the component model using Pydantic:

    ```python
    from pydantic import BaseModel

    class ButtonProps(BaseModel):
        label: str
        variant: Literal["primary", "secondary", "ghost"]
        disabled: bool = False
        aria_label: str | None = None
    ```

2. **Include** accessibility props by default
3. **Support** theming via design tokens
4. **Write** render methods for each output target
5. **Add** comprehensive tests (unit + a11y)

## Accessibility Requirements

Every component **must**:

- [ ] Include appropriate ARIA attributes
- [ ] Support keyboard navigation
- [ ] Meet WCAG 2.1 AA color contrast ratios (4.5:1 for text, 3:1 for large text)
- [ ] Work with screen readers (test with NVDA/VoiceOver)
- [ ] Manage focus correctly
- [ ] Not rely solely on color to convey information
- [ ] Include a11y test markers: `@pytest.mark.a11y`

## Testing Standards

- **Unit tests** — Every public function/method
- **Integration tests** — Component composition and theming
- **Accessibility tests** — ARIA, contrast, keyboard navigation
- **Visual regression tests** — Rendered output snapshots (when applicable)

### Test File Naming

```text
tests/unit/test_<module>.py
tests/integration/test_<feature>.py
tests/visual/test_<component>_visual.py
```

### Running Specific Test Categories

```bash
# All tests
pytest

# Only accessibility tests
pytest -m a11y

# Only visual tests
pytest -m visual

# Specific module
pytest tests/unit/test_button.py
```

---

## Questions?

Open a [Discussion](https://github.com/migar-git/vidara/discussions) or reach out in an issue. We're happy to help!
