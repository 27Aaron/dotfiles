# 列出所有可用命令
list:
    @just --list

# 应用当前配置
switch:
    @sudo nixos-rebuild --flake .# switch

# 使用 SJTU 镜像源加速构建
switch-sjtu:
    @sudo nixos-rebuild --flake .# switch --option substituters "https://mirror.sjtu.edu.cn/nix-channels/store"

# 禁用沙盒模式应用配置
switch-no-sandbox:
    @sudo nixos-rebuild --flake .# switch --option sandbox false

# 检查 Flake 语法
check:
    @nix flake check

# 更新 flake.lock 依赖
update:
    @nix flake update

# 彻底清理垃圾和旧版本
gc:
    @sudo nix store gc --debug
    @sudo nix-collect-garbage --delete-old

# 查看系统 Profile 历史记录
history:
    @nix profile history --profile /nix/var/nix/profiles/system

# 清理 3 天前的旧版本记录
clean:
    @sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 3d

# 远程部署到指定主机
switch-remote host:
    @nixos-rebuild --flake ".#{{host}}" switch --target-host "root@{{host}}" -v
