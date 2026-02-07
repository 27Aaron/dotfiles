{ pkgs, ... }:
{
  imports = [
    ./hardware.nix
  ];

  programs'.zed.enable = true;
  programs'.firefox.enable = true;

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
      neovim
      nvtopPackages.amd
    ];
  };

  services'.vnstat.enable = true;
  services'.openssh.enable = true;
  security'.firewall.enable = true;
}
