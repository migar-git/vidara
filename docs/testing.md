---
prd-version: "1.0"
last-updated: "2026-04-27"
status: "Current"
---

# Testing Guide - vidara

## Framework
pytest + pytest-asyncio + pytest-cov

## Running Tests
`ash
pytest -q                    # all tests
pytest tests/unit/ -q        # unit only
pytest --cov=src/ -q         # with coverage
`


## Coverage Target
>= 70% of src/

## Test Structure
tests/unit/ - no external calls
tests/integration/ - with services

