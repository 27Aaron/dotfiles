{
  inputs,
  lib,
  myvars,
  ...
}: let
  user = myvars.username;
in {
  imports = [
    inputs.preservation.nixosModules.default

    (lib.mkAliasOptionModule ["preservation'" "os"] ["preservation" "preserveAt" "/persistent"])
    (lib.mkAliasOptionModule
      ["preservation'" "user"]
      ["preservation" "preserveAt" "/persistent" "users" user])
  ];

  boot = {
    initrd.systemd.enable = true;
    tmp.cleanOnBoot = true;
  };

  # Preservation needs the persistent storage in the initrd for machine-id.
  fileSystems."/persistent".neededForBoot = true;

  preservation = {
    enable = true;

    preserveAt."/persistent" = {
      commonMountOptions = [
        "x-gdu.hide"
        "x-gvfs-hide"
      ];

      directories = [
        # Simple paths
        "/var/lib/systemd"
        "/var/log"

        # Complex configurations
        {
          directory = "/etc/nixos/nix-config";
          mode = "0700";
          user = user;
          group = "users";
        }
        {
          directory = "/etc/NetworkManager/system-connections";
          mode = "0700";
        }
        "/var/lib/NetworkManager"
        "/var/lib/bluetooth"
        "/var/lib/fwupd"
        {
          directory = "/var/lib/machines";
          mode = "0700";
        }
        {
          directory = "/var/lib/nixos";
          inInitrd = true;
        }
        {
          directory = "/var/lib/private";
          mode = "0700";
        }
      ];

      files = [
        {
          file = "/etc/machine-id";
          how = "symlink";
          inInitrd = true;
          configureParent = true;
        }
      ];

      users.${user}.directories = [
        "Desktop"
        "Documents"
        "Downloads"
        "Music"
        "Pictures"
        "Videos"
        ".config"
        ".local/share"
        ".local/state"
        {
          directory = ".ssh";
          mode = "0700";
        }
      ];
    };
  };

  # systemd-machine-id-commit.service would fail, but it is not relevant
  # in this specific setup for a persistent machine-id so we disable it
  #
  # see the firstboot example below for an alternative approach
  systemd.suppressedSystemUnits = ["systemd-machine-id-commit.service"];

  # let the service commit the transient ID to the persistent volume
  systemd.services.systemd-machine-id-commit = {
    unitConfig.ConditionPathIsMountPoint = [
      ""
      "/persistent/etc/machine-id"
    ];
    serviceConfig.ExecStart = [
      ""
      "systemd-machine-id-setup --commit --root /persistent"
    ];
  };
}
