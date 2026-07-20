{
  hm'.programs.mise = {
    enable = true;
    enableFishIntegration = true;
    enableZshIntegration = true;

    globalConfig.tools = {
      node = "lts";

      "npm:@anthropic-ai/claude-code" = {
        version = "latest";
        allow_builds = ["@anthropic-ai/claude-code"];
      };

      "npm:@openai/codex" = "latest";
    };
  };
}
