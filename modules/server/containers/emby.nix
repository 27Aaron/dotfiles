{
  lib,
  config,
  ...
}:
let
  cfg = config.containers'.emby;
in
{
  options.containers'.emby = {
    enable = lib.mkEnableOption "Enable Emby container";

    domain = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Domain name to serve Emby on via Caddy.";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.tmpfiles.rules = [
      "d /var/lib/emby 0755 root root -"
    ];

    virtualisation.oci-containers.containers = {
      emby = {
        hostname = "emby";
        serviceName = "emby";
        image = "amilys/embyserver:latest";
        ports = [ "8096:8096" ];
        environment = {
          PUID = "0";
          PGID = "0";
          GIDLIST = "0";
          TZ = "Asia/Shanghai";
        };
        volumes = [
          "/var/lib/emby:/config"
          "/var/lib/moviepilot/media:/media"
        ];
        extraOptions = [
          "--privileged"
        ];
        autoStart = true;
      };
    };

    networking.firewall.allowedTCPPorts = lib.mkIf (cfg.domain == null) [
      8096
    ];

    services.caddy.virtualHosts = lib.mkIf (cfg.domain != null) {
      "${cfg.domain}" = {
        extraConfig = ''
          reverse_proxy localhost:8096
        '';
      };
    };

    preservation'.os.directories = [
      "/var/lib/emby"
    ];
  };
}
