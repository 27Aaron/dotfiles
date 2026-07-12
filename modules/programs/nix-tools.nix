{pkgs, ...}: {
  hm'.programs = {
    direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
        package = pkgs.lixPackageSets.stable.nix-direnv;
      };
    };

    nix-index = {
      enable = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };
  };
}
