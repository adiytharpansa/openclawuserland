#!/bin/bash
# ┌──────────────────────────────────────────┐
# │  🦀 OpenClaw INSTANT INSTALL             │
# │  UserLAnd / Android - SUPER SIMPLE       │
# │  Copy-paste, Enter, DONE!                │
# └──────────────────────────────────────────┘

set -e

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

clear
echo -e "${BLUE}"
echo "╔══════════════════════════════════════════╗"
echo "║   🦀 OpenClaw INSTANT INSTALL            ║"
echo "║   UserLAnd / Android                     ║"
echo "╚══════════════════════════════════════════╝"
echo -e "${NC}"
echo ""

# Quick check
echo -e "${YELLOW}Checking system...${NC}"
echo ""

# Step 1: OpenClaw
if command -v openclaw &> /dev/null; then
    echo -e "${GREEN}[1/4] ✓ OpenClaw already installed${NC}"
else
    echo -e "${GREEN}[1/4] Installing OpenClaw...${NC}"
    if npm install -g openclaw > /tmp/openclaw-install.log 2>&1; then
        echo -e "${GREEN}         ✓ OpenClaw installed${NC}"
    else
        echo -e "${RED}         ✗ OpenClaw install failed${NC}"
        echo -e "${YELLOW}         Check: /tmp/openclaw-install.log${NC}"
        exit 1
    fi
fi

if command -v ollama &> /dev/null; then
    echo -e "${GREEN}✓ Ollama already installed${NC}"
else
    echo -e "${GREEN}[2/4] Installing Ollama...${NC}"
    curl -fsSL https://ollama.com/install.sh | bash
    echo -e "${GREEN}✓ Done${NC}"
fi

# Model check
echo -e "${GREEN}[3/4] Checking AI model...${NC}"
if ollama list 2>/dev/null | grep -q "llama3.2:1b"; then
    echo -e "${GREEN}✓ Model ready${NC}"
else
    echo -e "${YELLOW}Downloading model (this takes time)...${NC}"
    ollama pull llama3.2:1b
    echo -e "${GREEN}✓ Model ready${NC}"
fi

# Config
echo -e "${GREEN}[4/4] Setting up config...${NC}"
mkdir -p ~/.openclaw
cat > ~/.openclaw/config.json << 'EOF'
{
  "models": {"default": "ollama/llama3.2:1b"},
  "gateway": {"port": 3000}
}
EOF
echo -e "${GREEN}✓ Config ready${NC}"

# Helper scripts
echo ""
echo -e "${YELLOW}Creating quick commands...${NC}"
SCRIPT_DIR=~/openclaw
mkdir -p "$SCRIPT_DIR"

cat > "$SCRIPT_DIR/start.sh" << 'SCRIPT'
#!/bin/bash
echo "🚀 Starting OpenClaw..."
pkill -f "ollama serve" 2>/dev/null || true
pkill -f "openclaw gateway" 2>/dev/null || true
sleep 1
ollama serve > /tmp/ollama.log 2>&1 &
sleep 2
openclaw gateway start > /tmp/openclaw.log 2>&1 &
sleep 2
echo "✅ Ready! Chat via Telegram or run: openclaw"
SCRIPT

cat > "$SCRIPT_DIR/stop.sh" << 'SCRIPT'
#!/bin/bash
echo "🛑 Stopping..."
pkill -f "ollama serve" 2>/dev/null || true
pkill -f "openclaw gateway" 2>/dev/null || true
echo "✅ Stopped"
SCRIPT

cat > "$SCRIPT_DIR/status.sh" << 'SCRIPT'
#!/bin/bash
echo "📊 Status:"
pgrep -f "ollama serve" > /dev/null && echo "  Ollama: ✓ Running" || echo "  Ollama: ✗ Stopped"
pgrep -f "openclaw gateway" > /dev/null && echo "  OpenClaw: ✓ Running" || echo "  OpenClaw: ✗ Stopped"
SCRIPT

chmod +x "$SCRIPT_DIR"/*.sh

echo -e "${GREEN}✓ Scripts ready${NC}"
echo ""

# Done!
echo -e "${GREEN}╔══════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║   ✅ INSTALL COMPLETE!                   ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BLUE}Quick Commands:${NC}"
echo "  ~/openclaw/start.sh    ← Start OpenClaw"
echo "  ~/openclaw/stop.sh     ← Stop OpenClaw"
echo "  ~/openclaw/status.sh   ← Check status"
echo ""
echo -e "${YELLOW}Next step:${NC}"
echo "  Run: ~/openclaw/start.sh"
echo ""
echo -e "${GREEN}🎉 Done! OpenClaw siap dipakai!${NC}"
echo ""
