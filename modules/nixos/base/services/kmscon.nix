{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.services'.kmscon;
in {
  options.services'.kmscon = {
    enable = lib.mkEnableOption "KMS-based virtual consoles with CJK support";

    fontSize = lib.mkOption {
      type = lib.types.ints.positive;
      default = 30;
      description = "Font size used by kmscon";
    };
  };

  config = lib.mkIf cfg.enable {
    fonts = {
      fontconfig.enable = true;
      packages = [pkgs.maple-mono.NF-CN-unhinted];
    };

    hardware.graphics.enable = lib.mkDefault true;

    services.kmscon = {
      enable = true;
      useXkbConfig = true;

      config = {
        font-name = "Maple Mono NF CN";
        font-size = cfg.fontSize;
        hwaccel = true;
      };
    };
  };
}
