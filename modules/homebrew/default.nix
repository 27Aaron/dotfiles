{
  homebrew = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;

    onActivation = {
      autoUpdate = true; # Fetch the newest stable branch of Homebrew's git repo
      upgrade = true; # Upgrade outdated casks, formulae, and App Store apps
      cleanup = "zap"; # 'zap': uninstalls all formulae(and related files) not listed in the generated Brewfile
    };

    # Applications to install from Mac App Store using mas.
    # You need to install all these Apps manually first so that your apple account have records for them.
    # otherwise Apple Store will refuse to install them.
    # For details, see https://github.com/mas-cli/mas
    masApps = {
      "Bob" = 1630034110;
    };

    # `brew install`
    brews = [
      # Development
      "git"
      "git-lfs"
      "gh"
      "just"
      "lazygit"
      "mise"
      "neovim"
      "rtk"
      "uv"

      # File & Search
      "fd"
      "fzf"
      "jq"
      "ripgrep"
      "wget"

      # Disk & Cleanup
      "duf"
      "dust"
      "mole"
      "ncdu"

      # System Monitor
      "btop"
      "fastfetch"

      # Media
      "ffmpeg"

      # Network
      "nmap"
      "socat"
    ];

    # `brew install --cask`
    casks = [
      # Browser
      "brave-browser"
      "google-chrome"

      # Editor
      "zed"
      "visual-studio-code"

      # Terminal Emulator
      "ghostty"
      "kitty"

      # Font
      "font-hack-nerd-font"
      "font-jetbrains-mono-nerd-font"
      "font-lxgw-wenkai"
      "font-maple-mono-nf-cn"
      "font-material-icons"

      # Communication
      "feishu"
      "telegram"
      "wechat"

      # Network Tools
      "surge"

      # Input & Keyboard
      "input-source-pro"
      "karabiner-elements"

      # Hardware
      "macs-fan-control"
      "monitorcontrol"

      # Productivity
      "qspace-pro"
      "raycast"

      # System Monitor
      "stats"

      # AI Development
      "cc-switch"
      "cherry-studio"
      "claude"
      "codex"
      "codex-app"
    ];
  };
}
