#!/bin/bash
# Save state before closing UserLAnd
# Usage: ./save-state.sh

set -e

echo "💾 Saving OpenClaw state..."
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Stop services gracefully
echo -e "${YELLOW}Stopping services...${NC}"

if pgrep -f "ollama serve" > /dev/null; then
    pkill -f "ollama serve"
    echo -e "${GREEN}✓ Ollama stopped${NC}"
else
    echo -e "${YELLOW}⊘ Ollama not running${NC}"
fi

if pgrep -f "openclaw gateway" > /dev/null; then
    pkill -f "openclaw gateway"
    echo -e "${GREEN}✓ OpenClaw Gateway stopped${NC}"
else
    echo -e "${YELLOW}⊘ OpenClaw Gateway not running${NC}"
fi

# Backup config
BACKUP_DIR=~/openclaw-backup-$(date +%Y%m%d-%H%M)
echo ""
echo -e "${YELLOW}Creating backup: $BACKUP_DIR${NC}"

mkdir -p "$BACKUP_DIR"
cp -r ~/.openclaw "$BACKUP_DIR/" 2>/dev/null || true

if [ -d "$BACKUP_DIR/.openclaw" ]; then
    echo -e "${GREEN}✓ Config backed up${NC}"
else
    echo -e "${YELLOW}⚠️  No config to backup${NC}"
fi

# Show restore instructions
echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}State saved!${NC}"
echo ""
echo "Next time you open UserLAnd:"
echo "  1. Restore (if needed): cp -r $BACKUP_DIR/.openclaw ~/"
echo "  2. Start: ./start-openclaw.sh"
echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
