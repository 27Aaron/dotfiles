{
  lib,
  pkgs,
  ...
}: {
  nix = {
    package = pkgs.nix;
    gc.dates = lib.mkDefault "weekly";
    settings = {
      trusted-users = ["@wheel"];
      extra-substituters = ["https://noctalia.cachix.org"];
      extra-trusted-public-keys = [
        "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      ];
    };
  };
}
