{
  lib,
  self,
  inputs,
  ...
}: let
  mkNixosSystem = host: _: {
    ${host} = lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        {
          core' = {
            userName = "aaron";
            hostName = host;
          };
        }
        self.nixosModules.default
        ./${host}
      ];
    };
  };
  hasDefaultModule = name: builtins.pathExists (./. + "/${name}/default.nix");
  isHost = name: type: type == "directory" && hasDefaultModule name;
in
  lib.pipe (builtins.readDir ./.) [
    (lib.filterAttrs isHost)
    (lib.concatMapAttrs mkNixosSystem)
  ]
