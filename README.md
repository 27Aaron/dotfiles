<h2 align="center">❄️ Aaron's nix-darwin Config ❄️</h2>

<p align="center">
  <img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/palette/macchiato.png" width="400" alt="Catppuccin Macchiato color palette" />
</p>

<p align="center">
  <a href="https://github.com/nix-darwin/nix-darwin">
    <img alt="nix-darwin" src="https://img.shields.io/badge/nix--darwin-master-informational.svg?style=for-the-badge&logo=nixos&color=F2CDCD&logoColor=D9E0EE&labelColor=302D41"/>
  </a>
  <a href="https://github.com/nix-community/home-manager">
    <img alt="Home Manager" src="https://img.shields.io/badge/Home%20Manager-declarative-7EBAE4?style=for-the-badge&logo=nixos&color=F2CDCD&logoColor=D9E0EE&labelColor=302D41"/>
  </a>
</p>

A flake for macOS, managed with nix-darwin and Home Manager.

## Hosts

| Host | Machine |
|---|---|
| `elaina` | MacBook Pro 16-inch (2023), Apple M2 Max |
| `luna` | MacBook Air 15-inch (2026), Apple M5 |
| `mini` | Mac mini (2024), Apple M4 |

## Layout

| Path | Contents |
|---|---|
| [`hosts/`](hosts/) | one directory per machine |
| [`modules/`](modules/) | nix-darwin modules |
| [`home/`](home/) | Home Manager modules |
| [`vars/`](vars/) | shared values |

## References

- [rgcr/m-cli](https://github.com/rgcr/m-cli)
- [mas-cli/mas](https://github.com/mas-cli/mas)
- [nix-darwin/nix-darwin](https://github.com/nix-darwin/nix-darwin)
- [yannbertrand/macos-defaults](https://github.com/yannbertrand/macos-defaults)
- [ryan4yin/nix-darwin-kickstarter](https://github.com/ryan4yin/nix-darwin-kickstarter)
