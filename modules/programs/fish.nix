{
  hm'.programs.fish = {
    enable = true;
    shellInit = ''
      # Add Nix user profile to PATH
      fish_add_path --prepend --global /etc/profiles/per-user/$USER/bin

      # Nix daemon
      if test -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'
        source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'
      end
    '';
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
