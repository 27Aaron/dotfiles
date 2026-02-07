{ pkgs, ... }:
{
  imports = [
    ./hardware.nix
  ];

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
      zed-editor
      neovim
      nvtopPackages.amd
    ];
  };

  preservation' = {
    user.directories = [
      ".config/zed"
      ".cache/mozila"
      ".local/share/zed"
    ];
  };

  services'.vnstat.enable = true;
  services'.openssh.enable = true;
  security'.firewall.enable = true;
}
