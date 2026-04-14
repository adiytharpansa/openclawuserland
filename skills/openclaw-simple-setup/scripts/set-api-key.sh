#!/bin/bash
# ┌──────────────────────────────────────────┐
# │  🔑 OpenClaw - Set API Key               │
# │  Flexible API Key Management             │
# └──────────────────────────────────────────┘

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'

CONFIG=~/.openclaw/config.json
BACKUP=~/.openclaw/config.json.backup

echo -e "${BLUE}"
echo "╔══════════════════════════════════════════╗"
echo "║   🔑 API Key Manager                     ║"
echo "╚══════════════════════════════════════════╝"
echo -e "${NC}"
echo ""

# Check if config exists
if [ ! -f "$CONFIG" ]; then
    echo -e "${RED}❌ Config not found!${NC}"
    echo ""
    echo "Run install first:"
    echo "  curl -fsSL https://YOUR-REPO/INSTALL-CLOUD.sh | bash"
    exit 1
fi

# Backup existing config
cp "$CONFIG" "$BACKUP"
echo -e "${GREEN}✓ Config backed up${NC}"
echo ""

# Show current status
echo -e "${CYAN}Current Status:${NC}"
if grep -q "apiKey" "$CONFIG" && ! grep -q '"apiKey": ""' "$CONFIG"; then
    echo -e "${GREEN}  API Key: ✓ Configured${NC}"
else
    echo -e "${YELLOW}  API Key: ✗ Not set (using free tier)${NC}"
fi
echo ""

# Menu
echo -e "${YELLOW}Options:${NC}"
echo "  1. Set new API key"
echo "  2. Remove API key (use free tier)"
echo "  3. Show current config"
echo "  4. Restore backup"
echo "  5. Exit"
echo ""
read -p "Choice [1-5]: " CHOICE

case $CHOICE in
    1)
        echo ""
        echo -e "${CYAN}Get API Key:${NC}"
        echo "  https://openrouter.ai/keys"
        echo ""
        read -p "Paste API key: " KEY
        
        if [ -z "$KEY" ]; then
            echo -e "${RED}❌ Empty key${NC}"
            exit 1
        fi
        
        # Extract existing config and update
        MODEL=$(grep -o '"default": "[^"]*"' "$CONFIG" | cut -d'"' -f4)
        if [ -z "$MODEL" ]; then
            MODEL="openrouter/meta-llama/llama-3-8b-instruct:free"
        fi
        
        cat > "$CONFIG" << EOF
{
  "models": {
    "default": "$MODEL",
    "openrouter": {
      "apiKey": "$KEY"
    }
  },
  "gateway": {"port": 3000}
}
EOF
        echo -e "${GREEN}✅ API key updated!${NC}"
        echo ""
        echo "Restart OpenClaw?"
        read -p "y/n: " RESTART
        if [ "$RESTART" = "y" ]; then
            ~/openclaw/stop.sh 2>/dev/null
            sleep 1
            ~/openclaw/start.sh
        fi
        ;;
    
    2)
        # Remove API key, keep model
        MODEL=$(grep -o '"default": "[^"]*"' "$CONFIG" | cut -d'"' -f4)
        if [ -z "$MODEL" ]; then
            MODEL="openrouter/meta-llama/llama-3-8b-instruct:free"
        fi
        
        cat > "$CONFIG" << EOF
{
  "models": {
    "default": "$MODEL"
  },
  "gateway": {"port": 3000}
}
EOF
        echo -e "${GREEN}✅ API key removed (free tier)${NC}"
        ;;
    
    3)
        echo ""
        echo -e "${CYAN}Current Config:${NC}"
        cat "$CONFIG"
        echo ""
        ;;
    
    4)
        if [ -f "$BACKUP" ]; then
            cp "$BACKUP" "$CONFIG"
            echo -e "${GREEN}✓ Config restored${NC}"
        else
            echo -e "${RED}✗ Backup not found${NC}"
        fi
        ;;
    
    5)
        echo "Bye!"
        exit 0
        ;;
    
    *)
        echo -e "${RED}Invalid choice${NC}"
        exit 1
        ;;
esac

echo ""
echo -e "${GREEN}Done!${NC}"
