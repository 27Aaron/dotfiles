{
  lib,
  config,
  inputs,
  ...
}:
let
  cfg = config.services'.couchdb;
in
{
  options.services'.couchdb = {
    enable = lib.mkEnableOption "Enable couchdb service";

    domain = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "The domain name for couchdb";
    };
  };

  config = lib.mkIf cfg.enable {
    sops.secrets.couchdb_password = {
      sopsFile = "${inputs.my-secrets}/services/couchdb.yaml";
      owner = config.services.couchdb.user;
      group = config.services.couchdb.group;
    };

    services.couchdb = {
      enable = true;
      port = config.port'.couchdb;
      bindAddress = "127.0.0.1";
      extraConfigFiles = [ config.sops.secrets.couchdb_password.path ];
      extraConfig = {
        couchdb = {
          max_document_size = 50000000;
        };
        chttpd = {
          require_valid_user = "true";
          max_http_request_size = 1073741824;
        };
        chttpd_auth = {
          require_valid_user = "true";
        };
        httpd = {
          WWW-Authenticate = "Basic realm=\"couchdb\"";
          enable_cors = "true";
        };
        cors = {
          credentials = "true";
          origins = "app://obsidian.md,capacitor://localhost,http://localhost";
        };
      };
    };

    services.caddy.virtualHosts = lib.mkIf (cfg.domain != null) {
      "${cfg.domain}" = {
        extraConfig = ''
          reverse_proxy localhost:${config.portStr'.couchdb}
        '';
      };
    };

    preservation'.os.directories = [
      "/var/lib/couchdb"
    ];
  };
}
