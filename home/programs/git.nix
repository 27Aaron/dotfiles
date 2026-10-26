{
  config,
  lib,
  pkgs,
  vars,
  ...
}:
{
  # 設定改由 ~/.config/git/config 管理，移除舊的 ~/.gitconfig。
  home.activation.removeExistingGitconfig = lib.hm.dag.entryBefore [ "checkLinkTargets" ] ''
    rm -f ${config.home.homeDirectory}/.gitconfig
  '';

  programs = {
    git = {
      enable = true;
      lfs.enable = true;
      settings = {
        user = {
          name = vars.fullName;
          email = "85681241+27Aaron@users.noreply.github.com";
        };

        fetch.prune = true;
        init.defaultBranch = "main";
        log.date = "iso";
        pull.rebase = true;
        push.autoSetupRemote = true;
      };
    };

    # git、diff、grep、blame 的語法高亮分頁器。
    delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        diff-so-fancy = true;
        line-numbers = true;
        true-color = "always";
      };
    };

    # Git 終端介面。
    lazygit.enable = true;
  };

  # GitHub CLI，以及清理已合併分支的 git-trim。
  home.packages = [
    pkgs.gh
    pkgs.git-trim
  ];
}
