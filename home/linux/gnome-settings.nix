# home/linux/gnome-settings.nix — GNOME dconf configuration
#
# Extensions, keybindings, panel layout, themes, and interface tweaks.
{ pkgs, lib, ... }:
{
  dconf.settings = {

    # ══════════════════════════════════════════════════════
    #  EXTENSIONS
    # ══════════════════════════════════════════════════════

    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "windowsNavigator@gnome-shell-extensions.gcampax.github.com"
        "appindicatorsupport@rgcjonas.gmail.com"
        "arcmenu@arcmenu.com"
        "pop-shell@system76.com"
        "dash-to-panel@jderose9.github.com"
        "date-menu-formatter@marcinjakubowski.github.com"
        "gTile@vibou"
        "highlight-focus@pimsnel.com"
        "just-perfection-desktop@just-perfection"
        "Vitals@CoreCoding.com"
        "transparent-window-moving@noobsai.github.com"
        "quick-settings-tweaks@qwreey"
        "pano@elhan.io"
        "workspace-indicator@gnome-shell-extensions.gcampax.github.com"
        "caffeine@patapon.info"
        "tilingshell@ferrarodomenico.com"
      ];
    };

    # ── ArcMenu ────────────────────────────────────────────
    "org/gnome/shell/extensions/arcmenu" = {
      menu-button-icon = "Distro_Icon";
      distro-icon = 0;
      menu-button-postion-offset = 2;
      menu-layout = "Whisker";
      menu-button-appearance = "Icon";
      activate-on-hover = true;
      menu-hotkey-type = "Custom";
      menu-hotkey = "<Super>Escape";
      menu-height = 575;
      enable-standlone-runner-menu = true;
      runner-menu-custom-hotkey = "<Super>";
      search-provider-open-windows = true;
      menu-border-color = "rgb(63,62,64)";
      menu-foreground-color = "rgb(211,218,227)";
      menu-item-active-bg-color = "rgba(228,228,226,0.15)";
      menu-item-hover-bg-color = "rgba(238,238,236,0.08)";
      menu-separator-color = "rgb(63,62,64)";
    };

    # ── Just Perfection ────────────────────────────────────
    "org/gnome/shell/extensions/just-perfection" = {
      startup-status = 0;
      overlay-key = true;
    };

    # ── Date Menu Formatter ────────────────────────────────
    "org/gnome/shell/extensions/date-menu-formatter" = {
      pattern = "EEEE, MMMM d h:mm a";
    };

    # ── Quick Settings Tweaker ─────────────────────────────
    "org/gnome/shell/extensions/quick-settings-tweaks" = {
      notifications-integrated = false;
      output-show-selected = true;
    };

    # ── Pano (clipboard manager) ───────────────────────────
    "org/gnome/shell/extensions/pano" = {
      history-length = 25;
    };

    # ── Dash to Panel ──────────────────────────────────────
    "org/gnome/shell/extensions/dash-to-panel" = {
      panel-positions = "{\"0\":\"TOP\",\"1\":\"TOP\",\"2\":\"TOP\",\"3\":\"TOP\"}";
      panel-lenghts = "{\"0\":100}";
      panel-sizes = "{\"0\":24,\"1\":24,\"2\":24,\"3\":24}";
      appicon-margin = 2;
      appicon-padding = 2;
      dot-style-focused = "SOLID";
      dot-style-unfocused = "DOTS";
      animate-appicon-hover = true;
      trans-use-custom-opacity = true;
      trans-panel-opacity = 0;
      primary-monitor = 0;
      panel-element-positions = builtins.toJSON {
        "0" = [
          { element = "desktopButton";    visible = false; position = "stackedTL"; }
          { element = "leftBox";          visible = true;  position = "stackedTL"; }
          { element = "showAppsButton";   visible = false; position = "stackedTL"; }
          { element = "activitiesButton"; visible = false; position = "stackedTL"; }
          { element = "taskbar";          visible = true;  position = "stackedTL"; }
          { element = "centerBox";        visible = true;  position = "centered"; }
          { element = "dateMenu";         visible = true;  position = "centered"; }
          { element = "rightBox";         visible = true;  position = "stackedBR"; }
          { element = "systemMenu";       visible = true;  position = "stackedBR"; }
        ];
        "1" = [
          { element = "desktopButton";    visible = false; position = "stackedTL"; }
          { element = "leftBox";          visible = true;  position = "stackedTL"; }
          { element = "showAppsButton";   visible = false; position = "stackedTL"; }
          { element = "activitiesButton"; visible = false; position = "stackedTL"; }
          { element = "taskbar";          visible = true;  position = "stackedTL"; }
          { element = "centerBox";        visible = true;  position = "centered"; }
          { element = "dateMenu";         visible = true;  position = "centered"; }
          { element = "rightBox";         visible = true;  position = "stackedBR"; }
          { element = "systemMenu";       visible = true;  position = "stackedBR"; }
        ];
        "2" = [
          { element = "desktopButton";    visible = false; position = "stackedTL"; }
          { element = "leftBox";          visible = true;  position = "stackedTL"; }
          { element = "showAppsButton";   visible = false; position = "stackedTL"; }
          { element = "activitiesButton"; visible = false; position = "stackedTL"; }
          { element = "taskbar";          visible = true;  position = "stackedTL"; }
          { element = "centerBox";        visible = true;  position = "centered"; }
          { element = "dateMenu";         visible = true;  position = "centered"; }
          { element = "rightBox";         visible = true;  position = "stackedBR"; }
          { element = "systemMenu";       visible = true;  position = "stackedBR"; }
        ];
        "3" = [
          { element = "desktopButton";    visible = false; position = "stackedTL"; }
          { element = "leftBox";          visible = true;  position = "stackedTL"; }
          { element = "showAppsButton";   visible = false; position = "stackedTL"; }
          { element = "activitiesButton"; visible = false; position = "stackedTL"; }
          { element = "taskbar";          visible = true;  position = "stackedTL"; }
          { element = "centerBox";        visible = true;  position = "centered"; }
          { element = "dateMenu";         visible = true;  position = "centered"; }
          { element = "rightBox";         visible = true;  position = "stackedBR"; }
          { element = "systemMenu";       visible = true;  position = "stackedBR"; }
        ];
      };
    };

    # ══════════════════════════════════════════════════════
    #  INTERFACE
    # ══════════════════════════════════════════════════════

    "org/gnome/desktop/interface" = {
      clock-format = "12h";
      color-scheme = "prefer-dark";
      scaling-factor = lib.hm.gvariant.mkUint32 1;
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
    };

    "org/gnome/mutter" = {
      edge-tiling = true;
    };

    "org/gtk/settings/file-chooser" = {
      sort-directories-first = true;
    };

    # ══════════════════════════════════════════════════════
    #  KEYBINDINGS
    # ══════════════════════════════════════════════════════

    "org/gnome/shell/keybindings" = {
      toggle-overview = "<Super_L>";
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom6/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom7/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom8/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom10/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom11/"
      ];
    };

    # Kill focused window (Wayland: via GNOME Shell dbus eval)
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Kill Focused Window";
      binding = "<Super><Ctrl><Alt>X";
      command = "busctl --user call org.gnome.Shell /org/gnome/Shell org.gnome.Shell Eval s 'global.display.get_focus_window().kill()'";
    };

    # Remote paste (via ydotool + wl-paste)
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      name = "Remote Paste";
      binding = "<Super><Ctrl><Alt>V";
      command = "sh -c 'sleep 0.5; ydotool type -- \"$(wl-paste)\"'";
    };

    # Close tab with Ctrl+Shift+Backspace
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      name = "Close Tab - Backspace";
      binding = "<Ctrl><Shift>Backspace";
      command = "sh -c 'ydotool key ctrl+w'";
    };

    # Citrix Ctrl+Alt+Delete
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
      name = "Citrix Control Alt Delete";
      binding = "<Ctrl><Alt>End";
      command = "sh -c 'ydotool key ctrl+alt+delete'";
    };

    # Citrix Super+Left
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4" = {
      name = "Citrix - Super Left";
      binding = "<Ctrl><Super><Alt>Left";
      command = "sh -c 'ydotool key super+left'";
    };

    # Citrix Super+Right
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5" = {
      name = "Citrix - Super Right";
      binding = "<Ctrl><Super><Alt>Right";
      command = "sh -c 'ydotool key super+right'";
    };

    # Rofi launcher
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom6" = {
      name = "Rofi";
      binding = "<Ctrl>Space";
      command = "rofi -monitor primary -modi [drun,combi] -show combi";
    };

    # Brightness Up
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom7" = {
      name = "Brightness Up";
      binding = "<Ctrl><Alt><Super>Up";
      command = "sh -c '/home/howardsp/workspace/scripts/brightness.sh Up'";
    };

    # Brightness Down
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom8" = {
      name = "Brightness Down";
      binding = "<Ctrl><Alt><Super>Down";
      command = "sh -c '/home/howardsp/workspace/scripts/brightness.sh Down'";
    };

    # Quick paste from file 1
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom10" = {
      name = "Paste from File ~/.config/.10.txt";
      binding = "<Ctrl><Alt>1";
      command = "sh -c 'sleep 1.0; ydotool type -- \"$(cat ~/.config/.10.txt)\"'";
    };

    # Quick paste from file 2
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom11" = {
      name = "Paste from File ~/.config/.11.txt";
      binding = "<Ctrl><Alt>2";
      command = "sh -c 'sleep 1.0; ydotool type -- \"$(cat ~/.config/.11.txt)\"'";
    };
  };
}
