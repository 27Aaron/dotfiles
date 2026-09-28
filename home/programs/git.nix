{
  pkgs,
  vars,
  ...
}:
{
  programs = {
    git = {
      enable = true;
      lfs.enable = true;
      settings = {
        user = {
          name = vars.fullName;
          email = vars.email;
        };

        fetch.prune = true;
        init.defaultBranch = "main";
        log.date = "iso";
        pull.rebase = true;
        push.autoSetupRemote = true;
      };
    };

    # A syntax-highlighting pager for git, diff, grep, and blame output
    delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        diff-so-fancy = true;
        line-numbers = true;
        true-color = "always";
      };
    };

    # Git terminal UI.
    lazygit.enable = true;
  };

  # GitHub CLI, plus git-trim for pruning merged/stray branches.
  home.packages = [
    pkgs.gh
    pkgs.git-trim
  ];
}
