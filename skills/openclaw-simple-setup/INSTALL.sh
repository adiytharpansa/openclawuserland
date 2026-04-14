#!/bin/bash
# ┌──────────────────────────────────────────┐
# │  OpenClaw ONE-CLICK INSTALL              │
# │  Untuk UserLAnd/Android                  │
# │  Copy-paste ini, tekan Enter, DONE!      │
# └──────────────────────────────────────────┘

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

clear
echo -e "${BLUE}"
echo "╔══════════════════════════════════════════╗"
echo "║   🚀 OpenClaw ONE-CLICK INSTALL          ║"
echo "║   UserLAnd / Android / Linux             ║"
echo "╚══════════════════════════════════════════╝"
echo -e "${NC}"

# Step 1: Install dependencies
echo -e "${GREEN}[1/5] Installing dependencies...${NC}"
sudo apt update -qq
sudo apt install -y -qq curl git nodejs npm > /dev/null 2>&1
echo -e "${GREEN}✓ Done${NC}"
sleep 1

# Step 2: Install OpenClaw
echo -e "${GREEN}[2/5] Installing OpenClaw...${NC}"
npm install -g openclaw > /dev/null 2>&1
echo -e "${GREEN}✓ OpenClaw installed${NC}"
sleep 1

# Step 3: Install Ollama
echo -e "${GREEN}[3/5] Installing Ollama...${NC}"
curl -fsSL https://ollama.com/install.sh | sh > /dev/null 2>&1
echo -e "${GREEN}✓ Ollama installed${NC}"
sleep 1

# Step 4: Pull model
echo -e "${GREEN}[4/5] Downloading AI model (this takes time)...${NC}"
ollama pull llama3.2:1b > /dev/null 2>&1
echo -e "${GREEN}✓ Model ready${NC}"
sleep 1

# Step 5: Create config
echo -e "${GREEN}[5/5] Creating config...${NC}"
mkdir -p ~/.openclaw
cat > ~/.openclaw/config.json << 'EOF'
{
  "models": {"default": "ollama/llama3.2:1b"},
  "gateway": {"port": 3000}
}
EOF
echo -e "${GREEN}✓ Config created${NC}"
sleep 1

# Download helper scripts
echo ""
echo -e "${YELLOW}Downloading helper scripts...${NC}"
SCRIPT_DIR=~/openclaw
mkdir -p "$SCRIPT_DIR"

# start.sh
cat > "$SCRIPT_DIR/start.sh" << 'SCRIPT'
#!/bin/bash
echo "🚀 Starting..."
pkill -f "ollama serve" 2>/dev/null || true
pkill -f "openclaw gateway" 2>/dev/null || true
sleep 1
ollama serve > /tmp/ollama.log 2>&1 &
sleep 2
openclaw gateway start > /tmp/openclaw.log 2>&1 &
sleep 2
echo "✅ Ready!"
openclaw status
SCRIPT
chmod +x "$SCRIPT_DIR/start.sh"

# stop.sh
cat > "$SCRIPT_DIR/stop.sh" << 'SCRIPT'
#!/bin/bash
echo "🛑 Stopping..."
pkill -f "ollama serve"
pkill -f "openclaw gateway"
echo "✅ Stopped"
SCRIPT
chmod +x "$SCRIPT_DIR/stop.sh"

# status.sh
cat > "$SCRIPT_DIR/status.sh" << 'SCRIPT'
#!/bin/bash
echo "📊 Status:"
echo ""
echo "Ollama:"
curl -s http://localhost:11434/api/tags | grep -o '"name":"[^"]*"' || echo "  Not running"
echo ""
echo "OpenClaw:"
openclaw status 2>/dev/null || echo "  Not running"
SCRIPT
chmod +x "$SCRIPT_DIR/status.sh"

echo -e "${GREEN}✓ Scripts ready${NC}"
echo ""

# Done!
echo ""
echo -e "${GREEN}╔══════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║   ✅ INSTALLATION COMPLETE!              ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BLUE}Commands:${NC}"
echo "  Start:  ~/openclaw/start.sh"
echo "  Stop:   ~/openclaw/stop.sh"
echo "  Status: ~/openclaw/status.sh"
echo ""
echo -e "${YELLOW}Next step:${NC}"
echo "  Run: ~/openclaw/start.sh"
echo ""
echo -e "${GREEN}🎉 Selamat! OpenClaw siap dipakai!${NC}"
echo ""
