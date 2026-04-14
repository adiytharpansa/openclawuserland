#!/usr/bin/env python3
"""
Simple Ollama Cloud Test untuk UserLAnd
Gampang dipakai!
"""

import requests
import json

# API Key kamu
API_KEY = "57b3c4ad42df47fdbc494eac4c8fec95.Zr0y59Dr__y43o6-Lli0fFf1"
BASE_URL = "https://api.ollama.com"
MODEL = "gemma3:27b"

print("=" * 50)
print("🧪 Test Ollama Cloud API")
print("=" * 50)
print()

# Test 1: Simple chat
print("Test 1: Simple chat...")
headers = {
    "Authorization": f"Bearer {API_KEY}",
    "Content-Type": "application/json"
}

response = requests.post(
    f"{BASE_URL}/api/chat",
    json={
        "model": MODEL,
        "messages": [{"role": "user", "content": "Hello!"}],
        "stream": False
    },
    headers=headers,
    timeout=60
)

if response.status_code == 200:
    result = response.json()
    message = result.get('message', {}).get('content', '')
    print(f"✅ Success: {message}")
else:
    print(f"❌ Error: {response.status_code}")

print()
print("=" * 50)
print("✅ Test done!")
print("=" * 50)
