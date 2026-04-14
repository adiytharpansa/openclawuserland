# 📱 OpenClaw + Signal Integration Guide

**Complete guide untuk integrasi Signal Messenger dengan OpenClaw workflows!**

---

## 🚀 Quick Start

### 1. Setup signal-cli (Di Local Machine)

```bash
# Install
sudo apt install signal-cli  # Ubuntu/Debian
brew install signal-cli      # macOS

# Register nomor kamu
signal-cli -u +628123456789 register
signal-cli -u +628123456789 verify <SMS_CODE>

# Set environment variable
export SIGNAL_PHONE_NUMBER=+628123456789
```

### 2. Copy Integration Script

```bash
# Copy ke local machine
scp -r skills/signal-messenger user@local-machine:/path/to/openclaw/workspace/
```

### 3. Test Integration

```bash
cd /path/to/openclaw/workspace/skills/signal-messenger
python3 integration.py
```

---

## 📝 Usage Examples

### Example 1: Notifikasi Content Complete

```python
from skills.signal-messenger.integration import (
    SignalNotifier,
    notify_content_complete
)

# Initialize
notifier = SignalNotifier()  # Uses SIGNAL_PHONE_NUMBER env var

# Send notification
notify_content_complete(
    notifier,
    recipient="+628987654321",
    topic="The Psychology of Habit Formation",
    output_path="The_Psychology_of_Habit_Formation/"
)
```

**Output:**
```
🎬 Content Generated!

📝 Topic: The Psychology of Habit Formation
📁 Output: The_Psychology_of_Habit_Formation/
⏰ Time: 04:53:00

✅ Ready to use!
```

---

### Example 2: Notifikasi Task Complete

```python
from skills.signal-messenger.integration import notify_task_complete

notify_task_complete(
    notifier,
    recipient="+628987654321",
    task_name="Video Script Generation",
    duration="56 seconds"
)
```

**Output:**
```
✅ Task Complete!

📋 Video Script Generation
⏱️ Duration: 56 seconds
🕐 2026-04-14 04:53
```

---

### Example 3: Notifikasi Error

```python
from skills.signal-messenger.integration import notify_error

notify_error(
    notifier,
    recipient="+628987654321",
    error_message="API Rate Limit Exceeded",
    context="Ollama Cloud API returned 429"
)
```

**Output:**
```
🚨 Error Alert!

❌ API Rate Limit Exceeded

📝 Context:
Ollama Cloud API returned 429

⏰ 04:53:00
```

---

### Example 4: Custom Message

```python
notifier = SignalNotifier()

result = notifier.send(
    message="Hello from OpenClaw! 🚀",
    recipient="+628987654321"
)

if result['success']:
    print("Message sent!")
else:
    print(f"Failed: {result['error']}")
```

---

### Example 5: Send to Group

```python
# Get group ID first
groups = notifier.list_groups()
print(groups)

# Send to group
result = notifier.send_to_group(
    group_id="group.id.here",
    message="Team update: Content generated! ✅"
)
```

---

### Example 6: Send with Attachment

```python
result = notifier.send(
    message="Check this image!",
    recipient="+628987654321",
    attachment="/path/to/image.jpg"
)
```

---

## 🔗 Integration dengan OpenClaw Workflows

### Workflow 1: AI-Content-Studio

```python
# In your content generation script
from skills.signal-messenger.integration import (
    SignalNotifier,
    notify_content_complete
)
import os

def generate_content(topic):
    # ... your content generation code ...
    
    # After generation complete
    notifier = SignalNotifier()
    notify_content_complete(
        notifier,
        recipient=os.getenv("NOTIFICATION_RECIPIENT"),
        topic=topic,
        output_path=f"{topic.replace(' ', '_')}/"
    )
```

---

### Workflow 2: Daily Summary

```python
from skills.signal-messenger.integration import notify_daily_summary

# Track daily stats
tasks_completed = 5
content_generated = 3

notifier = SignalNotifier()
notify_daily_summary(
    notifier,
    recipient="+628987654321",
    tasks_completed=tasks_completed,
    content_generated=content_generated
)
```

---

### Workflow 3: Research Complete

```python
from skills.signal-messenger.integration import notify_research_complete

# After research workflow
notifier = SignalNotifier()
notify_research_complete(
    notifier,
    recipient="+628987654321",
    topic="AI Trends 2026",
    findings_count=10
)
```

---

### Workflow 4: Error Handling

```python
from skills.signal-messenger.integration import notify_error

try:
    # Your workflow code
    risky_operation()
    
except Exception as e:
    notifier = SignalNotifier()
    notify_error(
        notifier,
        recipient="+628987654321",
        error_message=str(e),
        context="Workflow failed at step 3"
    )
    raise
```

---

## ⚙️ Configuration

### Environment Variables

```bash
# Required: Your Signal phone number
export SIGNAL_PHONE_NUMBER=+628123456789

# Optional: Default notification recipient
export NOTIFICATION_RECIPIENT=+628987654321
```

### Add to ~/.bashrc or ~/.zshrc

```bash
echo 'export SIGNAL_PHONE_NUMBER=+628123456789' >> ~/.bashrc
echo 'export NOTIFICATION_RECIPIENT=+628987654321' >> ~/.bashrc
source ~/.bashrc
```

---

## 📋 Complete API Reference

### SignalNotifier Class

```python
notifier = SignalNotifier(phone_number=None)
```

**Methods:**

| Method | Description | Returns |
|--------|-------------|---------|
| `send(message, recipient, attachment=None)` | Send message | `{'success': bool, 'error': str}` |
| `send_to_group(group_id, message)` | Send to group | `{'success': bool, 'error': str}` |
| `list_groups()` | List all groups | `list` of group dicts |

---

### Notification Templates

| Function | Parameters | Use Case |
|----------|------------|----------|
| `notify_content_complete()` | notifier, recipient, topic, output_path | Content generation done |
| `notify_task_complete()` | notifier, recipient, task_name, duration | Task finished |
| `notify_error()` | notifier, recipient, error_message, context | Error alerts |
| `notify_daily_summary()` | notifier, recipient, tasks, content | Daily recap |
| `notify_research_complete()` | notifier, recipient, topic, findings | Research done |

---

## 🐛 Troubleshooting

### "signal-cli not found"
```bash
sudo apt install signal-cli  # Ubuntu
brew install signal-cli      # macOS
```

### "Not registered"
```bash
signal-cli -u +628123456789 register
signal-cli -u +628123456789 verify <CODE>
```

### "SIGNAL_PHONE_NUMBER not set"
```bash
export SIGNAL_PHONE_NUMBER=+628123456789
```

### Can't send to group
```bash
# List groups to get ID
signal-cli -u +628123456789 listGroups
```

---

## 📁 Files

```
skills/signal-messenger/
├── integration.py        ← Main integration script ✨
├── lib/send_message.py   ← Basic send script
├── install-and-setup.sh  ← Auto setup
├── QUICKSTART.md         ← Quick guide
├── README.md             ← Full docs
└── SKILL.md              ← Skill definition
```

---

## 🎉 Ready!

**Integration lengkap siap dipakai!**

**Test sekarang:**
```bash
cd skills/signal-messenger
python3 integration.py
```

**Atau langsung pakai di workflow:**
```python
from skills.signal-messenger.integration import SignalNotifier

notifier = SignalNotifier()
notifier.send("Hello from OpenClaw! 🚀", "+628987654321")
```

---

*Signal is a registered trademark of Signal Foundation.*
