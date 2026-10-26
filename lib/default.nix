{ lib }:
rec {
  # 目錄裡的 .nix 檔，以及含 default.nix 的子目錄，都視為一個模組。
  # default.nix 本身不列入，避免自己匯入自己。
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
}
