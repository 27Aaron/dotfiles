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
    # 在系统级别将Fish注册为登录shell
    programs.fish.enable = lib.mkDefault true;

    time.timeZone = lib.mkDefault cfg.timeZone;

    system.primaryUser = cfg.userName;

    users.users.${cfg.userName} = {
      home = lib.mkDefault "/Users/${cfg.userName}";
      shell = lib.mkDefault pkgs.fish;
    };

    networking = {
      hostName = cfg.hostName;
      computerName = cfg.hostName;
    };
    system.defaults.smb.NetBIOSName = cfg.hostName;
  };
}
