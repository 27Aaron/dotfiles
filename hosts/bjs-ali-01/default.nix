{
  imports = [
    ./network.nix
    ./hardware.nix
  ];

  # Alibaba Beijing 2C-2G-40G
  
  # Security
  services'.openssh.enable = true;
  security'.firewall.enable = true;

  # Network monitoring
  services'.vnstat.enable = true;

  # Services
  services'.dae.enable = true;
  services'.tang.enable = true;
  services'.snell-server.enable = true;
  services'.postgresql.enable = true;
}
