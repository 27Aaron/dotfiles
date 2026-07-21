{
  inputs,
  myvars,
}: {
  hostName,
  system,
  systemModules ? [],
  homeModules ? [],
}: let
  specialArgs = {inherit inputs myvars hostName;};
in
  inputs.nix-darwin.lib.darwinSystem {
    inherit system specialArgs;

    modules =
      [
        ../modules/darwin
        inputs.home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "hm-bak";
            extraSpecialArgs = specialArgs;
            users.${myvars.username}.imports = homeModules;
          };
        }
      ]
      ++ systemModules;
  }
