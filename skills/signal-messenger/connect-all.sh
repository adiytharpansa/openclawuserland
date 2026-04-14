#!/bin/bash
# OpenClaw + Signal - One Command Setup
# Run ini di local machine/server

set -e

PHONE_NUMBER="+6285745115673"  # Your Signal number

echo "=============================================="
echo "🦞 OpenClaw + Signal - Complete Setup"
echo "=============================================="
echo ""

# Step 1: Install signal-cli
echo "Step 1/4: Installing signal-cli..."
echo "-------------------------------------------"

if command -v signal-cli &> /dev/null; then
    echo "✅ signal-cli already installed"
    signal-cli --version
else
    echo "📦 Installing signal-cli..."
    
    if [ -f /etc/debian_version ]; then
        sudo apt update
        sudo apt install -y signal-cli
    elif command -v brew &> /dev/null; then
        brew install signal-cli
    else
        echo "❌ Unsupported OS. Please install signal-cli manually."
        echo "   Ubuntu: sudo apt install signal-cli"
        echo "   macOS: brew install signal-cli"
        exit 1
    fi
    
    echo "✅ signal-cli installed"
fi

echo ""

# Step 2: Register phone number
echo "Step 2/4: Register phone number"
echo "-------------------------------------------"
echo ""
echo "📞 Your number: $PHONE_NUMBER"
echo ""
echo "Requesting verification code..."
signal-cli -u $PHONE_NUMBER register

echo ""
read -p "Enter SMS verification code: " VERIFY_CODE

echo ""
echo "Verifying..."
if signal-cli -u $PHONE_NUMBER verify $VERIFY_CODE; then
    echo "✅ Number verified!"
else
    echo "❌ Verification failed"
    exit 1
fi

echo ""

# Step 3: Set environment variable
echo "Step 3/4: Configure environment"
echo "-------------------------------------------"

if ! grep -q "SIGNAL_PHONE_NUMBER" ~/.bashrc; then
    echo "export SIGNAL_PHONE_NUMBER=$PHONE_NUMBER" >> ~/.bashrc
    echo "✅ Added to ~/.bashrc"
else
    echo "✅ SIGNAL_PHONE_NUMBER already in ~/.bashrc"
fi

if ! grep -q "SIGNAL_PHONE_NUMBER" ~/.zshrc 2>/dev/null; then
    echo "export SIGNAL_PHONE_NUMBER=$PHONE_NUMBER" >> ~/.zshrc 2>/dev/null || true
    echo "✅ Added to ~/.zshrc (if exists)"
fi

echo ""
echo "📝 Environment configured"
echo "   Run 'source ~/.bashrc' to apply"
echo ""

# Step 4: Test
echo "Step 4/4: Test setup"
echo "-------------------------------------------"

echo ""
echo "🧪 Sending test message..."
if signal-cli -u $PHONE_NUMBER send -m "🦞 OpenClaw Signal Setup Complete!

✅ Bot is ready!
🕐 $(date '+%H:%M:%S')
📅 $(date '+%Y-%m-%d')

Type /help for commands." $PHONE_NUMBER; then
    echo "✅ Test message sent!"
    echo "   Check your Signal app!"
else
    echo "⚠️  Test message failed (but setup might still work)"
fi

echo ""
echo "=============================================="
echo "✅ SETUP COMPLETE!"
echo "=============================================="
echo ""
echo "🚀 Next steps:"
echo ""
echo "1. Apply environment:"
echo "   source ~/.bashrc"
echo ""
echo "2. Run the bot:"
echo "   cd /path/to/skills/signal-messenger"
echo "   python3 signal-bot.py"
echo ""
echo "3. Or setup as service:"
echo "   See CONNECT_GUIDE.md for instructions"
echo ""
echo "4. Test commands:"
echo "   Send 'help' to your number in Signal"
echo ""
echo "📚 Documentation:"
echo "   - CONNECT_GUIDE.md (Complete guide)"
echo "   - INTEGRATION_GUIDE.md (API reference)"
echo "   - QUICKSTART.md (Quick start)"
echo ""
echo "🎉 OpenClaw is now connected to Signal!"
echo ""
