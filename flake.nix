{
  description = "Nix for macOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.05-darwin";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }: {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#MacBook-Pro
    darwinConfigurations."MacBook-Pro" =
      nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [ ./configuration.nix ];
      };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."MacBook-Pro".pkgs;
  };
}