# 🚀 OpenClaw Cheat Sheet

## Install (1x saja)

```bash
curl -fsSL https://raw.githubusercontent.com/your-repo/openclaw-simple-setup/main/INSTALL.sh | bash
```

**Atau manual:**
```bash
cd ~/openclaw-simple-setup
chmod +x INSTALL.sh
./INSTALL.sh
```

---

## Pakai (Setiap Hari)

```bash
# 1. Start
~/openclaw/start.sh

# 2. Check
~/openclaw/status.sh

# 3. Stop (sebelum close UserLAnd)
~/openclaw/stop.sh
```

---

## Commands

| Command | Deskripsi |
|---------|-----------|
| `~/openclaw/start.sh` | Start OpenClaw + Ollama |
| `~/openclaw/stop.sh` | Stop semua |
| `~/openclaw/status.sh` | Check status |
| `openclaw status` | Manual status check |
| `openclaw gateway logs` | Lihat logs |

---

## Troubleshooting

**Nggak bisa connect?**
```bash
~/openclaw/stop.sh
~/openclaw/start.sh
```

**Liat logs:**
```bash
tail -f /tmp/ollama.log
tail -f /tmp/openclaw.log
```

**Force stop:**
```bash
pkill -f ollama
pkill -f openclaw
```

---

## Setup Telegram (Optional)

1. Chat `@BotFather` di Telegram
2. Kirim `/newbot`
3. Simpan token
4. Edit `~/.openclaw/config.json`:

```json
{
  "telegram": {
    "botToken": "YOUR_TOKEN"
  }
}
```

5. Restart: `~/openclaw/stop.sh && ~/openclaw/start.sh`

---

## Ganti Model AI

```bash
# Liat models
ollama list

# Download model baru
ollama pull qwen2.5:1.5b

# Edit config
nano ~/.openclaw/config.json

# Change: "default": "ollama/qwen2.5:1.5b"

# Restart
~/openclaw/stop.sh
~/openclaw/start.sh
```

---

## Tips

- ✅ Model kecil = lebih cepat, kurang pintar
- ✅ Model besar = lebih pintar, lebih lambat
- ✅ Pakai Telegram bot untuk chat dari mana saja
- ✅ Stop sebelum close UserLAnd

---

**That's it!** Simple kan? 🎉
