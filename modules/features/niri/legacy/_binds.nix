{ pkgs, lib, self', ... }: {
  
  # "Mod+T".spawn-sh = lib.getExe self'.packages.myKitty;
  
  "Mod+B".quit = _: {};

  "Mod+Shift+Slash" = _: {
    content.show-hotkey-overlay = _: {};
  };
  
  "Mod+F1" = _: {
    props.hotkey-overlay-title = null;
    content.spawn-sh = "notify-send -u low -t 1000 $(date '+%H:%M')";
  };
  
  "XF86AudioRaiseVolume" = _: {
    props.allow-when-locked = true;
    content.spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+ -l 1.0";
  };
  
  "XF86AudioLowerVolume" = _: {
    props.allow-when-locked = true;
    content.spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-";
  };
  
  "XF86AudioMute" = _: {
    props.allow-when-locked = true;
    content.spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
  };
  
  "XF86AudioMicMute" = _: {
    props.allow-when-locked = true;
    content.spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
  };
  
  "XF86AudioPlay" = _: {
    props.allow-when-locked = true;
    content.spawn-sh = "playerctl play-pause";
  };
  
  "XF86AudioStop" = _: {
    props.allow-when-locked = true;
    content.spawn-sh = "playerctl stop";
  };
  
  "XF86AudioPrev" = _: {
    props.allow-when-locked = true;
    content.spawn-sh = "playerctl previous";
  };
  
  "XF86AudioNext" = _: {
    props.allow-when-locked = true;
    content.spawn-sh = "playerctl next";
  };
  
  "XF86MonBrightnessUp" = _: {
    props.allow-when-locked = true;
    content.spawn-sh = "brightnessctl --class=backlight set +10%";
  };
  
  "XF86MonBrightnessDown" = _: {
    props.allow-when-locked = true;
    content.spawn-sh = "brightnessctl --class=backlight set 10%-";
  };
  
  "Mod+Ctrl+Alt+BracketLeft" = _: {
    content.spawn-sh = "notify-send -u low -t 5000 \"Clciked left\"";
  };
  
  "Mod+Ctrl+Alt+BracketRight" = _: {
    content.spawn-sh = "notify-send -u low -t 5000 \"Clciked right\"";
  };
  
  "Mod+O" = _: {
    props.repeat = false;
    content.toggle-overview = _: {};
  };
  
  "Mod+Q" = _: {
    props.repeat = false;
    content.close-window = _: {};
  };
  
  "Mod+MouseBack" = _: {
    content.focus-column-left = _: {};
  };
  
  "Mod+MouseForward" = _: {
    content.focus-column-right = _: {};
  };
  
  "Mod+Left" = _: {
    props.hotkey-overlay-title = null;
    content.focus-column-left = _: {};
  };
  
  "Mod+Right" = _: {
    props.hotkey-overlay-title = null;
    content.focus-column-right = _: {};
  };
  
  "Mod+H" = _: {
    props.hotkey-overlay-title = null;
    content.focus-column-left = _: {};
  };
  
  "Mod+L" = _: {
    props.hotkey-overlay-title = null;
    content.focus-column-right = _: {};
  };
  
  "Mod+Alt+Left" = _: {
    props.hotkey-overlay-title = null;
    content.move-column-left = _: {};
  };
  
  "Mod+Alt+Right" = _: {
    props.hotkey-overlay-title = null;
    content.move-column-right = _: {};
  };
  
  "Mod+Alt+H" = _: {
    props.hotkey-overlay-title = null;
    content.move-column-left = _: {};
  };
  
  "Mod+Alt+L" = _: {
    props.hotkey-overlay-title = null;
    content.move-column-right = _: {};
  };
  
  "Mod+Home" = _: {
    content.focus-column-first = _: {};
  };
  
  "Mod+End" = _: {
    content.focus-column-last = _: {};
  };
  
  "Mod+Alt+Home" = _: {
    content.move-column-to-first = _: {};
  };
  
  "Mod+Alt+End" = _: {
    content.move-column-to-last = _: {};
  };
  
  "Mod+Shift+Left" = _: {
    content.focus-monitor-left = _: {};
  };
  
  "Mod+Shift+Down" = _: {
    content.focus-monitor-down = _: {};
  };
  
  "Mod+Shift+Up" = _: {
    content.focus-monitor-up = _: {};
  };
  
  "Mod+Shift+Right" = _: {
    content.focus-monitor-right = _: {};
  };
  
  "Mod+Shift+H" = _: {
    content.focus-monitor-left = _: {};
  };
  
  "Mod+Shift+J" = _: {
    content.focus-monitor-down = _: {};
  };
  
  "Mod+Shift+K" = _: {
    content.focus-monitor-up = _: {};
  };
  
  "Mod+Shift+L" = _: {
    content.focus-monitor-right = _: {};
  };
  
  "Mod+Shift+Ctrl+Left" = _: {
    content.move-column-to-monitor-left = _: {};
  };
  
  "Mod+Shift+Ctrl+Down" = _: {
    content.move-column-to-monitor-down = _: {};
  };
  
  "Mod+Shift+Ctrl+Up" = _: {
    content.move-column-to-monitor-up = _: {};
  };
  
  "Mod+Shift+Ctrl+Right" = _: {
    content.move-column-to-monitor-right = _: {};
  };
  
  "Mod+Shift+Ctrl+H" = _: {
    content.move-column-to-monitor-left = _: {};
  };
  
  "Mod+Shift+Ctrl+J" = _: {
    content.move-column-to-monitor-down = _: {};
  };
  
  "Mod+Shift+Ctrl+K" = _: {
    content.move-column-to-monitor-up = _: {};
  };
  
  "Mod+Shift+Ctrl+L" = _: {
    content.move-column-to-monitor-right = _: {};
  };
  
  "Mod+WheelScrollRight" = _: {
    content.focus-column-right = _: {};
  };
  
  "Mod+WheelScrollLeft" = _: {
    content.focus-column-left = _: {};
  };
  
  "Mod+Alt+WheelScrollRight" = _: {
    content.move-column-right = _: {};
  };
  
  "Mod+Alt+WheelScrollLeft" = _: {
    content.move-column-left = _: {};
  };
  
  "Mod+Shift+WheelScrollDown" = _: {
    content.focus-column-right = _: {};
  };
  
  "Mod+Shift+WheelScrollUp" = _: {
    content.focus-column-left = _: {};
  };
  
  "Mod+Alt+Shift+WheelScrollDown" = _: {
    content.move-column-right = _: {};
  };
  
  "Mod+Alt+Shift+WheelScrollUp" = _: {
    content.move-column-left = _: {};
  };
  
  "Mod+Page_Down" = _: {
    props.hotkey-overlay-title = null;
    content.focus-workspace-down = _: {};
  };
  
  "Mod+Page_Up" = _: {
    props.hotkey-overlay-title = null;
    content.focus-workspace-up = _: {};
  };
  
  "Mod+U" = _: {
    props.hotkey-overlay-title = null;
    content.focus-workspace-down = _: {};
  };
  
  "Mod+I" = _: {
    props.hotkey-overlay-title = null;
    content.focus-workspace-up = _: {};
  };
  
  "Mod+J" = _: {
    props.hotkey-overlay-title = null;
    content.focus-window-or-workspace-down = _: {};
  };
  
  "Mod+K" = _: {
    props.hotkey-overlay-title = null;
    content.focus-window-or-workspace-up = _: {};
  };
  
  "Mod+Down" = _: {
    props.hotkey-overlay-title = null;
    content.focus-window-or-workspace-down = _: {};
  };
  
  "Mod+Up" = _: {
    props.hotkey-overlay-title = null;
    content.focus-window-or-workspace-up = _: {};
  };
  
  "Mod+WheelScrollDown" = _: {
    props.hotkey-overlay-title = null;
    props.cooldown-ms = 50;
    content.focus-workspace-down = _: {};
  };
  
  "Mod+WheelScrollUp" = _: {
    props.hotkey-overlay-title = null;
    props.cooldown-ms = 50;
    content.focus-workspace-up = _: {};
  };
  
  "Mod+Alt+WheelScrollDown" = _: {
    props.hotkey-overlay-title = null;
    props.cooldown-ms = 50;
    content.move-column-to-workspace-down = _: {};
  };
  
  "Mod+Alt+WheelScrollUp" = _: {
    props.hotkey-overlay-title = null;
    props.cooldown-ms = 50;
    content.move-column-to-workspace-up = _: {};
  };
  
  "Mod+Alt+Page_Down" = _: {
    props.hotkey-overlay-title = null;
    content.move-column-to-workspace-down = _: {};
  };
  
  "Mod+Alt+Page_Up" = _: {
    props.hotkey-overlay-title = null;
    content.move-column-to-workspace-up = _: {};
  };
  
  "Mod+Alt+U" = _: {
    props.hotkey-overlay-title = null;
    content.move-column-to-workspace-down = _: {};
  };
  
  "Mod+Alt+I" = _: {
    props.hotkey-overlay-title = null;
    content.move-column-to-workspace-up = _: {};
  };
  
  "Mod+Alt+J" = _: {
    props.hotkey-overlay-title = null;
    content.move-window-down-or-to-workspace-down = _: {};
  };
  
  "Mod+Alt+K" = _: {
    props.hotkey-overlay-title = null;
    content.move-window-up-or-to-workspace-up = _: {};
  };
  
  "Mod+Alt+Down" = _: {
    props.hotkey-overlay-title = null;
    content.move-window-down-or-to-workspace-down = _: {};
  };
  
  "Mod+Alt+Up" = _: {
    props.hotkey-overlay-title = null;
    content.move-window-up-or-to-workspace-up = _: {};
  };
  
  "Mod+1" = _: {
    props.hotkey-overlay-title = null;
    content.focus-workspace = "1";
  };
  
  "Mod+2" = _: {
    props.hotkey-overlay-title = null;
    content.focus-workspace = "2";
  };
  
  "Mod+3" = _: {
    props.hotkey-overlay-title = null;
    content.focus-workspace = "3";
  };
  
  "Mod+4" = _: {
    props.hotkey-overlay-title = null;
    content.focus-workspace = "4";
  };
  
  "Mod+5" = _: {
    props.hotkey-overlay-title = null;
    content.focus-workspace = "5";
  };
  
  "Mod+6" = _: {
    props.hotkey-overlay-title = null;
    content.focus-workspace = "6";
  };
  
  "Mod+7" = _: {
    props.hotkey-overlay-title = null;
    content.focus-workspace = "7";
  };
  
  "Mod+8" = _: {
    props.hotkey-overlay-title = null;
    content.focus-workspace = "8";
  };
  
  "Mod+9" = _: {
    props.hotkey-overlay-title = null;
    content.focus-workspace = "9";
  };
  
  "Mod+S" = _: {
    props.hotkey-overlay-title = null;
    content.spawn-sh = "~/.config/niri/scripts/toggle_workspace.sh \"special\"";
  };
  
  "Mod+Alt+1" = _: {
    props.hotkey-overlay-title = null;
    content.move-column-to-workspace = "1";
  };
  
  "Mod+Alt+2" = _: {
    props.hotkey-overlay-title = null;
    content.move-column-to-workspace = "2";
  };
  
  "Mod+Alt+3" = _: {
    props.hotkey-overlay-title = null;
    content.move-column-to-workspace = "3";
  };
  
  "Mod+Alt+4" = _: {
    props.hotkey-overlay-title = null;
    content.move-column-to-workspace = "4";
  };
  
  "Mod+Alt+5" = _: {
    props.hotkey-overlay-title = null;
    content.move-column-to-workspace = "5";
  };
  
  "Mod+Alt+6" = _: {
    props.hotkey-overlay-title = null;
    content.move-column-to-workspace = "6";
  };
  
  "Mod+Alt+7" = _: {
    props.hotkey-overlay-title = null;
    content.move-column-to-workspace = "7";
  };
  
  "Mod+Alt+8" = _: {
    props.hotkey-overlay-title = null;
    content.move-column-to-workspace = "8";
  };
  
  "Mod+Alt+9" = _: {
    props.hotkey-overlay-title = null;
    content.move-column-to-workspace = "9";
  };
  
  "Mod+Alt+S" = _: {
    props.hotkey-overlay-title = null;
    content.move-column-to-workspace = "special";
  };
  
  "Mod+Shift+Page_down" = _: {
    props.hotkey-overlay-title = null;
    content.move-workspace-down = _: {};
  };
  
  "Mod+Shift+Page_Up" = _: {
    props.hotkey-overlay-title = null;
    content.move-workspace-up = _: {};
  };
  
  "Mod+Shift+U" = _: {
    props.hotkey-overlay-title = null;
    content.move-workspace-down = _: {};
  };
  
  "Mod+Shift+I" = _: {
    props.hotkey-overlay-title = null;
    content.move-workspace-up = _: {};
  };
  
  "Mod+BracketLeft" = _: {
    content.consume-or-expel-window-left = _: {};
  };
  
  "Mod+BracketRight" = _: {
    content.consume-or-expel-window-right = _: {};
  };
  
  "Mod+Comma" = _: {
    content.consume-window-into-column = _: {};
  };
  
  "Mod+Period" = _: {
    content.expel-window-from-column = _: {};
  };
  
  "Mod+R" = _: {
    props.repeat = false;
    content.switch-preset-column-width = _: {};
  };
  
  "Mod+Shift+R" = _: {
    props.repeat = false;
    content.switch-preset-window-height = _: {};
  };
  
  "Mod+Alt+R" = _: {
    content.reset-window-height = _: {};
  };
  
  "Mod+F" = _: {
    props.repeat = false;
    content.maximize-column = _: {};
  };
  
  "Mod+Ctrl+F" = _: {
    props.repeat = false;
    content.toggle-windowed-fullscreen = _: {};
  };
  
  "Mod+Shift+F" = _: {
    props.repeat = false;
    content.fullscreen-window = _: {};
  };
  
  "Mod+M" = _: {
    props.repeat = false;
    content.maximize-window-to-edges = _: {};
  };
  
  "Mod+Alt+F" = _: {
    content.expand-column-to-available-width = _: {};
  };
  
  "Mod+C" = _: {
    content.center-column = _: {};
  };
  
  "Mod+Alt+C" = _: {
    content.center-visible-columns = _: {};
  };
  
  "Mod+Minus" = _: {
    content.set-column-width = "-10%";
  };
  
  "Mod+Equal" = _: {
    content.set-column-width = "+10%";
  };
  
  "Mod+Shift+Minus" = _: {
    content.set-window-height = "-10%";
  };
  
  "Mod+Shift+Equal" = _: {
    content.set-window-height = "+10%";
  };
  
  "Mod+V" = _: {
    props.repeat = false;
    content.toggle-window-floating = _: {};
  };
  
  "Mod+Shift+V" = _: {
    content.switch-focus-between-floating-and-tiling = _: {};
  };
  
  "Mod+N" = _: {
    props.hotkey-overlay-title = "Cast Focused Window";
    content.spawn-sh = "niri msg action set-dynamic-cast-window --id $(niri msg -j focused-window | jq .id)";
  };
  
  "Print" = _: {
    props.hotkey-overlay-title = "Screenshot";
    content.spawn-sh = "grim -g \"$(slurp)\" - | satty --filename -";
  };
  
  "Shift+Print" = _: {
    props.hotkey-overlay-title = "Screenshot Screen";
    content.screenshot-screen = _: {};
  };
  
  "Alt+Print" = _: {
    props.hotkey-overlay-title = "Screenshot Window";
    content.screenshot-window = _: {};
  };
  
  "Ctrl+Print" = _: {
    props.hotkey-overlay-title = "Screenshot and Scan Text";
    content.spawn-sh = "grim -g \"$(slurp)\" - | tesseract - - -l rus+eng | wl-copy && notify-send -u low \"OCR\" \"Text has been copied\"";
  };
  
  "Mod+Escape" = _: {
    props.allow-inhibiting = false;
    content.toggle-keyboard-shortcuts-inhibit = _: {};
  };
  
  "Mod+Ctrl+M" = _: {
    props.hotkey-overlay-title = "Quit niri session";
    content.quit = _: {};
  };

  "Mod+Shift+P" = _: {
    content.power-off-monitors = _: {};
  };
  
  "Mod+T" = _: {
    props.repeat = false;
    props.hotkey-overlay-title = "Spawn Kitty";
    content.spawn = "${lib.getExe self'.packages.myKitty}";
  };
  
  "Mod+Return" = _: {
    props.repeat = false;
    props.hotkey-overlay-title = "Spawn Kitty";
    content.spawn = "${lib.getExe self'.packages.myKitty}";
  };
  
  "Mod+Shift+T" = _: {
    props.repeat = false;
    props.hotkey-overlay-title = "Spawn Floating Kitty";
    content.spawn-sh = "${lib.getExe self'.packages.myKitty} --app-id 'floating kitty'";
  };
  
  "Mod+Shift+Return" = _: {
    props.repeat = false;
    props.hotkey-overlay-title = "Spawn Floating Kitty";
    content.spawn-sh = "${lib.getExe self'.packages.myKitty} --app-id 'floating kitty'";
  };
  
  "Mod+E" = _: {
    props.repeat = false;
    props.hotkey-overlay-title = "Spawn Yazi";
    content.spawn-sh = "${lib.getExe self'.packages.myKitty} yazi";
  };
  
  "Mod+Shift+E" = _: {
    props.repeat = false;
    props.hotkey-overlay-title = "Spawn Floating Yazi";
    content.spawn-sh = "${lib.getExe self'.packages.myKitty} --class 'floating kitty' yazi";
  };
  
  "Mod+W" = _: {
    props.repeat = false;
    props.hotkey-overlay-title = "Run an Application: wofi";
    content.spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";
  };
  
  "Mod+X" = _: {
    props.repeat = false;
    props.hotkey-overlay-title = "Run an Application: wofi";
    content.spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";
  };
  
  "Mod+Ctrl+L" = _: {
    props.hotkey-overlay-title = "Lock the Screen";
    content.spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call lockScreen lock";
  };
  
  "Mod+Ctrl+Alt+L" = _: {
    props.hotkey-overlay-title = "Lock the Screen";
    content.spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call lockScreen lock";
  };
  
  "Mod+Shift+W" = _: {
    props.repeat = false;
    props.hotkey-overlay-title = "Select Wallpaper (neat)";
    content.spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call plugin:wallcards toggle";
  };
  
  "Mod+Alt+W" = _: {
    props.repeat = false;
    props.hotkey-overlay-title = "Select Wallpaper";
    content.spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call wallpaper toggle";
  };
  
  "Mod+Ctrl+W" = _: {
    props.repeat = false;
    props.hotkey-overlay-title = "Select Video Wallpaper";
    content.spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call plugin:videowallpaper openPanel";
  };
  
  "Ctrl+Alt+Delete" = _: {
    props.hotkey-overlay-title = "Open Session Menu";
    content.spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call sessionMenu toggle";
  };
  
  "Mod+Shift+M" = _: {
    props.hotkey-overlay-title = "Open Session Menu";
    content.spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call sessionMenu toggle";
  };
}
