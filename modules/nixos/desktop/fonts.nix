{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.desktop'.fonts;
in {
  options.desktop'.fonts = {
    enable = lib.mkEnableOption "System fonts configuration";
  };

  config = lib.mkIf cfg.enable {
    fonts = {
      enableDefaultPackages = false;
      fontDir.enable = true;

      packages = with pkgs; [
        dejavu_fonts
        font-awesome
        julia-mono
        lxgw-wenkai
        maple-mono.NF-CN-unhinted
        material-design-icons
        nerd-fonts.fira-code
        nerd-fonts.jetbrains-mono
        nerd-fonts.symbols-only
        noto-fonts-color-emoji
        source-han-sans
        source-han-serif
        source-sans
        source-serif
      ];

      fontconfig.defaultFonts = {
        serif = [
          "Source Han Serif SC"
          "Source Han Serif TC"
        ];
        sansSerif = [
          "Source Han Sans SC"
          "Source Han Sans TC"
        ];
        monospace = ["Maple Mono NF CN"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
