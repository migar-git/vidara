---
prd-version: "1.0"
last-updated: "2026-04-27"
status: "Current"
---

# Developer Guide - vidara

## Prerequisites
Python 3.11+, Git

## Setup
`ash
git clone https://github.com/migar-git/vidara.git && cd vidara
python -m venv .venv && .venv\Scripts\activate
pip install -e ".[dev]"
`


## Workflow
Branch: feature/{slug}, Commit: type(scope): description

## Test
`ash
pytest -q
`


## Lint
`ash
ruff check src/ tests/ && black --check src/ tests/
`


