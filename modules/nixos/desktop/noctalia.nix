{
  config,
  inputs,
  lib,
  myvars,
  ...
}: let
  cfg = config.desktop'.noctalia;
in {
  imports = [
    inputs.noctalia.nixosModules.default
  ];

  options.desktop'.noctalia = {
    enable = lib.mkEnableOption "Noctalia desktop shell";
  };

  config = lib.mkIf cfg.enable {
    programs.noctalia = {
      enable = true;
      package = null;
      recommendedServices.enable = true;
    };

    home-manager = {
      sharedModules = [
        inputs.noctalia.homeModules.default
      ];

      users.${myvars.username}.programs.noctalia = {
        enable = true;
        systemd.enable = false;

        settings.backdrop = {
          enabled = true;
          blur_intensity = 0.5;
          tint_intensity = 0.3;
        };
      };
    };
  };
}
