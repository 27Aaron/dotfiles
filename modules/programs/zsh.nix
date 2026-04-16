{
  hm'.programs.zsh = {
    enable = true;
    initContent = ''
      # Disable the greeting message.
      # Add uv and uvx shell completions
      if command -v uv &>/dev/null; then
        eval "$(uv generate-shell-completion zsh)"
      fi

      if command -v uvx &>/dev/null; then
        eval "$(uvx --generate-shell-completion zsh)"
      fi

      # Add mise shell completions
      eval "$(mise activate zsh)"
    '';
  };
}
