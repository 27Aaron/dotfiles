{ pkgs, ... }:
{
  imports = [
    ./hardware.nix
  ];

  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  networking.networkmanager.enable = true;

  hm' = {
    home.packages = with pkgs; [
      protonplus

      firefox
      zed-editor
      neovim
      nvtopPackages.amd
    ];

    # a GUI game launcher for Steam/GoG/Epic
    # https://lutris.net/games?ordering=-popularity
    programs.lutris = {
      enable = true;
      defaultWinePackage = pkgs.proton-ge-bin;
      steamPackage = pkgs.steam;
      winePackages = with pkgs; [
        wineWow64Packages.full
        wineWowPackages.stagingFull
      ];
      extraPackages = with pkgs; [
        winetricks
        gamescope
        gamemode
        mangohud
        umu-launcher
      ];
    };
  };

  preservation' = {
    user.directories = [
      ".local/share/umu"
      ".local/share/lutris"
      ".local/share/zed"
      ".cache/ProtonPlus"
      ".cache/mozila"
      ".config/zed"
    ];
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services'.vnstat.enable = true;
  services'.openssh.enable = true;
  security'.firewall.enable = true;
}
