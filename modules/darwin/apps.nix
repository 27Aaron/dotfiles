{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    neovim
    git
    nixfmt-rfc-style
  ];
  environment.variables.EDITOR = "nvim";

  # The apps installed by homebrew are not managed by nix, and not reproducible!
  # But on macOS, homebrew has a much larger selection of apps than nixpkgs, especially for GUI apps!
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      # 'zap': uninstalls all formulae(and related files) not listed here.
      cleanup = "zap";
    };

    # Applications to install from Mac App Store using mas.
    # You need to install all these Apps manually first so that your apple account have records for them.
    # otherwise Apple Store will refuse to install them.
    # For details, see https://github.com/mas-cli/mas 
    masApps = {
      Bob = 1630034110;
      # Xcode = 497799835;
      Enpass = 732710998;
      Wechat = 836500024;
      WechatWork = 1189898970;
    };

    taps = [
      "owo-network/brew"
      "nikitabobko/tap"
      "FelixKratz/formulae"
    ];

    # `brew install`
    brews = [
      "wget"
      "curl"
      "deeplx"
      "node"
      "sketchybar"
    ];

    # `brew install --cask`
    casks = [
      "intellij-idea"
      # "battery"
      "macs-fan-control"
      "raycast"
      "visual-studio-code"
      "termius"
      "google-chrome"
      "karabiner-elements"
      "microsoft-remote-desktop"
      "telegram"
      "qspace-pro"
      "surge"
      "font-lxgw-wenkai"
      "monitorcontrol"
      "zulu@8"
      "zulu@17"
      "stats"
      "aerospace"
    ];
  };
}
