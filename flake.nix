{
  description = "Aaron's Nix configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    ...
  }: let
    inherit (nixpkgs) lib;
    supportedSystems = [
      "aarch64-darwin"
      "x86_64-linux"
    ];
    forEachSystem = lib.genAttrs supportedSystems;
  in {
    darwinModules.default = import ./modules/darwin;
    darwinConfigurations = import ./hosts/darwin {inherit self inputs lib;};

    nixosModules.default = import ./modules/nixos;
    nixosConfigurations = import ./hosts/nixos {inherit self inputs lib;};

    # nix code formatter
    formatter = forEachSystem (system: nixpkgs.legacyPackages.${system}.alejandra);
  };
}
