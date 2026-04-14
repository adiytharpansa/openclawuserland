# 🦞 OpenClaw Permanent Setup for Firebase Studio

## ✅ **Cara Bikin Installasi PERMANEN**

Firebase Studio workspace **tersimpan otomatis di cloud** dan **persistent** lewat file `.idx/dev.nix`.

---

## 🚀 **Step-by-Step Setup Permanen**

### **1. Buat Workspace Baru di Firebase Studio**

```
1. Buka https://studio.firebase.google.com
2. Click "New Workspace"
3. Pilih "Blank Workspace" atau "Import from GitHub"
```

### **2. Upload File Config**

Upload file ini ke workspace:
- `.idx/dev.nix` ← **INI KUNCINYA!**
- `.env`
- `scripts/setup-firebase-studio.sh`

### **3. Workspace Auto-Provision**

Setiap kali workspace dibuka:
- ✅ Node.js & PHP terinstall
- ✅ OpenClaw CLI auto-install
- ✅ Skills essential auto-install
- ✅ Environment variables terset
- ✅ Extensions VS Code aktif

---

## 📁 **Struktur File untuk Permanen**

```
your-firebase-studio-workspace/
├── .idx/
│   └── dev.nix          ← Config environment (PENTING!)
├── .openclaw/
│   ├── workspace/
│   │   ├── skills/      ← Installed skills
│   │   ├── memory/      ← Memory files
│   │   ├── SETUP.md     ← Documentation
│   │   └── TOOLS.md     ← Local notes
│   └── openclaw.json    ← OpenClaw config
├── .env                 ← API keys (jangan commit!)
├── .gitignore
└── scripts/
    └── setup-firebase-studio.sh
```

---

## 💾 **Backup ke GitHub (Recommended)**

Agar lebih aman, commit config ke GitHub:

```bash
# Init git
git init
git add .idx/dev.nix
git add scripts/
git add .openclaw/workspace/SETUP.md
git add .openclaw/workspace/TOOLS.md
git commit -m "OpenClaw permanent setup"

# Push ke GitHub
git remote add origin https://github.com/username/repo.git
git push -u origin main
```

**Jangan commit:**
- `.env` (ada API key!)
- `.openclaw/workspace/memory/` (data sensitif)
- `.openclaw/exec-approvals.json`

---

## 🔄 **Cara Restore di Workspace Baru**

Kalau mau buat workspace baru atau pindah:

### **Option A: Import dari GitHub**
```
1. Firebase Studio → "Import Repository"
2. Paste URL GitHub kamu
3. Workspace otomatis provision dengan .idx/dev.nix
```

### **Option B: Manual Copy**
```bash
# Clone repo kamu
git clone https://github.com/username/repo.git

# Copy .env dari backup aman
cp .env.backup .env

# Workspace siap!
```

---

## ⚙️ **Apa yang Terjadi Otomatis**

Setiap kali workspace dibuka:

| Tahap | Yang Terjadi |
|-------|--------------|
| **1. Environment** | Node.js, PHP, Git, Composer diinstall via Nix |
| **2. OpenClaw CLI** | Auto-install via npm jika belum ada |
| **3. Skills** | 6 essential skills auto-install |
| **4. Env Vars** | MATON_API_KEY dll otomatis terset |
| **5. Extensions** | Laravel extensions VS Code aktif |

---

## 🎯 **Keuntungan Setup Permanen**

| Benefit | Penjelasan |
|---------|------------|
| ✅ **No Re-setup** | Nggak perlu install ulang setiap sesi |
| ✅ **Auto-Provision** | Environment siap dalam 2-3 menit |
| ✅ **Cloud Backup** | Tersimpan di cloud Google |
| ✅ **GitHub Sync** | Version control untuk config |
| ✅ **Team Ready** | Share workspace URL, semua dapat env sama |
| ✅ **Reproducible** | `.dev.nix` guarantee environment konsisten |

---

## ⚠️ **Catatan Penting**

### **Firebase Studio Sunset: March 22, 2027**

Google akan sunset Firebase Studio. Migration path:
- **Google AI Studio** → https://aistudio.google.com
- **Google Antigravity** → Internal Google tool

**Action:** Commit semua config ke GitHub untuk backup!

### **Workspace Limits**

| Tier | Workspaces |
|------|------------|
| Free (Preview) | 3 workspaces |
| Google Developer Program | 30 workspaces |

---

## 🛠️ **Troubleshooting**

### **Workspace tidak auto-install OpenClaw**
```bash
# Check .idx/dev.nix ada
ls -la .idx/dev.nix

# Rebuild environment
# Firebase Studio akan prompt rebuild saat .dev.nix berubah
```

### **Skills tidak terinstall**
```bash
# Manual install
clawhub install openclaw-cli firebase laravel php github telegram

# Verify
clawhub list
```

### **Environment variables hilang**
```bash
# Check .env file
cat .env

# Reload env
source .env
```

---

## 📚 **Resources**

- Firebase Studio Docs: https://firebase.studio/docs
- OpenClaw Docs: https://docs.openclaw.ai
- Nix Config Guide: https://firebase.studio/docs/configure-workspace
- ClawHub Skills: https://clawhub.ai

---

**Setup sekali, pakai selamanya (sampai Maret 2027)!** 🎉

_Last updated: 2026-04-14_
