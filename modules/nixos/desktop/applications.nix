{
  config,
  lib,
  myvars,
  pkgs,
  ...
}: let
  cfg = config.desktop'.applications;
in {
  options.desktop'.applications = {
    enable = lib.mkEnableOption "desktop file and media applications";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # GNOME utilities
      gnome-calculator
      gnome-system-monitor
      gnome-text-editor

      # Files and documents
      file-roller
      papers
      loupe

      # Media
      mpv
      ffmpegthumbnailer
    ];

    programs = {
      seahorse.enable = true;

      # Thunar file manager and its Xfconf-backed preferences.
      xfconf.enable = true;
      thunar = {
        enable = true;
        plugins = with pkgs; [
          thunar-archive-plugin
          thunar-volman
          thunar-media-tags-plugin
        ];
      };
    };

    # GVfs provides trash, network locations, MTP, and removable-media
    # integration. Tumbler provides thumbnails for Thunar.
    services.gvfs.enable = true;
    services.udisks2.enable = true;
    services.tumbler.enable = true;

    home-manager.users.${myvars.username}.xdg.mimeApps = {
      enable = true;

      # Home Manager derives all supported MIME types from the applications'
      # desktop files. Earlier packages take precedence when MIME types overlap.
      defaultApplicationPackages = with pkgs; [
        file-roller
        thunar
        loupe
        papers
        gnome-text-editor
        mpv
      ];
    };
  };
}
