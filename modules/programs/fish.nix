{
  hm'.programs.fish = {
    enable = true;
    interactiveShellInit = ''
      # Disable the greeting message.
      set fish_greeting

      # Load Starship.
      starship init fish | source

      # Add uv and uvx shell completions
      uv generate-shell-completion fish | source
      uvx --generate-shell-completion fish | source
    '';
  };
}
