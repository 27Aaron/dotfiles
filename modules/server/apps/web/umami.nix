{
  lib,
  config,
  inputs,
  ...
}:
let
  cfg = config.services'.umami;
in
{
  options.services'.umami = {
    enable = lib.mkEnableOption "Enable Umami analytics server";

    domain = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "The domain name for Umami";
    };
  };

  config = lib.mkIf cfg.enable {
    sops.secrets.umami_secret = {
      sopsFile = "${inputs.my-secrets}/services/umami.yaml";
    };

    services.umami = {
      enable = true;
      createPostgresqlDatabase = true;
      settings = {
        PORT = config.port'.umami;
        HOSTNAME = "127.0.0.1";

        COLLECT_API_ENDPOINT = "/api/cute";
        TRACKER_SCRIPT_NAME = [ "cute.js" ];

        APP_SECRET_FILE = config.sops.secrets.umami_secret.path;
        DISABLE_TELEMETRY = true;
      };
    };

    services.caddy.virtualHosts = lib.mkIf (cfg.domain != null) {
      "${cfg.domain}" = {
        extraConfig = ''
          reverse_proxy localhost:${config.portStr'.umami} {
            import cloudflare_headers
          }
        '';
      };
    };
  };
}
