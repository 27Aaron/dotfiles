{
  preservation'.os.directories = [
    # System state and logs
    "/var/lib/systemd"
    "/var/log"

    # Containers
    {
      directory = "/var/lib/machines";
      mode = "0700";
    }

    # NixOS
    {
      directory = "/var/lib/nixos";
      inInitrd = true;
    }

    # Private service state
    {
      directory = "/var/lib/private";
      mode = "0700";
    }

    # NetworkManager
    {
      directory = "/etc/NetworkManager/system-connections";
      mode = "0700";
    }
    "/var/lib/NetworkManager"

    # OpenSSH
    "/etc/ssh"

    # vnStat
    "/var/lib/vnstat"
  ];
}
