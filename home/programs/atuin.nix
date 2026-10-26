{
  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    settings = {
      sync_frequency = 0;
      inline_height = 30;
      history_filter = [
        # 略過以空白開頭的指令
        ''^\s+''
        # 略過非絕對路徑的 ls
        ''^ls($|(\s+((-([a-zA-Z0-9]|-)+)|"(\.|[^/])[^"]*"|'(\.|[^/])[^']*'|(\.|[^/\s-])[^\s]*))*\s*$)''
        # 略過非絕對路徑的 cd
        ''^cd($|\s+('[^/][^']*'|"[^/][^"]*"|[^/\s'"][^\s]*))$''
        # 略過含 /nix/store 的指令
        "/nix/store/.*"
        # 略過含 cookie 的指令
        ''--cookie[=\s]+.+''
      ];
    };
  };
}
