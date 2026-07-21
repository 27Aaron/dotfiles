{
  myvars,
  pkgs,
  ...
}: {
  imports = [
    ./hardware.nix
  ];

  hardware'.disko = {
    enable = true;
    device = "/dev/nvme0n1";
    espSize = "1G";
    swapSize = "32769M";
    luks.enable = true;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";

  users.users.${myvars.username} = {
    isNormalUser = true;
    initialHashedPassword = "$y$j9T$ea4hZjnVkMjgcLGzO3SVG1$iCo9h9t.7daEipVBZ6Saiw1Q0q17eRphAEsg7f77DjB";
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    packages = [pkgs.tree];
    openssh.authorizedKeys.keys = myvars.sshAuthorizedKeys;
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    just
    git
  ];

  services.openssh.enable = true;

  networking.firewall.enable = false;

  system.stateVersion = myvars.stateVersion;
}
