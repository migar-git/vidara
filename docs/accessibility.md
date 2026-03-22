# Accessibility Guide

Vidara is built with accessibility as a core principle, not an afterthought.

## WCAG 2.1 AA Compliance

Every component in Vidara meets [WCAG 2.1 Level AA](https://www.w3.org/WAI/WCAG21/quickref/) requirements.

### Color Contrast

| Context                  | Minimum Ratio |
| ------------------------ | ------------- |
| Normal text (< 18px)     | 4.5:1         |
| Large text (>= 18px)     | 3:1           |
| UI components & graphics | 3:1           |

Use `vidara.a11y.check_contrast()` to validate programmatically.

### Keyboard Navigation

All interactive components support:

- **Tab** — Move focus forward
- **Shift+Tab** — Move focus backward
- **Enter/Space** — Activate focused element
- **Escape** — Dismiss overlays, close modals
- **Arrow keys** — Navigate within composite widgets

### ARIA Attributes

Components automatically include appropriate ARIA attributes:

```python
# Button generates:
# <button role="button" aria-label="Submit" aria-disabled="false">Submit</button>

btn = Button(label="Submit")
```

### Screen Reader Support

- All images and icons have text alternatives
- Dynamic content changes are announced via `aria-live` regions
- Form inputs are associated with labels via `aria-labelledby`
- Error messages are linked via `aria-describedby`

## Testing Accessibility

```bash
# Run all accessibility tests
pytest -m a11y

# Run with verbose output
pytest -m a11y -v
```

## Resources

- [WCAG 2.1 Quick Reference](https://www.w3.org/WAI/WCAG21/quickref/)
- [ARIA Authoring Practices](https://www.w3.org/WAI/ARIA/apg/)
- [Color Contrast Checker](https://webaim.org/resources/contrastchecker/)
