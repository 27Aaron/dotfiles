{
  config,
  inputs,
  lib,
  ...
}:
let
  cfg = config.core';

  listModules =
    dir:
    lib.pipe (builtins.readDir dir) [
      (lib.filterAttrs (name: _: name != "default.nix"))
      (lib.mapAttrsToList (
        name: type:
        let
          path = dir + "/${name}";
          hasDefault = builtins.pathExists (path + "/default.nix");
          isNixFile = type == "regular" && lib.hasSuffix ".nix" name;
        in
        if type == "directory" then
          if hasDefault then path else listModules path
        else
          lib.optional isNixFile path
      ))
      lib.flatten
    ];
in
{
  imports = [ inputs.home-manager.darwinModules.home-manager ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "hm-bak";

    users.${cfg.userName} = {
      imports = listModules ./.;

      home = {
        username = cfg.userName;
        homeDirectory = lib.mkForce "/Users/${cfg.userName}";
        stateVersion = "26.05";
      };

      # 关闭 Home Manager 的手册生成。
      programs.man.enable = false;
      manual.manpages.enable = false;
    };
  };
}
