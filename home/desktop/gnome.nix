{ config, lib, pkgs, ... }:

{
  # GNOME dconf settings
  dconf.settings = {
    # Interface settings
    "org/gnome/desktop/interface" = {
      clock-format = "12h";
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
      gtk-theme = "Adwaita-dark";
      icon-theme = "Papirus-Dark";
      show-battery-percentage = true;
    };
    
    # Window manager
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
      num-workspaces = 4;
    };
    
    # Window manager keybindings
    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Super>q" ];
      switch-to-workspace-1 = [ "<Super>1" ];
      switch-to-workspace-2 = [ "<Super>2" ];
      switch-to-workspace-3 = [ "<Super>3" ];
      switch-to-workspace-4 = [ "<Super>4" ];
      move-to-workspace-1 = [ "<Super><Shift>1" ];
      move-to-workspace-2 = [ "<Super><Shift>2" ];
      move-to-workspace-3 = [ "<Super><Shift>3" ];
      move-to-workspace-4 = [ "<Super><Shift>4" ];
    };
    
    # Mutter (compositor)
    "org/gnome/mutter" = {
      dynamic-workspaces = false;
      edge-tiling = true;
      workspaces-only-on-primary = true;
    };
    
    # Shell
    "org/gnome/shell" = {
      favorite-apps = [
        "firefox.desktop"
        "org.gnome.Nautilus.desktop"
        "Alacritty.desktop"
        "code.desktop"
      ];
      
      enabled-extensions = [
        "appindicatorsupport@rgcjonas.gmail.com"
        "dash-to-dock@micxgx.gmail.com"
        "blur-my-shell@aunetx"
        "Vitals@CoreCoding.com"
        "caffeine@patapon.info"
        "clipboard-indicator@tudmotu.com"
        "just-perfection-desktop@just-perfection"
      ];
    };
    
    # Keybindings
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };
    
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Terminal";
      command = "alacritty";
      binding = "<Super>Return";
    };
    
    # Nautilus (file manager)
    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "list-view";
      search-filter-time-type = "last_modified";
      show-create-link = true;
      show-delete-permanently = true;
    };
    
    # Terminal
    "org/gnome/terminal/legacy/profiles:/:default" = {
      background-color = "#1e1e2e";
      foreground-color = "#cdd6f4";
      use-theme-colors = false;
      audible-bell = false;
      scrollback-unlimited = true;
    };
    
    # Privacy
    "org/gnome/desktop/privacy" = {
      remember-recent-files = true;
      recent-files-max-age = 30;
      remove-old-temp-files = true;
      remove-old-trash-files = true;
      old-files-age = 30;
    };
    
    # Power
    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing";
      sleep-inactive-battery-type = "suspend";
      sleep-inactive-battery-timeout = 900;
    };
  };
}
