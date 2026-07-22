{
  config,
  inputs,
  lib,
  myvars,
  pkgs,
  ...
}: let
  cfg = config.desktop'.steam;

  gamingModeGamescope = pkgs.writeShellScriptBin "gamescope" ''
    exec /run/wrappers/bin/gamescope \
      --output-width 1920 \
      --output-height 1200 \
      --nested-refresh 60 \
      "$@"
  '';

  steamSessionSelect = pkgs.writeShellApplication {
    name = "steamos-session-select";
    runtimeInputs = [pkgs.systemd];
    text = ''
      systemctl --user stop gamescope-session.target
    '';
  };
in {
  imports = [inputs.jovian-nixos.nixosModules.default];

  options.desktop'.steam = {
    enable = lib.mkEnableOption "Steam gaming with Gamescope and Decky Loader";
  };

  config = lib.mkIf cfg.enable {
    programs.steam = {
      enable = true;
      protontricks.enable = true;
      extraCompatPackages = [pkgs.proton-ge-bin];
      extraPackages = [
        pkgs.pulseaudio
        steamSessionSelect
      ];
    };

    programs.gamemode.enable = true;

    jovian = {
      steam = {
        enable = true;
        autoStart = false;
        user = myvars.username;
      };

      # Keep the Gaming Mode stack without applying unrelated SteamOS defaults.
      steamos.useSteamOSConfig = false;
    };

    # The internal panel is 2880x1800@120. Rendering the complete Deck UI at
    # that mode is unnecessarily expensive; Gamescope scales this 16:10 mode
    # to the panel while games can still choose their own resolution.
    environment.etc."jovian/gamescope-session/pre-start".text = ''
      export PATH=${gamingModeGamescope}/bin:$PATH
    '';

    jovian.decky-loader = {
      enable = true;
      extraPackages = [
        pkgs.python3
        pkgs.systemd
      ];
      package = let
        decky-loader = pkgs.callPackage "${inputs.jovian-nixos}/pkgs/decky-loader" {
          pnpm_9 = pkgs.pnpm_10;
        };
      in
        decky-loader.overrideAttrs (old: {
          postPatch =
            old.postPatch
            + ''
              substituteInPlace backend/decky_loader/localplatform/localplatformlinux.py \
                --replace-fail \
                  'env: ENV | None = {"LD_LIBRARY_PATH": ""}' \
                  'env: ENV | None = {"LD_LIBRARY_PATH": "", "PATH": os.environ.get("PATH", "")}'
              substituteInPlace backend/decky_loader/helpers.py \
                --replace-fail \
                  'env={} if localplatform.ON_LINUX else None' \
                  'env={"PATH": os.environ.get("PATH", "")} if localplatform.ON_LINUX else None'
            '';
          pnpmDeps = old.pnpmDeps.overrideAttrs (_: {
            outputHash = "sha256-X1L8JYG5hgYMmfg0aa8XhkRU6/oFrYTPiXDIyq77puE=";
          });
        });
      user = myvars.username;
    };

    # Decky currently needs Steam's CEF debugging marker on non-SteamOS systems.
    systemd.tmpfiles.rules = [
      "f /home/${myvars.username}/.local/share/Steam/.cef-enable-remote-debugging 0600 ${myvars.username} users -"
    ];
  };
}
