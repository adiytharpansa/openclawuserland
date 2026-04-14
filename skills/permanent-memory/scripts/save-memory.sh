#!/bin/bash
# save-memory.sh - Simpan entry ke MEMORY.md
# Usage: ./save-memory.sh "Entry yang ingin disimpan"

set -e

WORKSPACE="${WORKSPACE:-/mnt/data/openclaw/workspace/.openclaw/workspace}"
MEMORY_FILE="$WORKSPACE/MEMORY.md"
ENTRY="$1"

if [ -z "$ENTRY" ]; then
    echo "Error: Entry required"
    echo "Usage: $0 \"Entry text\""
    exit 1
fi

# Create file if not exists
if [ ! -f "$MEMORY_FILE" ]; then
    echo "# MEMORY.md - Long-term Memory" > "$MEMORY_FILE"
    echo "" >> "$MEMORY_FILE"
    echo "_Curated memories that persist across sessions._" >> "$MEMORY_FILE"
    echo "" >> "$MEMORY_FILE"
fi

# Add timestamp
TIMESTAMP=$(date -u +"%Y-%m-%d %H:%M UTC")
echo "" >> "$MEMORY_FILE"
echo "## [$TIMESTAMP]" >> "$MEMORY_FILE"
echo "$ENTRY" >> "$MEMORY_FILE"

echo "✓ Saved to MEMORY.md"
