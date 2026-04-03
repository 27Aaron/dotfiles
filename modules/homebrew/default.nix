{
  homebrew = {
    enable = true;

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
      Bob = 1630034110;
    };

    # `brew install`
    brews = [
      "mole"
    ];

    # `brew install --cask`
    casks = [
      # Browsers
      "brave-browser"
      "google-chrome"

      # Development
      "visual-studio-code"
      "zed"

      # Fonts
      "font-hack-nerd-font"
      "font-jetbrains-mono-nerd-font"
      "font-lxgw-wenkai"
      "font-maple-mono-nf-cn"
      "font-material-icons"

      # Network
      "surge"
      "telegram"

      # System
      "input-source-pro"
      "karabiner-elements"
      "macs-fan-control"
      "monitorcontrol"
      "qspace-pro"
      "squirrel-app"
      "stats"
    ];
  };
}
