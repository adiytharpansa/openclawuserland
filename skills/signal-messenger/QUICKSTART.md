# 📱 Signal Messenger - Quick Start Guide

**Setup Signal messaging di local machine!**

---

## 🚀 One-Command Setup

**Di local machine kamu (Ubuntu/Debian/macOS):**

```bash
cd /mnt/data/openclaw/workspace/.openclaw/workspace/skills/signal-messenger

# Copy script ke local machine
scp skills/signal-messenger/install-and-setup.sh user@local-machine:/tmp/

# Di local machine:
chmod +x /tmp/install-and-setup.sh
/tmp/install-and-setup.sh
```

**Atau manual:**

```bash
# 1. Install signal-cli
sudo apt install signal-cli  # Ubuntu/Debian
brew install signal-cli      # macOS

# 2. Register nomor
signal-cli -u +628123456789 register
signal-cli -u +628123456789 verify 123456  # Code dari SMS

# 3. Test kirim
signal-cli -u +628123456789 send -m "Hello!" +628987654321
```

---

## ✅ Checklist Setup

- [ ] Install signal-cli
- [ ] Register phone number
- [ ] Verify dengan SMS code
- [ ] Test kirim message
- [ ] Set environment variable

---

## 📝 Usage Examples

### Send Message
```bash
signal-cli -u +628123456789 send -m "Hello World!" +628987654321
```

### Send with Attachment
```bash
signal-cli -u +628123456789 send -m "Check this!" \
  -a /path/to/image.jpg \
  +628987654321
```

### Send to Group
```bash
# Get group ID first
signal-cli -u +628123456789 listGroups

# Send to group
signal-cli -u +628123456789 send -g <GROUP_ID> -m "Hi everyone!"
```

### Using Python Script
```bash
python3 lib/send_message.py --to +628987654321 --message "Test! 📱"
```

---

## 🔧 Environment Setup

**Add to ~/.bashrc or ~/.zshrc:**
```bash
export SIGNAL_PHONE_NUMBER=+628123456789
```

**Reload:**
```bash
source ~/.bashrc
```

---

## 🎯 Integration Examples

### OpenClaw Notification
```python
# In your OpenClaw skill
import subprocess

def send_signal_notification(message, recipient):
    phone = os.getenv("SIGNAL_PHONE_NUMBER")
    subprocess.run([
        "signal-cli", "-u", phone,
        "send", "-m", message, recipient
    ])

# Usage
send_signal_notification("✅ Task completed!", "+628987654321")
```

### Shell Script Alert
```bash
#!/bin/bash
# monitor.sh

if ! ping -c 1 google.com > /dev/null 2>&1; then
    signal-cli -u +628123456789 \
      send -m "🚨 ALERT: Server down!" \
      +628987654321
fi
```

### Cron Job Notification
```bash
# crontab -e
0 9 * * * /path/to/backup.sh && signal-cli -u +628123456789 send -m "✅ Backup done" +628987654321
```

---

## 🐛 Troubleshooting

### "Not registered"
```bash
signal-cli -u +628123456789 register
signal-cli -u +628123456789 verify <CODE>
```

### "Rate limit exceeded"
Wait 1 hour. Signal has anti-spam limits.

### "Group not found"
```bash
# List groups
signal-cli -u +628123456789 listGroups

# Use correct group ID
signal-cli -u +628123456789 send -g <ID> -m "Hello"
```

### Can't receive messages
```bash
# Receive messages
signal-cli -u +628123456789 receive
```

---

## 📁 Files

```
skills/signal-messenger/
├── install-and-setup.sh  ← Complete setup script ✨
├── setup-simple.py       ← Simple Python setup
├── setup.sh              ← Docker setup
├── lib/send_message.py   ← Python send script
├── SKILL.md              ← Skill definition
└── README.md             ← This guide
```

---

## 🎉 Ready!

**After setup, you can:**
- ✅ Send individual messages
- ✅ Send group messages
- ✅ Send attachments (images, files)
- ✅ Receive messages
- ✅ Integrate with OpenClaw workflows

**Test sekarang di local machine!** 🚀

---

*Signal is a registered trademark of Signal Foundation.*
