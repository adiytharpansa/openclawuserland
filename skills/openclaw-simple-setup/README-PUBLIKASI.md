# 🦀 OpenClaw Simple Setup

**Install OpenClaw dalam 1 MENIT!** Untuk UserLAnd, Android, Linux, Raspberry Pi.

Tanpa ribet, tanpa AI lokal (optional), API key flexible!

---

## ⚡ Quick Install

### **Option 1: CLOUD (Recommended! Ringan!)**

**1 MENIT install, RAM < 500MB!**

```bash
curl -fsSL https://raw.githubusercontent.com/YOUR-USERNAME/openclaw-simple-setup/main/INSTALL-CLOUD.sh | bash
```

**Keuntungan:**
- ✅ Install super cepat (1 menit)
- ✅ RAM usage < 500MB
- ✅ HP kentang friendly
- ✅ Model AI pintar (8B+)
- ✅ API key flexible (free tier available)

---

### **Option 2: LOKAL (Full Offline)**

**5 MENIT install, RAM 2-4GB**

```bash
curl -fsSL https://raw.githubusercontent.com/YOUR-USERNAME/openclaw-simple-setup/main/INSTALL.sh | bash
```

**Keuntungan:**
- ✅ Full offline
- ✅ Gratis total (no API key)
- ✅ Data tetap lokal

---

## 📱 Cara Pakai

```bash
# Start (setiap kali pakai)
~/openclaw/start.sh

# Check status
~/openclaw/status.sh

# Stop (sebelum close)
~/openclaw/stop.sh
```

---

## 🎯 Features

### **Smart Install**
- Auto-detect (global/sudo/local)
- Fallback otomatis
- Progress indicators

### **Flexible API Key**
- Enter saat install
- Skip & add later
- Get key via browser
- Free tier support

### **Helper Scripts**
```
~/openclaw/
├── start.sh        # Start OpenClaw
├── stop.sh         # Stop OpenClaw
├── status.sh       # Check status
├── setup-tele.sh   # Setup Telegram bot
└── set-api-key.sh  # Manage API key
```

### **UserLAnd Friendly**
- Single session support
- Auto backup config
- Optimized untuk Android

---

## 🔑 API Key Setup

**FREE TIER tersedia!** No key needed untuk mulai.

### Selama Install
```
Options:
  1. Enter API key now
  2. Skip (use free tier, add key later)
  3. Get key now (open browser)

Choice [1-3]: _
```

### Setelah Install
```bash
~/openclaw/set-api-key.sh
```

### Get API Key
1. Buka https://openrouter.ai
2. Sign up (gratis)
3. API Keys → Create Key
4. Copy & paste

---

## 📞 Setup Telegram Bot

```bash
~/openclaw/setup-tele.sh
```

**Steps:**
1. Chat @BotFather di Telegram
2. Kirim `/newbot`
3. Kasih nama bot
4. Copy token
5. Paste di script

---

## 🎭 Model Recommendations

### Free Tier (No API Key)
- `meta-llama/llama-3-8b-instruct:free` ⭐
- `google/gemma-7b-it:free`
- `mistralai/mistral-7b-instruct:free`

### With API Key
| Model | Speed | Intelligence | Cost |
|-------|-------|--------------|------|
| Llama-3-8B | Fast | Good | Free |
| Claude-3-Haiku | Fast | Very Good | $ |
| GPT-3.5-Turbo | Fast | Good | $ |
| Llama-3-70B | Medium | Excellent | $$ |

---

## 🐛 Troubleshooting

### **"Command not found"**
```bash
# Refresh PATH
source ~/.bashrc

# Or reinstall
curl -fsSL https://YOUR-URL/INSTALL-CLOUD.sh | bash
```

### **"Cannot connect to gateway"**
```bash
~/openclaw/stop.sh
~/openclaw/start.sh
```

### **"Rate limit exceeded"**
```bash
# Add API key
~/openclaw/set-api-key.sh

# Or switch model
nano ~/.openclaw/config.json
```

### **"Out of memory" (Local version)**
```bash
# Use smaller model
ollama pull tinyllama:1.1b

# Or switch to cloud version
curl -fsSL .../INSTALL-CLOUD.sh | bash
```

---

## 📚 Documentation

| File | Description |
|------|-------------|
| [QUICKSTART-CLOUD.md](QUICKSTART-CLOUD.md) | Cloud version quickstart |
| [QUICKSTART.md](QUICKSTART.md) | Local version quickstart |
| [CHEATSHEET.md](CHEATSHEET.md) | Quick reference |
| [USERLAND-QUICKSTART.md](USERLAND-QUICKSTART.md) | UserLAnd specific guide |
| [PUBLIKASI.md](PUBLIKASI.md) | How to publish/share |
| [CHANGELOG.md](CHANGELOG.md) | What's new |

---

## 💰 Biaya

### Cloud Version
- **FREE:** Llama-3-8B free tier (~100 req/hour)
- **PAID:** $5 credit = ~10,000 requests
- Pay as you go, no subscription

### Local Version
- **FREE:** 100% gratis
- Butuh RAM 2-4GB

---

## 🎯 Use Cases

| Use Case | Version | Why |
|----------|---------|-----|
| Android (UserLAnd) | Cloud | Ringan, cepat |
| Raspberry Pi | Cloud | No resource hog |
| Old Laptop | Cloud | RAM efficient |
| Privacy First | Local | Full offline |
| Production | Cloud | Reliable, scalable |

---

## 🚀 Complete Workflow

```bash
# 1. Install (1x saja)
curl -fsSL https://YOUR-URL/INSTALL-CLOUD.sh | bash

# 2. Start
~/openclaw/start.sh

# 3. (Optional) Setup Telegram
~/openclaw/setup-tele.sh

# 4. (Optional) Add API key
~/openclaw/set-api-key.sh

# 5. Pakai!
# Chat via Telegram atau: openclaw

# 6. Stop (sebelum close)
~/openclaw/stop.sh
```

---

## 📊 System Requirements

### Cloud Version
| Requirement | Minimum | Recommended |
|-------------|---------|-------------|
| RAM | 256MB | 512MB |
| Storage | 100MB | 500MB |
| Internet | Required | Required |
| OS | Linux/Android | Any |

### Local Version
| Requirement | Minimum | Recommended |
|-------------|---------|-------------|
| RAM | 2GB | 4GB+ |
| Storage | 5GB | 10GB |
| Internet | Install only | Never |
| OS | Linux/Android | Any |

---

## 🤝 Contributing

1. Fork repo
2. Create branch
3. Make changes
4. Submit PR

---

## 📝 License

MIT License - Feel free to use, modify, share!

---

## 🔗 Links

- **OpenClaw:** https://openclaw.ai
- **OpenRouter:** https://openrouter.ai
- **Docs:** https://docs.openclaw.ai
- **Discord:** https://discord.gg/clawd

---

## 🎉 Testimonials

> "Install dalam 1 menit, langsung pakai! Gila sih!" - UserLAnd User

> "Finally, AI assistant yang nggak butuh RAM 8GB!" - Android User

> "Free tier cukup buat personal use. Mantap!" - Student

---

**Made with 🦀 for the community**

**Questions?** Open issue atau join Discord!
