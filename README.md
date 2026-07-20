# Dotfiles

Declarative macOS configuration powered by [nix-darwin](https://github.com/nix-darwin/nix-darwin) and [Home Manager](https://github.com/nix-community/home-manager).

## Layout

- `hosts/darwin/`: per-machine macOS configuration
- `modules/programs/`: automatically discovered shared Home Manager configuration through the `hm'` platform alias
- `modules/darwin/`: macOS-specific system defaults, applications, and integrations
- `hosts/nixos/` and `modules/nixos/`: reserved for future NixOS configuration

## Getting Started

See the [macOS Setup Guide](docs/macOS%20配置指南.md) for detailed installation and configuration instructions.

## References

- [macos-defaults](https://github.com/yannbertrand/macos-defaults)
- [LnL7/nix-darwin](https://github.com/LnL7/nix-darwin)
- [ryan4yin/nix-darwin-kickstarter](https://github.com/ryan4yin/nix-darwin-kickstarter)
