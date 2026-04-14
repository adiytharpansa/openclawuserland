#!/bin/bash
# OpenClaw Quick Setup - One Liner Version
# Copy-paste friendly for Firebase Studio terminal

echo "🦞 Installing OpenClaw..." && \
npm install -g openclaw && \
echo "📝 Creating .env..." && \
cat > .env << 'ENVEOF'
MATON_API_KEY=fNEwqPnPmiR58CMu2HoU-1K7kdPDcMKf6hFSl4NDNURJWOcRQcZojTITsslt_4vZSLSRK4v_CQgusHsRn6lGl8i5Xm1Imam1Au8
OPENCLAW_HOME=$HOME/.openclaw
ENVEOF
echo "📚 Installing skills..." && \
clawhub install openclaw-cli && \
clawhub install firebase && \
clawhub install laravel && \
clawhub install php && \
clawhub install github && \
clawhub install telegram && \
clawhub install webhook-send && \
echo "🏗️  Creating directories..." && \
mkdir -p src tests config storage && \
echo "✅ Done! Run: openclaw status"
