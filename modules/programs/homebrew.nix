{
  homebrew = {
    enable = true;

    onActivation = {
      upgrade = true;
      autoUpdate = true;
      cleanup = "zap";
    };

    # 透過 mas 從 App Store 安裝。
    masApps = {
      "Bob" = 1630034110;
      "WPS" = 1443749478;
    };

    # formulae
    brews = [
      # 程式碼統計
      "tokei"

      # 磁碟清理
      "mole"

      # 媒體處理
      "ffmpeg"
    ];

    # casks
    casks = [
      # 瀏覽器
      "firefox"
      "google-chrome"

      # 開發工具
      "orbstack"
      "termius"
      "visual-studio-code"
      "zed"

      # 終端機
      "ghostty"

      # 字型
      "font-hack-nerd-font"
      "font-jetbrains-mono-nerd-font"
      "font-lxgw-wenkai"
      "font-maple-mono-nf-cn"
      "font-material-icons"

      # 知識庫
      "obsidian"

      # 媒體
      "iina"
      "neteasemusic"
      "obs"
      "plex"

      # 網路與通訊
      "feishu"
      "surge"
      "telegram"
      "wechat"

      # 系統增強
      "1password"
      "karabiner-elements"
      "macs-fan-control"
      "monitorcontrol"
      "qspace-pro"
      "raycast"
    ];
  };
}
