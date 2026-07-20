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
      "WPS" = 1443749478;
    };

    # `brew install`
    brews = [
      # Disk & Cleanup
      "mole"
    ];

    # `brew install --cask`
    casks = [
      # AI Development
      "chatgpt"
      "cc-switch"
      "steipete/tap/codexbar"

      # Browser
      "firefox"
      # "brave-browser"
      "google-chrome"

      # Communication
      "feishu"
      "wechat"
      "telegram"

      # Development
      "orbstack"

      # Editor
      "visual-studio-code"

      # Font
      "font-lxgw-wenkai"
      "font-hack-nerd-font"
      "font-material-icons"
      "font-maple-mono-nf-cn"
      "font-jetbrains-mono-nerd-font"

      # Hardware
      # "monitorcontrol"
      "macs-fan-control"

      # Input & Keyboard
      "input-source-pro"
      "karabiner-elements"

      # Knowledge Base
      "obsidian"

      # Media
      "obs"
      "iina"
      "plex"
      "neteasemusic"

      # Menu Bar
      "jordanbaird-ice@beta"

      # Network Tools
      "surge"

      # Productivity
      "raycast"
      "qspace-pro"

      # Remote Access
      "uuremote"

      # SSH Client
      "termius"

      # System Monitor
      "stats"

      # Terminal Emulator
      "kitty"
      "ghostty"
    ];
  };
}
