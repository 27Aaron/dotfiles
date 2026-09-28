{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # 开发与编辑
    just
    git
    git-lfs
    neovim

    # 查找与导航
    fd
    fzf
    ripgrep

    # 文本与数据处理
    jq
    gawk
    gnused
    gnugrep

    # 网络与下载
    curl
    wget
    iperf3

    # 磁盘与分析
    duf
    ncdu
    dust

    # 监控与诊断
    btop
    nload
    nmap
    socat
    fastfetch
  ];
}
