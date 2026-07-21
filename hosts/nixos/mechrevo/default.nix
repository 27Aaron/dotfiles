{pkgs, ...}: {
  imports = [
    ./hardware.nix
  ];

  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    vim
  ];

  services.openssh.enable = true;

  security'.firewall.enable = true;
}
