#!/usr/bin/env python3
"""
OpenClaw + Signal Integration
Complete script untuk kirim notifikasi Signal dari OpenClaw workflows
"""

import subprocess
import os
import json
from datetime import datetime
from pathlib import Path

class SignalNotifier:
    """Signal Messenger Integration for OpenClaw"""
    
    def __init__(self, phone_number=None):
        """
        Initialize Signal notifier
        
        Args:
            phone_number: Signal phone number (with country code, e.g., +628123456789)
                         If None, will use SIGNAL_PHONE_NUMBER env var
        """
        self.phone_number = phone_number or os.getenv("SIGNAL_PHONE_NUMBER")
        
        if not self.phone_number:
            raise ValueError(
                "SIGNAL_PHONE_NUMBER not set! "
                "Please set env var or pass phone_number to constructor.\n"
                "Example: export SIGNAL_PHONE_NUMBER=+628123456789"
            )
    
    def send(self, message, recipient, attachment=None):
        """
        Send Signal message
        
        Args:
            message: Text message to send
            recipient: Recipient phone number (with country code)
            attachment: Optional file path for attachment
        
        Returns:
            dict: {'success': bool, 'error': str or None}
        """
        cmd = [
            "signal-cli",
            "-u", self.phone_number,
            "send",
            "-m", message,
            recipient
        ]
        
        if attachment and os.path.exists(attachment):
            cmd.extend(["-a", attachment])
        
        try:
            result = subprocess.run(
                cmd,
                capture_output=True,
                text=True,
                timeout=30
            )
            
            if result.returncode == 0:
                return {"success": True, "error": None}
            else:
                return {"success": False, "error": result.stderr.strip()}
        
        except subprocess.TimeoutExpired:
            return {"success": False, "error": "Timeout sending message"}
        except Exception as e:
            return {"success": False, "error": str(e)}
    
    def send_to_group(self, group_id, message):
        """
        Send message to Signal group
        
        Args:
            group_id: Signal group ID
            message: Text message
        
        Returns:
            dict: {'success': bool, 'error': str or None}
        """
        cmd = [
            "signal-cli",
            "-u", self.phone_number,
            "send",
            "-g", group_id,
            "-m", message
        ]
        
        try:
            result = subprocess.run(cmd, capture_output=True, text=True, timeout=30)
            if result.returncode == 0:
                return {"success": True, "error": None}
            else:
                return {"success": False, "error": result.stderr.strip()}
        except Exception as e:
            return {"success": False, "error": str(e)}
    
    def list_groups(self):
        """
        List all Signal groups
        
        Returns:
            list: List of group dicts with id, name, members
        """
        cmd = ["signal-cli", "-u", self.phone_number, "listGroups"]
        
        try:
            result = subprocess.run(cmd, capture_output=True, text=True, timeout=30)
            if result.returncode == 0:
                groups = []
                for line in result.stdout.strip().split("\n"):
                    if line:
                        groups.append({"raw": line})
                return groups
            else:
                return []
        except Exception as e:
            print(f"Error listing groups: {e}")
            return []


# ============================================================================
# PRE-BUILT NOTIFICATION TEMPLATES
# ============================================================================

def notify_content_complete(notifier, recipient, topic, output_path):
    """
    Send notification when content generation completes
    
    Args:
        notifier: SignalNotifier instance
        recipient: Phone number
        topic: Content topic
        output_path: Path to generated content
    """
    message = f"""🎬 Content Generated!

📝 Topic: {topic}
📁 Output: {output_path}
⏰ Time: {datetime.now().strftime('%H:%M:%S')}

✅ Ready to use!"""
    
    return notifier.send(message, recipient)


def notify_task_complete(notifier, recipient, task_name, duration=None):
    """
    Send notification when task completes
    
    Args:
        notifier: SignalNotifier instance
        recipient: Phone number
        task_name: Name of completed task
        duration: Optional duration string
    """
    emoji = "✅"
    message = f"{emoji} Task Complete!\n\n"
    message += f"📋 {task_name}"
    
    if duration:
        message += f"\n⏱️ Duration: {duration}"
    
    message += f"\n🕐 {datetime.now().strftime('%Y-%m-%d %H:%M')}"
    
    return notifier.send(message, recipient)


def notify_error(notifier, recipient, error_message, context=None):
    """
    Send error notification
    
    Args:
        notifier: SignalNotifier instance
        recipient: Phone number
        error_message: Error description
        context: Optional context info
    """
    message = f"🚨 Error Alert!\n\n"
    message += f"❌ {error_message}"
    
    if context:
        message += f"\n\n📝 Context:\n{context}"
    
    message += f"\n\n⏰ {datetime.now().strftime('%H:%M:%S')}"
    
    return notifier.send(message, recipient)


