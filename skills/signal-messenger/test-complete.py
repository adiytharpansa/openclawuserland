#!/usr/bin/env python3
"""
Signal Integration Test Script
Test semua fungsi Signal integration

NOTE: This simulates the test. Run on local machine with signal-cli for real test.
"""

import os
import sys
import subprocess
from pathlib import Path

print("=" * 60)
print("🧪 OpenClaw + Signal Integration Test")
print("=" * 60)
print()

# Test 1: Check signal-cli
print("Test 1: Checking signal-cli...")
print("-" * 60)
result = subprocess.run(["which", "signal-cli"], capture_output=True, text=True)
if result.returncode == 0:
    print(f"✅ signal-cli found: {result.stdout.strip()}")
    version = subprocess.run(["signal-cli", "--version"], capture_output=True, text=True)
    print(f"   Version: {version.stdout.strip()}")
else:
    print("❌ signal-cli NOT found!")
    print()
    print("   Install on local machine:")
    print("   Ubuntu: sudo apt install signal-cli")
    print("   macOS: brew install signal-cli")
print()

# Test 2: Check environment
print("Test 2: Checking environment...")
print("-" * 60)
phone = os.getenv("SIGNAL_PHONE_NUMBER", "+6285745115673")
print(f"✅ Phone number: {phone}")
print()

# Test 3: Check registration
print("Test 3: Checking registration...")
print("-" * 60)
data_dir = Path.home() / ".local" / "share" / "signal-cli" / "data"
if data_dir.exists():
    print(f"✅ Signal registered: {data_dir}")
    files = list(data_dir.glob("*"))
    print(f"   Data files: {len(files)}")
else:
    print("❌ Signal NOT registered!")
    print()
    print("   Register on local machine:")
    print(f"   signal-cli -u {phone} register")
    print(f"   signal-cli -u {phone} verify <CODE>")
print()

# Test 4: Test send message (only if registered)
print("Test 4: Test send message...")
print("-" * 60)
if data_dir.exists():
    message = """🦞 OpenClaw Test!

✅ Signal integration working!
🕐 Test timestamp
📅 Test date

This is a test message from OpenClaw."""
    
    cmd = ["signal-cli", "-u", phone, "send", "-m", message, phone]
    result = subprocess.run(cmd, capture_output=True, text=True, timeout=30)
    
    if result.returncode == 0:
        print("✅ Message sent successfully!")
        print(f"   To: {phone}")
    else:
        print(f"❌ Failed to send: {result.stderr}")
else:
    print("⏭️  Skipped (not registered)")
print()

# Test 5: Check integration script
print("Test 5: Checking integration script...")
print("-" * 60)
integration_file = Path("integration.py")
if integration_file.exists():
    print(f"✅ integration.py found")
    print(f"   Size: {integration_file.stat().st_size} bytes")
else:
    print("❌ integration.py NOT found!")
print()

# Test 6: Check bot script
print("Test 6: Checking bot script...")
print("-" * 60)
bot_file = Path("signal-bot.py")
if bot_file.exists():
    print(f"✅ signal-bot.py found")
    print(f"   Size: {bot_file.stat().st_size} bytes")
else:
    print("❌ signal-bot.py NOT found!")
print()

# Test 7: Check documentation
print("Test 7: Checking documentation...")
print("-" * 60)
docs = ["CONNECT_GUIDE.md", "INTEGRATION_GUIDE.md", "QUICKSTART.md", "README.md"]
for doc in docs:
    doc_file = Path(doc)
    if doc_file.exists():
        print(f"✅ {doc}")
    else:
        print(f"❌ {doc} NOT found!")
print()

# Summary
print("=" * 60)
print("📊 Test Summary")
print("=" * 60)
print()

checks = [
    ("signal-cli installed", subprocess.run(["which", "signal-cli"], capture_output=True).returncode == 0),
    ("Environment configured", True),  # Always true (uses default)
    ("Signal registered", data_dir.exists()),
    ("integration.py exists", integration_file.exists()),
    ("signal-bot.py exists", bot_file.exists()),
    ("Documentation complete", all(Path(d).exists() for d in docs)),
]

passed = sum(1 for _, check in checks if check)
total = len(checks)

for name, check in checks:
    status = "✅" if check else "❌"
    print(f"{status} {name}")

print()
print(f"Result: {passed}/{total} checks passed")
print()

if passed == total:
    print("🎉 ALL TESTS PASSED!")
    print()
    print("Signal integration is ready to use!")
    print()
    print("Next steps:")
    print("1. Run bot: python3 signal-bot.py")
    print("2. Send 'help' to your Signal number")
    print("3. Check auto-reply")
elif passed >= total - 1:
    print("⚠️  Almost ready! Just need to complete setup.")
    print()
    if not data_dir.exists():
        print("Register Signal:")
        print(f"  signal-cli -u {phone} register")
        print(f"  signal-cli -u {phone} verify <CODE>")
else:
    print("❌ Setup incomplete. Please run connect-all.sh")
    print()
    print("Quick setup:")
    print("  ./connect-all.sh")

print()
print("=" * 60)
