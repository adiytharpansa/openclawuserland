# 📱 Signal Messenger Integration

**Custom skill untuk Signal messaging!**

---

## 🚀 Quick Setup

### Option 1: Simple Setup (Recommended for Local)

**Install signal-cli first:**
```bash
# Ubuntu/Debian
sudo apt update && sudo apt install signal-cli

# macOS
brew install signal-cli
```

**Run auto-setup:**
```bash
cd skills/signal-messenger
python3 setup-simple.py
```

This will:
1. ✅ Check signal-cli installation
2. ✅ Register your phone number
3. ✅ Verify with SMS code
4. ✅ Save configuration
5. ✅ Optional: Send test message

### Option 2: Docker (For Servers)

```bash
cd skills/signal-messenger
chmod +x setup.sh
./setup.sh
```

### Option 3: Manual

**Register your number:**
```bash
signal-cli -u +628123456789 register
signal-cli -u +628123456789 verify <SMS_CODE>
```

---

## ⚙️ Configuration

**Set environment variables:**

```bash
# For Docker/API
export SIGNAL_API_URL=http://localhost:8080
export SIGNAL_API_USER=admin
export SIGNAL_API_PASSWORD=signal123
export SIGNAL_PHONE_NUMBER=+628123456789

# Or for CLI only
export SIGNAL_CLI_PATH=/usr/bin/signal-cli
export SIGNAL_PHONE_NUMBER=+628123456789
```

**Add to your shell profile (~/.bashrc or ~/.zshrc):**
```bash
echo 'export SIGNAL_PHONE_NUMBER=+628123456789' >> ~/.bashrc
source ~/.bashrc
```

---

## 📝 Usage

### Send Message

```bash
# Using API (Docker)
python3 lib/send_message.py --to +628987654321 --message "Hello from Signal!"

# Using CLI directly
python3 lib/send_message.py --to +628987654321 --message "Hello from Signal!"

# With attachment
python3 lib/send_message.py --to +628987654321 --message "Check this!" --attachment image.jpg
```

### Example Output

```
📱 Sending via REST API...
✅ Sent via API
📱 To: +628987654321
⏰ Timestamp: 1713070800000
📄 Envelope ID: 1234567890.1234567890.0
```

---

## 🎯 Integration with OpenClaw

Once configured, you can use Signal for:

1. **Notifications** - Send alerts when tasks complete
2. **Messaging** - Send updates to individuals or groups
3. **Automation** - Trigger actions based on incoming messages
4. **Broadcasts** - Send to multiple recipients

**Example workflow:**
```python
# In your OpenClaw skill or script
from skills.signal-messenger.lib.send_message import send_message

# Send notification
result = send_message(
    to="+628987654321",
    message="Task completed! ✅"
)

if result["success"]:
    print("Notification sent!")
```

---

## 📚 API Endpoints (Docker)

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/v1/about` | GET | API info |
| `/v1/register/+{number}` | POST | Register number |
| `/v1/register/+{number}/verify/{code}` | PUT | Verify registration |
| `/v2/send` | POST | Send message |
| `/v1/receive` | GET | Receive messages |
| `/v1/groups` | GET | List groups |
| `/v1/attachments/{id}` | GET | Download attachment |
| `/v1/attachments` | POST | Upload attachment |

---

## 🔧 Troubleshooting

### "Not registered"
```bash
# Re-register
curl -X POST http://localhost:8080/v1/register/+628123456789
# Enter SMS code
curl -X PUT http://localhost:8080/v1/register/+628123456789/verify/123456
```

### "Rate limit exceeded"
Signal has anti-spam limits. Wait 1 hour before sending more.

### Container not starting
```bash
docker logs signal-api
docker restart signal-api
```

### Can't send to group
Get group ID first:
```bash
curl http://localhost:8080/v1/groups
```

---

## 🔒 Security

- ✅ End-to-end encrypted (Signal protocol)
- ✅ Local phone number verification
- ✅ No third-party servers
- ⚠️ Keep your verification code private
- ⚠️ Don't commit phone numbers to git

---

## 📁 Files

```
skills/signal-messenger/
├── SKILL.md           # This skill documentation
├── README.md          # Setup guide
├── setup.sh           # Automated setup
├── lib/
│   └── send_message.py  # Send messages
└── signal-cli-config/  # Docker volume (auto-created)
```

---

## 🎉 Ready!

**Setup complete!** Now you can send Signal messages from OpenClaw!

**Test it:**
```bash
python3 lib/send_message.py --to +628987654321 --message "Test message! 📱"
```

---

*Signal is a registered trademark of Signal Foundation. This skill is not affiliated with Signal.*
