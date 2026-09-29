{ lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    deadnix
    nil
    nixd
  ];

  nix = {
    enable = true;
    package = pkgs.nix;

    # 删除与nix-channel相关的工具和配置
    channel.enable = false;

    optimise.automatic = true;

    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  nixpkgs.config.allowUnfree = true;
}
