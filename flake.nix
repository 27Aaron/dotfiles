{
  description = "Aaron's macOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
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

    # 加密後的密鑰檔，本身不是 flake。
    secrets = {
      url = "git+ssh://git@github.com/27Aaron/nix-secrets.git?shallow=1";
      flake = false;
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      ...
    }:
    let
      inherit (nixpkgs) lib;
    in
    {
      darwinModules = import ./modules { inherit lib; } // {
        home = ./home;
      };
      darwinConfigurations = import ./hosts { inherit self inputs lib; };

      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixfmt-rs;
    };
}
