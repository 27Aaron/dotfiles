{myvars, ...}: {
  imports = [../common];

  home.homeDirectory = "/home/${myvars.username}";

  xdg.enable = true;
}
