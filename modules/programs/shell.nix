{
  hm' = {
    home.shellAliases = {
      cc = "claude --dangerously-skip-permissions";
    };

    programs = {
      fish = {
        enable = true;
        interactiveShellInit = ''
          # Disable the greeting message.
          set fish_greeting

          fish_add_path "$HOME/.local/bin"

          # Add uv and uvx shell completions
          if command -q uv
            uv generate-shell-completion fish | source
          end

          if command -q uvx
            uvx --generate-shell-completion fish | source
          end

          # Add mise shell completions
          mise activate fish | source
        '';
      };

      zsh = {
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
    };
  };
}
