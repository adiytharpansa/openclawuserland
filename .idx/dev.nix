# Firebase Studio Configuration for OpenClaw
# This file defines the development environment
# When workspace opens, this environment is automatically provisioned

{ pkgs, ... }: {
  # Packages to install in the environment
  packages = [
    pkgs.nodejs_20
    pkgs.nodePackages.npm
    pkgs.nodePackages.pnpm
    pkgs.git
    pkgs.php83
    pkgs.composer
    pkgs.openssl
  ];

  # Environment variables (persist across sessions)
  env = {
    MATON_API_KEY = "fNEwqPnPmiR58CMu2HoU-1K7kdPDcMKf6hFSl4NDNURJWOcRQcZojTITsslt_4vZSLSRK4v_CQgusHsRn6lGl8i5Xm1Imam1Au8";
    OPENCLAW_HOME = "/home/user/.openclaw";
    OPENCLAW_WORKSPACE = "/home/user/project";
  };

  # Auto-run commands when workspace opens
  # This installs OpenClaw CLI and essential skills
  idx = {
    shell = {
      init = ''
        # Install OpenClaw CLI if not already installed
        if ! command -v openclaw &> /dev/null; then
          echo "🦞 Installing OpenClaw CLI..."
          npm install -g openclaw
        fi

        # Install essential skills if not already installed
        echo "📚 Checking OpenClaw skills..."
        clawhub install openclaw-cli 2>/dev/null || true
        clawhub install firebase 2>/dev/null || true
        clawhub install laravel 2>/dev/null || true
        clawhub install php 2>/dev/null || true
        clawhub install github 2>/dev/null || true
        clawhub install telegram 2>/dev/null || true
        
        echo "✅ OpenClaw ready!"
        echo "💡 Run: openclaw status"
      '';
    };

    # Extensions for VS Code experience
    extensions = [
      "laravel-laravel-vscode.laravel-blade"
      "bmewburn.vscode-intelephense-client"
      "onecentlin.laravel-extension"
      "onecentlin.laravel5-snippets"
      "onecentlin.laravel-artisan"
    ];

    # Workspace settings
    workspace = {
      onCreate = {
        # Create default directories
        default-open = [
          "."
          "./src"
          "./.openclaw/workspace"
        ];
      };
    };
  };
}
