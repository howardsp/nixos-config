# modules/linux/gnome.nix — GNOME desktop + extensions + themes
{ config, pkgs, ... }:
{
  # ── X11 & Display Manager ────────────────────────────────
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.variant = "";    
  };

  services.displayManager.gdm.enable = true;
  
  #services.displayManager.gdm.wayland = false;    # X11 for Citrix/Synergy compat
  services.desktopManager.gnome.enable = true;
  services.udev.packages = [ pkgs.gnome-settings-daemon ];
  services.dbus.packages = [ pkgs.gnome2.GConf ];
  programs.dconf.enable = true;

  services.gnome.gnome-keyring.enable = true;

  # ── Remove bloat from default GNOME install ──────────────
  environment.gnome.excludePackages = with pkgs; [
    gnome-remote-desktop
    epiphany
    geary
    gnome-maps
    gnome-weather
  ];

  # ── GNOME Packages ───────────────────────────────────────
  environment.systemPackages = with pkgs; [
    # Core GNOME apps
    gnome-tweaks
    nautilus
    nautilus-python
    gnome-software
    gnome-terminal
    gnome-console
    gnome-system-monitor
    gnome-initial-setup
    gnome-characters
    dconf-editor
    refine
    gedit
    gthumb
    amberol             # music player

    # Extensions
    gnomeExtensions.arcmenu
    gnomeExtensions.dash-to-panel
    gnomeExtensions.date-menu-formatter
    gnomeExtensions.gtile
    gnomeExtensions.highlight-focus
    gnomeExtensions.just-perfection
    gnomeExtensions.appindicator
    gnomeExtensions.vitals
    gnomeExtensions.transparent-window-moving
    gnomeExtensions.pop-shell
    gnomeExtensions.desktop-icons-ng-ding
    gnomeExtensions.quick-settings-tweaker
    gnomeExtensions.pano
    gnomeExtensions.x11-gestures
    gnomeExtensions.caffeine
    gnomeExtensions.tiling-shell

    # Themes & Icons
    adwaita-icon-theme
    whitesur-icon-theme
    nordzy-icon-theme
    yaru-theme
    yaru-remix-theme
    orchis-theme
    whitesur-gtk-theme
    whitesur-cursors
  ];
}
