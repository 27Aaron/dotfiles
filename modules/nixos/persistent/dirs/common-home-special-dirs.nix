{
  preservation'.user.directories = [
    {
      directory = ".ssh";
      mode = "0700";
    }

    {
      directory = "nix-config";
      mode = "0700";
    }
  ];
}
