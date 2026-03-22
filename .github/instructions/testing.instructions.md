---
applyTo: "tests/**"
---

# Testing Instructions

## Test Organization

```text
tests/
├── conftest.py            # Shared fixtures (themes, token sets)
├── unit/                  # Isolated unit tests
│   ├── test_button.py
│   ├── test_card.py
│   └── test_tokens.py
├── integration/           # Component composition + theming tests
│   ├── test_theme_application.py
│   └── test_component_tree.py
└── visual/                # Rendered output snapshot tests
    └── test_button_visual.py
```

## Fixtures

Define shared fixtures in `tests/conftest.py`:

```python
import pytest
from vidara.themes import Theme

@pytest.fixture
def default_theme() -> Theme:
    return Theme.from_preset("default")

@pytest.fixture
def dark_theme() -> Theme:
    return Theme.from_preset("dark")
```

## Test Naming

```python
def test_<component>_<behavior>() -> None:
    """Tests should read like specifications."""

# Good
def test_button_renders_primary_variant_with_correct_classes() -> None: ...
def test_button_disabled_includes_aria_disabled_attribute() -> None: ...
def test_theme_override_applies_custom_colors() -> None: ...

# Bad
def test_button() -> None: ...
def test_render() -> None: ...
```

## Accessibility Test Pattern

```python
import pytest

@pytest.mark.a11y
def test_button_has_aria_label_fallback() -> None:
    """Button uses label as aria-label when not explicitly set."""
    btn = Button(label="Submit")
    html = btn.render("html")
    assert 'aria-label="Submit"' in html

@pytest.mark.a11y
def test_button_contrast_meets_wcag_aa() -> None:
    """Button text/background contrast meets 4.5:1 ratio."""
    from vidara.a11y import check_contrast
    theme = Theme.from_preset("default")
    ratio = check_contrast(theme.color.primary[500], theme.color.neutral[50])
    assert ratio >= 4.5
```

## Coverage

- Target: 80% minimum, 90%+ preferred
- Run: `pytest --cov=vidara --cov-report=term-missing`
- New components must ship with tests — PRs without tests will be rejected
