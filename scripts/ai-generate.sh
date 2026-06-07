#!/usr/bin/env bash
# scripts/ai-generate.sh — Generate a first draft from template + context
# Usage: bash scripts/ai-generate.sh <template-path> [--context <str>] [--output <path>]
set -euo pipefail

TEMPLATE="${1:?Usage: ai-generate.sh <template-path> [--context <str|file|url>] [--output <path>]}"
CONTEXT="" OUTPUT=""
while [[ $# -gt 1 ]]; do
  case "$1" in
    --context) CONTEXT="$2"; shift 2 ;;
    --output)  OUTPUT="$2";  shift 2 ;;
    *) shift ;;
  esac
done

# Route to local LLM for governance docs
if echo "$OUTPUT" | grep -q "10-governance"; then
  PROVIDER="local"
else
  PROVIDER="cloud"
fi

# Fetch context if it's a GitHub URL
if echo "$CONTEXT" | grep -q "github.com"; then
  CONTEXT=$(gh api "$(echo "$CONTEXT" | sed 's|github.com|api.github.com/repos|;s|/issues/|/issues/|')" \
    --jq '.body' 2>/dev/null || echo "$CONTEXT")
fi

TEMPLATE_CONTENT=$(cat "$TEMPLATE")
PROMPT="Generate a documentation first draft following this template EXACTLY.
Fill every required section. Set status to Draft. Date: $(date +%Y-%m-%d).
Context: $CONTEXT
Template: $TEMPLATE_CONTENT"

OUTFILE="${OUTPUT:-/dev/stdout}"
echo "<!-- AI-generated draft — human review required -->" > "$OUTFILE"
echo "$PROMPT" | python3 scripts/_ai-call.py "$PROVIDER" >> "$OUTFILE" 2>/dev/null || \
  echo "# [Draft required — AI provider not configured]" >> "$OUTFILE"
echo "Generated: ${OUTPUT:-stdout}"
