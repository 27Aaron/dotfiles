{
  lib,
  myvars,
  ...
}: let
  isModule = name: type:
    name
    != "default.nix"
    && (
      (type == "regular" && lib.hasSuffix ".nix" name)
      || (type == "directory" && builtins.pathExists (./. + "/${name}/default.nix"))
    );
  modules = lib.pipe (builtins.readDir ./.) [
    (lib.filterAttrs isModule)
    (lib.mapAttrsToList (name: _: ./. + "/${name}"))
  ];
in {
  imports = modules;

  home = {
    username = myvars.username;
    stateVersion = myvars.stateVersion;
  };

  programs = {
    man.enable = false;
    man.generateCaches = false;
  };
}
