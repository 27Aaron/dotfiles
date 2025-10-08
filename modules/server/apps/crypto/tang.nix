{
  lib,
  config,
  ...
}:
let
  cfg = config.services'.tang;
in
{
  options.services'.tang = {
    enable = lib.mkEnableOption "Enable Tang key derivation service";
  };

  config = lib.mkIf cfg.enable {
    services.tang = {
      enable = true;
      listenStream = [ config.portStr'.tang ];
      ipAddressAllow = [
        "0.0.0.0/0"
      ];
    };

    preservation'.os.directories = [
      "/var/lib/private/tang"
    ];

    networking.firewall.allowedTCPPorts = [ config.port'.tang ];
  };
}
