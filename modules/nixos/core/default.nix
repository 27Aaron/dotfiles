{
  config,
  inputs,
  lib,
  ...
}: let
  cfg = config.core';
in {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    (lib.mkAliasOptionModule ["hm'"] ["home-manager" "users" cfg.userName])
  ];

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
      default = "Asia/Taipei";
      description = "System timezone";
    };
    homeStateVersion = lib.mkOption {
      type = lib.types.str;
      default = "26.11";
      description = "Home Manager state version";
    };
  };

  config = {
    networking.hostName = cfg.hostName;
    time.timeZone = cfg.timeZone;

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "hm-bak";

      users.${cfg.userName} = {
        home = {
          username = cfg.userName;
          homeDirectory = "/home/${cfg.userName}";
          stateVersion = cfg.homeStateVersion;
        };
        programs.man.enable = false;
      };
    };
  };
}
