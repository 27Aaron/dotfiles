{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.core';
in
{
  options.core' = {
    userName = lib.mkOption {
      type = lib.types.str;
      description = "Login user name";
    };
    hostName = lib.mkOption {
      type = lib.types.str;
      description = "Network hostname";
    };
    timeZone = lib.mkOption {
      type = lib.types.str;
      description = "System timezone";
    };
  };

  config = {
    time.timeZone = lib.mkDefault cfg.timeZone;
    system.primaryUser = cfg.userName;

    programs.fish.enable = true;
    environment.shells = [ pkgs.fish ];

    users.users.${cfg.userName} = {
      home = lib.mkDefault "/Users/${cfg.userName}";
      shell = pkgs.fish;
    };

    networking = {
      hostName = cfg.hostName;
      computerName = cfg.hostName;
    };
    system.defaults.smb.NetBIOSName = cfg.hostName;

    # `%01` 關閉開機音效；`%00` 恢復。
    system.nvram.variables.StartupMute = "%01";
  };
}
