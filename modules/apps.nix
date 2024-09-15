{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    neovim
    git
    just
    nixfmt-rfc-style
  ];
  environment.variables.EDITOR = "nvim";
}
