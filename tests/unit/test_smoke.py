"""Smoke test to verify the package imports correctly."""

from __future__ import annotations


def test_version_is_set() -> None:
    from vidara import __version__

    assert __version__ == "0.1.0"


def test_exceptions_importable() -> None:
    from vidara.exceptions import (
        AccessibilityError,
        ContrastError,
        RenderError,
        ThemeError,
        TokenError,
        VidaraError,
    )

    assert issubclass(TokenError, VidaraError)
    assert issubclass(ThemeError, VidaraError)
    assert issubclass(RenderError, VidaraError)
    assert issubclass(AccessibilityError, VidaraError)
    assert issubclass(ContrastError, AccessibilityError)
