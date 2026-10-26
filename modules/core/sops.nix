{
  config,
  inputs,
  pkgs,
  vars,
  ...
}:
{
  imports = [ inputs.sops-nix.darwinModules.sops ];

  environment.systemPackages = [
    pkgs.sops
    pkgs.age
  ];

  # keys.txt 由這台機器的 ed25519 私鑰轉出，對應 nix-secrets 裡的 Macbook 收件人。
  sops.age.keyFile = "${config.users.users.${vars.username}.home}/.config/sops/age/keys.txt";
}
