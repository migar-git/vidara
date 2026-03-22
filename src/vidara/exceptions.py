"""Custom exceptions for Vidara."""

from __future__ import annotations


class VidaraError(Exception):
    """Base exception for all Vidara errors."""


class TokenError(VidaraError):
    """Raised when a design token is invalid or not found."""


class ThemeError(VidaraError):
    """Raised when theme configuration is invalid."""


class RenderError(VidaraError):
    """Raised when component rendering fails."""


class AccessibilityError(VidaraError):
    """Raised when accessibility requirements are not met."""


class ContrastError(AccessibilityError):
    """Raised when color contrast does not meet WCAG requirements."""
