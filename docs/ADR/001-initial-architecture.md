# ADR-001: Initial Architecture — Vidara

**Date:** 2026-04-07
**Status:** Accepted

## Context

Needed a Python-native UI component library that enforces accessibility (WCAG 2.1 AA) by default and supports token-based theming. Existing libraries lacked accessibility-first design and Python-native APIs.

## Decision

Build Vidara as a Python package using a `src/` layout. Components implement WCAG 2.1 AA compliance as a first-class requirement. Design tokens power light/dark mode theming. Full type annotations with mypy strict.

## Rationale

- Python-native: fits existing Python-first developer workflow
- WCAG-first: accessibility built in, not bolted on
- Token-based theming: consistent, maintainable design system
- src/ layout: prevents import confusion during development

## Consequences

- Positive: Consistent accessibility across all components
- Positive: Themeable via token system — easy white-labeling
- Positive: Type-safe API reduces integration errors
- Negative: Python-only — not usable in JS/TS projects
- Negative: Visual regression testing is more complex in Python than in browser-native tools
