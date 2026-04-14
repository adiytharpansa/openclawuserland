#!/bin/bash
# daily-note.sh - Buat atau buka daily note hari ini
# Usage: ./daily-note.sh [date]

set -e

WORKSPACE="${WORKSPACE:-/mnt/data/openclaw/workspace/.openclaw/workspace}"
MEMORY_DIR="$WORKSPACE/memory"
TODAY=$(date -u +"%Y-%m-%d")
DATE="${1:-$TODAY}"
DAILY_FILE="$MEMORY_DIR/$DATE.md"

# Create directory if not exists
mkdir -p "$MEMORY_DIR"

# Create file if not exists
if [ ! -f "$DAILY_FILE" ]; then
    cat > "$DAILY_FILE" << EOF
# $DATE

## Log

## Decisions

## TODO
- [ ] 

## Notes

---
_Source: daily-note.sh_
EOF
    echo "✓ Created $DAILY_FILE"
else
    echo "✓ Opened $DAILY_FILE"
fi

# Output file path for reference
echo "FILE:$DAILY_FILE"
