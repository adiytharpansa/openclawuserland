#!/usr/bin/env python3
"""
OpenClaw + Signal Bot
Terima dan balas pesan Signal secara otomatis dengan OpenClaw

Setup:
1. Install signal-cli
2. Register nomor
3. Run script ini
4. Bot akan listen dan balas pesan otomatis
"""

import subprocess
import os
import json
import time
import signal
import sys
from datetime import datetime
from pathlib import Path

# Configuration
SIGNAL_PHONE_NUMBER = os.getenv("SIGNAL_PHONE_NUMBER")
POLL_INTERVAL = 5  # Check messages every 5 seconds
STATE_FILE = Path.home() / ".openclaw-signal-state.json"

class SignalBot:
    def __init__(self, phone_number=None):
        self.phone_number = phone_number or os.getenv("SIGNAL_PHONE_NUMBER")
        if not self.phone_number:
            raise ValueError("SIGNAL_PHONE_NUMBER not set!")
        
        self.running = True
        self.last_message_time = 0
        self.processed_messages = set()
        
        # Load state
        self.load_state()
    
    def load_state(self):
        """Load last processed message state"""
        if STATE_FILE.exists():
            try:
                with open(STATE_FILE, 'r') as f:
                    state = json.load(f)
                    self.last_message_time = state.get('last_message_time', 0)
                    self.processed_messages = set(state.get('processed_ids', []))
            except:
                pass
    
    def save_state(self):
        """Save state to file"""
        state = {
            'last_message_time': self.last_message_time,
            'processed_ids': list(self.processed_messages)
        }
        with open(STATE_FILE, 'w') as f:
            json.dump(state, f, indent=2)
    
    def receive_messages(self):
        """Receive messages from Signal"""
        cmd = [
            "signal-cli",
            "-u", self.phone_number,
            "receive"
        ]
        
        try:
            result = subprocess.run(
                cmd,
                capture_output=True,
                text=True,
                timeout=10
            )
            
            if result.returncode == 0 and result.stdout.strip():
                messages = []
                for line in result.stdout.strip().split('\n'):
                    if line.strip():
                        messages.append(line)
                return messages
            return []
        
        except subprocess.TimeoutExpired:
            return []
        except Exception as e:
            print(f"Error receiving: {e}")
            return []
    
    def send_message(self, recipient, message):
        """Send message to Signal"""
        cmd = [
            "signal-cli",
            "-u", self.phone_number,
            "send",
            "-m", message,
            recipient
        ]
        
        try:
            result = subprocess.run(cmd, capture_output=True, text=True, timeout=30)
            return result.returncode == 0
        except:
            return False
    
    def process_message(self, message_line):
        """Process incoming message and generate response"""
        # Parse message (format: timestamp from number: message)
        try:
            parts = message_line.split(':', 1)
            if len(parts) < 2:
                return
            
            sender_info = parts[0]
            message_text = parts[1].strip() if len(parts) > 1 else ""
            
            # Extract sender number
            sender = sender_info.split('from')[-1].strip() if 'from' in sender_info else sender_info.split()[0]
            
            # Skip if already processed
            msg_id = f"{sender}:{message_text}"
            if msg_id in self.processed_messages:
                return
            
            print(f"\n📨 Received from {sender}: {message_text}")
            
            # Generate response based on message
            response = self.generate_response(message_text)
            
            if response:
                print(f"📤 Sending response to {sender}")
                self.send_message(sender, response)
            
            # Mark as processed
            self.processed_messages.add(msg_id)
            self.last_message_time = time.time()
            self.save_state()
            
            # Keep only last 100 messages
            if len(self.processed_messages) > 100:
                self.processed_messages = set(list(self.processed_messages)[-100:])
        
        except Exception as e:
            print(f"Error processing message: {e}")
    
    def generate_response(self, message):
        """Generate response based on incoming message"""
        message_lower = message.lower().strip()
        
        # Command: help
        if message_lower in ['help', '/help', 'halo', 'hi', 'hello']:
            return """🦞 OpenClaw Bot

Commands:
/status - Check bot status
/time - Current time
/date - Current date
/help - Show this help

Or just chat!"""
        
        # Command: status
        elif message_lower in ['/status', 'status']:
            return f"""✅ Bot Status

🟢 Online
🕐 {datetime.now().strftime('%H:%M:%S')}
📅 {datetime.now().strftime('%Y-%m-%d')}
📱 Number: {self.phone_number}"""
        
        # Command: time
        elif message_lower in ['/time', 'jam', 'waktu']:
            return f"🕐 Current time: {datetime.now().strftime('%H:%M:%S')}"
        
        # Command: date
        elif message_lower in ['/date', 'tanggal', 'date']:
            return f"📅 Today: {datetime.now().strftime('%A, %B %d, %Y')}"
        
        # Command: test
        elif message_lower in ['/test', 'test']:
            return "✅ Test successful! Bot is working!"
        
        # Default: Echo with OpenClaw branding
        else:
            return f"""🦞 OpenClaw received:

"{message}"

Bot is listening! 👂
Type /help for commands."""
    
    def run(self):
        """Main bot loop"""
        print("=" * 60)
        print("🦞 OpenClaw Signal Bot")
        print("=" * 60)
        print(f"Phone: {self.phone_number}")
        print(f"Poll interval: {POLL_INTERVAL}s")
        print("Press Ctrl+C to stop")
        print("=" * 60)
        print()
        print("Bot is listening for messages...")
        print()
        
        # Signal handler for graceful shutdown
        def signal_handler(sig, frame):
            print("\n\n🛑 Stopping bot...")
            self.running = False
        
        signal.signal(signal.SIGINT, signal_handler)
        signal.signal(signal.SIGTERM, signal_handler)
        
        # Main loop
        while self.running:
            try:
                messages = self.receive_messages()
                
                for message in messages:
                    if message:
                        self.process_message(message)
                
                time.sleep(POLL_INTERVAL)
            
            except KeyboardInterrupt:
                break
            except Exception as e:
                print(f"Error in main loop: {e}")
                time.sleep(POLL_INTERVAL)
        
        print()
        print("✅ Bot stopped gracefully")
        self.save_state()


def main():
    print("\n📱 OpenClaw + Signal Bot Setup\n")
    
    # Check signal-cli
    if not subprocess.run(["which", "signal-cli"], capture_output=True).returncode == 0:
        print("❌ signal-cli not found!")
        print("\nInstall first:")
        print("  Ubuntu/Debian: sudo apt install signal-cli")
        print("  macOS: brew install signal-cli")
        sys.exit(1)
    
    print("✅ signal-cli found")
    
    # Check registration
    phone = os.getenv("SIGNAL_PHONE_NUMBER")
    if not phone:
        print("\n⚠️  SIGNAL_PHONE_NUMBER not set!")
        print("\nSet your phone number:")
        print("  export SIGNAL_PHONE_NUMBER=+6285745115673")
        sys.exit(1)
    
    print(f"✅ Phone: {phone}")
    
    # Check if registered
    data_dir = Path.home() / ".local" / "share" / "signal-cli" / "data"
    if not data_dir.exists():
        print("\n❌ Signal not registered!")
        print("\nRegister first:")
        print(f"  signal-cli -u {phone} register")
        print(f"  signal-cli -u {phone} verify <CODE>")
        sys.exit(1)
    
    print("✅ Signal registered")
    print()
    
    # Start bot
    try:
        bot = SignalBot(phone)
        bot.run()
    except Exception as e:
        print(f"\n❌ Error: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()
