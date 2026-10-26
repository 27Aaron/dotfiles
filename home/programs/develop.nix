{ pkgs, ... }:
{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.mise = {
    enable = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };

  home.packages = with pkgs; [
    prettier
    uv
  ];
}
