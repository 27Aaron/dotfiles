{
  inputs,
  myvars,
}: let
  inherit (inputs.nixpkgs) lib;

  platforms = {
    darwin = {
      builder = inputs.nix-darwin.lib.darwinSystem;
      homeModule = ../home/darwin;
      systemModule = ../modules/darwin;
      homeManagerModule = inputs.home-manager.darwinModules.home-manager;
    };

    nixos = {
      builder = lib.nixosSystem;
      homeModule = ../home/nixos;
      systemModule = ../modules/nixos;
      homeManagerModule = inputs.home-manager.nixosModules.home-manager;
    };
  };

  mkHost = platformName: platform: hostName: _: let
    specialArgs = {inherit inputs myvars hostName;};
  in
    platform.builder {
      inherit specialArgs;

      modules = [
        platform.systemModule
        platform.homeManagerModule
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "hm-bak";
            extraSpecialArgs = specialArgs;
            users.${myvars.username}.imports = [platform.homeModule];
          };
        }
        (./. + "/${platformName}/${hostName}")
      ];
    };

  mkConfigurations = platformName: platform:
    lib.pipe (builtins.readDir (./. + "/${platformName}")) [
      (lib.filterAttrs (hostName: type:
        type
        == "directory"
        && builtins.pathExists (./. + "/${platformName}/${hostName}/default.nix")))
      (lib.mapAttrs (mkHost platformName platform))
    ];
in
  lib.mapAttrs' (
    platformName: platform:
      lib.nameValuePair "${platformName}Configurations" (mkConfigurations platformName platform)
  )
  platforms
