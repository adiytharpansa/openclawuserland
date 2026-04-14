# 🚀 OpenClaw - QUICK START (UserLAnd)

## ⚡ INSTALASI (1 Command!)

**Copy-paste ini di UserLAnd:**

```bash
curl -fsSL https://raw.githubusercontent.com/YOUR-REPO/openclaw-simple-setup/main/INSTALL.sh | bash
```

**Atau kalau udah download folder ini:**

```bash
cd ~/openclaw-simple-setup
./INSTALL.sh
```

**Tunggu 3-5 menit... DONE!** ✅

---

## 📱 PAKAI (3 Command Aja)

```bash
# 1. Start (setiap buka UserLAnd)
~/openclaw/start.sh

# 2. Check status
~/openclaw/status.sh

# 3. Stop (sebelum close UserLAnd)
~/openclaw/stop.sh
```

---

## 🎯 Workflow Harian

```
┌─────────────────────────────────┐
│  BUKA USERLAND                  │
│  ↓                              │
│  ~/openclaw/start.sh            │
│  ↓                              │
│  Pakai! (chat via Telegram)     │
│  ↓                              │
│  ~/openclaw/stop.sh             │
│  ↓                              │
│  Close UserLAnd                 │
└─────────────────────────────────┘
```

---

## 📋 Cheatsheet

| Mau apa? | Command |
|----------|---------|
| Start | `~/openclaw/start.sh` |
| Stop | `~/openclaw/stop.sh` |
| Check | `~/openclaw/status.sh` |
| Logs Ollama | `cat /tmp/ollama.log` |
| Logs OpenClaw | `cat /tmp/openclaw.log` |

---

## 🐛 Troubleshooting

**"Command not found"**
```bash
# Install ulang
curl -fsSL https://raw.githubusercontent.com/YOUR-REPO/openclaw-simple-setup/main/INSTALL.sh | bash
```

**"Port already in use"**
```bash
# Stop semua, start ulang
~/openclaw/stop.sh
~/openclaw/start.sh
```

**"Out of memory"**
```bash
# Pakai model lebih kecil
ollama pull tinyllama:1.1b
# Edit ~/.openclaw/config.json
```

---

## 📞 Setup Telegram (Optional)

1. Chat **@BotFather** di Telegram
2. Kirim `/newbot`
3. Kasih nama bot
4. Simpan token yang dikasih
5. Edit `~/.openclaw/telegram.json`:

```json
{
  "botToken": "PASTE_TOKEN_DISINI"
}
```

6. Restart: `~/openclaw/stop.sh` lalu `~/openclaw/start.sh`

---

## 🎉 That's It!

Nggak perlu ribet, nggak perlu baca doc panjang. Install → Start → Pakai!

**Questions?** Cek `README.md` atau `USERLAND-QUICKSTART.md`
