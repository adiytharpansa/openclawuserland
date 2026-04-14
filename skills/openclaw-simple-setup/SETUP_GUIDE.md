# 🚀 OpenClaw Simple Setup - UserLAnd/Android

Setup OpenClaw yang **simple, powerful, dan mudah** dihubungkan ke Telegram, Signal, dll.

---

## 📋 Prerequisites

```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install basic tools
sudo apt install -y curl wget git python3 python3-pip nodejs npm
```

---

## 🏗️ Step 1: Install OpenClaw

### Option A: Quick Install (Recommended)

```bash
# Install OpenClaw
curl -fsSL https://openclaw.ai/install.sh | bash

# Or manual install
npm install -g openclaw
```

### Option B: From Source

```bash
git clone https://github.com/openclaw/openclaw.git
cd openclaw
npm install
npm link
```

### Verify Installation

```bash
openclaw --version
openclaw status
```

---

## 🔑 Step 2: Setup AI Models

### Option A: Ollama (Local/Cloud)

```bash
# Install Ollama
curl -fsSL https://ollama.com/install.sh | sh

# Pull models
ollama pull llama3.2
ollama pull gemma3:27b
ollama pull qwen2.5:7b

# Start Ollama (default: http://localhost:11434)
ollama serve
```

**Configure in OpenClaw:**

Edit `~/.openclaw/config.json`:

```json
{
  "models": {
    "default": "ollama/llama3.2",
    "ollama": {
      "baseUrl": "http://localhost:11434",
      "apiKey": ""  // Empty for local
    }
  }
}
```

### Option B: OpenRouter (Free Models)

```bash
# Get API key from https://openrouter.ai
export OPENROUTER_API_KEY="your-key-here"
```

Config:

```json
{
  "models": {
    "default": "openrouter/meta-llama/llama-3-8b-instruct:free",
    "openrouter": {
      "apiKey": "sk-or-..."
    }
  }
}
```

### Option C: Multiple Providers

```json
{
  "models": {
    "default": "ollama/llama3.2",
    "fallback": "openrouter/meta-llama/llama-3-8b-instruct:free",
    "ollama": { "baseUrl": "http://localhost:11434" },
    "openrouter": { "apiKey": "sk-or-..." },
    "openai": { "apiKey": "sk-..." }
  }
}
```

---

## 📱 Step 3: Connect Messaging Platforms

### Telegram Bot (Easiest)

1. **Create Bot:**
   - Chat dengan `@BotFather` di Telegram
   - Kirim: `/newbot`
   - Ikuti instruksi, simpan token

2. **Configure:**

```bash
# Set environment
export TELEGRAM_BOT_TOKEN="1234567890:ABCdefGHIjklMNOpqrsTUVwxyz"

# Or edit config
mkdir -p ~/.openclaw
cat > ~/.openclaw/telegram.json << 'EOF'
{
  "botToken": "1234567890:ABCdefGHIjklMNOpqrsTUVwxyz",
  "webhook": false
}
EOF
```

3. **Start Gateway:**

```bash
openclaw gateway start
```

4. **Test:**
   - Cari bot kamu di Telegram
   - Kirim `/start`
   - Bot akan reply!

### Signal Messenger

```bash
# Install signal-cli
sudo apt install -y signal-cli

# Register number (replace with your number)
signal-cli -u +628123456789 register

# Verify with SMS code
signal-cli -u +628123456789 verify "123456"

# Link device (optional)
signal-cli -u +628123456789 link --device-name "OpenClaw"
```

**Configure:**

```bash
cat > ~/.openclaw/signal.json << 'EOF'
{
  "phoneNumber": "+628123456789",
  "dbPath": "/home/user/.local/share/signal-cli"
}
EOF
```

### WhatsApp (via Twilio)

```bash
# Install twilio-cli
npm install -g twilio-cli
twilio login

# Get credentials from https://twilio.com
cat > ~/.openclaw/whatsapp.json << 'EOF'
{
  "accountSid": "AC...",
  "authToken": "...",
  "fromNumber": "whatsapp:+14155238886"
}
EOF
```

---

## ⚡ Step 4: One-Command Setup Script

Simpan sebagai `setup-openclaw.sh`:

