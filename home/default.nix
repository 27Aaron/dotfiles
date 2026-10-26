{
  config,
  inputs,
  lib,
  vars,
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
    extraSpecialArgs = { inherit vars; };

    users.${cfg.userName} = {
      imports = listModules ./.;

      home = {
        username = cfg.userName;
        homeDirectory = lib.mkForce "/Users/${cfg.userName}";
        stateVersion = "26.05";
        language.collate = "C.UTF-8";
      };

      # 不產生 Home Manager 手冊。
      programs.man.enable = false;
      manual.manpages.enable = false;
    };
  };
}
