---
applyTo: "src/vidara/components/**"
---

# Component Development Instructions

## Component Structure

Every UI component follows this pattern:

```python
from __future__ import annotations

from typing import Literal
from pydantic import BaseModel, Field

from vidara.tokens import ThemeTokens
from vidara.a11y import validate_contrast, AriaAttrs


class ComponentProps(BaseModel):
    """Props model with validation and defaults."""
    # Required props
    label: str

    # Optional with defaults
    variant: Literal["primary", "secondary", "ghost"] = "primary"
    disabled: bool = False
    size: Literal["sm", "md", "lg"] = "md"

    # Accessibility — always include
    aria_label: str | None = None
    aria_describedby: str | None = None
    role: str | None = None


class Component:
    """Component with render methods for each target."""

    def __init__(self, props: ComponentProps, theme: ThemeTokens) -> None:
        self.props = props
        self.theme = theme

    def render(self, target: str = "html") -> str:
        """Render to the specified target format."""
        renderer = getattr(self, f"_render_{target}", None)
        if renderer is None:
            raise ValueError(f"Unsupported render target: {target}")
        return renderer()

    def _render_html(self) -> str:
        ...

    def _render_terminal(self) -> str:
        ...
```

## Checklist for New Components

- [ ] Props model with Pydantic validation
- [ ] ARIA attributes in props (aria_label, role, etc.)
- [ ] HTML renderer with semantic markup
- [ ] Terminal renderer using Rich
- [ ] Unit tests in `tests/unit/test_<component>.py`
- [ ] A11y tests with `@pytest.mark.a11y`
- [ ] Design token integration (no hardcoded values)
- [ ] Docstring with usage example
- [ ] Added to `src/vidara/components/__init__.py` exports
