{
  self,
  config,
  pkgs,
  vars,
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
    flake = "${config.users.users.${vars.username}.home}/nix-config";

    clean = {
      enable = true;
      # 每週日 03:15。
      interval = {
        Weekday = 7;
        Hour = 3;
        Minute = 15;
      };
      extraArgs = "--keep 8 --keep-since 14d";
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
      # 本機使用者可使用二進位快取與遠端建置。
      trusted-users = [ vars.username ];
    };
  };

  nixpkgs.config.allowUnfree = true;

  system.configurationRevision = self.rev or self.dirtyRev or null;
}
