{...}: {
  imports = [
    ./hardware.nix
  ];

  desktop'.fonts.enable = true;

  services' = {
    networkmanager.enable = true;
    openssh.enable = true;
    vnstat.enable = true;
  };

  security'.firewall.enable = true;
}
