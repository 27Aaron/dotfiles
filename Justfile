hostname := `hostname -s`

# 列出所有 recipe。
default:
    @just --list

# 檢查格式、未使用宣告與 flake 求值。
check:
    @nix fmt . -- --check
    @deadnix --fail .
    @nix flake check path:. --no-build --no-write-lock-file

# 建置並啟用目前主機的設定。
switch:
    @nh darwin switch path:. -H {{ hostname }}

# 只建置，不啟用。
build:
    @nix build path:.#darwinConfigurations.{{ hostname }}.system \
        --extra-experimental-features 'nix-command flakes'

# 在全新系統上安裝 nix-darwin。
install:
    @sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake path:.#{{ hostname }}

# 更新所有 flake input。
update:
    @nix flake update

# 互動式清理，每週服務之外手動執行。
gc:
    @nh clean all --keep 8 --keep-since 14d --ask

# 格式化所有 Nix 檔案。
fmt:
    @nix fmt .
