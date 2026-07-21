{myvars, ...}: {
  imports = [./nix.nix];

  time.timeZone = myvars.timeZone;
}
