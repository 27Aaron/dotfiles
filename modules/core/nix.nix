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

    # 每周进行垃圾回收
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };

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
