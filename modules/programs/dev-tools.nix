{pkgs, ...}: {
  hm'.programs = {
    delta = {
      enable = true;
      options = {
        diff-so-fancy = true;
        line-numbers = true;
        true-color = "always";
      };
    };

    direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
        package = pkgs.nix-direnv;
      };
    };

    git = {
      enable = true;
      lfs.enable = true;
      settings.user = {
        name = "Aaron";
        email = "niceboy@duck.com";
      };
    };

    nix-index = {
      enable = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };
  };
}
