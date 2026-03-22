# Security Policy

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| 0.x     | :white_check_mark: |

## Reporting a Vulnerability

If you discover a security vulnerability within Vidara, please report it responsibly:

1. **Do NOT** open a public GitHub issue
2. **Email** the maintainers or use [GitHub's private vulnerability reporting](https://github.com/migar-git/vidara/security/advisories/new)
3. Include:
    - Description of the vulnerability
    - Steps to reproduce
    - Potential impact
    - Suggested fix (if any)

We will acknowledge your report within **48 hours** and aim to release a fix within **7 days** for critical vulnerabilities.

## Security Best Practices

This project follows these security practices:

- **Dependency scanning** via GitHub Dependabot and CodeQL
- **SAST** (Static Application Security Testing) on every PR
- **Pre-commit hooks** that detect private keys and large files
- **Pinned CI dependencies** to prevent supply chain attacks
- **Signed releases** when publishing to PyPI
