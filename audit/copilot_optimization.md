# vidara — Copilot Optimization
**Audit Date:** 2026-03-29

---

## Copilot-Readiness Score: **70 / 100**

| Dimension | Score | Notes |
|---|---|---|
| Tooling configuration | 95 | Best-in-portfolio: UV, hatchling, mypy strict, ruff with S/ANN/B rules, pre-commit |
| `.github/copilot-instructions.md` | 85 | Present (per README reference); provides architecture context for Copilot |
| Docstrings on implemented code | 75 | Exception classes have good docstrings |
| Type annotations | 80 | `from __future__ import annotations` throughout; mypy strict target |
| Implementation to generate from | 15 | Almost nothing implemented for Copilot to learn patterns from |
| Test examples for generation | 20 | Only 2 smoke tests; no component test patterns for Copilot to follow |

**Assessment:** Vidara has the best tooling scaffolding in the portfolio but the lowest implementation density. Copilot has a clear configuration context (via `copilot-instructions.md`) and correct type annotation style, but nothing to generate *more of* because there is nothing yet. The score of 70 reflects the excellent setup infrastructure that will pay off as soon as implementation begins.

---

## How to Restructure for Copilot Effectiveness

### 1. Implement One Complete Component as the "Golden Example"
Before asking Copilot to generate any more components, implement `Button` completely (props, render, validate_accessibility, tests). Copilot's ability to generate `Card`, `Input`, `Modal`, etc. will be dramatically better when it has one complete, tested, typed reference implementation to pattern-match against.

### 2. Add `@dataclass` or Pydantic Model Props to Components
Define component props using Pydantic v2 `BaseModel` (since it's already a dependency). Copilot generates excellent Pydantic models from docstrings and type hints. This gives every new component a consistent, well-typed interface that Copilot can extend correctly.

### 3. Add `ComponentSpec` TypedDict or Dataclass Defining Required Attributes
```python
@dataclass
class ComponentSpec:
    name: str
    aria_role: str
    required_aria_attributes: list[str]
    wcag_level: Literal["A", "AA", "AAA"]
    allowed_variants: list[str]
```
Copilot will use this spec to generate correct ARIA implementations when asked to create new components.

### 4. Add `tests/unit/test_button.py` as a Testing Pattern Template
Once `Button` is implemented, the test file becomes the template for all other component tests. Structure it with clear sections: `TestButtonProps`, `TestButtonRender`, `TestButtonAccessibility`. Copilot will replicate this structure for every subsequent component.

### 5. Add `docs/components/button.md` as Documentation Template
A Sphinx RST or Markdown doc for `Button` with: description, props table, accessibility notes, usage examples, and browser support. This becomes the documentation pattern Copilot will replicate for new components.

---

## 5 Specific Prompt Patterns for This Repo

### Prompt 1 — Implement Design Token System
```
Implement the design token system in src/vidara/tokens/__init__.py.
Create these Pydantic v2 BaseModel classes (already a dependency):
  ColorToken(name: str, hex_value: str) — validate hex format
  SpacingToken(name: str, value_rem: float) — validate > 0
  TypographyToken(name: str, font_family: str, size_rem: float, weight: int)
  ShadowToken(name: str, css_value: str)
  Theme(name: str, colors: dict[str, ColorToken], spacing: dict[str, SpacingToken],
        typography: dict[str, TypographyToken], shadows: dict[str, ShadowToken])
  Theme.from_preset(name: str) -> "Theme" — implement "default" and "dark" presets
Add __all__ exporting Theme and all token classes.
Raise TokenError from exceptions.py on validation failures.
Add tests in tests/unit/test_tokens.py.
```

### Prompt 2 — Implement WCAG Contrast Checker
```
Implement WCAG 2.1 AA contrast checking in src/vidara/a11y/__init__.py.
Functions needed:
  relative_luminance(r: int, g: int, b: int) -> float
    — WCAG formula: linearize each channel, apply luminance coefficients
  contrast_ratio(fg_rgb: tuple[int, int, int],
                 bg_rgb: tuple[int, int, int]) -> float
    — (lighter + 0.05) / (darker + 0.05)
  check_wcag_aa(fg: tuple[int, int, int], bg: tuple[int, int, int],
                large_text: bool = False) -> bool
    — WCAG AA requires 4.5:1 (normal) or 3:1 (large text)
Raise ContrastError from exceptions.py if check fails.
Add __all__. Add tests in tests/unit/test_a11y.py with known color pairs and
expected contrast ratios (e.g., black on white = 21:1).
No external dependencies — stdlib math only.
```

### Prompt 3 — Implement Button Component
```
Implement Button component in src/vidara/components/__init__.py.
Use Pydantic v2 BaseModel for props:
  class Button(BaseModel):
    label: str
    variant: Literal["primary", "secondary", "danger"] = "primary"
    theme: Theme  # import from tokens
    disabled: bool = False
    aria_label: str | None = None

    def render(self) -> str: ...  # returns HTML string with correct ARIA attributes
    def validate_accessibility(self) -> None: ...  # raises AccessibilityError if contrast fails
Require: aria_label must be provided if label contains only an icon.
Use html.escape() on label before inserting into HTML.
Add tests in tests/unit/test_button.py covering: render output, aria attributes,
disabled state, contrast validation.
```

### Prompt 4 — Add HTML Renderer
```
Implement HTML renderer in src/vidara/renderers/__init__.py.
Use Jinja2 (already a dependency) with templates in src/vidara/templates/.
  class HTMLRenderer:
    def __init__(self, template_dir: Path | None = None)
    def render(self, component: Any) -> str
    def render_to_file(self, component: Any, output_path: Path) -> None
Raise RenderError from exceptions.py on Jinja2 template errors.
Create src/vidara/templates/button.html.jinja2 for Button.
Add tests in tests/unit/test_renderer.py.
```

### Prompt 5 — Add Visual Regression Test
```
Implement a visual regression test framework in tests/visual/.
Use pytest-snapshot or a simple file comparison approach:
  1. tests/visual/test_button_visual.py renders Button with default theme
  2. Compares rendered HTML against a stored snapshot in tests/visual/snapshots/
  3. On first run (--snapshot-update flag), writes the snapshot
  4. On subsequent runs, fails if output differs
Add conftest.py with snapshot fixture.
Mark these tests with @pytest.mark.visual so they can be skipped in unit CI.
```

---

## Agent Integration Opportunities

### Opportunity 1 — Copilot-Driven Component Generation From Specification
Once the `ComponentSpec` dataclass is implemented, an agent can read a spec file, call Copilot to generate the component implementation, run tests, and iterate until tests pass. This is the "design system factory" pattern — the hardest part of a design system (implementing 50+ consistent components) becomes agent-automatable.

### Opportunity 2 — WCAG Compliance Auditor Agent
An agent that installs `vidara`, imports all components, renders them with the default theme, and runs `validate_accessibility()` on each. Reports pass/fail to a compliance dashboard. This is only possible once components and the a11y module are implemented.

### Opportunity 3 — Theme Generation From Color Palette
An agent that takes a brand color hex code, generates a WCAG-compliant color palette (ensuring 4.5:1 contrast ratios), and produces a `Theme` object. The `ContrastChecker` (when implemented) provides the validation function; the agent provides the generation loop.

### Opportunity 4 — Accessible Component Documentation Generator
An agent that imports each component, renders it with multiple variants, computes contrast ratios, and generates a `docs/components/<name>.md` file with the rendered HTML, WCAG compliance badge, and prop table. Automates the most tedious part of design system documentation.
