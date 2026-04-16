hostname := `hostname -s`

# List all the just commands
default:
    @just --list

# Build and activate the nix-darwin configuration
switch:
    @git add .
    @sudo darwin-rebuild --flake .#{{hostname}} switch

# Update the flake inputs (nixpkgs, nix-darwin, etc.)
update:
    @nix flake update

# Install nix-darwin on a fresh macOS system
install:
    @sudo nix run nix-darwin/master#darwin-rebuild -- switch

# Format all Nix files in the flake
fmt:
    @nix fmt .