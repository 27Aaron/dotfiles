{
  lib,
  self,
  inputs,
  ...
}:
let
  inherit (inputs) nix-darwin;
  vars = import ../vars;
  mkDarwinSystem = host: _: {
    ${host} = nix-darwin.lib.darwinSystem {
      specialArgs = { inherit self inputs vars; };
      modules = [
        {
          core' = {
            userName = vars.username;
            hostName = host;
            timeZone = vars.timeZone;
          };
        }
        self.darwinModules.default
        self.darwinModules.home
        ./${host}
      ];
    };
  };
in
lib.pipe (builtins.readDir ./.) [
  (lib.filterAttrs (n: _: n != "default.nix"))
  (lib.concatMapAttrs mkDarwinSystem)
]
