{
  lib,
  config,
  ...
}:
let
  cfg = config.applications'.zed;
in
{
  options.applications'.zed = {
    enable = lib.mkEnableOption "Zed editor";
  };

  config = lib.mkIf cfg.enable {
    programs.zed-editor = {
      enable = true;
    };

    preservation'.user.directories = [
      ".cache/zed"
      ".config/zed"
      ".local/share/zed"
    ];
  };
}
