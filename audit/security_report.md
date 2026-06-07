# vidara — Security Report
**Audit Date:** 2026-03-29
**Standard:** OWASP Top 10 (2021)
**Context:** Python UI component library; no server, no database, no network I/O currently

---

## Overall Assessment

`vidara` currently has an almost zero attack surface: no network I/O, no database, no credential handling, no file system writes, and no user input parsing (beyond what component constructors might accept in the future). The security posture is excellent for what is currently implemented. The security report is largely forward-looking — documenting risks that will emerge as the library is implemented.

`vidara` has the strongest security tooling setup in the portfolio: CodeQL workflow, `dependency-review` workflow, `ruff` with `"S"` (bandit) rules enabled, and `mypy strict`. These controls will catch security issues as implementation proceeds.

---

## Vulnerability Summary (Current)

| ID | OWASP Category | Risk | Status |
|---|---|---|---|
| SEC-1 | A03: Injection (XSS in render) | FUTURE-HIGH | Not yet applicable |
| SEC-2 | A06: Vulnerable Components | LOW | uv.lock pins dependencies |
| SEC-3 | A05: Misconfiguration (CD pipeline) | MEDIUM | Open |
| SEC-4 | A08: Data Integrity (render output) | FUTURE-MEDIUM | Not yet applicable |

---

## Current Findings

### SEC-1: XSS Risk in HTML Renderer (Future — HIGH when implemented)
**OWASP:** A03:2021

**Description:** When the `renderers/` module is implemented and components produce HTML output, any component that embeds user-supplied text (`Button.label`, `Card.title`) without HTML-escaping creates an XSS vector. If `vidara` components are used in web applications (the primary use case), unescaped output could execute JavaScript in the user's browser.

**File:** `src/vidara/renderers/__init__.py` (not yet implemented)

**Recommendation (for implementation):**
1. All component `render()` methods must use `html.escape()` on every user-supplied string before embedding in HTML output.
2. Use Jinja2's autoescape (`Environment(autoescape=True)`) when Jinja2 templates are implemented.
3. Add a Ruff `S` rule check for raw string concatenation in HTML contexts.
4. Add test cases in `tests/unit/` that verify XSS payloads are correctly escaped: `label='<script>alert(1)</script>'` should produce `&lt;script&gt;alert(1)&lt;/script&gt;`.

---

### SEC-2: Vulnerable Components — LOW (uv.lock Mitigates)
**OWASP:** A06:2021

**Description:** `pyproject.toml` has `pydantic>=2.0`, `rich>=13.0`, `jinja2>=3.1` as runtime deps. All three have had CVEs historically. The `uv.lock` file pins exact versions, mitigating the dependency-confusion risk.

**Status:** Substantially mitigated by `uv.lock`. The `dependency-review` GitHub Actions workflow provides additional protection.

**Remaining Gap:** No `pip-audit` or `uv audit` step in the CI workflow — CVEs in pinned versions are not automatically flagged.

**Recommendation:** Add `uv audit` step to `.github/workflows/ci.yml`:
```yaml
- name: Audit dependencies
  run: uv audit
```

---

### SEC-3: CD Pipeline Security — MEDIUM
**OWASP:** A05:2021

**Description:** `.github/workflows/cd.yml` exists. If this workflow publishes to PyPI on a tag push, it must be protected by:
1. PyPI Trusted Publisher (OIDC) — not a stored secret.
2. Branch protection rules preventing direct pushes to `main`.
3. A pre-publish gate that verifies the package actually works (prevents publishing broken Alpha).

The CD workflow configuration was not read in full detail; these are standard requirements for any package publishing pipeline.

**Recommendation:** Verify that:
1. PyPI publishing uses OIDC Trusted Publisher, not a stored `PYPI_TOKEN` secret.
2. The CD workflow includes a `test` job that must pass before `publish`.
3. Manual approval is required for production PyPI releases.

---

### SEC-4: Template Injection Risk in Jinja2 Renderer (Future — MEDIUM)
**OWASP:** A03:2021

**Description:** When `jinja2` is used in `renderers/`, template injection is possible if any Jinja2 template is constructed from user-supplied strings (e.g., `Template(user_input)`). This would allow arbitrary code execution.

**Recommendation (for implementation):**
1. Never construct `Template(user_input)` — only load templates from trusted file paths.
2. Use `jinja2.sandbox.SandboxedEnvironment` for any templates that incorporate user data.
3. Add a Ruff `S` rule for `jinja2.Template()` with non-constant strings.

---

## Security Tooling Assessment — STRONG

The following security controls are already in place and deserve recognition:

| Control | Status | File |
|---|---|---|
| CodeQL static analysis | Active | `.github/workflows/codeql.yml` |
| Dependency review on PRs | Active | `.github/workflows/dependency-review.yml` |
| Ruff `"S"` (bandit) rules | Enabled | `pyproject.toml:69` |
| Mypy strict mode | Enabled | `pyproject.toml:76-83` |
| Pre-commit hooks | Configured | `.pre-commit-config.yaml` |
| uv.lock for reproducible builds | Active | `uv.lock` |

This is the strongest security tooling setup in the portfolio. The controls are appropriate and well-configured. Maintain them as implementation proceeds.
