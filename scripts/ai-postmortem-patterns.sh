#!/usr/bin/env bash
# scripts/ai-postmortem-patterns.sh — Identify recurring root causes across incidents
# Usage: bash scripts/ai-postmortem-patterns.sh [--path docs/07-operations/postmortems]
set -euo pipefail

POSTMORTEM_DIR="${1:-docs/07-operations/postmortems}"

if [ ! -d "$POSTMORTEM_DIR" ]; then
  echo "No postmortem directory found at $POSTMORTEM_DIR"
  exit 0
fi

POSTMORTEMS=$(find "$POSTMORTEM_DIR" -name "*.md" ! -name "_*" 2>/dev/null | sort)
COUNT=$(echo "$POSTMORTEMS" | grep -c . 2>/dev/null || echo 0)

if [ "$COUNT" -eq 0 ]; then
  echo "No postmortems found in $POSTMORTEM_DIR"
  exit 0
fi

echo "Analyzing $COUNT postmortem(s) for recurring patterns..."
COMBINED=$(cat $POSTMORTEMS)
PROMPT="Analyze these $COUNT postmortems and identify:
1. Top 3 recurring root cause categories
2. Most common contributing factors
3. Action items that were never resolved
4. Recommendations to prevent recurrence
Postmortems:
$COMBINED"

echo "$PROMPT" | python3 scripts/_ai-call.py cloud 2>/dev/null || \
  echo "AI analysis skipped — set AI_API_KEY to enable"
