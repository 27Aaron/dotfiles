{ pkgs, ... }:
{
  imports = [
    ./hardware.nix
  ];

  applications'.zed.enable = true;

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  networking.networkmanager.enable = true;

  hm' = {
    home.packages = with pkgs; [
      firefox
      neovim
      nvtopPackages.amd
    ];
  };

  preservation' = {
    user.directories = [
      ".cache/mozila"
    ];
  };

  services'.vnstat.enable = true;
  services'.openssh.enable = true;
  security'.firewall.enable = true;
}
