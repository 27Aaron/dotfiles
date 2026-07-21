{
  preservation'.os.files = [
    {
      file = "/etc/machine-id";
      how = "symlink";
      inInitrd = true;
      configureParent = true;
    }
  ];

  # The transient machine-id service cannot commit through the persistent mount.
  systemd.suppressedSystemUnits = ["systemd-machine-id-commit.service"];

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
