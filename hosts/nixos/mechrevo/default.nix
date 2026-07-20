{pkgs, ...}: {
  imports = [
    ./hardware.nix
  ];

  core'.timeZone = "Asia/Singapore";

  hardware'.disko = {
    enable = true;
    device = "/dev/disk/by-id/nvme-CT1000P3PSSD8_24364AD5D8E0";
    espSize = "1G";
    swapSize = "32769M";
    luks.enable = true;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";

  users.users.aaron = {
    isNormalUser = true;
    initialHashedPassword = "$y$j9T$ea4hZjnVkMjgcLGzO3SVG1$iCo9h9t.7daEipVBZ6Saiw1Q0q17eRphAEsg7f77DjB";
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    packages = [pkgs.tree];
    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKHjMAQUXfyMv8TG1NfqjmQJG3gqZkh25KAvAMvxVrWS Aaron@MacBook-Pro"];
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
  ];

  services.openssh.enable = true;

  networking.firewall.enable = false;

  system.stateVersion = "26.11";
}
