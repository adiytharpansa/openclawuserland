# 📢 Publikasi OpenClaw Simple Setup

**Agar orang lain bisa install dengan 1 command!**

---

## 🎯 Option 1: GitHub Gist (Paling Mudah!)

### Step 1: Buat Gist

1. Buka https://gist.github.com
2. Login dengan GitHub account
3. Paste isi `INSTALL.sh`
4. Nama file: `install-openclaw.sh`
5. Klik "Create public gist"

### Step 2: Dapatkan Raw URL

Setelah create, klik tombol "Raw" dan copy URL-nya.

Format: `https://gist.githubusercontent.com/USERNAME/GIST_ID/raw/INSTALL.sh`

### Step 3: Share Command

Orang lain bisa install dengan:

```bash
curl -fsSL https://gist.githubusercontent.com/USERNAME/GIST_ID/raw/install-openclaw.sh | bash
```

---

## 🎯 Option 2: GitHub Repository

### Step 1: Buat Repo

```bash
# Di GitHub.com, buat repo baru
# Nama: openclaw-simple-setup
# Visibility: Public
```

### Step 2: Push Files

```bash
cd ~/openclaw-simple-setup
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/USERNAME/openclaw-simple-setup.git
git push -u origin main
```

### Step 3: Share Command

```bash
curl -fsSL https://raw.githubusercontent.com/USERNAME/openclaw-simple-setup/main/INSTALL.sh | bash
```

---

## 🎯 Option 3: Pastebin / Alternatif

### Pastebin (https://pastebin.com)

1. Paste isi INSTALL.sh
2. Set visibility: Public
3. Copy "Raw" URL
4. Share command

### Note: URL akan expire jika tidak pakai GitHub

---

## 📝 Template README untuk Share

Copy-paste ini saat share di media sosial / grup:

```markdown
# 🚀 OpenClaw Simple Setup

Install OpenClaw di UserLAnd/Android/Linux dalam 5 menit!

## Install (1 Command)

```bash
curl -fsSL https://YOUR-URL-HERE/install-openclaw.sh | bash
```

## Pakai

```bash
~/openclaw/start.sh    # Start
~/openclaw/status.sh   # Check
~/openclaw/stop.sh     # Stop
```

## Features

✅ OpenClaw + Ollama (AI lokal)
✅ Telegram bot ready
✅ Optimized untuk HP/Android
✅ Single session (UserLAnd friendly)
✅ Auto config

## Info

GitHub: https://github.com/USERNAME/openclaw-simple-setup
Docs: CHEATSHEET.md

#OpenClaw #AI #UserLAnd #Android #SelfHosted
```

---

## 🎯 Option 4: Telegram / Discord Share

**Untuk grup Telegram/Discord:**

```
🚀 OPENCLAW SIMPLE SETUP

Install AI assistant di HP kamu (UserLAnd/Android)!

📦 Install:
curl -fsSL YOUR-URL-HERE/install-openclaw.sh | bash

⚡ Pakai:
~/openclaw/start.sh    # Start
~/openclaw/stop.sh     # Stop

✅ Gratis
✅ Lokal (no API key)
✅ Telegram bot ready
✅ 5 menit install

Docs: GitHub-URL-HERE
```

---

## 🔧 Update Installer

Jika ada update:

### GitHub Gist:
1. Edit gist
2. Commit changes
3. Raw URL tetap sama!

### GitHub Repo:
```bash
git add .
git commit -m "Update: XYZ"
git push
```
Raw URL tetap sama!

---

## 📊 Tracking Installations

Tambahkan analytics sederhana:

```bash
# Di awal INSTALL.sh, tambahkan:
curl -s "https://analytics.example.com/install?source=$1" > /dev/null 2>&1 || true
```

Atau pakai GitHub stars sebagai tracking:
- Minta user star repo jika suka
- Count stars = proxy untuk installations

---

## 🎁 Bonus: Versioned Installer

Buat multiple versions:

```
install.sh          # Latest stable
install-dev.sh      # Development version
install-v1.0.sh     # Specific version
```

User bisa pilih version yang mau diinstall.

---

## ✅ Checklist Sebelum Publikasi

- [ ] Test INSTALL.sh di fresh environment
- [ ] Test di UserLAnd
- [ ] Test di Ubuntu/Debian
- [ ] Pastikan semua URLs correct
- [ ] Add error handling
- [ ] Add progress indicators
- [ ] Test uninstall/reinstall
- [ ] Buat CHEATSHEET.md yang jelas
- [ ] Buat README.md yang menarik
- [ ] Screenshot testing (optional)

---

**Ready to share!** 🎉
