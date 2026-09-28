{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      # 按字节序排序，让 ls 的结果稳定可预期。
      set -gx LC_COLLATE "C.UTF-8"

      # Disable the greeting message.
      set -g fish_greeting

      # Load uv and uvx completions when the development toolset is installed.
      if command -q uv
        uv generate-shell-completion fish | source
      end

      if command -q uvx
        uvx --generate-shell-completion fish | source
      end
    '';
  };
}
