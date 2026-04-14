[macos]
hostname := `hostname -s`

switch:
    @sudo darwin-rebuild --flake .# switch

update:
    @nix flake update

darwin:
    @sudo -E ./result/sw/bin/darwin-rebuild switch --flake .#{{hostname}}

darwin-build:
    @nix build .#darwinConfigurations.{{hostname}}.system \
    --extra-experimental-features 'nix-command flakes'
