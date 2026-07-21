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
    "/var/lib/lastlog"
    "/var/lib/nftables"
    "/var/lib/systemd"
    "/var/log"

    # Manual-page cache
    {
      directory = "/var/cache/man";
      user = "mandb";
      group = "mandb";
    }

    # Tuigreet
    {
      directory = "/var/cache/tuigreet";
      user = "greeter";
      group = "greeter";
    }

    # Files expected to survive reboots, unlike /tmp
    {
      directory = "/var/tmp";
      mode = "1777";
    }

    # vnStat
    {
      directory = "/var/lib/vnstat";
      user = "vnstatd";
      group = "vnstatd";
    }
  ];
}
