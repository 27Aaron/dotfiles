{lib, ...}: let
  modules = lib.pipe (lib.filesystem.listFilesRecursive ./.) [
    (builtins.filter (path: path != ./default.nix && lib.hasSuffix ".nix" (toString path)))
  ];
in {
  imports = [../base] ++ modules;
}
