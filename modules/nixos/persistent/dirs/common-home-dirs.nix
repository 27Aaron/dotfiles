{
  preservation'.user.directories = [
    # AI assistants
    ".codex"
    ".claude"

    # Atuin
    ".local/share/atuin"

    # Fish
    ".cache/fish"
    ".config/fish"
    ".local/share/fish"

    # Nix and Home Manager
    ".cache/nix"
    ".local/share/nix"
    ".local/state/home-manager"
    ".local/state/nix/profiles"
  ];
}
