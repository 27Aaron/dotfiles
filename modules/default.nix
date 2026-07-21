platformName: {lib, ...}: let
  platforms = {
    darwin = ./darwin;
    nixos = ./nixos;
  };

  moduleDirectories = [
    ./common
    platforms.${platformName}
  ];
  modules =
    lib.concatMap (
      directory:
        builtins.filter
        (path: lib.hasSuffix ".nix" (toString path))
        (lib.filesystem.listFilesRecursive directory)
    )
    moduleDirectories;
in {
  imports = modules;
}
