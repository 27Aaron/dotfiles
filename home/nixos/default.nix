{myvars, ...}: {
  imports = [
    ../common
    ./i18n.nix
    ./xdg-user-dirs.nix
  ];

  home.homeDirectory = "/home/${myvars.username}";
}
