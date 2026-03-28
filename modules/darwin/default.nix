# modules/darwin/default.nix — macOS (nix-darwin) system configuration
{ config, lib, pkgs, username, ... }:
{
  imports = [
    ./packages.nix
    ./homebrew.nix
  ];

  system.stateVersion = 5;

  # ── User Account ─────────────────────────────────────────
  users.users.${username} = {
    home = "/Users/${username}";
  };

  # ── Nix Daemon ───────────────────────────────────────────
  # nix-darwin manages the daemon automatically

  # ── macOS System Preferences ─────────────────────────────
  system.primaryUser = username;

  security.pam.services.sudo_local.touchIdAuth = true;  # Touch ID for sudo

  system.defaults = {
    # Global
    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      AppleInterfaceStyleSwitchesAutomatically = true;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSDocumentSaveNewDocumentsToCloud = false;
      "com.apple.mouse.tapBehavior" = 1;
      "com.apple.trackpad.trackpadCornerClickBehavior" = 1;
    };

    # Window Manager
    WindowManager.GloballyEnabled = true;

    # Control Center
    controlcenter.BatteryShowPercentage = true;

    # Finder
    finder = {
      _FXShowPosixPathInTitle = false;
      _FXSortFoldersFirst = true;
      AppleShowAllExtensions = true;
      AppleShowAllFiles = false;
      FXDefaultSearchScope = "SCcf";            # Search current folder
      FXEnableExtensionChangeWarning = false;
      FXPreferredViewStyle = "clmv";            # Column view
      ShowPathbar = true;
      ShowStatusBar = true;
    };

    # Dock
    dock = {
      appswitcher-all-displays = true;
      autohide = true;
      autohide-delay = 0.0;
      autohide-time-modifier = 0.15;
      dashboard-in-overlay = false;
      enable-spring-load-actions-on-all-items = false;
      expose-animation-duration = 0.2;
      expose-group-apps = false;
      mineffect = "genie";
      minimize-to-application = true;
      mouse-over-hilite-stack = true;
      mru-spaces = false;
      orientation = "bottom";
      show-process-indicators = true;
      show-recents = false;
      showhidden = true;
      tilesize = 48;
      persistent-apps = [
        "/System/Applications/App Store.app"
        "/System/Cryptexes/App/System/Applications/Safari.app"
        "/Applications/Firefox.app"
        "/Applications/Google Chrome.app"
        "/System/Applications/Messages.app"
        "/Applications/zoom.us.app"
        "/Applications/Visual Studio Code.app"
        "/Applications/iterm.app"
        "/System/Applications/Utilities/Activity Monitor.app"
        "/System/Applications/System Settings.app"
      ];
      persistent-others = [
        "/Users/${username}/Downloads/"
      ];
    };
  };
}
