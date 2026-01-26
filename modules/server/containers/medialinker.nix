{
  lib,
  config,
  ...
}:
let
  cfg = config.containers'.medialinker;
in
{
  options.containers'.medialinker = {
    enable = lib.mkEnableOption "Enable MediaLinker container";
  };

  config = lib.mkIf cfg.enable {
    systemd.tmpfiles.rules = [
      "d /var/lib/medialinker 0755 root root -"
    ];

    virtualisation.oci-containers.containers = {
      medialinker = {
        hostname = "medialinker";
        serviceName = "medialinker";
        image = "thsrite/medialinker:latest";
        volumes = [
          "/var/lib/medialinker:/opt"
        ];
        extraOptions = [
          "--network=host"
        ];
        autoStart = true;
      };
    };

    networking.firewall.allowedTCPPorts = [
      8091
    ];

    preservation'.os.directories = [
      "/var/lib/medialinker"
    ];
  };
}
