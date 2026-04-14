# 🚀 OpenClaw untuk UserLAnd (Single Session)

**Quick start khusus UserLAnd** — tanpa multi-session, tanpa systemd.

---

## ⚡ Setup Pertama Kali (5 menit)

```bash
# 1. Update & install dependencies
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl wget git python3 python3-pip nodejs npm

# 2. Install OpenClaw
npm install -g openclaw

# 3. Install Ollama
curl -fsSL https://ollama.com/install.sh | sh

# 4. Pull model (pilih yang kecil untuk HP)
ollama pull llama3.2:1b      # 1.3GB, paling cepat
# ATAU
ollama pull qwen2.5:1.5b     # 1.5GB, balanced

# 5. Buat config
mkdir -p ~/.openclaw
cat > ~/.openclaw/config.json << 'EOF'
{
  "models": {
    "default": "ollama/llama3.2:1b",
    "ollama": {
      "baseUrl": "http://localhost:11434"
    }
  },
  "gateway": {
    "port": 3000
  }
}
EOF
```

---

## 📱 Setup Telegram (Optional tapi Recommended)

```bash
# 1. Chat @BotFather di Telegram
# 2. Kirim: /newbot
# 3. Simpan token

# 4. Save config
cat > ~/.openclaw/telegram.json << 'EOF'
{
  "botToken": "YOUR_TOKEN_HERE"
}
EOF
```

---

## 🎯 Cara Pakai (Single Session Workflow)

### Option A: Pakai `screen` (Recommended)

```bash
# Install screen
sudo apt install -y screen

# Start Ollama di background
screen -dmS ollama ollama serve

# Start OpenClaw di background
screen -dmS openclaw openclaw gateway start

# Check running
screen -ls

# Attach ke session
screen -r ollama
screen -r openclaw

# Detach (Ctrl+A, lalu D)
```

### Option B: Pakai `&` (Simple)

```bash
# Start Ollama background
ollama serve > /tmp/ollama.log 2>&1 &

# Start OpenClaw background
openclaw gateway start > /tmp/openclaw.log 2>&1 &

# Check running
ps aux | grep -E "ollama|openclaw"

# Stop
pkill -f "ollama serve"
pkill -f "openclaw gateway"
```

### Option C: Manual (Test Dulu)

```bash
# Terminal 1: Start Ollama
ollama serve

# Lalu buka UserLAnd session baru (jika bisa)
# Atau pakai screen/Option B
```

---

## 📊 Status Check

```bash
# Check Ollama
curl http://localhost:11434/api/tags

# Check OpenClaw
openclaw status

# Check logs
tail -f /tmp/ollama.log
tail -f /tmp/openclaw.log
```

---

## 🔧 One-Command Start Script

Simpan sebagai `start-openclaw.sh`:

```bash
#!/bin/bash
echo "🚀 Starting OpenClaw..."

# Check if already running
if pgrep -f "ollama serve" > /dev/null; then
    echo "⚠️  Ollama already running"
else
    echo "▶️  Starting Ollama..."
    ollama serve > /tmp/ollama.log 2>&1 &
    sleep 3
fi

if pgrep -f "openclaw gateway" > /dev/null; then
    echo "⚠️  OpenClaw already running"
else
    echo "▶️  Starting OpenClaw Gateway..."
    openclaw gateway start > /tmp/openclaw.log 2>&1 &
    sleep 2
fi

echo ""
echo "✅ Services started!"
echo ""
echo "Status:"
curl -s http://localhost:11434/api/tags | head -5
echo ""
openclaw status 2>/dev/null || echo "Check /tmp/openclaw.log for errors"
```

**Usage:**
```bash
chmod +x start-openclaw.sh
./start-openclaw.sh
```

---

## 🛑 Stop Services

```bash
# Simple stop
pkill -f "ollama serve"
pkill -f "openclaw gateway"

# Or with screen
screen -S ollama -X quit
screen -S openclaw -X quit
```

---

## 💾 Save State (Before Close UserLAnd)

UserLAnd akan stop semua process saat ditutup. Save state:

```bash
# Create save script
cat > ~/save-state.sh << 'EOF'
#!/bin/bash
echo "💾 Saving state..."

# Kill services gracefully
pkill -f "ollama serve"
pkill -f "openclaw gateway"

# Backup config
cp -r ~/.openclaw ~/openclaw-backup-$(date +%Y%m%d)

echo "✅ State saved!"
EOF

chmod +x ~/save-state.sh
```

**Run before close UserLAnd:**
```bash
./save-state.sh
```

---

## 📱 Optimasi untuk HP (Low RAM)

### Pilih Model Kecil

```bash
# Very small (under 1GB)
ollama pull llama3.2:1b         # 1.3GB
ollama pull qwen2.5:1.5b        # 1.5GB
ollama pull tinyllama:1.1b      # 630MB

# Medium (2-4GB)
ollama pull llama3.2            # 2GB
ollama pull mistral:7b          # 4.1GB
```

### Limit Ollama Memory

```bash
# Create wrapper script
cat > ~/ollama-limited.sh << 'EOF'
#!/bin/bash
export OLLAMA_MAX_VRAM=2048  # Limit to 2GB
ollama serve
EOF

chmod +x ~/ollama-limited.sh
```

### Use Cloud Models (Jika HP Lemot)

```bash
# Get OpenRouter API key: https://openrouter.ai
cat > ~/.openclaw/config.json << 'EOF'
{
  "models": {
    "default": "openrouter/meta-llama/llama-3-8b-instruct:free",
    "openrouter": {
      "apiKey": "sk-or-YOUR_KEY"
    }
  }
}
EOF
```

---

## 🐛 Troubleshooting UserLAnd

### "Cannot connect to Ollama"

```bash
# Check if running
ps aux | grep ollama

# Restart
pkill -f "ollama serve"
ollama serve > /tmp/ollama.log 2>&1 &
sleep 3
curl http://localhost:11434/api/tags
```

### "Gateway won't start"

```bash
# Check logs
cat /tmp/openclaw.log

# Check port
netstat -tlnp | grep 3000

# Kill and restart
pkill -f "openclaw gateway"
openclaw gateway start
```

### "Out of memory"

```bash
# Use smaller model
ollama pull tinyllama:1.1b

# Or cloud model
# Edit config to use OpenRouter
```

### UserLAnd crash setelah close

Normal! UserLAnd tidak persisten. Pakai save script:

```bash
# Always run before close
./save-state.sh

# Next time, restart
./start-openclaw.sh
```

---

## 📋 Quick Reference

| Command | Description |
|---------|-------------|
| `./start-openclaw.sh` | Start semua services |
| `./save-state.sh` | Save sebelum close |
| `openclaw status` | Check status |
| `ps aux \| grep ollama` | Check Ollama |
| `pkill -f ollama` | Stop Ollama |
| `screen -ls` | List screen sessions |

---

## 🎯 Complete Workflow

```bash
# 1. Buka UserLAnd
# 2. Start services
./start-openclaw.sh

# 3. Test
openclaw status

# 4. Pakai (chat via Telegram atau langsung)

# 5. Sebelum close UserLAnd
./save-state.sh

# Next session: ulangi dari step 1
```

---

## 📚 Next Steps

- Setup Telegram bot untuk chat dari mana saja
- Install skills: `clawhub install git web-browsing`
- Custom workflow di `~/.openclaw/workspace/`

---

**🎉 Selamat! OpenClaw siap di UserLAnd!**

Made for single-session Android workflow. 📱
