{...}: {
  imports = [
    ./hardware.nix
  ];

  desktop' = {
    cursors.enable = true;
    fcitx5.enable = true;
    fonts.enable = true;
    niri.enable = true;
    noctalia.enable = true;
  };

  services' = {
    kmscon.enable = true;
    networkmanager.enable = true;
    openssh.enable = true;
    vnstat.enable = true;
  };

  security'.firewall.enable = true;
}
