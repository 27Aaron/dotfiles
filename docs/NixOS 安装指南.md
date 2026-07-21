# NixOS 安装指南

本文档介绍如何从 NixOS 安装介质启动，使用 [Disko](https://github.com/nix-community/disko) 完成磁盘分区和格式化，然后使用 Flake 安装系统。

> [!CAUTION]
> Disko 会清空目标磁盘上的所有分区和数据。请先备份数据，并确认选择了正确的磁盘。

## Disko 简介

Disko 使用 Nix 进行声明式磁盘分区和格式化。磁盘布局写成共享 NixOS 模块，执行一条命令即可完成分区、加密、格式化和挂载。

本文使用的布局为：

- 1 GiB EFI 分区，挂载到 `/boot`。
- 剩余空间使用 LUKS2 加密。
- 加密分区内使用 Btrfs。
- `/nix`、`/persistent` 和 `/snapshots` 使用 Btrfs 子卷。
- 根文件系统 `/` 使用 tmpfs，重启后重置。

---

## 安装准备

从 [NixOS 下载页](https://nixos.org/download/) 下载 ISO，制作启动盘，然后以 UEFI 模式启动。

查看磁盘：

```bash
lsblk -o NAME,PATH,SIZE,MODEL,SERIAL,FSTYPE,MOUNTPOINTS
ls -l /dev/disk/by-id/
```

优先使用 `/dev/disk/by-id/` 下的整盘路径，不要选择以 `-part1`、`-part2` 结尾的分区链接。

---

## 创建 Disko 配置

公共磁盘布局位于 `modules/nixos/hardware/disko.nix`，由 `modules/nixos/default.nix` 自动发现。主机只需指定磁盘路径、swap 大小以及是否启用 LUKS，例如 `hosts/nixos/mechrevo/default.nix`：

> [!IMPORTANT]
> 执行前必须把 `device` 替换为实际的目标磁盘路径。

```nix
hardware'.disko = {
  enable = true;
  device = "/dev/disk/by-id/nvme-CT1000P3PSSD8_24364AD5D8E0";
  espSize = "1G";
  swapSize = "32769M";
  luks.enable = true;
};
```

### 独立 Disko 配置备份

下面保留模块化之前使用的完整 `disko.nix`。需要脱离本仓库单独使用时，可以将其保存为 `disko.nix`，确认磁盘路径后直接交给 Disko 执行。

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

```bash
sudo nix --experimental-features "nix-command flakes" \
  run github:nix-community/disko/latest -- \
  --mode destroy,format,mount --flake path:.#mechrevo
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

将生成的硬件配置放回主机目录：

```bash
sudo cp /mnt/etc/nixos/hardware-configuration.nix \
  ./hosts/nixos/mechrevo/hardware.nix
git add hosts/nixos/mechrevo/hardware.nix
```

安装系统：

```bash
sudo nixos-install \
  --root /mnt \
  --flake path:.#mechrevo \
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
> 根文件系统使用 tmpfs，未声明持久化的数据会在重启后消失。`modules/nixos/default.nix` 会自动发现 `modules/nixos/system/preservation.nix`，使用 Preservation 将必要的系统状态和用户目录保存到 `/persistent`。

---

## 参考资料

- [Disko 项目](https://github.com/nix-community/disko)
- [Disko Quickstart](https://github.com/nix-community/disko/blob/master/docs/quickstart.md)
- [Disko 官方示例](https://github.com/nix-community/disko/tree/master/example)
- [Preservation 项目](https://github.com/nix-community/preservation)
