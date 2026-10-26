{
  lib,
  self,
  inputs,
  ...
}:
let
  vars = import ../vars;

  hosts = lib.filterAttrs (
    name: type: type == "directory" && builtins.pathExists (./. + "/${name}/default.nix")
  ) (builtins.readDir ./.);

  mkHost =
    host: _:
    inputs.nix-darwin.lib.darwinSystem {
      specialArgs = {
        inherit
          self
          inputs
          vars
          ;
        hostName = host;
      };
      modules = [
        self.darwinModules.default
        self.darwinModules.home
        ./${host}
      ];
    };
in
lib.mapAttrs mkHost hosts
