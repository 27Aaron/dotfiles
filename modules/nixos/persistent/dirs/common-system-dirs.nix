{
  preservation'.os.directories = [
    # Containers
    {
      directory = "/var/lib/machines";
      mode = "0700";
    }

    # NetworkManager
    {
      directory = "/etc/NetworkManager/system-connections";
      mode = "0700";
    }
    "/var/lib/NetworkManager"

    # NixOS
    {
      directory = "/var/lib/nixos";
      inInitrd = true;
    }

    # OpenSSH
    "/etc/ssh"

    # Private service state
    {
      directory = "/var/lib/private";
      mode = "0700";
    }

    # System state and logs
    "/var/lib/systemd"
    "/var/log"

    # Tuigreet
    {
      directory = "/var/cache/tuigreet";
      user = "greeter";
      group = "greeter";
    }

    # vnStat
    {
      directory = "/var/lib/vnstat";
      user = "vnstatd";
      group = "vnstatd";
    }
  ];
}
