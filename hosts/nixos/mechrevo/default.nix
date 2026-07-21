{pkgs, ...}: {
  imports = [
    ./hardware.nix
  ];

  networking.networkmanager.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";

  environment.systemPackages = with pkgs; [
    vim
    wget
    just
    git
  ];

  services.openssh.enable = true;

  security'.firewall.enable = true;
}
