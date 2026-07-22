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
        target = "graphical-session.target";
      };
    };

    hardware.bluetooth.enable = lib.mkDefault true;
    services.upower.enable = lib.mkDefault true;
  };
}
