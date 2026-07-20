# Dotfiles

Declarative macOS and NixOS configuration powered by [nix-darwin](https://github.com/nix-darwin/nix-darwin), [Disko](https://github.com/nix-community/disko), and [Home Manager](https://github.com/nix-community/home-manager).

## Layout

- `hosts/darwin/`: per-machine macOS configuration
- `hosts/nixos/`: per-machine NixOS configuration
- `modules/programs/`: automatically discovered shared Home Manager configuration through the `hm'` platform alias
- `modules/darwin/`: macOS-specific system defaults, applications, and integrations
- `modules/nixos/`: NixOS-specific system configuration and integrations

## Getting Started

- [macOS Setup Guide](docs/macOS%20配置指南.md)
- [NixOS Setup Guide](docs/NixOS%20安装指南.md)

## References

- [macos-defaults](https://github.com/yannbertrand/macos-defaults)
- [LnL7/nix-darwin](https://github.com/LnL7/nix-darwin)
- [ryan4yin/nix-darwin-kickstarter](https://github.com/ryan4yin/nix-darwin-kickstarter)
