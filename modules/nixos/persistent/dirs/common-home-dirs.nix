{
  preservation'.user.directories = [
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
