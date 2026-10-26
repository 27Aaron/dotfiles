{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # 開發與編輯
    just
    neovim

    # 搜尋與導覽
    fd
    fzf
    ripgrep

    # 文字與資料處理
    jq
    gawk
    gnused
    gnugrep

    # 網路與下載
    curl
    wget
    iperf3

    # 磁碟分析
    duf
    ncdu
    dust

    # 監控與診斷
    btop
    nload
    nmap
    socat
    fastfetch
  ];
}
