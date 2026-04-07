---
title: "Vidara — Product Requirements Document"
version: "1.0"
status: "Active"
owner: "migar"
last-updated: "2026-04-07"
---

# Vidara — PRD

> **Version 1.0** | Active | Updated 2026-04-07

## 1. Vision & Problem Statement

Python-based applications lack a first-class, accessibility-first UI component library comparable to what the JavaScript ecosystem offers (Radix, Shadcn, Material). Developers building Python-rendered UIs must either adopt JavaScript toolchains or assemble accessibility attributes manually, leading to inconsistent, non-WCAG-compliant interfaces. Vidara provides a Python-native design system — token-based, themeable, type-safe, and WCAG 2.1 AA compliant — so Python developers can build consistent, accessible UIs without leaving the Python ecosystem.

## 2. Goals & Success Metrics

| Goal | KPI | Target | Measurement Method |
|---|---|---|---|
| WCAG 2.1 AA compliance | A11y test pass rate | 100% of shipped components | `pytest -m a11y` in CI |
| Test coverage | Branch + line coverage | >=80% (enforced by `fail_under`) | pytest-cov in CI |
| Type safety | mypy strict errors | Zero | CI gate |
| PyPI availability | Published package | Installable via `pip install vidara` | PyPI release check |
| Developer experience | Time to render first component | <5 lines of Python | Quickstart example |

## 3. User Personas & Stakeholders

| Persona | Role | Pain Points | What Success Looks Like |
|---|---|---|---|
| Python UI Developer | Builds Flask/FastAPI/CLI UIs in Python | No accessible component primitives; manual ARIA attrs | Import `Button`, render WCAG-compliant HTML in 2 lines |
| Design System Maintainer | Owns token/theme definitions | Inconsistent tokens across projects | Single `Theme.from_preset()` applied globally |
| Accessibility Auditor | Reviews WCAG compliance | Components fail ARIA audits post-hoc | All components carry verified ARIA attributes by default |
| Contributor | Open-source contributor | No clear conventions; no CI feedback | PR CI runs full lint + type + a11y + visual regression |

## 4. Functional Requirements

### 4.1 Component Library
- FR-001: MUST provide a `components/` module with at minimum `Button` and `Card` components
- FR-002: MUST support a `variant` parameter per component (e.g. `primary`, `secondary`, `danger`)
- FR-003: MUST expose a `render()` method on every component returning a string (HTML or terminal markup)
- FR-004: MUST accept a `theme` parameter on every component for token injection

### 4.2 Design Tokens
- FR-005: MUST provide a `tokens/` module covering colors, spacing, and typography
- FR-006: MUST support light and dark mode token sets

### 4.3 Theming
- FR-007: MUST provide `Theme.from_preset("default")` and at least one named preset
- FR-008: MUST support custom token overrides per-theme instance

### 4.4 Accessibility
- FR-009: MUST embed correct ARIA attributes in every rendered component
- FR-010: MUST validate color contrast ratios against WCAG 2.1 AA in `a11y/` validators
- FR-011: MUST support keyboard navigation metadata in component output
- FR-012: MUST include screen reader compatibility annotations
- FR-013: MUST provide focus management metadata

### 4.5 Renderers
- FR-014: MUST provide an HTML renderer producing valid, semantic HTML5
- FR-015: SHOULD provide a terminal/Rich renderer for CLI UIs

### 4.6 Testing
- FR-016: MUST maintain unit tests in `tests/unit/`, integration tests in `tests/integration/`, and visual regression tests in `tests/visual/`
- FR-017: MUST use `pytest -m a11y` marker for accessibility-specific tests

## 5. Non-Functional Requirements (NFRs)

| Category | Requirement | Target | Priority |
|---|---|---|---|
| Python version | Minimum runtime | 3.11+ (py311–py313 CI matrix) | Must |
| Test coverage | Enforced floor | >=80% branch + line | Must |
| Type annotations | mypy strict | Zero errors | Must |
| Package size | Installed footprint | <5MB (no heavy UI dependencies) | Should |
| CI/CD | Automated lint + test + publish | All checks green on every PR | Must |
| License | Open source | MIT | Must |
| Dependencies | Runtime deps | pydantic>=2.0, rich>=13.0, jinja2>=3.1 only | Should |

## 6. Constraints & Assumptions

- Python-side rendering only — not a JavaScript component library
- WCAG 2.1 AA is the minimum accessibility target; AAA is aspirational
- `uv` is the recommended package manager; pip also supported
- Semantic HTML5 is the primary output format for the HTML renderer
- Visual regression tests require a headless browser or image-diff tooling (not yet specified)
- Package not yet published to PyPI (v0.1.0, Alpha)

## 7. Out of Scope (v1.0)

- JavaScript / TypeScript components
- React, Vue, or Svelte wrappers
- Server-side streaming / HTMX-specific patterns
- Full interactive web previewer (frontend/ directory is scaffolded but not shipped)
- Internationalization (i18n) / RTL layout support
- Animation / motion tokens

## 8. Risks & Mitigations

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| WCAG spec interpretation inconsistency | Medium | High | Reference WCAG 2.1 spec directly; link tests to spec IDs |
| Visual regression tests require image snapshots — brittle in CI | Medium | Medium | Use perceptual diff threshold; skip on first run |
| Jinja2 renderer produces unsafe HTML if user data injected | Low | High | Auto-escape all user-supplied values; document policy |
| Package namespace conflict on PyPI | Low | Medium | Verify name availability before first publish |

## 9. Document Index

| Document | Path | Status |
|---|---|---|
| README | `/README.md` | Current |
| Changelog | `/CHANGELOG.md` | Active |
| Accessibility guide | `/docs/accessibility.md` | Referenced (not yet written) |
| Contributing guide | `/.github/CONTRIBUTING.md` | Current |
| CI workflow | `/.github/workflows/ci.yml` | Active |
| CD workflow | `/.github/workflows/cd.yml` | Active |
