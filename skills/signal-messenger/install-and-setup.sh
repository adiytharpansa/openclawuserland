#!/bin/bash
# Signal Messenger - Complete Installation & Setup
# Run ini di local machine (Ubuntu/Debian/Linux)

set -e

echo "=============================================="
echo "📱 Signal Messenger - Complete Setup"
echo "=============================================="
echo ""

# Detect OS
if [ -f /etc/debian_version ]; then
    echo "✅ Debian/Ubuntu detected"
    INSTALL_CMD="sudo apt"
elif [ -f /etc/redhat-release ]; then
    echo "✅ RedHat/CentOS detected"
    INSTALL_CMD="sudo yum"
elif command -v brew &> /dev/null; then
    echo "✅ macOS detected"
    INSTALL_CMD="brew"
else
    echo "⚠️  Unknown OS - will try generic install"
    INSTALL_CMD=""
fi

# Step 1: Install signal-cli
echo ""
echo "Step 1/3: Installing signal-cli..."
echo "-------------------------------------------"

if command -v signal-cli &> /dev/null; then
    echo "✅ signal-cli already installed"
    signal-cli --version
else
    echo "📦 Installing signal-cli..."
    
    if [ "$INSTALL_CMD" = "sudo apt" ]; then
        # Add repository and install
        sudo apt update
        sudo apt install -y signal-cli || {
            echo "⚠️  apt install failed, trying manual..."
            # Manual install
            wget -q https://github.com/AsamK/signal-cli/releases/download/v2.6.0/signal-cli-2.6.0.tar.gz -O /tmp/signal-cli.tar.gz
            tar -xzf /tmp/signal-cli.tar.gz -C /opt/
            ln -sf /opt/signal-cli-2.6.0/bin/signal-cli /usr/local/bin/signal-cli
        }
    elif [ "$INSTALL_CMD" = "brew" ]; then
        brew install signal-cli
    else
        # Manual install
        echo "📥 Downloading signal-cli..."
        wget -q https://github.com/AsamK/signal-cli/releases/download/v2.6.0/signal-cli-2.6.0.tar.gz -O /tmp/signal-cli.tar.gz
        tar -xzf /tmp/signal-cli.tar.gz -C /opt/
        ln -sf /opt/signal-cli-2.6.0/bin/signal-cli /usr/local/bin/signal-cli
    fi
    
    if command -v signal-cli &> /dev/null; then
        echo "✅ signal-cli installed successfully!"
        signal-cli --version
    else
        echo "❌ Failed to install signal-cli"
        echo ""
        echo "Please install manually:"
        echo "  Ubuntu: sudo apt install signal-cli"
        echo "  macOS: brew install signal-cli"
        echo "  Manual: https://github.com/AsamK/signal-cli"
        exit 1
    fi
fi

# Step 2: Register phone number
echo ""
echo "Step 2/3: Register your phone number"
echo "-------------------------------------------"
echo ""
echo "📞 Enter your Signal phone number (with country code):"
echo "   Example: +628123456789 (Indonesia)"
echo "            +1234567890 (USA)"
read -p "   > " PHONE_NUMBER

if [[ ! $PHONE_NUMBER =~ ^\+ ]]; then
    echo "❌ Phone number must start with + (country code)"
    exit 1
fi

echo ""
echo "📲 Requesting verification code..."
echo "   You will receive an SMS or call shortly"
echo ""

# Request verification
signal-cli -u $PHONE_NUMBER register

echo ""
read -p "Enter verification code from SMS: " VERIFICATION_CODE

echo ""
echo "🔐 Verifying..."
signal-cli -u $PHONE_NUMBER verify $VERIFICATION_CODE

if [ $? -eq 0 ]; then
    echo "✅ Phone number verified!"
else
    echo "❌ Verification failed"
    exit 1
fi

# Step 3: Test send message
echo ""
echo "Step 3/3: Send test message"
echo "-------------------------------------------"
echo ""
read -p "Enter recipient number for test (+...): " TEST_NUMBER

if [ -n "$TEST_NUMBER" ]; then
    echo ""
    echo "📱 Sending test message..."
    signal-cli -u $PHONE_NUMBER send -m "Hello from Signal Messenger! 🚀 Setup complete!" $TEST_NUMBER
    
    if [ $? -eq 0 ]; then
        echo "✅ Message sent successfully!"
    else
        echo "⚠️  Message failed (this is ok - recipient might not exist)"
    fi
fi

# Save configuration
echo ""
echo "💾 Saving configuration..."
CONFIG_FILE="$HOME/.signal-messenger-config.json"
cat > $CONFIG_FILE << EOF
{
  "phone_number": "$PHONE_NUMBER",
  "setup_date": "$(date -Iseconds)",
  "status": "active"
}
EOF

echo "✅ Config saved to: $CONFIG_FILE"

# Environment variable
echo ""
echo "=============================================="
echo "✅ SETUP COMPLETE!"
echo "=============================================="
echo ""
echo "📝 Add to your ~/.bashrc or ~/.zshrc:"
echo "   export SIGNAL_PHONE_NUMBER=$PHONE_NUMBER"
echo ""
echo "📚 Usage:"
echo "   # Send message"
echo "   signal-cli -u $PHONE_NUMBER send -m 'Hello!' +1234567890"
echo ""
echo "   # Or use the Python script:"
echo "   python3 lib/send_message.py --to +1234567890 --message 'Hi!'"
echo ""
echo "🎉 Signal Messenger is ready to use!"
echo ""
