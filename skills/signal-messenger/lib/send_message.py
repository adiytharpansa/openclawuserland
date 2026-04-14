#!/usr/bin/env python3
"""
Signal Messenger - Send Messages
Supports both signal-cli and signal-cli-rest-api
"""

import os
import sys
import json
import requests
import subprocess
import argparse
from pathlib import Path

# Configuration
SIGNAL_CLI_PATH = os.getenv("SIGNAL_CLI_PATH", "signal-cli")
SIGNAL_API_URL = os.getenv("SIGNAL_API_URL", "http://localhost:8080")
SIGNAL_API_USER = os.getenv("SIGNAL_API_USER", "admin")
SIGNAL_API_PASSWORD = os.getenv("SIGNAL_API_PASSWORD", "")
SIGNAL_PHONE_NUMBER = os.getenv("SIGNAL_PHONE_NUMBER", "")

def send_message_cli(to, message, attachment=None):
    """Send message using signal-cli"""
    cmd = [
        SIGNAL_CLI_PATH,
        "-u", SIGNAL_PHONE_NUMBER,
        "send", "-m", message, to
    ]
    
    if attachment:
        cmd.extend(["-a", attachment])
    
    try:
        result = subprocess.run(cmd, capture_output=True, text=True, timeout=30)
        if result.returncode == 0:
            return {"success": True, "message": "Sent via CLI", "timestamp": result.stdout.strip()}
        else:
            return {"success": False, "error": result.stderr.strip()}
    except Exception as e:
        return {"success": False, "error": str(e)}

def send_message_api(to, message, attachment=None):
    """Send message using signal-cli-rest-api"""
    url = f"{SIGNAL_API_URL}/v2/send"
    
    payload = {
        "message": message,
        "number": SIGNAL_PHONE_NUMBER,
        "recipients": [to]
    }
    
    if attachment:
        # Upload attachment first
        files = {"file": open(attachment, "rb")}
        upload_response = requests.post(
            f"{SIGNAL_API_URL}/v1/attachments",
            files=files,
            auth=(SIGNAL_API_USER, SIGNAL_API_PASSWORD)
        )
        if upload_response.status_code == 200:
            payload["attachments"] = [upload_response.json()["id"]]
    
    try:
        response = requests.post(
            url,
            json=payload,
            auth=(SIGNAL_API_USER, SIGNAL_API_PASSWORD),
            timeout=30
        )
        
        if response.status_code == 201:
            result = response.json()
            return {
                "success": True,
                "message": "Sent via API",
                "timestamp": result.get("timestamp"),
                "envelope_id": result.get("envelopeId")
            }
        else:
            return {"success": False, "error": response.text}
    except Exception as e:
        return {"success": False, "error": str(e)}

def send_message(to, message, attachment=None, use_api=False):
    """Send Signal message"""
    if use_api or SIGNAL_API_URL:
        print(f"📱 Sending via REST API...")
        return send_message_api(to, message, attachment)
    else:
        print(f"📱 Sending via CLI...")
        return send_message_cli(to, message, attachment)

def main():
    parser = argparse.ArgumentParser(description="Send Signal messages")
    parser.add_argument("--to", required=True, help="Recipient phone number (+1234567890)")
    parser.add_argument("--message", required=True, help="Message text")
    parser.add_argument("--attachment", help="Path to attachment file")
    parser.add_argument("--api", action="store_true", help="Use REST API instead of CLI")
    
    args = parser.parse_args()
    
    if not SIGNAL_PHONE_NUMBER:
        print("❌ Error: SIGNAL_PHONE_NUMBER not set!")
        print("   Set env var: export SIGNAL_PHONE_NUMBER=+1234567890")
        sys.exit(1)
    
    result = send_message(
        to=args.to,
        message=args.message,
        attachment=args.attachment,
        use_api=args.api
    )
    
    if result["success"]:
        print(f"✅ {result['message']}")
        print(f"📱 To: {args.to}")
        print(f"⏰ Timestamp: {result.get('timestamp', 'N/A')}")
        if result.get('envelope_id'):
            print(f"📄 Envelope ID: {result['envelope_id']}")
    else:
        print(f"❌ Failed: {result['error']}")
        sys.exit(1)

if __name__ == "__main__":
    main()
