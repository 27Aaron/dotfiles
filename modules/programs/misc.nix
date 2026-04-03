{pkgs, ...}: {
  hm' = {
    home.packages = with pkgs; [
      gh
      git-lfs
      just
      lazygit
      mise
      neovim
      uv

      fd
      fzf

      gawk
      gnused
      gnugrep
      jq

      curl
      wget

      dust
      duf
      ncdu

      btop
      fastfetch
      nmap
      socat
    ];
  };
}