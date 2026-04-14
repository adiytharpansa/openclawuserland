#!/bin/bash
set -e

# OpenClaw Simple Setup Script
# For UserLAnd/Android/Ubuntu/Debian

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   🚀 OpenClaw Simple Setup             ║${NC}"
echo -e "${BLUE}║   UserLAnd/Android/Linux               ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"
echo ""

# Check OS
if [ ! -f /etc/os-release ]; then
    echo -e "${RED}❌ Error: Only supports Linux${NC}"
    exit 1
fi

source /etc/os-release
echo -e "${GREEN}✓ Detected:${NC} $PRETTY_NAME"
echo ""

# Step 1: Install dependencies
echo -e "${YELLOW}[1/6] Installing dependencies...${NC}"
sudo apt update -qq
sudo apt install -y -qq curl wget git python3 python3-pip nodejs npm signal-cli > /dev/null 2>&1
echo -e "${GREEN}✓ Dependencies installed${NC}"
echo ""

# Step 2: Install OpenClaw
echo -e "${YELLOW}[2/6] Installing OpenClaw...${NC}"
npm install -g openclaw > /dev/null 2>&1
OPENCLAW_VERSION=$(openclaw --version 2>/dev/null || echo "unknown")
echo -e "${GREEN}✓ OpenClaw $OPENCLAW_VERSION installed${NC}"
echo ""

# Step 3: Setup Ollama
echo -e "${YELLOW}[3/6] Setting up Ollama...${NC}"
if command -v ollama &> /dev/null; then
    echo -e "${GREEN}✓ Ollama already installed${NC}"
else
    curl -fsSL https://ollama.com/install.sh | sh > /dev/null 2>&1
    echo -e "${GREEN}✓ Ollama installed${NC}"
fi

# Pull default model
echo "Pulling llama3.2 model (this may take a while)..."
ollama pull llama3.2 > /dev/null 2>&1
echo -e "${GREEN}✓ Model llama3.2 ready${NC}"
echo ""

# Step 4: Create config directory
echo -e "${YELLOW}[4/6] Creating configuration...${NC}"
mkdir -p ~/.openclaw

# Main config
cat > ~/.openclaw/config.json << 'EOF'
{
  "models": {
    "default": "ollama/llama3.2",
    "fallbacks": [
      "ollama/gemma3:27b",
      "ollama/qwen2.5:7b"
    ],
    "ollama": {
      "baseUrl": "http://localhost:11434",
      "apiKey": ""
    }
  },
  "gateway": {
    "port": 3000,
    "host": "0.0.0.0"
  },
  "workspace": {
    "path": "~/.openclaw/workspace"
  }
}
EOF
echo -e "${GREEN}✓ Config created at ~/.openclaw/config.json${NC}"
echo ""

# Step 5: Messaging platforms (optional)
echo -e "${YELLOW}[5/6] Messaging platforms (optional)${NC}"
echo ""

# Telegram
echo -e "${BLUE}Telegram Setup:${NC}"
echo "  1. Chat @BotFather on Telegram"
echo "  2. Send: /newbot"
echo "  3. Follow instructions, save token"
echo ""
read -p "Enter Telegram bot token (or press Enter to skip): " TG_TOKEN

if [ ! -z "$TG_TOKEN" ]; then
    cat > ~/.openclaw/telegram.json << EOF
{
  "botToken": "$TG_TOKEN",
  "webhook": false
}
EOF
    echo -e "${GREEN}✓ Telegram configured${NC}"
else
    echo -e "${YELLOW}⊘ Skipping Telegram${NC}"
fi
echo ""

# Signal
echo -e "${BLUE}Signal Setup:${NC}"
echo "  Signal requires phone number verification"
echo ""
read -p "Setup Signal? (y/n): " SIGNAL_SETUP

if [ "$SIGNAL_SETUP" = "y" ] || [ "$SIGNAL_SETUP" = "Y" ]; then
    read -p "Enter phone number (e.g., +628123456789): " SIGNAL_PHONE
    
    echo "Registering Signal..."
    signal-cli -u "$SIGNAL_PHONE" register
    
    read -p "Enter verification code from SMS: " SIGNAL_CODE
    signal-cli -u "$SIGNAL_PHONE" verify "$SIGNAL_CODE"
    
    cat > ~/.openclaw/signal.json << EOF
{
  "phoneNumber": "$SIGNAL_PHONE",
  "dbPath": "/home/$(whoami)/.local/share/signal-cli"
}
EOF
    echo -e "${GREEN}✓ Signal configured${NC}"
else
    echo -e "${YELLOW}⊘ Skipping Signal${NC}"
fi
echo ""

# Step 6: Create workspace
echo -e "${YELLOW}[6/6] Setting up workspace...${NC}"
mkdir -p ~/.openclaw/workspace

# Copy skills if exists
if [ -d "/mnt/data/openclaw/workspace/.openclaw/workspace/skills" ]; then
    cp -r /mnt/data/openclaw/workspace/.openclaw/workspace/skills ~/.openclaw/workspace/
    echo -e "${GREEN}✓ Skills copied to workspace${NC}"
fi

# Create basic files
cat > ~/.openclaw/workspace/SOUL.md << 'EOF'
# SOUL.md - Who You Are

Be helpful, concise, and direct. No filler words.
Use Bahasa Indonesia unless asked otherwise.
EOF

cat > ~/.openclaw/workspace/USER.md << 'EOF'
# USER.md - About Your Human

- **Name:** User
- **Timezone:** Asia/Jakarta
- **Notes:** Prefers simple, powerful setups
EOF

echo -e "${GREEN}✓ Workspace ready${NC}"
echo ""

# Final summary
echo ""
echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║   ✅ Setup Complete!                   ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BLUE}Next steps:${NC}"
echo ""
echo "  1. ${YELLOW}Start Ollama:${NC}"
echo "     ollama serve"
echo ""
echo "  2. ${YELLOW}Start OpenClaw Gateway:${NC}"
echo "     openclaw gateway start"
echo ""
echo "  3. ${YELLOW}Check status:${NC}"
echo "     openclaw status"
echo ""
echo "  4. ${YELLOW}Test Telegram (if configured):${NC}"
echo "     Find your bot on Telegram and send /start"
echo ""
echo -e "${BLUE}Optional:${NC}"
echo ""
echo "  - ${YELLOW}Pull more models:${NC}"
echo "    ollama pull gemma3:27b"
echo "    ollama pull qwen2.5:7b"
echo ""
echo "  - ${YELLOW}Auto-start on boot:${NC}"
echo "    ./install-services.sh (run as root)"
echo ""
echo ""
echo -e "${GREEN}🎉 Selamat! OpenClaw siap dipakai!${NC}"
echo ""
