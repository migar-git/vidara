---
applyTo: "src/vidara/tokens/**,src/vidara/themes/**"
---

# Design Token & Theme Instructions

## Token Categories

| Category      | Examples                           | Format            |
| ------------- | ---------------------------------- | ----------------- |
| `color`       | primary, secondary, neutral, error | Hex `#RRGGBB`     |
| `spacing`     | xs, sm, md, lg, xl                 | Integer (px)      |
| `font.size`   | xs, sm, base, lg, xl, 2xl          | Integer (px)      |
| `font.weight` | light, normal, medium, bold        | Integer (100-900) |
| `radius`      | none, sm, md, lg, full             | Integer (px)      |
| `shadow`      | none, sm, md, lg                   | CSS shadow string |
| `z-index`     | base, dropdown, modal, toast       | Integer           |

## Token Naming

Use hierarchical dot-notation:

```python
"color.primary.500"     # Main primary color
"color.primary.100"     # Light variant
"color.primary.900"     # Dark variant
"color.error.500"       # Error state
"spacing.md"            # 16px
"font.size.base"        # 16px
"radius.md"             # 8px
```

## Scale Conventions

- **Colors**: 50, 100, 200, 300, 400, 500 (base), 600, 700, 800, 900, 950
- **Spacing**: xs(4), sm(8), md(16), lg(24), xl(32), 2xl(48), 3xl(64)
- **Font sizes**: xs(12), sm(14), base(16), lg(18), xl(20), 2xl(24), 3xl(30)
- **Border radius**: none(0), sm(4), md(8), lg(12), xl(16), full(9999)

## Theme Structure

Themes compose tokens into semantic roles:

```python
class SemanticColors(BaseModel):
    background: str       # color.neutral.50
    surface: str          # color.neutral.100
    text_primary: str     # color.neutral.900
    text_secondary: str   # color.neutral.600
    accent: str           # color.primary.500
    error: str            # color.error.500
    success: str          # color.success.500
    warning: str          # color.warning.500
```

## Contrast Requirements

- Text on background: minimum 4.5:1 ratio
- Large text (18px+ or 14px+ bold): minimum 3:1 ratio
- Interactive element borders: minimum 3:1 ratio against background
- Always validate with `vidara.a11y.validate_contrast()`
