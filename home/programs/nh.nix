{ config, ... }:
{
  programs.nh = {
    enable = true;
    darwinFlake = "${config.home.homeDirectory}/dotfiles";

    clean = {
      enable = true;
      dates = "weekly";
      # Keep generations and gc roots from the last seven days on Darwin.
      extraArgs = "--keep-since=7d";
    };
  };
}
