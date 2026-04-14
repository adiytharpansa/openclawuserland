#!/usr/bin/env python3
"""
Signal Messenger - Simple Setup & Test
Tanpa Docker - langsung pakai signal-cli
"""

import os
import sys
import subprocess
import json

def check_signal_cli():
    """Check if signal-cli is installed"""
    try:
        result = subprocess.run(['which', 'signal-cli'], capture_output=True, text=True)
        if result.returncode == 0:
            return result.stdout.strip()
        return None
    except:
        return None

def register_number(phone_number):
    """Register phone number with Signal"""
    print(f"\n📱 Registering {phone_number}...")
    
    # Request verification code
    cmd = ['signal-cli', '-u', phone_number, 'register']
    print(f"   Requesting SMS code...")
    result = subprocess.run(cmd, capture_output=True, text=True)
    
    if result.returncode == 0:
        print(f"   ✅ Registration request sent!")
        print(f"   📲 Check your SMS for verification code")
        
        code = input("   Enter verification code: ").strip()
        
        # Verify code
        cmd = ['signal-cli', '-u', phone_number, 'verify', code]
        result = subprocess.run(cmd, capture_output=True, text=True)
        
        if result.returncode == 0:
            print(f"   ✅ Number verified!")
            return True
        else:
            print(f"   ❌ Verification failed: {result.stderr}")
            return False
    else:
        print(f"   ❌ Registration failed: {result.stderr}")
        return False

def send_test_message(phone_number, to_number):
    """Send test message"""
    print(f"\n📱 Sending test message to {to_number}...")
    
    cmd = [
        'signal-cli', '-u', phone_number,
        'send', '-m', 'Hello from Signal Messenger! 🚀',
        to_number
    ]
    
    result = subprocess.run(cmd, capture_output=True, text=True)
    
    if result.returncode == 0:
        print(f"   ✅ Message sent!")
        return True
    else:
        print(f"   ❌ Failed: {result.stderr}")
        return False

def main():
    print("=" * 60)
    print("📱 Signal Messenger - Quick Setup")
    print("=" * 60)
    
    # Check signal-cli
    print("\n🔍 Checking signal-cli...")
    signal_path = check_signal_cli()
    
    if not signal_path:
        print("   ❌ signal-cli not found!")
        print("\n   Please install signal-cli first:")
        print("   ")
        print("   Ubuntu/Debian:")
        print("     sudo apt update && sudo apt install signal-cli")
        print("   ")
        print("   macOS:")
        print("     brew install signal-cli")
        print("   ")
        print("   Or download from: https://github.com/AsamK/signal-cli")
        sys.exit(1)
    
    print(f"   ✅ Found: {signal_path}")
    
    # Get phone number
    print("\n📞 Enter your Signal phone number (with country code):")
    print("   Example: +628123456789 or +1234567890")
    phone_number = input("   > ").strip()
    
    if not phone_number.startswith('+'):
        print("   ❌ Phone number must start with + (country code)")
        sys.exit(1)
    
    # Register
    if not register_number(phone_number):
        print("\n❌ Registration failed. Please try again.")
        sys.exit(1)
    
    # Save config
    config_file = os.path.expanduser('~/.signal-messenger-config.json')
    config = {
        'phone_number': phone_number,
        'setup_complete': True
    }
    
    with open(config_file, 'w') as f:
        json.dump(config, f, indent=2)
    
    print(f"\n✅ Setup complete!")
    print(f"   Config saved to: {config_file}")
    
    # Set environment variable
    print(f"\n📝 Add to your ~/.bashrc or ~/.zshrc:")
    print(f"   export SIGNAL_PHONE_NUMBER={phone_number}")
    
    # Optional: Send test message
    print(f"\n🧪 Want to send a test message?")
    choice = input("   (y/n): ").strip().lower()
    
    if choice == 'y':
        to_number = input("   Enter recipient number (+...): ").strip()
        send_test_message(phone_number, to_number)
    
    print("\n" + "=" * 60)
    print("✅ Signal Messenger Ready!")
    print("=" * 60)
    print("\n📚 Usage:")
    print(f"   python3 lib/send_message.py --to <NUMBER> --message 'Hello!'")
    print(f"\n🔑 Or set env var: export SIGNAL_PHONE_NUMBER={phone_number}")
    print()

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\n\n🛑 Setup cancelled")
        sys.exit(0)
    except Exception as e:
        print(f"\n❌ Error: {e}")
        sys.exit(1)
