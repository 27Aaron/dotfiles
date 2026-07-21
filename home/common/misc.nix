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
    tree
    wget

    # Disk & Cleanup
    duf
    dust
    ncdu

    # System Monitor
    btop
    fastfetch
    htop
    nload

    # Media
    ffmpeg

    # Network
    iperf3
    nmap
    socat
  ]);
}
