{
  lib,
  config,
  inputs,
  ...
}:
let
  cfg = config.containers'.moviepilot;
in
{
  options.containers'.moviepilot = {
    enable = lib.mkEnableOption "Enable MoviePilot container";

    domain = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Domain name to serve MoviePilot on via Caddy.";
    };
  };

  config = lib.mkIf cfg.enable {
    sops.secrets =
      let
        sopsFile = "${inputs.my-secrets}/containers/moviepilot.yaml";
      in
      {
        "moviepilot/user" = { inherit sopsFile; };
        "moviepilot/password" = { inherit sopsFile; };
      };

    systemd.tmpfiles.rules = [
      "d /var/lib/moviepilot 0755 root root -"
      "Z /var/lib/moviepilot/media 0755 root root -"
      "Z /var/lib/moviepilot/config 0755 root root -"
      "Z /var/lib/moviepilot/core 0755 root root -"
    ];

    services'.redis.name = "moviepilot";

    services.postgresql = {
      ensureDatabases = [ "moviepilot" ];
      ensureUsers = [
        {
          name = "moviepilot";
          ensureDBOwnership = true;
        }
      ];
    };

    sops.templates."moviepilot.env".content = ''
      NGINX_PORT=${config.portStr'.moviepilot-web}
      PORT=${config.portStr'.moviepilot-api}
      PUID=0
      PGID=0
      UMASK=000
      TZ=Asia/Shanghai
      SUPERUSER=${config.sops.placeholder."moviepilot/user"}
      SUPERUSER_PASSWORD=${config.sops.placeholder."moviepilot/password"}
      DB_TYPE=postgresql
      DB_POSTGRESQL_HOST=/var/run/postgresql
      DB_POSTGRESQL_DATABASE=moviepilot
      DB_POSTGRESQL_USERNAME=moviepilot
      CACHE_BACKEND_TYPE=redis
      CACHE_BACKEND_URL=redis://${
        config.sops.placeholder."redis_password"
      }@localhost:${config.portStr'.redis}
    '';

    virtualisation.oci-containers.containers = {
      moviepilot = {
        hostname = "moviepilot";
        serviceName = "moviepilot";
        image = "jxxghp/moviepilot-v2:latest";
        environmentFiles = [
          config.sops.templates."moviepilot.env".path
        ];
        volumes = [
          "/var/lib/moviepilot/media:/media"
          "/var/lib/moviepilot/config:/config"
          "/var/lib/moviepilot/core:/moviepilot/.cache/ms-playwright"
          "/var/run/podman/podman.sock:/var/run/docker.sock:ro"
        ];
        extraOptions = [
          "--network=host"
          "--stdin-open=true"
          "--tty=true"
        ];
        autoStart = true;
      };
    };

    networking.firewall.allowedTCPPorts = lib.mkIf (cfg.domain == null) [
      config.port'.moviepilot-web
    ];

    services.caddy.virtualHosts = lib.mkIf (cfg.domain != null) {
      "${cfg.domain}" = {
        extraConfig = ''
          reverse_proxy localhost:${config.portStr'.moviepilot-web}
        '';
      };
    };

    preservation'.os.directories = [
      "/var/lib/moviepilot"
    ];
  };
}
