hostname := `hostname -s`

# List all available recipes.
default:
    @just --list

# Check formatting, unused declarations, and the flake evaluation.
check:
    @nix fmt . -- --check
    @deadnix --fail .
    @nix flake check path:. --no-build --no-write-lock-file

# Build and activate the nix-darwin configuration for the current host.
switch:
    @nh darwin switch path:. -H {{ hostname }}

# Build the nix-darwin configuration without activating it.
build:
    @nix build path:.#darwinConfigurations.{{ hostname }}.system \
        --extra-experimental-features 'nix-command flakes'

# Install nix-darwin on a fresh macOS system.
install:
    @sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake path:.#{{ hostname }}

# Update all flake inputs.
update:
    @nix flake update

# Run an explicit, interactive cleanup in addition to the weekly nh service.
gc:
    @nh clean all --keep 8 --keep-since 14d --ask

# Format all Nix files in the flake.
fmt:
    @nix fmt .
