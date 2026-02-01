## Disk Partitioning
Partitioning using Disko

```nix
# disko.nix
{
  disko.devices = {
    disk = {
      nvme = {
        type = "disk";
        device = "/dev/nvme0n1"; # <- Change to your disk
        content = {
          type = "gpt";
          partitions = {
            esp = {
              size = "2G"; # <- Change to your ESP partition size
              type = "EF00";
              content = {
                type = "filesystem";
                extraArgs = [
                  "-n"
                  "BOOT"
                ];
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            crypted = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                settings = {
                  allowDiscards = true;
                  bypassWorkqueues = true;
                  crypttabExtraOpts = [
                    "same-cpu-crypt"
                    "submit-from-crypt-cpus"
                  ];
                };
                content = {
                  type = "btrfs";
                  extraArgs = [
                    "-f"
                    "--label nixos"
                    "--csum xxhash64"
                    "--features"
                    "block-group-tree"
                  ];
                  subvolumes = {
                    "persistent" = {
                      mountpoint = "/persistent";
                      mountOptions = [
                        "compress-force=zstd"
                        "noatime"
                        "discard=async"
                        "space_cache=v2"
                      ];
                    };
                    "nix" = {
                      mountpoint = "/nix";
                      mountOptions = [
                        "compress-force=zstd"
                        "noatime"
                        "discard=async"
                        "space_cache=v2"
                        "nodev"
                        "nosuid"
                      ];
                    };
                    "persistent/tmp" = {
                      mountpoint = "/tmp";
                      mountOptions = [
                        "relatime"
                        "nodev"
                        "nosuid"
                        "discard=async"
                        "space_cache=v2"
                      ];
                    };
                  };
                };
              };
            };
            encryptedSwap = {
              size = "65537M"; # <- Change to your swap partition size
              content = {
                type = "swap";
                randomEncryption = true;
              };
            };
          };
        };
      };
    };
    nodev = {
      "/" = {
        fsType = "tmpfs";
        mountOptions = [
          "relatime"
          "nosuid"
          "nodev"
          "size=2G"
          "mode=755"
        ];
      };
    };
  };
}
```
