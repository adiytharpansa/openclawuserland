#!/bin/bash
# ┌──────────────────────────────────────────┐
# │  🦀 OpenClaw CLOUD - SMART INSTALL       │
# │  API Key Flexible / Auto / Skip          │
# └──────────────────────────────────────────┘

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'

clear
echo -e "${BLUE}"
echo "╔══════════════════════════════════════════╗"
echo "║   🦀 OpenClaw CLOUD INSTALL              ║"
echo "║   Smart API Key Setup                    ║"
echo "╚══════════════════════════════════════════╝"
echo -e "${NC}"
echo ""

# Step 1: Install OpenClaw
echo -e "${GREEN}[1/4] Installing OpenClaw...${NC}"
if npm install -g openclaw --silent 2>/dev/null; then
    echo -e "${GREEN}       ✓ Done${NC}"
elif command -v sudo &> /dev/null && sudo npm install -g openclaw --silent 2>/dev/null; then
    echo -e "${GREEN}       ✓ Done (sudo)${NC}"
else
    echo -e "${YELLOW}       Local install...${NC}"
    mkdir -p ~/.npm-global
    npm config set prefix '~/.npm-global'
    grep -q "npm-global" ~/.bashrc || echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.bashrc
    export PATH=~/.npm-global/bin:$PATH
    npm install -g openclaw --silent 2>/dev/null
    echo -e "${GREEN}       ✓ Done (local)${NC}"
fi

if ! command -v openclaw &> /dev/null; then
    echo -e "${RED}       ✗ Failed${NC}"
    exit 1
fi

# Step 2: API Key Setup (FLEXIBLE!)
echo ""
echo -e "${GREEN}[2/4] API Key Setup${NC}"
echo ""
echo -e "${CYAN}OpenRouter API Key (Optional)${NC}"
echo ""
echo "  • Free tier available (no key needed)"
echo "  • Get key: https://openrouter.ai"
echo "  • Key = higher limits + more models"
echo ""
echo -e "${YELLOW}Options:${NC}"
echo "  1. Enter API key now"
echo "  2. Skip (use free tier, add key later)"
echo "  3. Get key now (open browser)"
echo ""
read -p "Choice [1-3]: " CHOICE

API_KEY=""

case $CHOICE in
    1)
        read -p "Paste API key: " API_KEY
        if [ -z "$API_KEY" ]; then
            echo -e "${YELLOW}       Empty, using free tier${NC}"
        else
            echo -e "${GREEN}       ✓ Key saved${NC}"
        fi
        ;;
    2)
        echo -e "${YELLOW}       Skipping (free tier)${NC}"
        ;;
    3)
        echo -e "${BLUE}       Opening browser...${NC}"
        if command -v xdg-open &> /dev/null; then
            xdg-open https://openrouter.ai/keys 2>/dev/null || true
        elif command -v gnome-open &> /dev/null; then
            gnome-open https://openrouter.ai/keys 2>/dev/null || true
        else
            echo -e "${YELLOW}       Manual: https://openrouter.ai/keys${NC}"
        fi
        echo ""
        read -p "Paste API key (or Enter to skip): " API_KEY
        if [ -n "$API_KEY" ]; then
            echo -e "${GREEN}       ✓ Key saved${NC}"
        else
            echo -e "${YELLOW}       Using free tier${NC}"
        fi
        ;;
    *)
        echo -e "${YELLOW}       Invalid, using free tier${NC}"
        ;;
esac

# Step 3: Create Config
echo ""
echo -e "${GREEN}[3/4] Creating config...${NC}"
mkdir -p ~/.openclaw

if [ -n "$API_KEY" ]; then
    cat > ~/.openclaw/config.json << EOF
{
  "models": {
    "default": "openrouter/meta-llama/llama-3-8b-instruct:free",
    "openrouter": {
      "apiKey": "$API_KEY"
    }
  },
  "gateway": {"port": 3000}
}
EOF
else
    cat > ~/.openclaw/config.json << 'EOF'
{
  "models": {
    "default": "openrouter/meta-llama/llama-3-8b-instruct:free"
  },
  "gateway": {"port": 3000}
}
EOF
fi
echo -e "${GREEN}       ✓ Config ready${NC}"

