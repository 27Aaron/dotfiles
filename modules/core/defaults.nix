# macOS 系統偏好設定。
# https://daiderd.com/nix-darwin/manual/index.html#sec-options
{ ... }:
{
  # sudo 使用 Touch ID 驗證。
  security.pam.services.sudo_local.touchIdAuth = true;

  system.defaults = {
    # 選單列時鐘。
    menuExtraClock.Show24Hour = true; # 24 小時制。
    menuExtraClock.ShowSeconds = true; # 顯示秒。

    dock = {
      autohide = true; # 游標靠近螢幕邊緣才顯示。
      show-recents = false; # 隱藏最近使用的 App。
      tilesize = 28; # 圖示大小，16–128，預設 64。
      magnification = true; # 游標懸停時放大，預設關閉。
      largesize = 128; # 放大後尺寸，16–128，預設 16。

      # 觸發角。1 關閉；2 Mission Control；3 App 視窗；4 桌面；
      # 5 啟動螢幕保護程式；6 停用；7 Dashboard；10 顯示器睡眠；
      # 11 Launchpad；12 通知中心；13 鎖定螢幕；14 快速備忘錄。
      wvous-tl-corner = 2; # 左上：Mission Control。
      wvous-tr-corner = 4; # 右上：桌面。
      wvous-bl-corner = 3; # 左下：App 視窗。
      wvous-br-corner = 13; # 右下：鎖定螢幕。
    };

    finder = {
      _FXShowPosixPathInTitle = true; # 標題列顯示完整路徑。
      _FXSortFoldersFirst = true; # 資料夾排在檔案前。
      AppleShowAllExtensions = true; # 顯示所有副檔名。
      FXDefaultSearchScope = "SCcf"; # 只搜尋目前資料夾。
      FXEnableExtensionChangeWarning = false; # 變更副檔名不警告。
      NewWindowTarget = "Home"; # 新視窗開啟使用者主目錄。
      QuitMenuItem = true; # 允許結束 Finder。
      ShowPathbar = true; # 顯示路徑列。
      ShowStatusBar = true; # 顯示項目數與可用空間。
      ShowMountedServersOnDesktop = true; # 桌面顯示已掛載的伺服器。
    };

    WindowManager = {
      EnableStandardClickToShowDesktop = false; # 點擊桌布不顯示桌面。
    };

    screensaver = {
      askForPassword = true; # 螢幕保護程式或睡眠後要求密碼。
      askForPasswordDelay = 0; # 立即要求，無寬限時間。
    };

    screencapture = {
      location = "~/Desktop"; # 截圖儲存到桌面。
      type = "png"; # PNG。
    };

    NSGlobalDomain = {
      "com.apple.sound.beep.feedback" = 0; # 調整音量不播放提示音。0 關閉，1 開啟。

      AppleInterfaceStyle = "Dark"; # 深色外觀。刪除此項恢復淺色。

      # 2：Tab 可在所有控制項間移動焦點。
      AppleKeyboardUIMode = 2;

      # 按住按鍵後開始重複前的延遲，單位 15 ms。15 = 225 ms，為最快。
      InitialKeyRepeat = 15;
      # 重複間隔，單位 15 ms。2 = 30 ms 為最快；3 = 45 ms。
      KeyRepeat = 3;

      NSAutomaticCapitalizationEnabled = false; # 關閉自動大寫。
      NSAutomaticDashSubstitutionEnabled = false; # 不將連字號換成破折號。
      NSAutomaticPeriodSubstitutionEnabled = false; # 不將雙空格換成句號。
      NSAutomaticQuoteSubstitutionEnabled = false; # 不將直引號換成彎引號。
      NSAutomaticSpellingCorrectionEnabled = false; # 關閉自動拼字校正。
      NSNavPanelExpandedStateForSaveMode = true; # 展開舊版儲存對話框。
      NSNavPanelExpandedStateForSaveMode2 = true; # 展開目前的儲存對話框。
    };

    # 無原生選項，以 defaults 寫入。未列於文件的鍵取自 https://github.com/rgcr/m-cli。
    CustomUserPreferences = {
      ".GlobalPreferences" = {
        # 切換 App 時前往該 App 所在的 Space。
        AppleSpacesSwitchOnActivate = true;
      };
      NSGlobalDomain = {
        # 網頁檢視的快顯選單加入 Web Inspector。
        WebKitDeveloperExtras = true;
      };
      "com.apple.desktopservices" = {
        # 不在這些卷宗建立 .DS_Store。
        DSDontWriteNetworkStores = true;
        DSDontWriteUSBStores = true;
      };
      "com.apple.AdLib" = {
        # 關閉 Apple 個人化廣告。
        allowApplePersonalizedAdvertising = false;
      };
      "com.apple.timezone.auto" = {
        # 關閉「使用目前位置自動設定時區」。
        Active = false;
      };
      # 連接相機或手機時不開啟「照片」。
      "com.apple.ImageCapture".disableHotPlug = true;
    };
  };
}
