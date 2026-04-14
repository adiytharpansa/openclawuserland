# 🤖 OpenClaw + Signal di UserLAnd (Android)

**Setup bot untuk kontrol OpenClaw dari HP Android!**

---

## 📱 Setup di UserLAnd

### **1. Install signal-cli**

```bash
sudo apt update
sudo apt install signal-cli -y
```

### **2. Register Nomor**

```bash
signal-cli -u +6285745115673 register
```

Kamu dapat SMS, lalu verify:

```bash
signal-cli -u +6285745115673 verify 123456
# Ganti dengan kode SMS
```

### **3. Test**

```bash
signal-cli -u +6285745115673 send -m "Test!" +6285745115673
```

Cek Signal di HP - harusnya ada pesan! ✅

---

## 🚀 Jalankan Bot

### **Option 1: Simple (Recommended)**

```bash
cd /path/to/skills/signal-messenger
python3 userland-bot.py
```

Bot akan jalan dan dengar pesan masuk!

### **Option 2: Background (Screen)**

```bash
# Install screen
sudo apt install screen -y

# Jalankan di background
screen -S signal-bot
python3 userland-bot.py

# Keluar: Ctrl+A, D
# Kembali: screen -r
```

---

## 📱 Commands dari Signal

**Kirim pesan ke nomor Signal kamu:**

| Command | Hasil |
|---------|-------|
| `help` | Menu commands |
| `/status` | Status OpenClaw |
| `/time` | Waktu sekarang |
| `/date` | Tanggal |
| `/test` | Test bot |
| `/generate AI` | Generate content |
| `/research topic` | Research |

---

## 💡 Contoh Penggunaan

### **1. Cek Status**

**Kirim:** `/status`

**Balas:**
```
✅ OpenClaw Status

🟢 Online
📱 UserLAnd Android
🕐 06:38:00
📚 27 Skills loaded
🎬 AI-Content-Studio ready
```

### **2. Generate Content**

**Kirim:** `/generate Psychology of Habits`

**Balas:**
```
🎬 Generating content about: Psychology of Habits

⏳ Please wait...
```

### **3. Check Waktu**

**Kirim:** `/time`

**Balas:**
```
🕐 Waktu: 06:38:00
```

---

## 🔧 Customize Bot

Edit file `userland-bot.py`, bagian `process_command()`:

```python
def process_command(self, message):
    # Tambah command baru di sini
    if message == "/mycommand":
        return "Custom response!"
```

---

## 🎯 Next Steps

1. ✅ Install signal-cli di UserLAnd
2. ✅ Register nomor
3. ✅ Copy file `userland-bot.py` ke UserLAnd
4. ✅ Run: `python3 userland-bot.py`
5. ✅ Test dari Signal HP!

---

**Bot siap dipakai untuk kontrol OpenClaw dari HP!** 🚀
