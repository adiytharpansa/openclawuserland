# 🦀 OpenClaw Simple Setup

**Install OpenClaw dalam 1 MENIT!** Untuk UserLAnd/Android/Linux.

---

## ⚡ PILIH INSTALLER

### 🌩️ CLOUD (Recommended! Ringan!)
**Tanpa AI lokal, 1 MENIT install!**

```bash
curl -fsSL https://raw.githubusercontent.com/YOUR-REPO/openclaw-simple-setup/main/INSTALL-CLOUD.sh | bash
```

**Keuntungan:**
- ✅ 1 MENIT install
- ✅ RAM < 500MB
- ✅ HP kentang OK
- ✅ Model pintar (8B+)
- ❌ Butuh API key (free tier ada)

**Docs:** [QUICKSTART-CLOUD.md](QUICKSTART-CLOUD.md)

---

### 💻 LOKAL (Full Offline)
**AI lokal, 5 MENIT install**

```bash
curl -fsSL https://raw.githubusercontent.com/YOUR-REPO/openclaw-simple-setup/main/INSTALL.sh | bash
```

**Keuntungan:**
- ✅ Gratis total
- ✅ Full offline
- ✅ No API key
- ❌ RAM 2-4GB
- ❌ 5-10 MENIT install

**Docs:** [QUICKSTART.md](QUICKSTART.md)

---

## ⚡ ONE-CLICK INSTALL

### Copy-Paste Ini (5 menit):

```bash
curl -fsSL https://raw.githubusercontent.com/your-repo/openclaw-simple-setup/main/INSTALL.sh | bash
```

**Atau download manual:**
```bash
cd ~/openclaw-simple-setup
chmod +x INSTALL.sh
./INSTALL.sh
```

**Done!** ✅

---

## 📱 Cara Pakai

```bash
# Start (setiap buka UserLAnd)
~/openclaw/start.sh

# Check status
~/openclaw/status.sh

# Stop (sebelum close UserLAnd)
~/openclaw/stop.sh
```

**That's it!**

---

## 📚 Documentation

| File | Deskripsi |
|------|-----------|
| **[CHEATSHEET.md](CHEATSHEET.md)** | Quick reference ⭐ |
| [INSTALL.sh](INSTALL.sh) | One-click installer |
| [USERLAND-QUICKSTART.md](USERLAND-QUICKSTART.md) | Detailed UserLAnd guide |
| [SETUP_GUIDE.md](SETUP_GUIDE.md) | Complete documentation |

---

## 🎯 Features

- ✅ **1 Command Install** - Copy-paste, done!
- ✅ **Auto Setup** - OpenClaw + Ollama + Config
- ✅ **Simple Scripts** - start.sh, stop.sh, status.sh
- ✅ **Telegram Ready** - Easy bot setup
- ✅ **Lightweight** - Optimized for Android/HP
- ✅ **Single Session** - Perfect for UserLAnd

---

## 🤖 AI Models

**Default:** `llama3.2:1b` (1.3GB, fast)

**Ganti model:**
```bash
ollama pull qwen2.5:1.5b
# Edit ~/.openclaw/config.json
# Restart: ~/openclaw/stop.sh && ~/openclaw/start.sh
```

---

## 📱 Setup Telegram (2 menit)

1. Chat `@BotFather` di Telegram
2. Kirim `/newbot`
3. Save token
4. Edit `~/.openclaw/config.json`:
   ```json
   {"telegram": {"botToken": "YOUR_TOKEN"}}
   ```
5. Restart: `~/openclaw/stop.sh && ~/openclaw/start.sh`

---

## 🐛 Troubleshooting

**Nggak jalan?**
```bash
~/openclaw/stop.sh
~/openclaw/start.sh
```

**Liat logs:**
```bash
tail -f /tmp/ollama.log
tail -f /tmp/openclaw.log
```

**Masih nggak jalan?**
```bash
# Reinstall
curl -fsSL https://raw.githubusercontent.com/your-repo/openclaw-simple-setup/main/INSTALL.sh | bash
```

---

## 📊 What's Installed

```
~/.openclaw/
├── config.json          # Main config
├── telegram.json        # Telegram (optional)
└── workspace/           # Your files & skills

~/openclaw/
├── start.sh             # Start all services
├── stop.sh              # Stop all services
└── status.sh            # Check status
```

---

## 🎉 Quick Reference

```bash
# Install (1x)
curl -fsSL .../INSTALL.sh | bash

# Daily use
~/openclaw/start.sh      # Start
~/openclaw/status.sh     # Check
~/openclaw/stop.sh       # Stop

# OpenClaw commands
openclaw status
openclaw gateway logs
```

---

**Simple kan?** 🎊

Made with ❤️ for UserLAnd users who want simple & powerful.
