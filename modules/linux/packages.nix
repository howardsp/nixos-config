# modules/linux/packages.nix — Linux-only system packages
#
# ┌─────────────────────────────────────────────────────────┐
# │  ADD LINUX-ONLY PACKAGES HERE                           │
# │  For cross-platform → modules/common/packages.nix      │
# │  For macOS-only     → modules/darwin/packages.nix       │
# └─────────────────────────────────────────────────────────┘
{ config, lib, pkgs, pkgs-unstable, pkgs-2505,... }:
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
  };


config.environment.systemPackages = with pkgs;
    [
      # ── System Utilities ──────────────────────────────
      xfce.thunar           # lightweight file manager
      rofi                  # application launcher 
      gnome-multi-writer    # write ISO to multiple USB drives at once
      mediawriter           # bootable USB creator (Fedora media writer)
      syncthing             # peer-to-peer file sync
      insync                # Google Drive / OneDrive client
      android-tools         # adb, fastboot for Android device management
      gitkraken             # Git GUI

      # ── Dev Tools ───────────────────────────────────────
      gcc                   # C/C++ compiler
      cmake                 # build system generator
      jdk                   # Java Development Kit
      direnv              # per-directory environment variables

      # ── Containers ──────────────────────────────────────
      docker-compose        # multi-container Docker orchestration
      dive                  # explore Docker image layers

      # ───────────────────────────────────
      pkgs-unstable.deskflow            # software KVM switch (share keyboard/mouse)
      wirelesstools       # wireless network utilities
      iproute2            # network config (ip command)
      netcat-gnu          # read/write TCP/UDP connections
      iputils             # ping and other IP utilities
      iptables            # Linux firewall rules
      traceroute          # trace network path to host



      # ── Wayland Utilities ────────────────────────────
      wl-clipboard          # clipboard access from the terminal (wl-copy/wl-paste)
      ydotool               # Wayland keyboard/mouse automation (needs services.ydotool.enable)
    ]
    # ── Conditional Feature Sets ────────────────────────
    ++ lib.optionals config.features.browsers.enable [
      brave               # privacy-focused Chromium browser
      firefox             # Mozilla Firefox
      google-chrome       # Google Chrome
      microsoft-edge      # Microsoft Edge
    ]
    ++ lib.optionals config.features.office.enable [
      flameshot           # screenshot tool with annotation
      libreoffice-fresh   # office suite
      onlyoffice-desktopeditors  # MS Office-compatible suite
      inkscape            # vector graphics editor
    ]
    ++ lib.optionals config.features.photo.enable [
      vlc                 # versatile media player
      gimp                # image editor
      pinta               # simple paint / image editor
      krita               # digital painting and illustration
      glib                # GLib utilities
      photocollage        # photo collage maker
      mpv                 # minimal scriptable media player
    ]
    ++ lib.optionals config.features.webcam.enable [
      zoom-us             # Zoom video conferencing
      webex               # Cisco Webex conferencing
      cameractrls         # webcam controls (CLI)
      cameractrls-gtk4    # webcam controls (GTK4 GUI)
      obs-studio          # screen recording and live streaming
      linuxPackages.v4l2loopback  # virtual webcam kernel module
      v4l-utils           # Video4Linux utilities
    ]
    ++ lib.optionals config.features.citrix.enable [
      pkgs-2505.citrix_workspace  # Citrix virtual desktop client      
    ]
    ++ lib.optionals config.features.qemu.enable [
      virt-viewer         # VM display viewer (SPICE/VNC)
      virtio-win          # Windows VirtIO drivers ISO
      virt-top            # VM resource monitor (like top for VMs)
      virt-manager        # VM management GUI
    ];
}
