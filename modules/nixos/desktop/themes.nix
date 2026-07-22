{
  config,
  lib,
  myvars,
  pkgs,
  ...
}: let
  cfg = config.desktop'.themes;
in {
  options.desktop'.themes = {
    enable = lib.mkEnableOption "GTK and icon themes";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.${myvars.username} = {
      home.packages = with pkgs; [
        gtk3
        gtk4
      ];

      gtk = {
        enable = true;

        theme = {
          package = pkgs.flat-remix-gtk;
          name = "Flat-Remix-GTK-Grey-Darkest";
        };

        iconTheme = {
          package = pkgs.papirus-icon-theme;
          name = "Papirus-Dark";
        };

        font = {
          package = pkgs.cantarell-fonts;
          name = "Cantarell Regular";
          size = 12;
        };
      };

      dconf.settings."org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };
}
