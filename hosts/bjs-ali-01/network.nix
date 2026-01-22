{
  lib,
  ...
}:
{
  # Networking
  systemd.network.enable = true;
  networking.useDHCP = false;
  networking.useNetworkd = true;
  networking.resolvconf.enable = false;

  # DNS
  services.resolved.settings.Resolve = {
    LLMNR = false;
    MulticastDNS = false;
    Cache = "no-negative";
  };

  environment.etc."resolv.conf".text = lib.mkForce ''
    nameserver 223.5.5.5
    nameserver 223.6.6.6
    options edns0 trust-ad
  '';

  # Network interfaces
  systemd.network.networks."10-eth0" = {
    DHCP = "yes";
    matchConfig.Name = "eth0";
  };
}
