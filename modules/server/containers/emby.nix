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

    preservation'.os.directories = [
      "/var/lib/emby"
    ];
  };
}
