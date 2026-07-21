{
  lib,
  pkgs,
  ...
}: {
  nix = {
    package = pkgs.nix;
    gc.dates = lib.mkDefault "weekly";
    settings.trusted-users = ["@wheel"];
  };
}
