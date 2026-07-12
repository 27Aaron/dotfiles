{pkgs, ...}: {
  hm'.home.packages = with pkgs; [
    # Development
    gh
    just
    lazygit
    mise
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
  ];
}
