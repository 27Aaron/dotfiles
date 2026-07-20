{
  lib,
  config,
  inputs,
  ...
}: let
  cfg = config.core';
in {
  imports = [
    inputs.home-manager.darwinModules.home-manager
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
    # Enable alternative shell support in nix-darwin.
    programs.fish.enable = true;

    system.primaryUser = cfg.userName;

    networking.hostName = cfg.hostName;
    networking.computerName = cfg.hostName;
    system.defaults.smb.NetBIOSName = cfg.hostName;

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "hm-bak";

      users.${cfg.userName} = {
        home.stateVersion = cfg.homeStateVersion;
        home.homeDirectory = lib.mkForce "/Users/${cfg.userName}";
        programs.man.enable = false;
      };
    };
  };
}
