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
    nix-prefetch-git # get fetchgit hashes
    nix-tree
    nurl # get fetchgit hashes
    nvd
  ];

  nix = {
    enable = true;
    package = pkgs.lixPackageSets.stable.lix;

    # remove nix-channel related tools & configs, we use flakes instead.
    channel.enable = false;

    # do garbage collection weekly to keep disk usage low
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
      substituters = [
        "https://cache.garnix.io"
      ];
      trusted-public-keys = [
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      ];
      builders-use-substitutes = true;
    };
  };

  # to install chrome, you need to enable unfree packages
  nixpkgs.config.allowUnfree = true;
}
