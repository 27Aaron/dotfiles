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

    preservation.url = "github:nix-community/preservation";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {nixpkgs, ...}: let
    inherit (nixpkgs) lib;

    myvars = import ./vars;
    configurations = import ./hosts {inherit inputs myvars;};

    supportedSystems = [
      "aarch64-darwin"
      "x86_64-linux"
    ];
    forEachSystem = lib.genAttrs supportedSystems;
  in
    configurations
    // {
      darwinModules.default = import ./modules/darwin;
      nixosModules.default = import ./modules/nixos;

      formatter = forEachSystem (system: nixpkgs.legacyPackages.${system}.alejandra);
    };
}
