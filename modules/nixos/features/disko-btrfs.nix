{
  config,
  inputs,
  lib,
  ...
}: let
  cfg = config.dotfiles.disko;

  btrfsSubvolumes =
    {
      "@nix" = {
        mountpoint = "/nix";
        mountOptions = [
          "compress-force=zstd:1"
          "noatime"
          "discard=async"
        ];
      };

      "@persistent" = {
        mountpoint = "/persistent";
        mountOptions = [
          "compress-force=zstd:1"
          "noatime"
          "discard=async"
        ];
      };

      "@snapshots" = {
        mountpoint = "/snapshots";
        mountOptions = [
          "compress-force=zstd:1"
          "noatime"
          "discard=async"
        ];
      };
    }
    // lib.optionalAttrs (cfg.swapSize != null) {
      "@swap" = {
        mountpoint = "/swap";
        swap.swapfile.size = cfg.swapSize;
      };
    };
in {
  imports = [inputs.disko.nixosModules.disko];

  options.dotfiles.disko = {
    enable = lib.mkEnableOption "Disko disk management";

    device = lib.mkOption {
      type = lib.types.str;
      example = "/dev/disk/by-id/nvme-example";
      description = "Disk device path";
    };

    espSize = lib.mkOption {
      type = lib.types.str;
      default = "256M";
      example = "1G";
      description = "EFI system partition size";
    };

    swapSize = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      example = "8G";
      description = "Btrfs swap file size, or null to disable swap";
    };

    luks.enable = lib.mkEnableOption "LUKS encryption";
  };

  config = lib.mkIf cfg.enable {
    fileSystems."/persistent".neededForBoot = true;

    disko.devices = {
      nodev."/" = {
        fsType = "tmpfs";
        mountOptions = [
          "nodev"
          "nosuid"
          "relatime"
          "mode=755"
          "size=4G"
        ];
      };

      disk.main = {
        type = "disk";
        device = cfg.device;
        content = {
          type = "gpt";
          partitions =
            {
              ESP = {
                priority = 1;
                size = cfg.espSize;
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                  extraArgs = [
                    "-n"
                    "BOOT"
                  ];
                  mountOptions = ["umask=0077"];
                };
              };
            }
            // (
              if cfg.luks.enable
              then {
                luks = {
                  priority = 2;
                  size = "100%";
                  type = "8309";
                  content = {
                    type = "luks";
                    name = "crypted";
                    askPassword = true;
                    initrdUnlock = true;
                    settings = {
                      allowDiscards = true;
                      bypassWorkqueues = true;
                      crypttabExtraOpts = [
                        "same-cpu-crypt"
                        "submit-from-crypt-cpus"
                        "token-timeout=10"
                      ];
                    };
                    extraFormatArgs = [
                      "--type"
                      "luks2"
                      "--pbkdf"
                      "argon2id"
                    ];
                    content = {
                      type = "btrfs";
                      extraArgs = [
                        "-f"
                        "--csum"
                        "xxhash64"
                        "--label"
                        "NixOS"
                      ];
                      mountpoint = "/btr_pool";
                      mountOptions = [
                        "subvolid=5"
                        "noatime"
                      ];
                      subvolumes = btrfsSubvolumes;
                    };
                  };
                };
              }
              else {
                root = {
                  priority = 2;
                  size = "100%";
                  content = {
                    type = "btrfs";
                    extraArgs = [
                      "-f"
                      "--csum"
                      "xxhash64"
                      "--label"
                      "NixOS"
                    ];
                    mountpoint = "/btr_pool";
                    mountOptions = [
                      "subvolid=5"
                      "noatime"
                    ];
                    subvolumes = btrfsSubvolumes;
                  };
                };
              }
            );
        };
      };
    };
  };
}
