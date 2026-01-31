{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.desktop.gnome;
in
{
  options.modules.desktop.gnome = {
    enable = mkEnableOption "GNOME desktop environment";
    
    extensions = mkOption {
      type = types.bool;
      default = true;
      description = "Install popular GNOME extensions";
    };
    
    fractionalScaling = mkOption {
      type = types.bool;
      default = false;
      description = "Enable fractional scaling (useful for HiDPI)";
    };
  };

  config = mkIf cfg.enable {
    # Enable GNOME
    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    # Exclude unwanted GNOME apps
    environment.gnome.excludePackages = with pkgs; [
      gnome-tour
      gnome-music
      epiphany      # GNOME Web browser
      geary         # Email client
      gnome-maps
      gnome-weather
      gnome-contacts
      simple-scan
    ];

    # Essential GNOME packages
    environment.systemPackages = with pkgs; [
      gnome-tweaks
      gnome-extension-manager
      dconf-editor
      
      # File managers and tools
      nautilus
      file-roller
      
      # System monitor
      gnome-system-monitor
    ] ++ optionals cfg.extensions [
      # Popular extensions
      gnomeExtensions.appindicator
      gnomeExtensions.dash-to-dock
      gnomeExtensions.blur-my-shell
      gnomeExtensions.vitals
      gnomeExtensions.caffeine
      gnomeExtensions.clipboard-indicator
      gnomeExtensions.just-perfection
    ];

    # Enable GNOME services
    services = {
      gnome = {
        gnome-keyring.enable = true;
        gnome-settings-daemon.enable = true;
      };
      
      # Automatic problem reporting
      gnome.core-utilities.enable = true;
    };

    # GDM configuration
    services.xserver.displayManager.gdm = {
      wayland = true;
      autoSuspend = false;
    };

    # Enable fractional scaling if requested
    environment.sessionVariables = mkIf cfg.fractionalScaling {
      GDK_SCALE = "1";
      GDK_DPI_SCALE = "1";
    };

    # Additional configuration
    programs.dconf.enable = true;
    
    # XDG portals for Wayland
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
      ];
    };
  };
}
