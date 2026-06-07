---
applyTo: "**"
---

# Vidara — Copilot Workspace Instructions

## Project Identity

- **Name**: Vidara
- **Type**: Python UI component library and design system toolkit
- **Python**: 3.11+ (target 3.13)
- **Build system**: Hatchling via pyproject.toml
- **Package manager**: uv (preferred) or pip
- **Source layout**: `src/vidara/` (src-layout)

## Architecture

```
src/vidara/
├── components/   # UI component models (Pydantic-based)
├── tokens/       # Design tokens: colors, spacing, typography, shadows
├── themes/       # Theme presets and configuration engine
├── a11y/         # Accessibility validators and ARIA utilities
└── renderers/    # Output renderers (HTML, terminal/Rich, JSON)
```

## Coding Standards

### Style & Formatting

- **Formatter**: ruff format (line-length 100)
- **Linter**: ruff (rules: E, W, F, I, N, UP, B, A, SIM, TCH, ANN, S, RUF)
- **Type checker**: mypy --strict
- All public APIs must have type annotations
- Use `from __future__ import annotations` in every module
- Prefer `str | None` over `Optional[str]`

### Naming Conventions

- **Modules**: snake_case (`design_tokens.py`)
- **Classes**: PascalCase (`ButtonProps`, `ThemeConfig`)
- **Functions/methods**: snake_case (`render_html()`)
- **Constants**: UPPER_SNAKE_CASE (`DEFAULT_FONT_SIZE`)
- **Design tokens**: dot-notation strings (`"color.primary.500"`)

### Patterns

- Components use **Pydantic BaseModel** for props validation
- Every component implements a `render()` method
- Design tokens are typed dataclasses or Pydantic models
- Themes compose tokens into a coherent configuration
- Renderers are strategy-pattern classes that consume component trees
- Use `rich` for terminal output rendering

### Error Handling

- Raise specific exceptions from `vidara.exceptions`
- Never catch broad `Exception` — catch specific types
- Validation errors should surface clear messages for component consumers

## Accessibility (A11Y) — CRITICAL

Every component MUST:

1. Include correct ARIA attributes (`role`, `aria-label`, `aria-describedby`, etc.)
2. Support keyboard navigation (tab order, Enter/Space activation, Escape dismiss)
3. Pass WCAG 2.1 AA contrast ratios (4.5:1 normal text, 3:1 large text)
4. Not rely on color alone to convey information
5. Manage focus correctly (trap focus in modals, restore on close)
6. Be tested with `@pytest.mark.a11y` marker

When reviewing or generating component code, ALWAYS verify these requirements.

## Testing

- **Framework**: pytest
- **Coverage target**: 80% minimum, aim for 90%+
- **Test location**: `tests/unit/`, `tests/integration/`, `tests/visual/`
- **Markers**: `@pytest.mark.a11y`, `@pytest.mark.slow`, `@pytest.mark.visual`
- Every new component needs: unit tests + a11y tests
- Use `pytest-cov` for coverage reporting

### Test naming

```python
def test_button_renders_primary_variant() -> None: ...
def test_button_includes_aria_label_when_provided() -> None: ...
def test_theme_applies_color_tokens() -> None: ...
```

## Git & CI/CD

- **Commits**: Conventional Commits (`feat:`, `fix:`, `docs:`, `a11y:`, etc.)
- **Branches**: `main` (stable), `develop` (integration), `feat/*`, `fix/*`, `docs/*`
- **CI**: Runs on every push/PR — lint, typecheck, test (3.11/3.12/3.13), a11y audit
- **CD**: Triggered by version tags (`v*`) — build, publish to PyPI, deploy docs
- **Security**: CodeQL weekly + on PR, dependency review on PR

## Design Token Conventions

```python
# Token naming follows: category.property.variant
"color.primary.500"
"color.neutral.100"
"spacing.sm"        # 8px
"spacing.md"        # 16px
"font.size.base"    # 16px
"font.weight.bold"  # 700
"radius.md"         # 8px
"shadow.sm"         # subtle drop shadow
```

## Dependencies

- **pydantic** >=2.0 — Component prop validation
- **rich** >=13.0 — Terminal rendering
- **jinja2** >=3.1 — HTML template rendering

Dev dependencies: pytest, pytest-cov, ruff, mypy, pre-commit, sphinx

## What NOT to Do

- Do NOT use `Any` types unless absolutely unavoidable
- Do NOT skip accessibility attributes on components
- Do NOT add dependencies without discussion
- Do NOT write components without corresponding tests
- Do NOT use `print()` for output — use the renderer system
- Do NOT hardcode colors/sizes — use design tokens

## Time Rules
- All timestamps UTC ISO 8601 (e.g. `2026-03-30T14:30:00Z`)
- No local timezone assumptions — agents run across machines
- Use absolute dates in commit messages, logs, and memory files
- No relative dates ("yesterday", "last week") in any persisted text
