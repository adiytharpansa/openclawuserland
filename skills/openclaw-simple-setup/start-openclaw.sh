#!/bin/bash
# Start OpenClaw for UserLAnd (Single Session)
# Usage: ./start-openclaw.sh

set -e

echo "🚀 Starting OpenClaw..."
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Check if Ollama is running
if pgrep -f "ollama serve" > /dev/null; then
    echo -e "${YELLOW}⚠️  Ollama already running${NC}"
else
    echo -e "${GREEN}▶️  Starting Ollama...${NC}"
    ollama serve > /tmp/ollama.log 2>&1 &
    sleep 3
    
    # Verify
    if curl -s http://localhost:11434/api/tags > /dev/null; then
        echo -e "${GREEN}✓ Ollama started${NC}"
    else
        echo -e "${RED}✗ Ollama failed - check /tmp/ollama.log${NC}"
        exit 1
    fi
fi

# Check if Gateway is running
if pgrep -f "openclaw gateway" > /dev/null; then
    echo -e "${YELLOW}⚠️  OpenClaw Gateway already running${NC}"
else
    echo -e "${GREEN}▶️  Starting OpenClaw Gateway...${NC}"
    openclaw gateway start > /tmp/openclaw.log 2>&1 &
    sleep 2
    
    # Verify
    if openclaw status > /dev/null 2>&1; then
        echo -e "${GREEN}✓ OpenClaw Gateway started${NC}"
    else
        echo -e "${YELLOW}⚠️  Gateway starting... check /tmp/openclaw.log${NC}"
    fi
fi

echo ""
echo -e "${GREEN}✅ Services started!${NC}"
echo ""

# Show status
echo -e "${YELLOW}Ollama Models:${NC}"
curl -s http://localhost:11434/api/tags 2>/dev/null | grep -o '"name":"[^"]*"' | head -5 || echo "  (checking...)"

echo ""
echo -e "${YELLOW}OpenClaw Status:${NC}"
openclaw status 2>/dev/null || echo "  Check /tmp/openclaw.log for errors"

echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}Next steps:${NC}"
echo "  1. Test: openclaw status"
echo "  2. Telegram: Find your bot and send /start"
echo "  3. Stop: pkill -f 'ollama serve' && pkill -f 'openclaw gateway'"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
