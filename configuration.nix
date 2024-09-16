{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./modules/apps.nix
    ./modules/system.nix
    ./modules/nix-core.nix
  ];

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  nix.configureBuildUsers = true;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
