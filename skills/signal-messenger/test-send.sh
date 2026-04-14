#!/bin/bash
# Test kirim pesan Signal ke nomor kamu
# Run ini di local machine yang sudah install signal-cli

PHONE_NUMBER="+6285745115673"  # Nomor kamu

echo "=============================================="
echo "📱 Test Kirim Pesan Signal"
echo "=============================================="
echo ""
echo "Mengirim pesan ke: $PHONE_NUMBER"
echo ""

# Check if signal-cli is installed
if ! command -v signal-cli &> /dev/null; then
    echo "❌ signal-cli tidak terinstall!"
    echo ""
    echo "Install dulu:"
    echo "  Ubuntu/Debian: sudo apt install signal-cli"
    echo "  macOS: brew install signal-cli"
    exit 1
fi

echo "✅ signal-cli ditemukan"
echo ""

# Check if registered
echo "🔍 Checking registration..."
if [ ! -d ~/.local/share/signal-cli ]; then
    echo "❌ Signal belum terdaftar!"
    echo ""
    echo "Register dulu dengan nomor kamu:"
    echo "  signal-cli -u +6285745115673 register"
    echo "  signal-cli -u +6285745115673 verify <KODE_SMS>"
    exit 1
fi

echo "✅ Signal terdaftar"
echo ""

# Get sender number from config
SENDER_NUMBER=$(ls ~/.local/share/signal-cli/data/ 2>/dev/null | head -1 | cut -d'+' -f2 | cut -d'.' -f1)
SENDER_NUMBER="+$SENDER_NUMBER"

if [ -z "$SENDER_NUMBER" ]; then
    echo "⚠️  Tidak ada nomor terdaftar"
    echo ""
    echo "Register dulu:"
    echo "  signal-cli -u +6285745115673 register"
    exit 1
fi

echo "📤 Mengirim pesan..."
echo ""

# Send message
signal-cli -u $SENDER_NUMBER send -m "🦞 OpenClaw Test!

Halo! Ini test pesan dari OpenClaw.

✅ Signal integration berhasil!
🕐 $(date '+%H:%M:%S')
📅 $(date '+%Y-%m-%d')

Next: Setup notifikasi otomatis untuk workflows!" $PHONE_NUMBER

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ PESAN TERKIRIM!"
    echo ""
    echo "Cek Signal di HP kamu!"
else
    echo ""
    echo "❌ Gagal kirim pesan"
    echo ""
    echo "Pastikan:"
    echo "  1. Nomor sudah terdaftar"
    echo "  2. Recipient punya Signal"
    echo "  3. Koneksi internet bagus"
fi

echo ""
echo "=============================================="
