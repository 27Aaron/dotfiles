{
  config,
  lib,
  ...
}:
let
  cfg = config.programs'.homebrew;
in
{
  options.programs'.homebrew = {
    enable = lib.mkEnableOption "Homebrew package management";
  };

  config = lib.mkIf cfg.enable {

    homebrew = {
      enable = true;

      onActivation = {
        upgrade = false;
        autoUpdate = false;
        cleanup = "zap";
      };

      # 使用 mas 从 App Store 安装的应用。
      # https://github.com/mas-cli/mas
      masApps = {
        "Bob" = 1630034110;
        "WPS" = 1443749478;
      };

      # `brew install`
      brews = [
        # 代码统计 (Code Stats)
        "tokei"

        # 磁盘清理 (Cleanup)
        "mole"

        # 媒体处理 (Media)
        "ffmpeg"
      ];

      # `brew install --cask`
      casks = [
        # AI 开发 (AI Development)
        "cc-switch"
        "chatgpt"
        "codexbar"
        "grok-build"
        "zcode"

        # 电池管理 (Battery)
        # "battery"
        # "battery-buddy"

        # 浏览器 (Browser)
        # "brave-browser"
        "firefox"
        "google-chrome"

        # 开发工具 & 终端 (Development)
        # "android-platform-tools"
        # "lm-studio"
        "orbstack"
        "termius"
        "visual-studio-code"
        "zed"

        # 字体 (Fonts)
        "font-hack-nerd-font"
        "font-jetbrains-mono-nerd-font"
        "font-lxgw-wenkai"
        "font-maple-mono-nf-cn"
        "font-material-icons"

        # 知识库 (Knowledge Base)
        "obsidian"

        # 媒体播放 (Media)
        "iina"
        "neteasemusic"
        "obs"
        "plex"

        # 网络与通讯 (Network)
        "feishu"
        "surge"
        "telegram"
        "wechat"

        # 系统增强 & 效能 (Productivity)
        "input-source-pro"
        "jordanbaird-ice@beta"
        "karabiner-elements"
        "macs-fan-control"
        "monitorcontrol"
        "qspace-pro"
        "raycast"
        # "squirrel-app"
        "stats"

        # 远程访问 (Remote Access)
        "uuremote"

        # 终端模拟器 (Terminal Emulator)
        "ghostty"
        # "kitty"
      ];
    };
  };
}
