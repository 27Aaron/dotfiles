{
  hostName,
  myvars,
  ...
}: let
  userName = myvars.username;
  sshKeys = myvars.sshAuthorizedKeys;
in {
  users.mutableUsers = false;

  users.users = {
    root = {
      hashedPassword = "$y$j9T$9BVbJKhiRZ/U5iTL7sZtT/$3xUVDretSE/RqiacfJbu/vK0Li0H8Z/S4LESEj1E/u1";
      openssh.authorizedKeys.keys = sshKeys;
    };

    ${userName} = {
      isNormalUser = true;
      extraGroups = ["wheel"];
      hashedPassword = "$y$j9T$9BVbJKhiRZ/U5iTL7sZtT/$3xUVDretSE/RqiacfJbu/vK0Li0H8Z/S4LESEj1E/u1";
      openssh.authorizedKeys.keys = sshKeys;
    };
  };

  networking.hostName = hostName;
  time.timeZone = myvars.timeZone;
  system.stateVersion = myvars.stateVersion;

  documentation.nixos.enable = false;
}
