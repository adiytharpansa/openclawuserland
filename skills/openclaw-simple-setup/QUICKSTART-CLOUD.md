# 🦀 OpenClaw CLOUD - Quick Start

**Tanpa AI lokal! Ringan, cepat, 1 MENIT install!** ⚡

---

## ⚡ INSTALL (1 Command!)

```bash
curl -fsSL https://raw.githubusercontent.com/YOUR-REPO/openclaw-simple-setup/main/INSTALL-CLOUD.sh | bash
```

**Atau manual:**
```bash
cd ~/openclaw-simple-setup
chmod +x INSTALL-CLOUD.sh
./INSTALL-CLOUD.sh
```

**1 MENIT... DONE!** ✅

---

## 📱 PAKAI (3 Command)

```bash
# 1. Start
~/openclaw/start.sh

# 2. Check
~/openclaw/status.sh

# 3. Stop
~/openclaw/stop.sh
```

---

## 🎯 Kenapa Cloud?

| Cloud (OpenRouter) | Lokal (Ollama) |
|--------------------|----------------|
| ✅ 1 MENIT install | ❌ 5-10 MENIT |
| ✅ RAM < 500MB | ❌ RAM 2-4GB |
| ✅ Model pintar (8B+) | ❌ Model kecil (1-3B) |
| ✅ HP kentang OK | ❌ HP kuat aja |
| ❌ Butuh API key | ✅ Gratis total |

---

## 🔑 API Key (Optional tapi Recommended)

**Free tier tersedia!**

### Option A: OpenRouter (Recommended)

1. Buka https://openrouter.ai
2. Sign up / Login
3. Create API key
4. Edit config:
   ```bash
   nano ~/.openclaw/config.json
   ```
5. Ganti:
   ```json
   {
     "models": {
       "default": "openrouter/meta-llama/llama-3-8b-instruct:free",
       "openrouter": {
         "apiKey": "sk-or-XXXXXX"
       }
     }
   }
   ```

### Option B: Model Gratis

```json
{
  "models": {
    "default": "openrouter/meta-llama/llama-3-8b-instruct:free"
  }
}
```

**No API key needed!** Tapi ada rate limit.

---

## 📞 Setup Telegram (Optional)

```bash
~/openclaw/setup-tele.sh
```

**Atau manual:**

1. Chat @BotFather di Telegram
2. `/newbot`
3. Kasih nama
4. Copy token
5. Edit `~/.openclaw/telegram.json`:
   ```json
   {"botToken": "PASTE_TOKEN"}
   ```
6. Restart:
   ```bash
   ~/openclaw/stop.sh && ~/openclaw/start.sh
   ```

---

## 🎭 Model Recommendations

### Gratis (No API Key)
- `openrouter/meta-llama/llama-3-8b-instruct:free` ⭐
- `openrouter/google/gemma-7b-it:free`
- `openrouter/mistralai/mistral-7b-instruct:free`

### Berbayar (API Key)
- `openrouter/anthropic/claude-3-haiku` - Cepat, murah
- `openrouter/openai/gpt-3.5-turbo` - Standard
- `openrouter/meta-llama/llama-3-70b-instruct` - Pintar!

---

## 🐛 Troubleshooting

**"Cannot connect to gateway"**
```bash
~/openclaw/stop.sh
~/openclaw/start.sh
```

**"Rate limit exceeded"**
```bash
# Ganti model atau add API key
nano ~/.openclaw/config.json
```

**"Invalid API key"**
```bash
# Check key di openrouter.ai
# Edit config lagi
nano ~/.openclaw/config.json
```

---

## 💰 Biaya

**FREE TIER:**
- ✅ Llama-3-8B gratis
- ✅ Rate limit: ~100 requests/hour
- ✅ Cukup untuk personal use

**PAID (Optional):**
- $5 credit = ~10,000 requests
- Pay as you go
- No subscription

---

## 📊 Workflow Harian

```
┌─────────────────────────┐
│  BUKA USERLAND          │
│    ↓                    │
│  ~/openclaw/start.sh    │
│    ↓                    │
│  Chat via Telegram      │
│    ↓                    │
│  ~/openclaw/stop.sh     │
│    ↓                    │
│  CLOSE USERLAND         │
└─────────────────────────┘
```

---

## 🎉 That's It!

**Simple kan?** Nggak perlu download model 1-4GB, nggak butuh RAM besar!

**Next:** Setup Telegram bot biar bisa chat dari mana aja! 📱
