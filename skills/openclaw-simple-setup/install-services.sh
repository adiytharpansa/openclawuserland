#!/bin/bash
# Install systemd services for auto-start on boot

set -e

if [ "$EUID" -ne 0 ]; then 
    echo "Please run as root (sudo ./install-services.sh)"
    exit 1
fi

USERNAME=$(whoami)
HOME_DIR="/home/$USERNAME"

echo "🔧 Installing systemd services..."

# Ollama service
cat > /etc/systemd/system/ollama.service << EOF
[Unit]
Description=Ollama Service
After=network.target

[Service]
Type=simple
User=$USERNAME
ExecStart=/usr/local/bin/ollama serve
Restart=always
Environment="PATH=/usr/local/bin:/usr/bin:/bin"

[Install]
WantedBy=multi-user.target
EOF

# OpenClaw Gateway service
cat > /etc/systemd/system/openclaw-gateway.service << EOF
[Unit]
Description=OpenClaw Gateway
After=network.target ollama.service

[Service]
Type=simple
User=$USERNAME
WorkingDirectory=$HOME_DIR/.openclaw/workspace
ExecStart=/usr/bin/openclaw gateway start
Restart=always
Environment="PATH=/usr/local/bin:/usr/bin:/bin"
Environment="NODE_ENV=production"

[Install]
WantedBy=multi-user.target
EOF

# Enable and start
echo "Enabling services..."
systemctl daemon-reload
systemctl enable ollama
systemctl enable openclaw-gateway

echo "Starting services..."
systemctl start ollama
systemctl start openclaw-gateway

echo ""
echo "✅ Services installed and started!"
echo ""
echo "Check status:"
echo "  systemctl status ollama"
echo "  systemctl status openclaw-gateway"
echo ""
echo "View logs:"
echo "  journalctl -u ollama -f"
echo "  journalctl -u openclaw-gateway -f"
