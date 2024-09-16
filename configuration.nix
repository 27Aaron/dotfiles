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

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
