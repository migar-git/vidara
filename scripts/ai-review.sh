#!/usr/bin/env bash
# scripts/ai-review.sh — Review a doc against myprd exit criteria
# Usage: bash scripts/ai-review.sh <doc-path> [--strict] [--output markdown|json]
set -euo pipefail

DOC="${1:?Usage: ai-review.sh <doc-path> [--strict] [--output markdown|json]}"
STRICT=0 OUTPUT_FMT="markdown"
while [[ $# -gt 1 ]]; do
  case "$1" in
    --strict) STRICT=1; shift ;;
    --output) OUTPUT_FMT="$2"; shift 2 ;;
    *) shift ;;
  esac
done

# Detect doc type from path
if echo "$DOC" | grep -q "02-product/prd"; then     DOC_TYPE="PRD"
elif echo "$DOC" | grep -q "03-architecture/adr";   then DOC_TYPE="ADR"
elif echo "$DOC" | grep -q "runbooks";              then DOC_TYPE="Runbook"
elif echo "$DOC" | grep -q "postmortems";           then DOC_TYPE="Postmortem"
else DOC_TYPE="Generic"
fi

DOC_CONTENT=$(cat "$DOC")
PROMPT="Review this $DOC_TYPE documentation against its exit criteria.
For each criterion output: PASS / WARN / FAIL — with specific evidence or gap.
Check completeness, accuracy, frontmatter validity, and clarity of all required sections.
Document content:
$DOC_CONTENT"

echo "AI Review: $DOC — $(date +%Y-%m-%d)"
echo "Type: $DOC_TYPE"
echo "---"
RESULT=$(echo "$PROMPT" | python3 scripts/_ai-call.py cloud 2>/dev/null || \
  echo "AI review skipped — provider not configured (set AI_API_KEY)")
echo "$RESULT"

if [[ $STRICT -eq 1 ]] && echo "$RESULT" | grep -q "FAIL"; then
  echo "STRICT mode: FAIL findings detected — blocking"
  exit 1
fi
