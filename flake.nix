{
  description = "Aaron's NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    preservation.url = "github:nix-community/preservation";
  };

  outputs =
    inputs@{
      nixpkgs,
      disko,
      preservation,
      ...
    }:
    {
      nixosConfigurations = {
        elaina = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/elaina/default.nix
            disko.nixosModules.disko
            preservation.nixosModules.default
          ];
        };
      };
    };
}
