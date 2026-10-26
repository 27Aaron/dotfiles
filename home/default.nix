{
  inputs,
  lib,
  vars,
  ...
}:
let
  inherit (import ../lib { inherit lib; }) listModules;
in
{
  imports = [ inputs.home-manager.darwinModules.home-manager ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "hm-bak";
    extraSpecialArgs = { inherit vars; };

    users.${vars.username} = {
      imports = listModules ./.;

      home = {
        username = vars.username;
        homeDirectory = lib.mkForce "/Users/${vars.username}";
        stateVersion = "26.05";
        language.collate = "C.UTF-8";
      };

      # 不產生 Home Manager 手冊。
      programs.man.enable = false;
      manual.manpages.enable = false;
    };
  };
}
