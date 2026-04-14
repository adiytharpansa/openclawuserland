# 🦀 OpenClaw Cheat Sheet (UserLAnd)

## ⚡ Install (1x Aja!)

### 🌩️ CLOUD (Recommended!)
```bash
curl -fsSL https://raw.githubusercontent.com/YOUR-REPO/openclaw-simple-setup/main/INSTALL-CLOUD.sh | bash
```
**1 MENIT! RAM < 500MB!** ⚡

### 💻 LOKAL
```bash
curl -fsSL https://raw.githubusercontent.com/YOUR-REPO/openclaw-simple-setup/main/INSTALL.sh | bash
```
**5 MENIT! RAM 2-4GB**

---

## 📱 Workflow Harian

```
┌─────────────────────────────┐
│  BUKA USERLAND              │
│    ↓                        │
│  ~/openclaw/start.sh        │
│    ↓                        │
│  PAKAI! (chat Telegram)     │
│    ↓                        │
│  ~/openclaw/stop.sh         │
│    ↓                        │
│  CLOSE USERLAND             │
└─────────────────────────────┘
```

---

## 🎯 3 Commands Penting

| Command | Kapan? |
|---------|--------|
| `~/openclaw/start.sh` | Setiap buka UserLAnd |
| `~/openclaw/status.sh` | Mau check running apa nggak |
| `~/openclaw/stop.sh` | Sebelum close UserLAnd |

---

## 🐛 Troubleshooting

| Masalah | Solusi |
|---------|--------|
| Nggak start | `~/openclaw/stop.sh` → `~/openclaw/start.sh` |
| Port error | `pkill -f ollama` → start lagi |
| Out of memory | Ganti model kecil (lihat bawah) |
| Logs? | `cat /tmp/ollama.log` |

---

## 🧠 Ganti Model AI

**Model kecil (HP kentang):**
```bash
ollama pull tinyllama:1.1b    # 630MB
```

**Model medium (HP biasa):**
```bash
ollama pull llama3.2:1b       # 1.3GB ⭐ recommended
ollama pull qwen2.5:1.5b      # 1.5GB
```

**Edit config:**
```bash
nano ~/.openclaw/config.json
```

Change:
```json
{
  "models": {"default": "ollama/NAMA_MODEL"}
}
```

---

## 📞 Setup Telegram (Recommended!)

1. Buka Telegram → cari **@BotFather**
2. Kirim: `/newbot`
3. Kasih nama bot (bebas)
4. Copy token yang dikasih
5. Edit config:
   ```bash
   nano ~/.openclaw/telegram.json
   ```
6. Paste:
   ```json
   {"botToken": "PASTE_TOKEN_DISINI"}
   ```
7. Restart: `~/openclaw/stop.sh` → `~/openclaw/start.sh`

---

## 💡 Tips

- ✅ **Stop sebelum close UserLAnd** (biar nggak corrupt)
- ✅ **Pakai model kecil** kalau HP lemot
- ✅ **Telegram bot** = bisa chat dari mana aja
- ✅ **Backup config** kalau mau aman

---

**🎉 Simple kan? Nggak perlu ribet!**
