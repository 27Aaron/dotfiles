{
  homebrew = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;

    onActivation = {
      autoUpdate = true; # Fetch the newest stable branch of Homebrew's git repo
      upgrade = true; # Upgrade outdated casks, formulae, and App Store apps
      cleanup = "zap"; # Uninstall unlisted packages and their related files
    };

    # Applications to install from Mac App Store using mas.
    masApps = {
      "Bob" = 1630034110;
    };

    # `brew install`
    brews = [
      # Disk & Cleanup
      "mole"
    ];

    # `brew install --cask`
    casks = [
      # AI Development
      "cc-switch"
      "codex-app"

      # Browser
      "brave-browser"
      "google-chrome"

      # Communication
      "feishu"
      "telegram"
      "wechat"

      # Editor
      "visual-studio-code"

      # Font
      "font-hack-nerd-font"
      "font-jetbrains-mono-nerd-font"
      "font-lxgw-wenkai"
      "font-maple-mono-nf-cn"
      "font-material-icons"

      # Hardware
      "monitorcontrol"

      # Input & Keyboard
      "input-source-pro"
      "karabiner-elements"

      # Knowledge Base
      "obsidian"

      # Media
      "iina"
      "neteasemusic"
      "obs"

      # Menu Bar
      "jordanbaird-ice@beta"

      # Network Tools
      "surge"

      # Productivity
      "qspace-pro"
      "raycast"

      # SSH Client
      "termius"

      # System Monitor
      "stats"

      # Terminal Emulator
      "ghostty"
      "kitty"
    ];
  };
}
