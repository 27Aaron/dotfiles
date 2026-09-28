{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent = ''
      # Load Homebrew environment variables for zsh shell.
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
