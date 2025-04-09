{
  lib,
  config,
  inputs,
  ...
}:
let
  cfg = config.services'.sing-box;

  acme_config = {
    domain = cfg.domain;
    dns01_challenge = {
      provider = "cloudflare";
      api_token._secret = config.sops.secrets."cloudflare/api_token".path;
    };
    email._secret = config.sops.secrets."cloudflare/email".path;
    data_directory = "/var/lib/sing-box/certmagic";
  };
in
{
  options.services'.sing-box = {
    enable = lib.mkEnableOption "The universal proxy platform";

    domain = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "The domain for TLS configuration.";
    };

    tuic_port = lib.mkOption {
      type = lib.types.nullOr lib.types.port;
      default = null;
      description = "TUIC port. Set to enable TUIC inbound.";
    };

    vless_port = lib.mkOption {
      type = lib.types.nullOr lib.types.port;
      default = null;
      description = "VLESS Reality port. Set to enable VLESS inbound.";
    };

    anytls_port = lib.mkOption {
      type = lib.types.nullOr lib.types.port;
      default = null;
      description = "AnyTLS port. Set to enable AnyTLS inbound.";
    };

    hysteria_port = lib.mkOption {
      type = lib.types.nullOr lib.types.port;
      default = null;
      description = "Hysteria2 port. Set to enable Hysteria2 inbound.";
    };

    reality_domain = lib.mkOption {
      type = lib.types.str;
      default = "itunes.apple.com";
      description = "VLESS Reality server for handshake.";
    };
  };

  config = lib.mkIf cfg.enable {
    sops.secrets = {
      "cloudflare/email" = {
        sopsFile = "${inputs.my-secrets}/services/sing-box.yaml";
      };
      "cloudflare/api_token" = {
        sopsFile = "${inputs.my-secrets}/services/sing-box.yaml";
      };
      "proxy/uuid" = {
        sopsFile = "${inputs.my-secrets}/services/sing-box.yaml";
      };
      "proxy/password" = {
        sopsFile = "${inputs.my-secrets}/services/sing-box.yaml";
      };
      "proxy/private_key" = {
        sopsFile = "${inputs.my-secrets}/services/sing-box.yaml";
      };
    };

    services.sing-box = {
      enable = true;
      settings = {
        log = {
          disabled = false;
          level = "info";
          timestamp = true;
        };
        dns = {
          servers = [
            {
              tag = "local";
              type = "local";
            }
          ];
          final = "local";
          strategy = "prefer_ipv6";
        };
        ntp = {
          enabled = true;
          server = "time.apple.com";
          server_port = 123;
          interval = "30m";
        };
        inbounds =
          lib.lists.optional (cfg.tuic_port != null) {
            type = "tuic";
            tag = "TUIC";
            listen = "::";
            listen_port = cfg.tuic_port;
            users = [
              {
                name = "TUIC";
                uuid._secret = config.sops.secrets."proxy/uuid".path;
                password._secret = config.sops.secrets."proxy/password".path;
              }
            ];
            congestion_control = "bbr";
            zero_rtt_handshake = false;
            tls = {
              enabled = true;
              server_name = cfg.domain;
              alpn = [ "h3" ];
              acme = acme_config;
            };
          }
          ++ lib.lists.optional (cfg.vless_port != null) {
            type = "vless";
            tag = "Reality";
            listen = "::";
            listen_port = cfg.vless_port;
            tcp_fast_open = true;
            tls = {
              enabled = true;
              reality = {
                enabled = true;
                handshake = {
                  server = cfg.reality_domain;
                  server_port = 443;
                };
                private_key._secret = config.sops.secrets."proxy/private_key".path;
                short_id = [ "5baddde7dcd75ec2" ];
              };
              server_name = cfg.reality_domain;
            };
            multiplex = {
              enabled = true;
              padding = true;
              brutal = {
                enabled = true;
                up_mbps = 1000;
                down_mbps = 1000;
              };
            };
            users = [
              {
                uuid._secret = config.sops.secrets."proxy/uuid".path;
                flow = "xtls-rprx-vision";
              }
            ];
          }
          ++ lib.lists.optional (cfg.anytls_port != null) {
            type = "anytls";
            tag = "AnyTLS";
            listen = "::";
            listen_port = cfg.anytls_port;
            users = [
              {
                name = "AnyTLS";
                password._secret = config.sops.secrets."proxy/password".path;
              }
            ];
            tls = {
              enabled = true;
              server_name = cfg.domain;
              acme = acme_config;
            };
          }
          ++ lib.lists.optional (cfg.hysteria_port != null) {
            type = "hysteria2";
            tag = "Hysteria";
            listen = "::";
            listen_port = cfg.hysteria_port;
            up_mbps = 1000;
            down_mbps = 1000;
            obfs = {
              type = "salamander";
              password._secret = config.sops.secrets."proxy/uuid".path;
            };
            users = [
              {
                name = "Hysteria";
                password._secret = config.sops.secrets."proxy/password".path;
              }
            ];
            ignore_client_bandwidth = false;
            tls = {
              enabled = true;
              server_name = cfg.domain;
              acme = acme_config;
            };
          };
      };
    };

    networking.firewall = {
      allowedTCPPorts =
        lib.lists.optional (cfg.tuic_port != null) cfg.tuic_port
        ++ lib.lists.optional (cfg.vless_port != null) cfg.vless_port
        ++ lib.lists.optional (cfg.anytls_port != null) cfg.anytls_port
        ++ lib.lists.optional (cfg.hysteria_port != null) cfg.hysteria_port;
      allowedUDPPorts =
        lib.lists.optional (cfg.tuic_port != null) cfg.tuic_port
        ++ lib.lists.optional (cfg.vless_port != null) cfg.vless_port
        ++ lib.lists.optional (cfg.anytls_port != null) cfg.anytls_port
        ++ lib.lists.optional (cfg.hysteria_port != null) cfg.hysteria_port;
    };
  };
}
