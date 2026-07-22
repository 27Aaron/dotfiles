{...}: {
  imports = [
    ./hardware.nix
  ];

  desktop' = {
    applications.enable = true;
    cursors.enable = true;
    dms.enable = true;
    fcitx5.enable = true;
    fonts.enable = true;
    niri.enable = true;
  };

  hardware'.amdgpu.enable = true;

  security.rtkit.enable = true;

  services' = {
    btrbk.enable = true;
    btrfs-scrub.enable = true;
    kmscon.enable = true;
    networkmanager.enable = true;
    openssh.enable = true;
    printing.enable = true;
    vnstat.enable = true;
  };

  security'.firewall.enable = true;
}
