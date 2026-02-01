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

  hm'.home.packages = with pkgs; [
    lutris
    protonplus

    firefox
    zed-editor
    neovim
  ];

  services'.vnstat.enable = true;
  services'.openssh.enable = true;
  security'.firewall.enable = true;
}
