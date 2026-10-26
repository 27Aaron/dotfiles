{
  programs.fastfetch = {
    enable = true;

    settings = {
      logo = {
        # kitty-direct 讓終端自己讀檔。type = "kitty" 要先查字元像素大小，
        # 查不到就會退回內建的 macOS logo。
        type = "kitty-direct";
        source = ./logo.png;
        width = 32;
        height = 14;
        padding = {
          top = 1;
          right = 3;
        };
      };

      display = {
        separator = "  ";
        color = {
          keys = "blue";
          title = "blue";
        };
        key = {
          width = 12;
        };
      };

      modules = [
        {
          type = "title";
          format = "{user-name}@{host-name}";
          color = {
            user = "blue";
            at = "cyan";
            host = "blue";
          };
        }
        {
          type = "separator";
          string = "-";
          times = 26;
        }
        {
          type = "os";
          key = "OS";
          format = "{name} {codename} {version}";
        }
        {
          type = "host";
          key = "Host";
          format = "{name}";
        }
        {
          type = "kernel";
          key = "Kernel";
          format = "{sysname} {release}";
        }
        {
          type = "shell";
          key = "Shell";
          format = "{pretty-name} {version}";
        }
        {
          type = "terminal";
          key = "Terminal";
          format = "{pretty-name} {version}";
        }
        {
          type = "separator";
          string = "-";
          times = 26;
        }
        {
          type = "cpu";
          key = "CPU";
          format = "{name}";
          temp = false;
        }
        {
          type = "memory";
          key = "Memory";
          # 9 是帶顏色的百分比數字，不畫進度條。1 只有數字、沒有顏色。
          percent.type = 9;
        }
        {
          # `/` 是唯讀系統快照，用量幾乎是空的。資料卷才反映實際佔用。
          # APFS 快照會讓「可用」偏小，所以只顯示已用和總量。
          type = "disk";
          key = "Disk";
          folders = "/System/Volumes/Data";
          format = "{size-used} / {size-total} ({size-percentage})";
        }
        {
          type = "battery";
          key = "Battery";
          format = "{capacity} [{status}]";
        }
        {
          # 沒接充電器時偵測結果是空的，預設不印錯誤，所以這一行會消失。
          type = "poweradapter";
          key = "Adapter";
          format = "{watts}W";
        }
        {
          type = "separator";
          string = "-";
          times = 26;
        }
        {
          type = "uptime";
          key = "Uptime";
        }
        {
          type = "packages";
          key = "Packages";
          # brew 含 cask，nix 含 system、default、user。
          format = "{brew-all} (brew), {nix-all} (nix)";
        }
      ];
    };
  };
}
