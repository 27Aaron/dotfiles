{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      # 載入 Homebrew 環境變數。
      if test -x /opt/homebrew/bin/brew
        eval (/opt/homebrew/bin/brew shellenv fish)
      else if test -x /usr/local/bin/brew
        eval (/usr/local/bin/brew shellenv fish)
      end

      # 關閉歡迎訊息。
      set -g fish_greeting

      # 已安裝時載入 uv、uvx 補全。
      if command -q uv
        uv generate-shell-completion fish | source
      end

      if command -q uvx
        uvx --generate-shell-completion fish | source
      end
    '';
  };
}
