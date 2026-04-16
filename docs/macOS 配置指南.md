# macOS 配置指南

本文档详细介绍如何在全新 macOS 系统上从零配置开发环境。基于 **nix-darwin** 实现声明式系统管理，Homebrew 应用由 Nix 统一托管。

## 目录

- [环境准备](#环境准备)
  - [安装 Homebrew](#安装-homebrew)
  - [安装 Nix (Lix)](#安装-nix-lix)
- [初始化 nix-darwin](#初始化-nix-darwin)
  - [克隆配置仓库](#克隆配置仓库)
  - [首次构建](#首次构建)
- [配置 Shell (Fish)](#配置-shell-fish)
- [软件配置](#软件配置)
- [系统配置](#系统配置)
- [应用管理](#应用管理)
- [卸载](#卸载)

---

## 环境准备

### 安装 Homebrew

Homebrew 是 macOS 的包管理器，是后续安装的基础依赖。

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

安装完成后，按提示将 Homebrew 加入 PATH：

```bash
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

验证安装：

```bash
brew --version
```

### 安装 Nix (Lix)

Lix 是 Nix 的高性能兼容分支，nix-darwin 的基础。

```bash
curl -sSf -L https://install.lix.systems/lix | sh -s -- install
```

安装完成后，重新加载 shell 或重启终端使 PATH 生效。

验证安装：

```bash
nix --version
```

---

## 初始化 nix-darwin

### 克隆配置仓库

将 dotfiles 仓库克隆到本地：

```bash
git clone --branch v0.0.1 https://github.com/27Aaron/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 修改主机配置

克隆后执行以下命令，自动获取主机名和用户名：

```bash
# 重命名主机目录
mv hosts/MacBook-Pro hosts/$(hostname -s)

# 修改用户名
sed -i '' "s/userName = \"aaron\"/userName = \"$(whoami)\"/" hosts/default.nix
```

> 获取主机名：`hostname -s`
> 获取用户名：`whoami`

### 迁移前备份（重要）

> ⚠️ **首次 `darwin-rebuild switch` 会清理未声明的 Homebrew 应用。**
> `modules/homebrew/default.nix` 中 `cleanup = "zap"` 会在构建时卸载所有不在列表中的已安装应用。

如果当前系统已有 Homebrew 安装的应用，**先执行备份，再配置列表，然后才能首次构建**：

```bash
# 1. 导出当前所有应用为 Brewfile（备份）
brew bundle dump --describe --force --file="~/Desktop/Brewfile"

# 2. 查看已安装的应用列表
brew bundle list --formula --file="~/Desktop/Brewfile"
brew bundle list --cask --file="~/Desktop/Brewfile"
```

备份完成后，编辑 `modules/homebrew/default.nix`，将已有应用逐条加入 `brews` 或 `casks` 列表。

### 首次构建

nix-darwin 没有独立的安装程序，初始构建需要通过 `nix run` 拉取并执行。**构建完成后，fish 已通过 home-manager 自动配置完毕，无需额外操作**：

```bash
sudo nix run nix-darwin/master#darwin-rebuild -- switch
```

构建过程会自动完成：

- 安装 nix-darwin 服务
- 配置 Nix store 路径
- 安装并配置 Homebrew 应用（通过 homebrew module）
- 应用系统默认配置（dock、finder、键盘等）
- 设置 TouchID sudo 认证

**重启终端**使所有配置生效。

### 配置 Fish 为默认 Shell

home-manager 安装了 fish，但默认 shell 的切换需要手动完成：

```bash
# 将 fish 添加到系统允许的 shells 列表
sudo sh -c 'echo /run/current-system/sw/bin/fish >> /etc/shells'

# 设置 fish 为默认 shell
chsh -s /run/current-system/sw/bin/fish
```

重新登录或重启终端使配置生效。

验证：

```bash
echo $SHELL
# 应输出: /run/current-system/sw/bin/fish
```

---

## 后续配置

首次构建后，通过修改对应配置文件并重新构建来管理配置：

```bash
# 重新构建生效（推荐方式）
just switch

# 或手动执行 darwin-rebuild
sudo darwin-rebuild switch
```

常用配置路径：

- 系统配置：`modules/system/default.nix`
- Homebrew 应用：`modules/homebrew/default.nix`
- 用户程序配置：`modules/programs/`

---

## 软件配置

`modules/programs/` 目录下的配置由 **home-manager** 管理，声明式配置用户级软件。

### Git 配置

编辑 `modules/programs/git.nix`，修改以下内容为你的信息：

```nix
{
  hm'.programs = {
    git = {
      enable = true;
      lfs.enable = true;
      settings = {
        user = {
          name = "你的名字";
          email = "your.email@example.com";
        };
      };
    };
    # ... 其他配置
  };
}
```

重新构建使配置生效：

```bash
just switch
```

### 搜索 Home Manager 选项

第三方 Home Manager 选项搜索：https://home-manager-options.extranix.com/

### nix-darwin 参考文档

- 在线文档：https://nix-darwin.github.io/nix-darwin/manual/index.html
- 本地查看：`darwin-help`
- man 手册：`man 5 configuration.nix`

---

## 系统配置

`modules/system/default.nix` 包含 macOS 系统级配置（由 nix-darwin 托管）。

### 常用配置项

| 配置类别 | 说明                           | 参考来源                     |
| -------- | ------------------------------ | ---------------------------- |
| Dock     | 自动隐藏、禁用最近应用、触发角 | `modules/system/default.nix` |
| Finder   | 显示完整路径、显示所有扩展名   | `modules/system/default.nix` |
| 键盘     | 键重复速率、自动大写、智能替换 | `modules/system/default.nix` |
| 触摸板   | 点击、三指拖动                 | 需手动取消注释相关配置       |
| 外观     | 深色模式、24小时制时钟         | `modules/system/default.nix` |

### 自定义系统配置

macOS `defaults` 命令参考：https://macos-defaults.com/

所有支持选项均可通过编辑 `modules/system/default.nix` 中的 `system.defaults` 和 `CustomUserPreferences` 部分声明。

重新应用系统配置：

```bash
just switch
```

---

## 应用管理

Homebrew 安装的应用通过 Nix 的 homebrew module 统一管理，配置位于 `modules/homebrew/default.nix`。

### 常用操作

```bash
# 查看当前已安装的 Homebrew 应用
brew list
brew list --cask

# 添加新应用
# 1. 编辑 modules/homebrew/default.nix，在 brews 或 casks 列表中添加条目
# 2. 重新构建
just switch

# 升级所有应用
brew upgrade
```

### 配置文件结构说明

```nix
{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;  # 自动更新 Homebrew
      upgrade = true;    # 升级过时应用
      cleanup = "zap";   # 清理未收录应用
    };

    brews = [
      # 通过 `brew install` 安装的命令行工具
      "git"
      "neovim"
      "fzf"
      # ...
    ];

    casks = [
      # 通过 `brew install --cask` 安装的 GUI 应用
      "visual-studio-code"
      "karabiner-elements"
      # ...
    ];

    masApps = {
      # Mac App Store 应用（需先在 App Store 登录）
      "Bob" = 1630034110;
    };
  };
}
```

---

## 卸载

### 卸载 nix-darwin

```bash
# 使用官方卸载脚本
sudo nix --extra-experimental-features "nix-command flakes" run nix-darwin#darwin-uninstaller

# 或使用本地安装的卸载器
sudo darwin-uninstaller
```

### 卸载 Nix

> ⚠️ 卸载 Nix 会移除所有通过 Nix 安装的包和配置，**此操作不可逆**。

```bash
# 移除 Nix 相关目录和文件
rm -rf ~/.nix-defender ~/.nix-memos ~/.nix-profile ~/.nix-shell ~/.config/nixpkgs ~/.config/nix

# 移除系统级 Nix 文件
sudo rm -rf /nix \
  /Library/LaunchDaemons/org.nixos.nixd.plist \
  /Library/LaunchDaemons/org.nixos.nix-daemon.plist \
  /etc/profile/nix.sh \
  /etc/profile.d/nix.sh
```

### 卸载 Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
```

---

## 日常维护

```bash
# 更新所有依赖并重新构建
just switch

# 单独升级 Homebrew 应用
brew upgrade && brew cleanup
```
