{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./modules/apps.nix
    ./modules/nix-core.nix
  ];

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  nix.configureBuildUsers = true;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
