#!/usr/bin/env python3
"""
OpenClaw Signal Bot - UserLAnd Edition
Kontrol OpenClaw dari Signal di Android!
"""

import subprocess
import os
import sys
from datetime import datetime

PHONE_NUMBER = "+6285745115673"  # Nomor Signal kamu

def send_signal(message):
    """Kirim pesan ke Signal"""
    cmd = [
        "signal-cli",
        "-u", PHONE_NUMBER,
        "send", "-m", message,
        PHONE_NUMBER  # Kirim ke diri sendiri
    ]
    subprocess.run(cmd, capture_output=True)

def receive_signal():
    """Terima pesan dari Signal"""
    cmd = ["signal-cli", "-u", PHONE_NUMBER, "receive"]
    result = subprocess.run(cmd, capture_output=True, text=True, timeout=10)
    return result.stdout.strip()

def process_command(message):
    """Proses command dari Signal"""
    msg = message.lower().strip()
    
    # Command: help
    if msg in ['help', '/help', 'halo', 'hi']:
        return """🦞 OpenClaw Bot

Commands:
/status - Status OpenClaw
/generate <topic> - Generate content
/research <topic> - Research
/time - Waktu sekarang
/date - Tanggal
/test - Test bot

Contoh:
/generate AI trends"""

    # Command: status
    elif msg in ['/status', 'status']:
        return """✅ OpenClaw Status

🟢 Online
📱 UserLAnd Android
🕐 {}
📚 27 Skills loaded
🎬 AI-Content-Studio ready""".format(datetime.now().strftime('%H:%M:%S'))

    # Command: time
    elif msg in ['/time', 'jam', 'waktu']:
        return "🕐 Waktu: {}".format(datetime.now().strftime('%H:%M:%S'))

    # Command: date
    elif msg in ['/date', 'tanggal']:
        return "📅 Tanggal: {}".format(datetime.now().strftime('%A, %d %B %Y'))

    # Command: test
    elif msg in ['/test', 'test']:
        return "✅ Test berhasil! Bot bekerja!"

    # Command: generate content
    elif msg.startswith('/generate') or 'generate' in msg:
        topic = message.replace('/generate', '').replace('generate', '').strip()
        if not topic:
            topic = "AI"
        
        # Trigger AI-Content-Studio (simple version)
        return "🎬 Generating content about: {}\n\n⏳ Please wait...".format(topic)

    # Command: research
    elif msg.startswith('/research') or 'research' in msg:
        topic = message.replace('/research', '').strip()
        if not topic:
            topic = "technology"
        
        return "🔬 Researching: {}\n\n⏳ Working on it...".format(topic)

    # Default: echo
    else:
        return """🦞 OpenClaw received:

"{}"

Type /help for commands.""".format(message)

def main():
    print("=" * 50)
    print("🦞 OpenClaw Signal Bot - UserLAnd")
    print("=" * 50)
    print("Phone: {}".format(PHONE_NUMBER))
    print("Listening for messages...")
    print("=" * 50)
    print()
    
    print("Bot started! Press Ctrl+C to stop")
    
    last_messages = set()
    
    while True:
        try:
            # Terima pesan
            messages = receive_signal()
            
            if messages:
                for msg in messages.split('\n'):
                    if msg and msg not in last_messages:
                        print("\n📨 Received: {}".format(msg))
                        
                        # Proses dan balas
                        reply = process_command(msg)
                        print("📤 Reply: {}".format(reply[:50]))
                        
                        send_signal(reply)
                        
                        # Simpan agar tidak diproses ulang
                        last_messages.add(msg)
                        if len(last_messages) > 50:
                            last_messages.clear()
            
            # Tunggu 5 detik
            import time
            time.sleep(5)
            
        except KeyboardInterrupt:
            print("\n\n🛑 Bot stopped")
            break
        except Exception as e:
            print("Error: {}".format(e))
            time.sleep(5)

if __name__ == "__main__":
    main()
