# modules/linux/packages.nix — Linux-only system packages
#
# ┌─────────────────────────────────────────────────────────┐
# │  ADD LINUX-ONLY PACKAGES HERE                           │
# │  For cross-platform → modules/common/packages.nix      │
# │  For macOS-only     → modules/darwin/packages.nix       │
# └─────────────────────────────────────────────────────────┘
{ config, lib, pkgs, nixpkgs-unstable, ... }:
{
  # ── Feature Toggles ──────────────────────────────────────
  # Override these per-host: e.g. `features.office.enable = false;`
  options.features = {
    browsers.enable = lib.mkEnableOption "Web browsers"              // { default = true; };
    office.enable   = lib.mkEnableOption "Office suite"              // { default = true; };
    photo.enable    = lib.mkEnableOption "Photo/video tools"         // { default = true; };
    webcam.enable   = lib.mkEnableOption "Webcam & video conferencing" // { default = true; };
    citrix.enable   = lib.mkEnableOption "Citrix Workspace"         // { default = true; };
    qemu.enable     = lib.mkEnableOption "QEMU/KVM virtualisation"  // { default = false; };
    "synergy-server".enable = lib.mkEnableOption "Synergy server"   // { default = false; };
  };


config.environment.systemPackages = with pkgs;
    [
    
      claude-code      

      
      # ── System Utilities ──────────────────────────────
      stacer                # system optimizer GUI
      xfce.thunar           # lightweight file manager
      rofi                  # application launcher
      gnome-multi-writer    # USB writer
      mediawriter           # Fedora media writer
      syncthing             # file sync
      insync                # Google Drive client
      android-tools         # adb, fastboot
      gitkraken             # Git GUI
      jdk                   # Java

      # ── X11 Utilities ────────────────────────────────
      xorg.xrandr
      xorg.xkill
      xdotool
      xclip
    ]
    # ── Conditional Feature Sets ────────────────────────
    ++ lib.optionals config.features.browsers.enable [
      brave firefox google-chrome microsoft-edge
    ]
    ++ lib.optionals config.features.office.enable [
      flameshot libreoffice-fresh onlyoffice-bin inkscape
    ]
    ++ lib.optionals config.features.photo.enable [
      vlc gimp pinta krita glib photocollage mpv
    ]
    ++ lib.optionals config.features.webcam.enable [
      zoom-us webex cameractrls cameractrls-gtk4 obs-studio
      linuxPackages.v4l2loopback v4l-utils
    ]
    ++ lib.optionals config.features.citrix.enable [
      citrix_workspace
    ]
    ++ lib.optionals config.features.qemu.enable [
      virt-viewer virtio-win virt-top virt-manager
    ];
}
