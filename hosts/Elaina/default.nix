{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./host-users.nix
    ../../modules/darwin
  ];

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  nix.configureBuildUsers = true;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "x86_64-darwin";
}
