{...}: {
  imports = [
    ./hardware.nix
  ];

  desktop' = {
    cursors.enable = true;
    dms.enable = true;
    fcitx5.enable = true;
    fonts.enable = true;
    niri.enable = true;
  };

  hardware'.amdgpu.enable = true;

  services' = {
    kmscon.enable = true;
    networkmanager.enable = true;
    openssh.enable = true;
    printing.enable = true;
    vnstat.enable = true;
  };

  security'.firewall.enable = true;
}
