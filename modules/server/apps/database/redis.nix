{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:
let
  cfg = config.services'.redis;
in
{
  options.services'.redis = {
    enable = lib.mkEnableOption "Enable Redis service";

    name = lib.mkOption {
      type = lib.types.str;
      default = "redis";
      description = "Redis instance name";
    };

    port = lib.mkOption {
      type = lib.types.port;
      default = config.port'.redis;
      description = "Redis port";
    };
  };

  config = lib.mkIf cfg.enable {
    sops.secrets.redis_password = {
      sopsFile = "${inputs.my-secrets}/services/redis.yaml";
    };

    services.redis = {
      vmOverCommit = true;
      package = pkgs.valkey;
      servers.${cfg.name} = {
        enable = true;
        bind = "0.0.0.0";
        port = cfg.port;
        logLevel = "notice";
        logfile = "\"\"";
        syslog = true;
        databases = 16;
        save = [
          [
            900
            1
          ]
          [
            300
            10
          ]
          [
            60
            10000
          ]
        ];
        requirePassFile = config.sops.secrets.redis_password.path;
        maxclients = 10000;
        appendOnly = true;
        appendFsync = "everysec";
        slowLogLogSlowerThan = 10000;
        slowLogMaxLen = 128;
        settings = {
          enable-module-command = "local";
          dbfilename = "dump.rdb";
          maxmemory = "256mb";
          appendfilename = "appendonly.aof";
          appenddirname = "appendonlydir";
        };
      };
    };

    networking.firewall.allowedTCPPorts = [ cfg.port ];

    systemd.tmpfiles.rules = [
      "d /var/lib/redis-${cfg.name} 0700 valkey valkey -"
    ];

    preservation'.os.directories = [
      "/var/lib/redis-${cfg.name}"
    ];
  };
}
