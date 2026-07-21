{myvars, ...}: let
  user = myvars.username;
in {
  preservation'.os.directories = [
    "/var/lib/systemd"
    "/var/log"
    {
      directory = "/etc/nixos/nix-config";
      mode = "0700";
      inherit user;
      group = "users";
    }
    "/var/lib/bluetooth"
    "/var/lib/fwupd"
    {
      directory = "/var/lib/machines";
      mode = "0700";
    }
    {
      directory = "/var/lib/nixos";
      inInitrd = true;
    }
    {
      directory = "/var/lib/private";
      mode = "0700";
    }
  ];
}
