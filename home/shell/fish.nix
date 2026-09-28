{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      # Load Homebrew environment variables for fish shell.
      if test -x /opt/homebrew/bin/brew
        eval (/opt/homebrew/bin/brew shellenv fish)
      else if test -x /usr/local/bin/brew
        eval (/usr/local/bin/brew shellenv fish)
      end

      # Disable the greeting message.
      set -g fish_greeting

      # Load uv and uvx completions when the development toolset is installed.
      if command -q uv
        uv generate-shell-completion fish | source
      end

      if command -q uvx
        uvx --generate-shell-completion fish | source
      end
    '';
  };
}
