{
  config,
  inputs,
  lib,
  myvars,
  pkgs,
  ...
}: let
  cfg = config.desktop'.steam;
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

      gamescopeSession = {
        enable = true;
        steamArgs = [
          "-pipewire-dmabuf"
          "-gamepadui"
          "-steamdeck"
          "-steamos3"
        ];
      };
    };

    programs.gamescope.capSysNice = true;
    programs.gamemode.enable = true;

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
