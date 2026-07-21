{
  lib,
  pkgs,
  ...
}: {
  home.packages = lib.mkAfter (with pkgs; [
    # Development
    gh
    just
    lazygit
    uv

    # File & Search
    fd
    fzf
    jq
    ripgrep
    wget

    # Disk & Cleanup
    duf
    dust
    ncdu

    # System Monitor
    btop
    fastfetch

    # Media
    ffmpeg

    # Network
    nmap
    socat
  ]);
}
