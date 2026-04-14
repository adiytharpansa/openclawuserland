# OpenClaw Setup Scripts

Automation scripts for OpenClaw installation and configuration.

## 📦 Firebase Studio Setup

### Quick Install (One-Liner)

Copy-paste this into Firebase Studio terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/your-repo/openclaw-setup/main/scripts/setup-firebase-studio.sh | bash
```

### Manual Install

1. **Clone or download** this repo to Firebase Studio
2. **Run the setup script:**

```bash
cd scripts
chmod +x setup-firebase-studio.sh
./setup-firebase-studio.sh
```

### What It Does

- ✅ Checks Node.js & npm prerequisites
- ✅ Installs OpenClaw CLI globally
- ✅ Creates `.env` with API keys
- ✅ Creates `.gitignore`
- ✅ Installs essential skills (firebase, laravel, php, github, telegram, etc.)
- ✅ Sets up workspace directory structure
- ✅ Creates basic Laravel config skeleton
- ✅ Starts OpenClaw Gateway

### Post-Setup

After running the script:

```bash
# Verify installation
openclaw status

# Authenticate GitHub
gh auth login

# Create Firebase connection
# Visit: https://ctrl.maton.ai/connections

# Start Laravel project (if needed)
composer create-project laravel/laravel .
```

---

## 🔧 Other Scripts

| Script | Description |
|--------|-------------|
| `setup-firebase-studio.sh` | Full OpenClaw setup for Firebase Studio |
| `install-skills.sh` | Install specific skill bundles |
| `backup-workspace.sh` | Backup workspace & configs |

---

## 🆘 Troubleshooting

### Node.js not found
```bash
# Firebase Studio usually has Node.js pre-installed
# If missing, check workspace settings
node --version
```

### Permission errors
```bash
# Make script executable
chmod +x setup-firebase-studio.sh
```

### Gateway won't start
```bash
# Check if port 9110 is in use
lsof -i :9110

# Or use different port
openclaw gateway start --port 9111
```

---

## 📝 Environment Variables

Required:
- `MATON_API_KEY` - Firebase Management API (provided in setup)

Optional:
- `SLACK_BOT_TOKEN` - Slack integration
- `NOTION_TOKEN` - Notion integration
- `OPENCLAW_HOME` - Custom OpenClaw home directory

---

_Last updated: 2026-04-14_
