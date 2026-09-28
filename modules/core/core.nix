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
      default = "Asia/Singapore";
      description = "System timezone";
    };
  };

  config = {
    # Register Fish as a valid login shell at the system level. The matching
    # Home Manager module configures Fish itself for the user.
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
