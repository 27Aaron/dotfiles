{
  self,
  config,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    deadnix
    nil
    nixd
  ];

  # 系統級清理涵蓋系統與使用者世代。Home Manager 只執行 `nh clean user`。
  programs.nh = {
    enable = true;
    flake = "${config.users.users.${config.core'.userName}.home}/nix-config";

    clean = {
      enable = true;
      extraArgs = "--keep-since 7d";
    };
  };

  nix = {
    enable = true;

    # 停用 nix-channel 及其預設搜尋路徑。
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

  system.configurationRevision = self.rev or self.dirtyRev or null;
}
