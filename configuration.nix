{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./modules/darwin/apps.nix
    ./modules/darwin/system.nix
    ./modules/darwin/nix-core.nix
    ./modules/darwin/host-users.nix
  ];

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  nix.configureBuildUsers = true;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
