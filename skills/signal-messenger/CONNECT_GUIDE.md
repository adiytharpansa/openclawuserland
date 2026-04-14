# 🦞 OpenClaw + Signal Integration

**Complete guide untuk menghubungkan OpenClaw dengan Signal Messenger!**

---

## 🎯 Overview

Setup ini akan:
1. ✅ Install signal-cli
2. ✅ Register nomor Signal kamu
3. ✅ Setup bot yang listen pesan masuk
4. ✅ Auto-reply dengan OpenClaw responses
5. ✅ Run as service (24/7)

---

## 🚀 Quick Setup (5 Steps)

### Step 1: Install signal-cli

```bash
# Ubuntu/Debian
sudo apt update
sudo apt install signal-cli

# macOS
brew install signal-cli
```

### Step 2: Register Nomor Kamu

```bash
# Register
signal-cli -u +6285745115673 register

# Masukkan kode SMS yang diterima
signal-cli -u +6285745115673 verify 123456
```

### Step 3: Set Environment Variable

```bash
echo 'export SIGNAL_PHONE_NUMBER=+6285745115673' >> ~/.bashrc
source ~/.bashrc
```

### Step 4: Test Manual

```bash
cd /path/to/skills/signal-messenger

# Test kirim
signal-cli -u +6285745115673 send -m "Test!" +6285745115673
```

### Step 5: Run Bot

```bash
# Run bot (interactive)
python3 signal-bot.py

# Or run as background service (see below)
```

---

## 🤖 Signal Bot Features

### Auto-Reply Commands

| Command | Response |
|---------|----------|
| `help`, `/help`, `hi`, `hello` | Show help menu |
| `/status` | Bot status |
| `/time` | Current time |
| `/date` | Current date |
| `/test` | Test connection |
| Other messages | Echo with branding |

### Example Conversation

**You:** `hello`

**Bot:**
```
🦞 OpenClaw Bot

Commands:
/status - Check bot status
/time - Current time
/date - Current date
/help - Show this help

Or just chat!
```

**You:** `/status`

**Bot:**
```
✅ Bot Status

🟢 Online
🕐 05:44:00
📅 2026-04-14
📱 Number: +6285745115673
```

---

## 🔧 Advanced Setup

### Option 1: Run as Systemd Service (Recommended for Servers)

**Edit service file:**

```bash
sudo nano /etc/systemd/system/openclaw-signal-bot.service
```

**Update paths:**

```ini
[Service]
User=your-username
WorkingDirectory=/home/your-username/openclaw/workspace/skills/signal-messenger
Environment="SIGNAL_PHONE_NUMBER=+6285745115673"
ExecStart=/usr/bin/python3 /home/your-username/openclaw/workspace/skills/signal-messenger/signal-bot.py
```

**Enable and start:**

```bash
sudo systemctl daemon-reload
sudo systemctl enable openclaw-signal-bot
sudo systemctl start openclaw-signal-bot

# Check status
sudo systemctl status openclaw-signal-bot

# View logs
sudo journalctl -u openclaw-signal-bot -f
```

---

### Option 2: Run with Screen/Tmux (For Development)

```bash
# With screen
screen -S signal-bot
python3 signal-bot.py
# Ctrl+A, D to detach

# With tmux
tmux new -s signal-bot
python3 signal-bot.py
# Ctrl+B, D to detach
```

---

### Option 3: Run with Nohup

```bash
nohup python3 signal-bot.py > signal-bot.log 2>&1 &

# Check if running
ps aux | grep signal-bot

# View logs
tail -f signal-bot.log
```

---

## 📝 Integration dengan OpenClaw Workflows

### Example 1: Send Notification After Task

```python
# In your OpenClaw workflow
import subprocess

def notify_signal(message):
    phone = os.getenv("SIGNAL_PHONE_NUMBER")
    subprocess.run([
        "signal-cli", "-u", phone,
        "send", "-m", message,
        "+6285745115673"  # Your number
    ])

# Usage
notify_signal("✅ Content generated successfully!")
```

---

### Example 2: Two-Way Communication

**Bot automatically responds to messages:**

1. User sends: "Generate content about AI"
2. Bot receives and processes
3. Bot triggers OpenClaw workflow
4. Bot sends result back via Signal

```python
# In signal-bot.py, customize generate_response()
def generate_response(self, message):
    if "generate" in message.lower():
        # Trigger OpenClaw workflow
        topic = message.replace("generate", "").strip()
        subprocess.run(["python3", "generate_content.py", topic])
        return f"🎬 Generating content about: {topic}"
    
    # ... rest of logic
```

---

### Example 3: Webhook Integration

```python
# Forward Signal messages to webhook
import requests

def forward_to_webhook(sender, message):
    requests.post("http://localhost:9110/webhook/signal", json={
        "sender": sender,
        "message": message,
        "timestamp": datetime.now().isoformat()
    })
```

---

## 🐛 Troubleshooting

### "signal-cli not found"
```bash
sudo apt install signal-cli  # Ubuntu
brew install signal-cli      # macOS
```

### "Not registered"
```bash
signal-cli -u +6285745115673 register
signal-cli -u +6285745115673 verify <CODE>
```

### "Connection timed out"
Check internet connection and Signal server status.

### Bot not receiving messages
```bash
# Check if running
ps aux | grep signal-bot

# Check logs
journalctl -u openclaw-signal-bot -f

# Restart
sudo systemctl restart openclaw-signal-bot
```

### Messages not sending
```bash
# Test manually
signal-cli -u +6285745115673 send -m "Test" +6285745115673
```

---

## 📁 Files

```
skills/signal-messenger/
├── signal-bot.py           ← Main bot script ✨
├── integration.py          ← Integration helpers
├── openclaw-signal-bot.service ← Systemd service
├── test-send.sh            ← Test script
├── install-and-setup.sh    ← Auto installer
├── INTEGRATION_GUIDE.md    ← Integration docs
└── README.md               ← This guide
```

---

## 🔒 Security Notes

- ✅ Messages are end-to-end encrypted
- ✅ Bot runs locally on your machine
- ⚠️ Don't expose signal-cli to untrusted users
- ⚠️ Keep your phone number private
- ⚠️ Review auto-responses before deploying

---

## 🎯 Next Steps

1. ✅ Setup bot on local machine/server
2. ✅ Test with `/test` command
3. ✅ Customize auto-responses in `generate_response()`
4. ✅ Integrate with OpenClaw workflows
5. ✅ Setup systemd service for 24/7 operation

---

## 📞 Support

**Documentation:**
- `INTEGRATION_GUIDE.md` - API reference
- `QUICKSTART.md` - Quick setup
- `README.md` - Full docs

**Community:**
- OpenClaw Discord: https://discord.gg/clawd
- Signal CLI: https://github.com/AsamK/signal-cli

---

*Signal is a registered trademark of Signal Foundation. This bot is not affiliated with Signal.*
