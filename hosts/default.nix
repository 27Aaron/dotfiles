{
  lib,
  self,
  inputs,
  ...
}: let
  inherit (inputs) nix-darwin;
  mkDarwinSystem = host: _: {
    ${host} = nix-darwin.lib.darwinSystem {
      specialArgs = {inherit inputs;};
      modules = [
        {
          core' = {
            userName = "aaron";
            hostName = host;
          };
        }
        self.darwinModules.default
        ./${host}
      ];
    };
  };
  hasDefaultModule = name: builtins.pathExists (./. + "/${name}/default.nix");
  isHost = name: type: type == "directory" && hasDefaultModule name;
in
  lib.pipe (builtins.readDir ./.) [
    (lib.filterAttrs isHost)
    (lib.concatMapAttrs mkDarwinSystem)
  ]
