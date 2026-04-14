#!/bin/bash
# OpenClaw + Signal - UserLAnd Quick Setup
# Run ini di UserLAnd (Android)

echo "========================================"
echo "🦞 OpenClaw Signal Bot - UserLAnd Setup"
echo "========================================"
echo ""

# Install signal-cli
echo "📦 Installing signal-cli..."
sudo apt update
sudo apt install signal-cli -y

echo ""
echo "✅ signal-cli installed"
echo ""

# Register
echo "📱 Register your number: +6285745115673"
echo ""
echo "Run these commands:"
echo ""
echo "  signal-cli -u +6285745115673 register"
echo "  signal-cli -u +6285745115673 verify <CODE>"
echo ""
read -p "Press Enter after verification..."

# Test
echo ""
echo "🧪 Testing..."
signal-cli -u +6285745115673 send -m "✅ Setup complete!" +6285745115673

echo ""
echo "========================================"
echo "✅ Setup Complete!"
echo "========================================"
echo ""
echo "🚀 Run bot:"
echo "   python3 userland-bot.py"
echo ""
echo "📱 Test from Signal:"
echo "   Send 'help' to your number"
echo ""
