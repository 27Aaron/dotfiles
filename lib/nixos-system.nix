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
  inputs.nixpkgs.lib.nixosSystem {
    inherit system specialArgs;

    modules =
      [
        ../modules/nixos
        inputs.home-manager.nixosModules.home-manager
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
