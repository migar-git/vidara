# vidara — Architecture Analysis
**Audit Date:** 2026-03-29

---

## Current Architecture Diagram (As-Built vs. Intended)

```
── AS-BUILT (v0.1.0) ──────────────────────────────────────────────────────

src/vidara/
├── __init__.py          [IMPLEMENTED] — __version__ = "0.1.0"
├── exceptions.py        [IMPLEMENTED] — 6-class exception hierarchy
├── components/
│   └── __init__.py      [EMPTY] — "from __future__ import annotations" only
├── tokens/
│   └── __init__.py      [EMPTY] — "from __future__ import annotations" only
├── themes/
│   └── __init__.py      [EMPTY] — "from __future__ import annotations" only
├── a11y/
│   └── __init__.py      [EMPTY] — "from __future__ import annotations" only
└── renderers/
    └── __init__.py      [EMPTY] — "from __future__ import annotations" only

tests/
├── unit/test_smoke.py   [IMPLEMENTED] — 2 smoke tests
├── integration/         [EMPTY] — __init__.py only
└── visual/              [EMPTY] — __init__.py only

── INTENDED (per README) ───────────────────────────────────────────────────

┌──────────────────────────────────────────────────────────────────────┐
│                     Theme / Token System                            │
│  tokens/           — colors, spacing, typography, shadows           │
│  themes/           — presets (default, dark, custom)               │
│  Theme.from_preset("default") → Theme instance                     │
└──────────────────────────────────────────────────────────────────────┘
                    │ theming
                    ▼
┌──────────────────────────────────────────────────────────────────────┐
│                   Component Layer                                   │
│  components/       — Button, Card, (others implied)                 │
│  Button(label, variant, theme) → Component                         │
│  Card(title, children, theme) → Component                          │
└──────────────────────────────────────────────────────────────────────┘
                    │ accessibility validation
                    ▼
┌──────────────────────────────────────────────────────────────────────┐
│               Accessibility Layer                                   │
│  a11y/             — ARIA attribute generation                      │
│                    — WCAG 2.1 AA contrast checking                 │
│                    — Focus management                               │
│                    — Screen reader compatibility                    │
└──────────────────────────────────────────────────────────────────────┘
                    │ rendering
                    ▼
┌──────────────────────────────────────────────────────────────────────┐
│                 Renderer Layer                                      │
│  renderers/        — HTMLRenderer (Jinja2 templates)               │
│                    — TerminalRenderer (rich)                        │
└──────────────────────────────────────────────────────────────────────┘
                    │
                    ▼
┌──────────────────────────────────────────────────────────────────────┐
│                    Output                                           │
│  HTML string (for web)                                              │
│  Terminal markup (for CLI dashboards)                               │
└──────────────────────────────────────────────────────────────────────┘
```

---

## Detected Anti-Patterns

### AP-1: README Claims Are Aspirational, Not Reflective of Reality
- **File:** `README.md:50-57`
- **Problem:** The usage example presents `Button`, `Card`, and `Theme` as importable. None exist. This is the most damaging anti-pattern for an open-source library: users who install the package get `ImportError` and file bugs or abandon the project.

### AP-2: Runtime Dependencies Added Before They Are Needed
- **File:** `pyproject.toml:26` — `"pydantic>=2.0", "rich>=13.0", "jinja2>=3.1"`
- **Problem:** All three are in `dependencies` (not `optional-dependencies`). Any `pip install vidara` pulls in 3 significant packages for zero functionality. The correct approach is to add dependencies at the commit that first uses them.

### AP-3: Strict `mypy` Configuration Without Any Real Code to Check
- **File:** `pyproject.toml:76-83` — `strict = true`, `disallow_untyped_defs = true`
- **Problem:** Strict mypy passes trivially on empty `__init__.py` files. This creates a false sense of type safety. The strict configuration is correct as a target, but it needs to be exercised against real implementations to have any value.

### AP-4: All Test Infrastructure Is Scaffolding With No Test Content
- **File:** `tests/integration/__init__.py`, `tests/visual/__init__.py` — empty
- **Problem:** Empty test directories inflate the apparent structure without providing any test coverage. Integration tests and visual regression tests are the most valuable for a UI component library and should be the second implementation priority (after the components themselves).

### AP-5: No Rendering Target Decision Documented
- **File:** `src/vidara/renderers/__init__.py` — empty, no design decision recorded
- **Problem:** The rendering architecture (Jinja2 HTML? Python-to-HTML? Server-side? Static?) is the foundational design decision for a UI library. Implementing components before this decision risks having to rewrite them. `DECISIONS.md` (if it existed) should document this.

### AP-6: Exception Hierarchy Defined Before the Exceptions Can Be Raised
- **File:** `src/vidara/exceptions.py`
- **Assessment (not an anti-pattern, but note):** The exception hierarchy is well-designed. `VidaraError → TokenError`, `ThemeError`, `RenderError`, `AccessibilityError → ContrastError` maps correctly to the intended component structure. This is actually a good practice — defining the error contract before the implementation.

---

## Refactor Recommendations (Prioritized)

These are ordered by implementation sequence, not severity, as the codebase is in early development.

### P1 — Decision Log: Pin the Rendering Architecture (This Week)
Write `DECISIONS.md` documenting:
- Rendering targets: HTML (via Jinja2), Terminal (via rich), or abstract component tree?
- Component model: class-based with `render()` method, or functional?
- Pydantic v2 model-based component props or dataclasses?
- Are components stateful or stateless?

This decision tree determines the implementation of `tokens/`, `themes/`, `components/`, `renderers/`, and `a11y/` in that order.

### P2 — Implement `tokens/` First (Week 1)
Design tokens are the foundation. Implement:
- `ColorToken` (hex, RGB, HSL with conversion)
- `SpacingToken` (rem-based scale)
- `TypographyToken` (font family, size scale, weight)
- `ShadowToken`
- `Theme` dataclass combining token sets
These are pure data structures — no rendering, no Jinja2, no ARIA — and are the safest first implementation.

### P3 — Implement `a11y/` ContrastChecker (Week 1)
```python
def relative_luminance(color: tuple[int, int, int]) -> float: ...
def contrast_ratio(fg: tuple, bg: tuple) -> float: ...
def check_wcag_aa(fg: tuple, bg: tuple, large_text: bool = False) -> bool: ...
```
This is a standard WCAG algorithm with no external dependencies (stdlib math only). Implementing this before components ensures every component can validate its own contrast.

### P4 — Implement `Button` Component (Week 2)
```python
@dataclass
class Button:
    label: str
    variant: Literal["primary", "secondary", "danger"]
    theme: Theme
    disabled: bool = False
    aria_label: str | None = None

    def render(self) -> str:  # HTML string
        ...

    def validate_accessibility(self) -> None:
        # Raises AccessibilityError if contrast ratio < 4.5:1
        ...
```

### P5 — Remove Unused Dependencies Until Needed (Week 1)
Move `rich` and `jinja2` to `[project.optional-dependencies]`:
```toml
[project.optional-dependencies]
html-renderer = ["jinja2>=3.1"]
terminal-renderer = ["rich>=13.0"]
```
Keep `pydantic` in `dependencies` only if used for component prop validation.

### P6 — Update README to Reflect Current Reality (Week 1)
Change the usage example to show only what actually works:
```python
from vidara import __version__
from vidara.exceptions import AccessibilityError, ContrastError
```
Add a "Roadmap" section showing planned features with status badges.
