#!/bin/bash
# Signal Messenger Setup Script

echo "📱 Signal Messenger Setup"
echo "========================"
echo ""

# Check if Docker is available
if command -v docker &> /dev/null; then
    echo "✅ Docker found!"
    echo ""
    
    # Check if signal-cli-rest-api is already running
    if docker ps | grep -q signal-api; then
        echo "✅ Signal API container already running"
    else
        echo "🐳 Starting signal-cli-rest-api container..."
        
        mkdir -p signal-cli-config
        
        docker run -d --name signal-api \
            -p 8080:8080 \
            -v $(pwd)/signal-cli-config:/home/.local/share/signal-cli \
            -e SIGNAL_CLI_HTTP_BASIC_AUTH_USER=admin \
            -e SIGNAL_CLI_HTTP_BASIC_AUTH_PASSWORD=signal123 \
            bbernhard/signal-cli-rest-api:latest
        
        echo "✅ Container started!"
        echo ""
        echo "⏳ Waiting for API to be ready..."
        sleep 5
    fi
    
    # Test API
    echo ""
    echo "🧪 Testing API connection..."
    if curl -s http://localhost:8080/v1/about > /dev/null 2>&1; then
        echo "✅ API is running!"
        echo ""
        echo "📋 Configuration:"
        echo "   API URL: http://localhost:8080"
        echo "   Username: admin"
        echo "   Password: signal123"
        echo ""
        echo "🔑 Next steps:"
        echo "   1. Register your number:"
        echo "      curl -X POST http://localhost:8080/v1/register/+<YOUR_NUMBER>"
        echo ""
        echo "   2. Verify with SMS code:"
        echo "      curl -X PUT http://localhost:8080/v1/register/+<YOUR_NUMBER>/verify/<CODE>"
        echo ""
        echo "   3. Set environment variables:"
        echo "      export SIGNAL_API_URL=http://localhost:8080"
        echo "      export SIGNAL_API_USER=admin"
        echo "      export SIGNAL_API_PASSWORD=signal123"
        echo "      export SIGNAL_PHONE_NUMBER=+<YOUR_NUMBER>"
        echo ""
        echo "   4. Test sending message:"
        echo "      python3 lib/send_message.py --to +1234567890 --message 'Hello!'"
        echo ""
    else
        echo "❌ API not responding. Check: docker logs signal-api"
    fi
    
else
    echo "❌ Docker not found!"
    echo ""
    echo "Please install Docker or signal-cli:"
    echo ""
    echo "Option 1: Install Docker"
    echo "   https://docs.docker.com/get-docker/"
    echo ""
    echo "Option 2: Install signal-cli directly"
    echo "   Ubuntu/Debian: sudo apt install signal-cli"
    echo "   macOS: brew install signal-cli"
    echo ""
    echo "After installing signal-cli:"
    echo "   1. Register: signal-cli -u +<NUMBER> register"
    echo "   2. Verify: signal-cli -u +<NUMBER> verify <CODE>"
    echo "   3. Set env: export SIGNAL_PHONE_NUMBER=+<NUMBER>"
    echo "   4. Test: python3 lib/send_message.py --to +1234567890 --message 'Hello!'"
fi
