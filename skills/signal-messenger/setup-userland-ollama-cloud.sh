#!/bin/bash
# Complete Setup: UserLAnd + Ollama Cloud API + Signal
# Run ini di UserLAnd setelah install Linux

set -e

echo "=============================================="
echo "🦞 OpenClaw Setup - UserLAnd + Ollama Cloud"
echo "=============================================="
echo ""

# Step 1: Install Python
echo "Step 1/5: Installing Python..."
sudo apt update
sudo apt install python3 python3-pip -y
echo "✅ Python installed"
echo ""

# Step 2: Setup virtual environment
echo "Step 2/5: Setting up Python environment..."
cd ~
python3 -m venv .venv
source .venv/bin/activate
pip install requests customtkinter
echo "✅ Python packages installed"
echo ""

# Step 3: Create config
echo "Step 3/5: Creating config..."
mkdir -p ~/openclaw
cd ~/openclaw

cat > config.json << 'EOF'
{
  "OLLAMA_API_KEY": "57b3c4ad42df47fdbc494eac4c8fec95.Zr0y59Dr__y43o6-Lli0fFf1",
  "OLLAMA_BASE_URL": "https://api.ollama.com",
  "OLLAMA_MODEL": "gemma3:27b"
}
EOF

echo "✅ Config created"
echo ""

# Step 4: Install signal-cli
echo "Step 4/5: Installing signal-cli..."
sudo apt install signal-cli -y
echo "✅ signal-cli installed"
echo ""

# Step 5: Create simple test script
echo "Step 5/5: Creating test script..."

cat > test-ollama.py << 'EOF'
#!/usr/bin/env python3
import requests
import json

# Load config
with open('config.json', 'r') as f:
    config = json.load(f)

API_KEY = config['OLLAMA_API_KEY']
BASE_URL = config['OLLAMA_BASE_URL']
MODEL = config['OLLAMA_MODEL']

print("=" * 50)
print("🧪 Testing Ollama Cloud API")
print("=" * 50)
print(f"Model: {MODEL}")
print(f"API: {BASE_URL}")
print()

headers = {
    "Authorization": f"Bearer {API_KEY}",
    "Content-Type": "application/json"
}

# Test chat
url = f"{BASE_URL}/api/chat"
payload = {
    "model": MODEL,
    "messages": [{"role": "user", "content": "Say hello in one word"}],
    "stream": False
}

print("Sending test request...")
response = requests.post(url, json=payload, headers=headers, timeout=60)

if response.status_code == 200:
    result = response.json()
    message = result.get('message', {}).get('content', '')
    print(f"✅ Success! Response: {message}")
else:
    print(f"❌ Error: {response.status_code}")
    print(response.text)

print()
print("=" * 50)
print("✅ Test Complete!")
print("=" * 50)
EOF

chmod +x test-ollama.py
python3 test-ollama.py

echo ""
echo "=============================================="
echo "✅ Setup Complete!"
echo "=============================================="
echo ""
echo "📁 Workspace: ~/openclaw"
echo "📝 Config: ~/openclaw/config.json"
echo "🧪 Test: cd ~/openclaw && python3 test-ollama.py"
echo ""
echo "📱 Next: Setup Signal bot"
echo "   cd ~/openclaw"
echo "   mkdir -p skills/signal-messenger"
echo "   # Copy userland-bot.py from cloud"
echo "   python3 userland-bot.py"
echo ""
echo "🎬 Next: Copy AI-Content-Studio from cloud"
echo ""
