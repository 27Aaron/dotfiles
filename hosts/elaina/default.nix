{
  pkgs,
  ...
}:
{
  imports = [
    ./disko.nix
    ./hardware.nix
    ./preservation.nix
  ];

  networking.hostName = "elaina";

  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Singapore";

  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.enable = true;

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  users.users.aaron = {
    isNormalUser = true;
    hashedPassword = "$y$j9T$9BVbJKhiRZ/U5iTL7sZtT/$3xUVDretSE/RqiacfJbu/vK0Li0H8Z/S4LESEj1E/u1";
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      git
      tree
      just
      fastfetch
    ];
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
  ];

  services.openssh.enable = true;

  system.stateVersion = "26.05";
}
