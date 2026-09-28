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
        # 磁盘清理 (Cleanup)
        "mole"

        # 代码统计 (Code Stats)
        "tokei"

        # 媒体处理 (Media)
        "ffmpeg"
      ];

      # `brew install --cask`
      casks = [
        # AI 开发 (AI Development)
        "cc-switch"
        "codexbar"
        "zcode"
        "chatgpt"

        # 开发工具 & 终端 (Development)
        "zed"
        "termius"
        "orbstack"
        # "lm-studio"
        # "claude-code"
        "visual-studio-code"
        # "android-platform-tools"

        # 终端模拟器 (Terminal Emulator)
        "ghostty"
        # "kitty"

        # 系统增强 & 效能 (Productivity)
        "stats"
        "raycast"
        "qspace-pro"
        # "squirrel-app"
        "monitorcontrol"
        "macs-fan-control"
        "input-source-pro"
        "karabiner-elements"
        "jordanbaird-ice@beta"

        # 电池管理 (Battery)
        # "battery"
        # "battery-buddy"

        # 浏览器 (Browser)
        # "brave-browser"
        "firefox"
        "google-chrome"

        # 网络与通讯 (Network)
        "surge"
        "feishu"
        "telegram"
        "wechat"

        # 远程访问 (Remote Access)
        "uuremote"

        # 知识库 (Knowledge Base)
        "obsidian"

        # 媒体播放 (Media)
        "iina"
        "neteasemusic"
        "obs"
        "plex"

        # 字体 (Fonts)
        "font-lxgw-wenkai"
        "font-material-icons"
        "font-hack-nerd-font"
        "font-maple-mono-nf-cn"
        "font-jetbrains-mono-nerd-font"
      ];
    };
  };
}
