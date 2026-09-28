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
      substituters = [
        "https://cache.numtide.com" # llm-agents prebuilds (numtide)
      ];
      trusted-public-keys = [
        "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g=" # cache.numtide.com
      ];
    };
  };

  nixpkgs.config.allowUnfree = true;
}