def notify_daily_summary(notifier, recipient, tasks_completed, content_generated):
    """
    Send daily summary notification
    
    Args:
        notifier: SignalNotifier instance
        recipient: Phone number
        tasks_completed: Number of tasks completed today
        content_generated: Number of content pieces generated
    """
    message = f"""📊 Daily Summary

🗓️ {datetime.now().strftime('%A, %B %d')}

✅ Tasks Completed: {tasks_completed}
🎬 Content Generated: {content_generated}

Keep up the great work! 💪"""
    
    return notifier.send(message, recipient)


def notify_research_complete(notifier, recipient, topic, findings_count):
    """
    Send research completion notification
    
    Args:
        notifier: SignalNotifier instance
        recipient: Phone number
        topic: Research topic
        findings_count: Number of key findings
    """
    message = f"""🔬 Research Complete!

📚 Topic: {topic}
📝 Key Findings: {findings_count}
⏰ {datetime.now().strftime('%H:%M:%S')}

Ready for review! 📖"""
    
    return notifier.send(message, recipient)


# ============================================================================
# USAGE EXAMPLES
# ============================================================================

def example_usage():
    """Example usage of Signal integration"""
    
    # Initialize notifier (make sure SIGNAL_PHONE_NUMBER is set)
    try:
        notifier = SignalNotifier()
    except ValueError as e:
        print(f"❌ {e}")
        return
    
    recipient = "+628987654321"  # Replace with actual number
    
    # Example 1: Content complete notification
    print("Sending content complete notification...")
    result = notify_content_complete(
        notifier,
        recipient,
        topic="The Psychology of Habit Formation",
        output_path="The_Psychology_of_Habit_Formation/"
    )
    print(f"Result: {result}")
    
    # Example 2: Task complete notification
    print("\nSending task complete notification...")
    result = notify_task_complete(
        notifier,
        recipient,
        task_name="Video Script Generation",
        duration="56 seconds"
    )
    print(f"Result: {result}")
    
    # Example 3: Custom message
    print("\nSending custom message...")
    result = notifier.send(
        "Hello from OpenClaw! 🚀\n\nSignal integration is working!",
        recipient
    )
    print(f"Result: {result}")


def integrate_with_workflow(workflow_type, topic, output_path, recipient):
    """
    Integrate Signal notifications with any workflow
    
    Args:
        workflow_type: Type of workflow (content, research, task, etc.)
        topic: Topic/title
        output_path: Output path
        recipient: Phone number
    """
    try:
        notifier = SignalNotifier()
    except ValueError as e:
        print(f"❌ {e}")
        return
    
    if workflow_type == "content":
        result = notify_content_complete(notifier, recipient, topic, output_path)
    elif workflow_type == "research":
        result = notify_research_complete(notifier, recipient, topic, findings_count=5)
    elif workflow_type == "task":
        result = notify_task_complete(notifier, recipient, topic)
    else:
        result = notifier.send(f"✅ {topic}\n\n{output_path}", recipient)
    
    print(f"Notification sent: {result['success']}")
    return result


if __name__ == "__main__":
    print("=" * 60)
    print("📱 OpenClaw + Signal Integration")
    print("=" * 60)
    print()
    
    # Check if signal-cli is available
    if not subprocess.run(["which", "signal-cli"], capture_output=True).returncode == 0:
        print("❌ signal-cli not found!")
        print()
        print("Please install signal-cli first:")
        print("  Ubuntu/Debian: sudo apt install signal-cli")
        print("  macOS: brew install signal-cli")
        print()
        print("Then setup:")
        print("  signal-cli -u +628123456789 register")
        print("  signal-cli -u +628123456789 verify <CODE>")
        print()
        exit(1)
    
    print("✅ signal-cli found")
    
    # Check if phone number is set
    phone = os.getenv("SIGNAL_PHONE_NUMBER")
    if not phone:
        print("⚠️  SIGNAL_PHONE_NUMBER not set")
        print()
        print("Set your phone number:")
        print("  export SIGNAL_PHONE_NUMBER=+628123456789")
        print()
        print("Running examples anyway (will fail without setup)...")
        print()
    
    # Run examples
    example_usage()
    
    print()
    print("=" * 60)
    print("✅ Integration test complete!")
    print("=" * 60)