```bash
#!/bin/bash
set -e

echo "🚀 OpenClaw Simple Setup"
echo "========================"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Check OS
if [ ! -f /etc/os-release ]; then
    echo -e "${RED}Error: Only supports Linux${NC}"
    exit 1
fi

source /etc/os-release
if [[ "$ID" != "ubuntu" && "$ID" != "debian" ]]; then
    echo -e "${YELLOW}Warning: Untested on $ID${NC}"
fi

# Step 1: Install dependencies
echo -e "${GREEN}[1/5] Installing dependencies...${NC}"
sudo apt update
sudo apt install -y curl wget git python3 python3-pip nodejs npm signal-cli

# Step 2: Install OpenClaw
echo -e "${GREEN}[2/5] Installing OpenClaw...${NC}"
npm install -g openclaw

# Step 3: Setup Ollama
echo -e "${GREEN}[3/5] Setting up Ollama...${NC}"
curl -fsSL https://ollama.com/install.sh | sh
ollama pull llama3.2

# Step 4: Create config
echo -e "${GREEN}[4/5] Creating config...${NC}"
mkdir -p ~/.openclaw

cat > ~/.openclaw/config.json << 'EOF'
{
  "models": {
    "default": "ollama/llama3.2",
    "ollama": {
      "baseUrl": "http://localhost:11434"
    }
  },
  "gateway": {
    "port": 3000
  }
}
EOF

# Step 5: Telegram setup (optional)
echo -e "${GREEN}[5/5] Telegram setup (optional)...${NC}"
read -p "Enter Telegram bot token (or skip): " TG_TOKEN

if [ ! -z "$TG_TOKEN" ]; then
    cat > ~/.openclaw/telegram.json << EOF
{
  "botToken": "$TG_TOKEN"
}
EOF
    echo -e "${GREEN}Telegram configured!${NC}"
else
    echo -e "${YELLOW}Skipping Telegram${NC}"
fi

# Start gateway
echo ""
echo -e "${GREEN}✅ Setup complete!${NC}"
echo ""
echo "Next steps:"
echo "  1. Start gateway: openclaw gateway start"
echo "  2. Start Ollama: ollama serve"
echo "  3. Test: openclaw status"
echo ""
```

**Run:**

```bash
chmod +x setup-openclaw.sh
./setup-openclaw.sh
```

---

## 🔧 Step 5: Advanced Configuration

### Multi-Model Fallback

```json
{
  "models": {
    "default": "ollama/llama3.2",
    "fallbacks": [
      "ollama/gemma3:27b",
      "openrouter/meta-llama/llama-3-8b-instruct:free"
    ],
    "ollama": { "baseUrl": "http://localhost:11434" },
    "openrouter": { "apiKey": "sk-or-..." }
  }
}
```

### Auto-Start on Boot (systemd)

```bash
# Create service
sudo cat > /etc/systemd/system/openclaw-gateway.service << 'EOF'
[Unit]
Description=OpenClaw Gateway
After=network.target ollama.service

[Service]
Type=simple
User=your-username
ExecStart=/usr/bin/openclaw gateway start
Restart=always
Environment="PATH=/usr/bin:/usr/local/bin"

[Install]
WantedBy=multi-user.target
EOF

# Enable and start
sudo systemctl daemon-reload
sudo systemctl enable openclaw-gateway
sudo systemctl start openclaw-gateway
```

### Ollama Service

```bash
sudo cat > /etc/systemd/system/ollama.service << 'EOF'
[Unit]
Description=Ollama Service
After=network.target

[Service]
Type=simple
User=your-username
ExecStart=/usr/local/bin/ollama serve
Restart=always

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable ollama
sudo systemctl start ollama
```

---

## 📊 Quick Commands Reference

| Command | Description |
|---------|-------------|
| `openclaw status` | Check status |
| `openclaw gateway start` | Start gateway |
| `openclaw gateway stop` | Stop gateway |
| `openclaw gateway restart` | Restart gateway |
| `openclaw gateway logs` | View logs |
| `ollama list` | List models |
| `ollama pull <model>` | Download model |
| `ollama run <model>` | Run model interactively |

---

## 🎯 Complete Setup Checklist

- [ ] Install dependencies (curl, git, python3, nodejs)
- [ ] Install OpenClaw (`npm install -g openclaw`)
- [ ] Install Ollama + pull models
- [ ] Configure `~/.openclaw/config.json`
- [ ] Setup Telegram bot (optional)
- [ ] Setup Signal (optional)
- [ ] Start gateway (`openclaw gateway start`)
- [ ] Test connection
- [ ] Setup systemd services (optional)

---

## 🐛 Troubleshooting

### Gateway won't start

```bash
# Check logs
openclaw gateway logs

# Check port
netstat -tlnp | grep 3000

# Restart
openclaw gateway restart
```

### Ollama connection failed

```bash
# Check if running
curl http://localhost:11434/api/tags

# Restart Ollama
sudo systemctl restart ollama
```

### Telegram bot not responding

```bash
# Check token
curl https://api.telegram.org/bot<TOKEN>/getMe

# Restart gateway
openclaw gateway restart
```

---

## 📚 Resources

- **OpenClaw Docs:** https://docs.openclaw.ai
- **Ollama Models:** https://ollama.com/library
- **OpenRouter:** https://openrouter.ai
- **Discord:** https://discord.gg/clawd

---

**🎉 Selamat! OpenClaw siap dipakai!**
