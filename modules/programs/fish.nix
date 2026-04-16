{
  hm'.programs.fish = {
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
}
