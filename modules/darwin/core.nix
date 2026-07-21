{
  hostName,
  myvars,
  ...
}: {
  programs.fish.enable = true;

  system.primaryUser = myvars.username;

  users.users.${myvars.username}.home = "/Users/${myvars.username}";

  networking = {
    inherit hostName;
    computerName = hostName;
  };
  system.defaults.smb.NetBIOSName = hostName;
}
