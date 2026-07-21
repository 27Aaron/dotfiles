{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.desktop'.niri;
in {
  options.desktop'.niri = {
    enable = lib.mkEnableOption "Niri desktop environment";
  };

  config = lib.mkIf cfg.enable {
    programs.niri = {
      enable = true;
      package = pkgs.niri;
    };

    services.greetd = {
      enable = true;
      useTextGreeter = true;
      settings.default_session.command = "${lib.getExe pkgs.tuigreet} --remember --time --cmd ${lib.getExe' pkgs.niri "niri-session"}";
    };
  };
}
