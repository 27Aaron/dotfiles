{
  preservation'.user.directories = [
    # AI assistants
    ".codex"
    ".claude"

    # Atuin
    {
      directory = ".atuin";
      mode = "0700";
    }
    ".local/share/atuin"

    # Desktop application launchers
    {
      directory = ".local/share/applications";
      mode = "0700";
    }

    # Desktop file management
    {
      directory = ".cache/thumbnails";
      mode = "0700";
    }
    {
      directory = ".config/gtk-3.0";
      mode = "0700";
    }
    {
      directory = ".local/share/Trash";
      mode = "0700";
    }
    {
      directory = ".local/share/gvfs-metadata";
      mode = "0700";
    }

    # DankMaterialShell
    ".config/DankMaterialShell"
    {
      directory = ".local/state/DankMaterialShell";
      mode = "0700";
    }
    {
      directory = ".cache/DankMaterialShell";
      mode = "0700";
    }
    {
      directory = ".cache/cliphist";
      mode = "0700";
    }

    # Dconf desktop settings
    {
      directory = ".config/dconf";
      mode = "0700";
    }

    # Fcitx5
    ".config/fcitx5"
    ".local/share/fcitx5"

    # Firefox
    ".config/mozilla"
    ".mozilla"
    {
      directory = ".cache/mozilla";
      mode = "0700";
    }

    # Fish
    ".cache/fish"
    ".config/fish"
    ".local/share/fish"

    # GNOME Keyring and NSS certificates
    {
      directory = ".local/share/keyrings";
      mode = "0700";
    }
    {
      directory = ".local/share/pki";
      mode = "0700";
    }

    # Niri
    ".config/niri"

    # Nix and Home Manager
    ".cache/nix"
    ".local/share/nix"
    ".local/state/home-manager"
    ".local/state/nix/profiles"

    # PulseAudio compatibility cookie
    {
      directory = ".config/pulse";
      mode = "0700";
    }

    # Telegram
    ".local/share/AyuGramDesktop"

    # Visual Studio Code
    ".config/Code"
    ".vscode"
    ".vscode-shared"

    # WirePlumber
    {
      directory = ".local/state/wireplumber";
      mode = "0700";
    }

    # Zoxide
    ".local/share/zoxide"

    # Application caches
    ".cache/Microsoft"
    {
      directory = ".cache/fastfetch";
      mode = "0744";
    }
    ".cache/fontconfig"
    ".cache/kitty"
    {
      directory = ".cache/mesa_shader_cache";
      mode = "0700";
    }
    {
      directory = ".cache/qtshadercache-x86_64-little_endian-lp64";
      mode = "0700";
    }
    {
      directory = ".cache/quickshell";
      mode = "0700";
    }
    ".cache/starship"
  ];
}
