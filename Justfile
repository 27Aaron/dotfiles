hostname := `hostname -s`

# List all the just commands
default:
    @just --list

# Check Nix formatting and unused declarations
check:
    @alejandra --check .
    @deadnix --fail .
    @nix flake check --no-build --all-systems

# Build and activate the nix-darwin configuration
[macos]
switch:
    @git add .
    @sudo darwin-rebuild --flake .#{{ hostname }} switch

# Build and activate the NixOS configuration
[linux]
switch:
    @git add .
    @sudo nixos-rebuild switch --flake .#{{ hostname }}

# Update the flake inputs (nixpkgs, nix-darwin, etc.)
update:
    @nix flake update

# Delete generations and collect unreachable store paths older than 7 days
gc:
    @sudo nix-collect-garbage --delete-older-than 7d

# Install nix-darwin on a fresh macOS system
[macos]
install:
    @sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake .#{{ hostname }}

# Format all Nix files in the flake
fmt:
    @nix fmt .
