{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    # 載入 .envrc 時不列出環境變數差異。
    config.global.hide_env_diff = true;
  };
}