# Step 4: Helper Scripts
echo ""
echo -e "${GREEN}[4/4] Creating helper scripts...${NC}"
mkdir -p ~/openclaw

cat > ~/openclaw/start.sh << 'SCRIPT'
#!/bin/bash
echo "🚀 Starting OpenClaw Cloud..."
pkill -f "openclaw gateway" 2>/dev/null || true
openclaw gateway start > /tmp/ocl.log 2>&1 &
sleep 2
echo "✅ Ready!"
openclaw status
SCRIPT

cat > ~/openclaw/stop.sh << 'SCRIPT'
#!/bin/bash
echo "🛑 Stopping..."
pkill -f "openclaw gateway" 2>/dev/null || true
echo "✅ Stopped"
SCRIPT

cat > ~/openclaw/status.sh << 'SCRIPT'
#!/bin/bash
echo "📊 Status:"
pgrep -f "openclaw gateway" > /dev/null && echo "  ✓ Running" || echo "  ✗ Stopped"
openclaw status 2>/dev/null || true
SCRIPT

cat > ~/openclaw/setup-tele.sh << 'SCRIPT'
#!/bin/bash
echo "📞 Telegram Setup"
echo "1. Chat @BotFather"
echo "2. Send: /newbot"
echo "3. Copy token"
echo ""
read -p "Token: " TOKEN
echo "{\"botToken\":\"$TOKEN\"}" > ~/.openclaw/telegram.json
echo "✅ Done! Restart: ~/openclaw/stop.sh && ~/openclaw/start.sh"
SCRIPT

cat > ~/openclaw/set-api-key.sh << 'SCRIPT'
#!/bin/bash
echo "🔑 Set API Key"
echo ""
echo "Get key: https://openrouter.ai/keys"
echo ""
read -p "Paste API key: " KEY

if [ -z "$KEY" ]; then
    echo "❌ Empty key"
    exit 1
fi

# Read existing config
CONFIG=~/.openclaw/config.json
if [ -f "$CONFIG" ]; then
    # Update with key
    cat > "$CONFIG" << EOF
{
  "models": {
    "default": "openrouter/meta-llama/llama-3-8b-instruct:free",
    "openrouter": {
      "apiKey": "$KEY"
    }
  },
  "gateway": {"port": 3000}
}
EOF
    echo "✅ API key updated!"
    echo ""
    echo "Restarting..."
    ~/openclaw/stop.sh
    sleep 1
    ~/openclaw/start.sh
else
    echo "❌ Config not found. Run install first!"
    exit 1
fi
SCRIPT

chmod +x ~/openclaw/*.sh
echo -e "${GREEN}       ✓ Scripts ready${NC}"

# Done
echo ""
echo -e "${GREEN}╔══════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║   ✅ INSTALL COMPLETE!                   ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BLUE}Quick Commands:${NC}"
echo "  ~/openclaw/start.sh       ← Start"
echo "  ~/openclaw/stop.sh        ← Stop"
echo "  ~/openclaw/status.sh      ← Check"
echo "  ~/openclaw/setup-tele.sh  ← Telegram"
echo "  ~/openclaw/set-api-key.sh ← Add API key later"
echo ""
echo -e "${YELLOW}Next Step:${NC}"
echo "  Run: ~/openclaw/start.sh"
echo ""
if [ -n "$API_KEY" ]; then
    echo -e "${GREEN}🎉 Done! API key configured!${NC}"
else
    echo -e "${GREEN}🎉 Done! Using free tier${NC}"
    echo -e "${YELLOW}💡 Add API key later: ~/openclaw/set-api-key.sh${NC}"
fi
echo ""
