{
  lib,
  inputs,
  ...
}:
let
  portsCfg = import "${inputs.my-secrets}/network/ports.nix" { inherit lib; };
in
{
  options.port' = lib.mkOption {
    type = with lib.types; attrsOf port;
    default = portsCfg.port;
    description = "Network port configurations";
  };

  options.portStr' = lib.mkOption {
    type = with lib.types; attrsOf str;
    default = portsCfg.portStr;
    description = "Network port configurations as strings";
  };
}
