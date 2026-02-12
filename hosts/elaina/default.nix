{ pkgs, inputs, ... }:
{
  imports = [
    ./hardware.nix
    inputs.jovian.nixosModules.jovian
  ];

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

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

  boot.kernel.sysctl = {
    "kernel.split_lock_mitigate" = 0;
    "kernel.nmi_watchdog" = 0;
    "kernel.sched_bore" = "1";
  };

  boot.plymouth.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.settings = {
    General = {
      MultiProfile = "multiple";
      FastConnectable = true;
    };
  };

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  jovian = {
    decky-loader.enable = true;

    steam.enable = true;
    steam.autoStart = true;
    steam.user = "aaron";
    steam.desktopSession = "gnome";

    steamos.useSteamOSConfig = true;
    hardware.has.amd.gpu = true;
  };

  environment.sessionVariables = {
    PROTON_USE_NTSYNC = "1";
    ENABLE_HDR_WSI = "1";
    DXVK_HDR = "1";
    PROTON_ENABLE_AMD_AGS = "1";
    PROTON_ENABLE_NVAPI = "1";
    ENABLE_GAMESCOPE_WSI = "1";
    STEAM_MULTIPLE_XWAYLANDS = "1";
  };

  services'.vnstat.enable = true;
  services'.openssh.enable = true;
  security'.firewall.enable = true;
}
