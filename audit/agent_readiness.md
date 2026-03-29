# vidara — Agent Readiness Assessment
**Audit Date:** 2026-03-29

---

## Agent Readiness Score: **28 / 100**

| Dimension | Score | Notes |
|---|---|---|
| Callable API for tool use | 10 | Only `exceptions.py` and `__version__` are implemented |
| CI/CD infrastructure | 90 | Best in portfolio: CodeQL, dependency review, CD pipeline |
| `.github/copilot-instructions.md` | 80 | Present; provides design system context for agent generation |
| Structured output | 0 | No components implemented; no rendered output to consume |
| Tool discoverability | 20 | No MCP manifest; no tool registry; no API |
| Test specifications as agent contracts | 30 | 2 smoke tests define the exception hierarchy; no component contract tests |

**Assessment:** `vidara`'s agent readiness score reflects its scaffolding-only state. The infrastructure is actually well-suited for agent-driven development (`.github/copilot-instructions.md`, strict CI, CodeQL) — the score is low because there is nothing for an agent to *use* yet. The roadmap below is therefore an implementation roadmap, not just an agent-integration roadmap.

---

## What's Present for Agent Automation

- **`.github/copilot-instructions.md`**: present (unique in the portfolio). This is the single most important file for agent-driven development — it gives Copilot and other code-generation agents architectural context, naming conventions, and design philosophy.
- **Exception hierarchy**: the 6-class exception tree (`VidaraError → TokenError, ThemeError, RenderError, AccessibilityError → ContrastError`) is a well-designed contract. Agents generating component code know exactly which exceptions to raise.
- **`pyproject.toml` with `[tool.ruff.lint] select = [..., "ANN", "S", "B", "RUF"]`**: comprehensive linting rules mean agent-generated code is automatically checked for annotations, security, and bugs on every commit.
- **CI workflow on every push to main**: any agent-generated code that breaks tests is caught immediately.
- **`uv.lock`**: reproducible builds mean agents running in different environments (CI, developer machine, agent sandbox) get identical dependency trees.
- **`pre-commit` hooks**: automatically enforced code style on agent-generated commits.

---

## What's Missing

1. **Any implemented functionality**: An agent cannot use `vidara` as a tool because there are no tools — no components, no tokens, no renderers, no a11y validators.

2. **Component specification format**: Without a machine-readable spec format (JSON schema, YAML, or dataclass), agents must infer component properties from README prose, which is unreliable.

3. **MCP server or tool manifest**: No `.vscode/mcp.json`, no `GET /mcp/tools`. Cannot be used by Claude Code's agent runtime.

4. **No `DECISIONS.md`**: Agents asked to extend `vidara` don't know the rendering target, component model (class-based vs. functional), or prop validation strategy. This is the most critical missing document.

5. **No API surface**: No HTTP server, no Python API beyond exceptions. Agents cannot call `vidara` as a tool in any meaningful way.

6. **No component test template**: Without a reference `test_button.py` showing how components should be tested, agents generating new components have no test pattern to follow.

---

## 4-Milestone Roadmap to Full Agent Readiness

### Milestone 1: Foundation — Design Tokens and Architecture Decision (Weeks 1–2)
- Write `DECISIONS.md` documenting rendering architecture (HTML-first recommended).
- Implement `tokens/` module: `ColorToken`, `SpacingToken`, `TypographyToken`, `Theme`.
- Implement `a11y/` module: `ContrastChecker`, `relative_luminance()`, `contrast_ratio()`.
- Add 20+ unit tests covering token validation and WCAG contrast calculations.
- Fix README to reflect current state.
- Remove unused `rich` and `jinja2` from `dependencies` until renderers are implemented.
- **Deliverable:** Agents have a working, tested token system to build components on top of. The DECISIONS.md provides architectural context that dramatically improves agent code generation quality.

### Milestone 2: First Component and Renderer (Weeks 3–5)
- Implement `components/Button` with Pydantic v2 props, `render() -> str`, `validate_accessibility()`.
- Implement `renderers/HTMLRenderer` using Jinja2 with autoescape.
- Add 30+ component tests: render output, ARIA attributes, contrast validation, disabled state.
- Update README with working examples.
- Export all implemented classes from `src/vidara/__init__.py`.
- **Deliverable:** `vidara` has one fully implemented, tested, accessible component. An agent can now extend the library by pattern-matching against `Button`.

### Milestone 3: Component Library Expansion via Agent-Driven Development (Weeks 6–10)
- Define `ComponentSpec` dataclass as machine-readable component specification.
- Create specifications for `Card`, `Input`, `Select`, `Modal`, `Alert`.
- Use Copilot (guided by `.github/copilot-instructions.md`) to generate component implementations from specs.
- Human review of each generated component for accessibility and WCAG compliance.
- Achieve 80%+ test coverage across all components.
- **Deliverable:** 6+ components implemented, tested, and documented. Agent-driven development is validated as the primary delivery mechanism.

### Milestone 4: MCP Tool Export and Design System Factory Agent (Weeks 11–12)
- Create `src/vidara/mcp_server.py` exporting: `render_component(name, props) -> str`, `validate_accessibility(name, props) -> bool`, `list_components() -> list[str]`, `get_component_spec(name) -> ComponentSpec`.
- Add `.vscode/mcp.json` pointing to local MCP server.
- Add theme generation MCP tool: `generate_theme(brand_color: str) -> Theme` (WCAG-compliant palette from color).
- **Deliverable:** `vidara` is a first-class design system tool in Claude Code's agent runtime. An LLM agent can render components, validate accessibility, and generate themes on-demand.
