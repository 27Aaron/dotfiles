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
      nautilus
      file-roller
      papers
      loupe

      # Media
      mpv
      ffmpegthumbnailer
    ];

    programs.seahorse.enable = true;

    # GVfs provides trash, network locations, MTP, and removable-media
    # integration. It enables UDisks2 as a dependency, but keep that
    # dependency explicit here because Nautilus relies on both services.
    services.gvfs.enable = true;
    services.udisks2.enable = true;

    home-manager.users.${myvars.username}.xdg.mimeApps = {
      enable = true;

      # Home Manager derives all supported MIME types from the applications'
      # desktop files. Earlier packages take precedence when MIME types overlap.
      defaultApplicationPackages = with pkgs; [
        file-roller
        nautilus
        loupe
        papers
        gnome-text-editor
        mpv
      ];
    };
  };
}
