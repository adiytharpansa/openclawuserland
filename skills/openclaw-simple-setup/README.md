# 🚀 OpenClaw Simple Setup

**Setup OpenClaw yang simple, powerful, dan mudah** untuk UserLAnd/Android/Linux.

Support: **Telegram**, **Signal**, **WhatsApp**, **Ollama**, **OpenRouter**, dan lebih banyak lagi!

---

## 📦 What's Included

```
openclaw-simple-setup/
├── README.md              # This file
├── SETUP_GUIDE.md         # Complete documentation
├── setup-openclaw.sh      # One-command setup ⭐
├── install-services.sh    # Systemd auto-start
└── configs/
    ├── config.json        # Main config template
    ├── telegram.json      # Telegram config
    └── signal.json        # Signal config
```

---

## ⚡ Quick Start (3 Commands)

### 1. Download & Run Setup

```bash
# Clone or copy this folder to your machine
cd openclaw-simple-setup

# Make executable
chmod +x setup-openclaw.sh install-services.sh

# Run setup (takes ~5 minutes)
./setup-openclaw.sh
```

### 2. Start Services

```bash
# Start Ollama (AI models)
ollama serve

# Start OpenClaw Gateway (in new terminal)
openclaw gateway start
```

### 3. Test

```bash
# Check status
openclaw status

# Or chat with your bot on Telegram!
```

---

## 🎯 Features

### ✅ Pre-configured

- **Ollama Integration** - Local AI models (llama3.2, gemma3, qwen2.5)
- **Telegram Bot** - Easy setup with BotFather
- **Signal Messenger** - End-to-end encrypted
- **Multi-Model Fallback** - Auto-switch if model fails
- **Auto-Start Services** - systemd for boot persistence

### 🔧 Customizable

- Multiple AI providers (Ollama, OpenRouter, OpenAI)
- Multiple messaging platforms
- Workspace skills system
- Hook system for automation

---

## 📱 Messaging Platforms

### Telegram (Recommended)

**Setup time:** 2 minutes

1. Chat `@BotFather` on Telegram
2. Send `/newbot`, follow instructions
3. Save the token
4. Paste token during setup

**Pros:**
- ✅ Easy setup
- ✅ Free
- ✅ Reliable
- ✅ Rich features (buttons, media, etc.)

### Signal

**Setup time:** 5 minutes

1. Install signal-cli (included in setup)
2. Register with phone number
3. Verify with SMS code

**Pros:**
- ✅ End-to-end encrypted
- ✅ Privacy-focused
- ✅ No Meta

**Cons:**
- ⚠️ More complex setup
- ⚠️ Requires phone number

### WhatsApp (via Twilio)

**Setup time:** 10 minutes

1. Sign up at https://twilio.com
2. Enable WhatsApp sandbox
3. Get credentials

**Pros:**
- ✅ Everyone has WhatsApp
- ✅ Business features

**Cons:**
- ⚠️ Requires Twilio account
- ⚠️ Not free (limited trial)

---

## 🤖 AI Models

### Local (Ollama) - Recommended

**Free, private, no API keys needed**

```bash
# Default model
ollama pull llama3.2        # 3.2B, fast, good quality

# Alternative models
ollama pull gemma3:27b      # 27B, better quality, slower
ollama pull qwen2.5:7b      # 7B, balanced
ollama pull mistral:7b      # 7B, good for code
```

**Config:**
```json
{
  "models": {
    "default": "ollama/llama3.2",
    "ollama": {
      "baseUrl": "http://localhost:11434"
    }
  }
}
```

### Cloud (OpenRouter)

**Free tier available, no local resources**

```bash
# Get API key: https://openrouter.ai
export OPENROUTER_API_KEY="sk-or-..."
```

**Config:**
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

### Multi-Provider Setup

**Best of both worlds:**

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

---

## 🔧 Advanced Configuration

### Edit Main Config

```bash
nano ~/.openclaw/config.json
```

### Add New Messaging Platform

```bash
# Create config file
cat > ~/.openclaw/whatsapp.json << 'EOF'
{
  "accountSid": "AC...",
  "authToken": "...",
  "fromNumber": "whatsapp:+14155238886"
}
EOF

# Restart gateway
openclaw gateway restart
```

### Install Skills

```bash
# From ClawHub
clawhub install git
clawhub install web-browsing
clawhub install summarize-pro

# Or copy manually
cp -r /path/to/skill ~/.openclaw/workspace/skills/
```

---

## 📊 Architecture

```
┌─────────────────────────────────────────────────────┐
│                  UserLAnd/Android                   │
│                                                     │
│  ┌─────────────┐    ┌─────────────┐                │
│  │   Ollama    │    │ OpenClaw    │                │
│  │  (AI Model) │───▶│   Gateway   │                │
│  │ localhost   │    │   Port 3000 │                │
│  └─────────────┘    └──────┬──────┘                │
│                            │                        │
│              ┌─────────────┼─────────────┐         │
│              │             │             │          │
│         ┌────▼────┐  ┌────▼────┐  ┌────▼────┐     │
│         │Telegram │  │ Signal  │  │WhatsApp │     │
│         │  Bot    │  │  CLI    │  │ Twilio  │     │
│         └─────────┘  └─────────┘  └─────────┘     │
└─────────────────────────────────────────────────────┘
```

---

## 🐛 Troubleshooting

### Gateway won't start

```bash
# Check logs
openclaw gateway logs

# Check if port is free
netstat -tlnp | grep 3000

# Restart
openclaw gateway restart
```

### Ollama connection failed

```bash
# Check if running
curl http://localhost:11434/api/tags

# Restart
sudo systemctl restart ollama
```

### Telegram bot not responding

```bash
# Test token
curl https://api.telegram.org/bot<TOKEN>/getMe

# Check gateway logs
openclaw gateway logs
```

### Out of memory (Android)

```bash
# Use smaller models
ollama pull llama3.2:1b
ollama pull qwen2.5:1.5b

# Or use cloud models (OpenRouter)
```

---

## 📚 Resources

| Resource | Link |
|----------|------|
| OpenClaw Docs | https://docs.openclaw.ai |
| Ollama Models | https://ollama.com/library |
| OpenRouter | https://openrouter.ai |
| Telegram API | https://core.telegram.org/bots |
| Signal CLI | https://github.com/AsamK/signal-cli |
| Discord Community | https://discord.gg/clawd |

---

## 🎉 Quick Reference

```bash
# Status
openclaw status

# Gateway
openclaw gateway start
openclaw gateway stop
openclaw gateway restart
openclaw gateway logs

# Ollama
ollama serve
ollama list
ollama pull <model>
ollama run <model>

# Systemd
systemctl status ollama
systemctl status openclaw-gateway
journalctl -u ollama -f
journalctl -u openclaw-gateway -f
```

---

## 📝 License

MIT License - Feel free to modify and distribute!

---

**🎊 Selamat! OpenClaw siap dipakai!**

Made with ❤️ for UserLAnd/Android users.
