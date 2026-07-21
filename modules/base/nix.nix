{
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    alejandra
    comma
    deadnix
    nixd
    nix-output-monitor
    nix-prefetch-github
    nix-prefetch-git
    nix-tree
    nurl
    nvd
  ];

  nix = {
    channel.enable = false;

    gc = {
      automatic = lib.mkDefault true;
      options = lib.mkDefault "--delete-older-than 7d";
    };

    optimise.automatic = true;

    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = ["https://cache.garnix.io"];
      trusted-public-keys = [
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      ];
      builders-use-substitutes = true;
    };
  };

  nixpkgs.config.allowUnfree = true;
}
