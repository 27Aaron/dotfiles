{
  lib,
  pkgs,
  vars,
  hostName,
  ...
}:
{
  time.timeZone = lib.mkDefault vars.timeZone;
  system.primaryUser = vars.username;

  programs.fish.enable = true;
  environment.shells = [ pkgs.fish ];

  users.users.${vars.username} = {
    home = lib.mkDefault "/Users/${vars.username}";
    shell = pkgs.fish;
  };

  networking = {
    hostName = hostName;
    computerName = hostName;
  };
  system.defaults.smb.NetBIOSName = hostName;

  # `%01` 關閉開機音效；`%00` 恢復。
  system.nvram.variables.StartupMute = "%01";
}
