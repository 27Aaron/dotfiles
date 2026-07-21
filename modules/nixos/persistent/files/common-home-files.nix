{
  preservation'.user.files = [
    # AI assistants
    {
      file = ".claude.json";
      how = "bindmount";
    }

    # Desktop application associations
    ".config/mimeapps.list"

    # WakaTime
    ".wakatime.cfg"
  ];
}
