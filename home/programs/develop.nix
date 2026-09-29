{ pkgs, ... }:
{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.mise = {
    enable = true;
    enableFishIntegration = true;
    enableZshIntegration = true;

    globalConfig = {
      settings = {
        # Keep mise's 24-hour supply-chain delay for other tools, but do not
        # delay DSH's rapidly evolving releases.
        minimum_release_age = "24h";
        minimum_release_age_excludes = [ "npm:@deepseek-ai/dsh" ];

        # DSH has a large dependency graph that is more reliable with pnpm
        # than mise's embedded aube installer.
        npm.package_manager = "pnpm";
      };

      tools = {
        # npm CLI tools need a Node.js runtime.
        node = "22";
        pnpm = "latest";
        "npm:@openai/codex" = "latest";
        "npm:@anthropic-ai/claude-code" = "latest";
        "npm:@deepseek-ai/dsh" = {
          version = "latest";
          allow_low_downloads = true;
        };
      };
    };
  };

  home.packages = with pkgs; [
    prettier
    uv
  ];
}
