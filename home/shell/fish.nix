{
  programs.fish = {
    enable = true;
    shellInit = ''
      # IDA Pro 專用 Python 虛擬環境。
      set -gx IDAPYTHON_VENV_EXECUTABLE "/Users/aaron/.idapro/venv/bin/python3"
    '';
    interactiveShellInit = ''
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
