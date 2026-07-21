# NixOS 安装指南

本文档介绍如何从 NixOS 安装介质启动，使用 [Disko](https://github.com/nix-community/disko) 完成磁盘分区和格式化，然后使用 Flake 安装系统。

> [!CAUTION]
> Disko 会清空目标磁盘上的所有分区和数据。请先备份数据，并确认选择了正确的磁盘。

## Disko 配置

将其保存为 `disko.nix`，确认磁盘路径后直接交给 Disko 执行。

```nix
{...}: {
  disko.devices = {
    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = [
        "defaults"
        "size=4G"
        "mode=755"
      ];
    };

    disk.main = {
      type = "disk";

      # 替换为实际的磁盘路径。
      device = "/dev/disk/by-id/nvme-CT1000P3PSSD8_24364AD5D8E0";

      content = {
        type = "gpt";
        partitions = {
          ESP = {
            priority = 1;
            size = "1G";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              extraArgs = [
                "-n"
                "BOOT"
              ];
              mountpoint = "/boot";
              mountOptions = ["umask=0077"];
            };
          };

          luks = {
            priority = 2;
            size = "100%";
            content = {
              type = "luks";
              name = "crypted";
              askPassword = true;
              initrdUnlock = true;

              settings = {
                allowDiscards = true;
                bypassWorkqueues = true;
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
                  "--label"
                  "NixOS"
                ];

                mountpoint = "/btr_pool";
                mountOptions = [
                  "subvolid=5"
                  "noatime"
                ];

                subvolumes = {
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

                  "@swap" = {
                    mountpoint = "/swap";
                    swap.swapfile.size = "32769M";
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
```

---

## 使用 Disko 安装文件系统

再次检查主机配置中的 `hardware'.disko.device`，然后从 Flake 的 NixOS 配置执行：

以下命令需要在配置仓库根目录执行；`.#elaina` 表示当前目录中的 `elaina` Flake 配置。

```bash
sudo nix --experimental-features "nix-command flakes" \
  run github:nix-community/disko/latest -- \
  --mode destroy,format,mount --flake .#elaina
```

Disko 会请求确认清空磁盘，并交互式询问 LUKS 密码。

> [!NOTE]
> 旧版 Disko 使用 `--mode disko`，当前对应的模式是 `--mode destroy,format,mount`。

验证挂载结果：

```bash
findmnt -R /mnt
lsblk -f
```

应当能看到 `/mnt`、`/mnt/boot`、`/mnt/nix`、`/mnt/persistent`、`/mnt/snapshots`、`/mnt/swap` 和 `/mnt/btr_pool`。

---

## 生成配置并安装系统

生成硬件配置。文件系统已由 Disko 定义，因此使用 `--no-filesystems`：

```bash
sudo nixos-generate-config --no-filesystems --root /mnt
```

安装系统：

```bash
sudo nixos-install \
  --root /mnt \
  --flake .#elaina \
  --no-root-password \
  --show-trace \
  --verbose
```

`--no-root-password` 不会为 root 设置密码。请确保 Flake 中已经配置一个可登录的普通用户。

安装完成后重启：

```bash
sync
sudo reboot
```

拔出安装介质。启动时输入 LUKS 密码，然后登录系统。

> [!IMPORTANT]
> 根文件系统使用 tmpfs，未声明持久化的数据会在重启后消失。`modules/default.nix` 会自动发现 `modules/nixos/persistent/` 中的目录与文件配置，使用 Preservation 将必要的状态保存到 `/persistent`。

---

## 参考资料

- [Disko 项目](https://github.com/nix-community/disko)
- [Disko Quickstart](https://github.com/nix-community/disko/blob/master/docs/quickstart.md)
- [Disko 官方示例](https://github.com/nix-community/disko/tree/master/example)
- [Preservation 项目](https://github.com/nix-community/preservation)
