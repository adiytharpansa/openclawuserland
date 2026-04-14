# Setup Guide - OpenClaw + Skills

## ✅ Skills Installed (26 total)

### Core OpenClaw
- `openclaw-cli` - CLI management

### Laravel & PHP Development
- `laravel` - Laravel best practices
- `php` - PHP language support

### Firebase & Database
- `firebase` - Firebase Management API (requires MATON_API_KEY)
- `database-agent` - Database operations

### Communication & Messaging
- `telegram` - Telegram bot
- `slack` - Slack integration  
- `notion` - Notion API
- `github` - GitHub CLI (gh)

### Utilities
- `webhook-send` - Send webhooks
- `weather` - Weather forecasts
- `summarize-pro` - Content summarization
- `web-browsing` - Web browsing
- `code-quality` - Code review
- `explain-code` - Code explanations

---

## ⚠️ Configuration Required

### 1. Firebase Integration ✅
**Skill:** `firebase`

**Status:** Configured & Connected

**Projects Found:**
- `fileku-4595f` (Fileku)

API key sudah tersimpan di `.env.local` dan siap digunakan.

---

### 2. GitHub Integration
**Skill:** `github`

Requires GitHub CLI (`gh`) authentication.

**Setup:**
```bash
# Authenticate with GitHub
gh auth login

# Verify
gh auth status
```

---

### 3. Telegram Bot
**Skill:** `telegram`

Already configured in this session (chat_id: telegram:8709836130)

**Note:** Gateway has `groupPolicy: "allowlist"` but no senders configured.
- Add sender IDs to `channels.telegram.groupAllowFrom` OR
- Set `channels.telegram.groupPolicy` to `"open"`

---

### 4. Slack Integration
**Skill:** `slack`

Requires Slack bot token.

**Setup:**
1. Create Slack app at https://api.slack.com/apps
2. Get bot token (xoxb-...)
3. Add to workspace
4. Set `SLACK_BOT_TOKEN` env var

---

### 5. Notion Integration
**Skill:** `notion`

Requires Notion integration token.

**Setup:**
1. Create integration at https://www.notion.so/my-integrations
2. Get internal integration token
3. Share pages/database with integration
4. Set `NOTION_TOKEN` env var

---

## 🔧 Gateway Status

**Current Issues (from `openclaw doctor`):**

1. **Gateway auth** - Token auth recommended but not configured
2. **Group policy** - Telegram group messages will be dropped (empty allowlist)
3. **Multiple state directories** - Can split session history
4. **Orphan transcript files** - Can be archived/deleted

**Gateway Info:**
- Bind: LAN (0.0.0.0)
- Port: 9110
- Dashboard: http://10.118.32.142:9110/

---

## 📝 Environment Variables

Add these to your shell profile (`~/.bashrc`, `~/.zshrc`, etc.):

```bash
# Firebase (Maton API)
export MATON_API_KEY="your-maton-api-key"

# Slack (optional)
export SLACK_BOT_TOKEN="xoxb-..."

# Notion (optional)
export NOTION_TOKEN="secret_..."

# GitHub (gh CLI handles this via gh auth)
```

---

## 🚀 Quick Start Commands

```bash
# Check OpenClaw status
openclaw status

# List installed skills
clawhub list

# Test Firebase connection
clawhub inspect firebase

# Test GitHub (after auth)
gh repo list

# Browse available skills
clawhub explore
```

---

## 📚 Documentation

- OpenClaw Docs: https://docs.openclaw.ai
- ClawHub Skills: https://clawhub.ai
- Firebase API: https://firebase.google.com/docs/reference/firebase-management/rest
- Maton (Firebase Gateway): https://maton.ai

---

_Last updated: 2026-04-14_
