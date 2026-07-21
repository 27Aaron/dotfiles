# Dotfiles

Declarative macOS and NixOS configuration powered by [nix-darwin](https://github.com/nix-darwin/nix-darwin), [Disko](https://github.com/nix-community/disko), [Preservation](https://github.com/nix-community/preservation), and [Home Manager](https://github.com/nix-community/home-manager).

## Layout

- `vars/`: shared, non-secret user metadata
- `hosts/default.nix`: discovers platform hosts and composes their system and Home Manager modules
- `hosts/darwin/`: per-machine macOS configuration
- `hosts/nixos/`: per-machine NixOS configuration
- `home/common/`: shared Home Manager configuration
- `home/darwin/`: macOS-specific Home Manager configuration
- `home/nixos/`: NixOS-specific Home Manager entry point
- `modules/base/`: system-level Nix configuration shared by Darwin and NixOS
- `modules/darwin/`: macOS-specific system defaults, applications, and integrations
- `modules/nixos/`: NixOS base configuration and shared features

## Getting Started

- [macOS Setup Guide](docs/macOS%20配置指南.md)
- [NixOS Setup Guide](docs/NixOS%20安装指南.md)

## References

- [macos-defaults](https://github.com/yannbertrand/macos-defaults)
- [LnL7/nix-darwin](https://github.com/LnL7/nix-darwin)
- [ryan4yin/nix-darwin-kickstarter](https://github.com/ryan4yin/nix-darwin-kickstarter)
