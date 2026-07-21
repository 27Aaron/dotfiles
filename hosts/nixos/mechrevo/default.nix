{pkgs, ...}: {
  imports = [
    ./hardware.nix
  ];

  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    just
    git
  ];

  services.openssh.enable = true;

  security'.firewall.enable = true;
}
