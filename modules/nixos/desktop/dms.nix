{
  config,
  lib,
  ...
}: let
  cfg = config.desktop'.dms;
in {
  options.desktop'.dms = {
    enable = lib.mkEnableOption "DankMaterialShell desktop shell";
  };

  config = lib.mkIf cfg.enable {
    programs.dms-shell = {
      enable = true;
      systemd = {
        enable = true;
        # Gaming Mode also starts graphical-session.target, but DMS requires
        # Niri's Wayland socket and otherwise enters a restart loop.
        target = "niri.service";
      };
    };

    hardware.bluetooth.enable = lib.mkDefault true;
    services.upower.enable = lib.mkDefault true;
  };
}
