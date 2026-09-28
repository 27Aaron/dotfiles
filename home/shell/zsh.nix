{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent = ''
      # 按字节序排序，让 ls 的结果稳定可预期。
      export LC_COLLATE="C.UTF-8"

      if [ -x /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
      elif [ -x /usr/local/bin/brew ]; then
        eval "$(/usr/local/bin/brew shellenv)"
      fi

      # Load uv and uvx completions when the development toolset is installed.
      if command -v uv &>/dev/null; then
        eval "$(uv generate-shell-completion zsh)"
      fi

      if command -v uvx &>/dev/null; then
        eval "$(uvx --generate-shell-completion zsh)"
      fi
    '';
  };
}
