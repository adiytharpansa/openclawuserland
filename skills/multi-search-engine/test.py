#!/usr/bin/env python3
"""
Test Multi Search Engine Skill
Test search dengan multiple engines
"""

import requests
import json
from urllib.parse import quote

print("=" * 60)
print("🔍 Multi Search Engine Test")
print("=" * 60)
print()

# Test query
QUERY = "OpenClaw AI agent"
print(f"Query: {QUERY}")
print()

# Search engines to test
engines = [
    ("Google", f"https://www.google.com/search?q={quote(QUERY)}"),
    ("DuckDuckGo", f"https://duckduckgo.com/html/?q={quote(QUERY)}"),
    ("Bing", f"https://www.bing.com/search?q={quote(QUERY)}"),
    ("Startpage", f"https://www.startpage.com/sp/search?query={quote(QUERY)}"),
]

# Test each engine
for name, url in engines:
    print(f"Testing {name}...")
    try:
        response = requests.get(
            url,
            headers={
                "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
            },
            timeout=10
        )
        
        if response.status_code == 200:
            print(f"  ✅ {name} - Success ({len(response.text)} bytes)")
        else:
            print(f"  ⚠️  {name} - Status {response.status_code}")
    
    except Exception as e:
        print(f"  ❌ {name} - Error: {e}")

print()
print("=" * 60)
print("✅ Test Complete!")
print("=" * 60)
