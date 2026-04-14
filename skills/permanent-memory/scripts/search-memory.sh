#!/bin/bash
# search-memory.sh - Cari di semua memori
# Usage: ./search-memory.sh "keyword"

set -e

WORKSPACE="${WORKSPACE:-/mnt/data/openclaw/workspace/.openclaw/workspace}"
MEMORY_FILE="$WORKSPACE/MEMORY.md"
MEMORY_DIR="$WORKSPACE/memory"
QUERY="$1"

if [ -z "$QUERY" ]; then
    echo "Error: Query required"
    echo "Usage: $0 \"search term\""
    exit 1
fi

echo "🔍 Searching for: $QUERY"
echo "================================"

# Search in MEMORY.md
if [ -f "$MEMORY_FILE" ]; then
    echo ""
    echo "📄 MEMORY.md:"
    grep -n -i -C 2 "$QUERY" "$MEMORY_FILE" || echo "  (no matches)"
fi

# Search in daily notes
if [ -d "$MEMORY_DIR" ]; then
    echo ""
    echo "📅 Daily Notes:"
    grep -r -n -i -l "$QUERY" "$MEMORY_DIR"/*.md 2>/dev/null | while read file; do
        echo "  → $(basename $file)"
    done || echo "  (no matches)"
fi

echo ""
echo "================================"
