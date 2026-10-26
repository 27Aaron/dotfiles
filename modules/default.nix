{ lib, ... }:
let
  inherit (import ../lib { inherit lib; }) listModules;
in
{
  default.imports = listModules ./.;
}
