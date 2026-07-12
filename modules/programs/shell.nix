{
  hm' = {
    home.shellAliases = {
      cc = "claude --dangerously-skip-permissions";
      cx = "codex --dangerously-bypass-approvals-and-sandbox";
    };

    programs = {
      fish = {
        enable = true;
        interactiveShellInit = ''
          # Disable the greeting message.
          set fish_greeting

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

      atuin = {
        enable = true;
        enableFishIntegration = true;
        enableZshIntegration = true;
        settings = {
          sync_frequency = 0;
          inline_height = 30;
          history_filter = [
            ''^ls($|(\s+((-([a-zA-Z0-9]|-)+)|"(\.|[^/])[^"]*"|'(\.|[^/])[^']*'|(\.|[^/\s-])[^\s]*))*\s*$)'' # filter ls command with non-absolute pathes
            ''^cd($|\s+('[^/][^']*'|"[^/][^"]*"|[^/\s'"][^\s]*))$'' # filter cd command with non-absolute pathes
            "/nix/store/.*" # command contains /nix/store
            ''--cookie[=\s]+.+'' # command contains cookie
          ];
        };
      };

      eza = {
        enable = true;
        enableFishIntegration = true;
        enableZshIntegration = true;
        git = true;
        icons = "auto";
      };

      starship = {
        enable = true;
        enableFishIntegration = true;
        enableZshIntegration = true;
        settings = {
          add_newline = false;
          character = {
            success_symbol = "[›](bold green)";
            error_symbol = "[✗](bold red)";
          };
        };
      };

      zoxide = {
        enable = true;
        enableFishIntegration = true;
        enableZshIntegration = true;
      };
    };
  };
}
