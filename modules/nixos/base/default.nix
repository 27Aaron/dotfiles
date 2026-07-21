{hostName, ...}: {
  imports = [./nix.nix];

  networking.hostName = hostName;
}
