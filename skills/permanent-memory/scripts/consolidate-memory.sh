#!/bin/bash
# consolidate-memory.sh - Review daily notes dan pindahkan yang penting ke MEMORY.md
# Usage: ./consolidate-memory.sh [days_to_review]

set -e

WORKSPACE="${WORKSPACE:-/mnt/data/openclaw/workspace/.openclaw/workspace}"
MEMORY_FILE="$WORKSPACE/MEMORY.md"
MEMORY_DIR="$WORKSPACE/memory"
DAYS="${1:-7}"

echo "📦 Consolidating memory from last $DAYS days..."
echo "================================"

# Find daily notes from last N days
echo ""
echo "Recent daily notes:"
find "$MEMORY_DIR" -name "*.md" -type f -mtime -"$DAYS" 2>/dev/null | sort | while read file; do
    echo "  → $(basename $file)"
done

echo ""
echo "================================"
echo ""
echo "💡 Manual review recommended:"
echo "1. Read each daily note"
echo "2. Identify important decisions/learnings"
echo "3. Add to MEMORY.md using save-memory.sh"
echo "4. Mark reviewed in daily note"
echo ""
