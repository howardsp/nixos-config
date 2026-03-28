# modules/linux/default.nix — NixOS-specific system configuration
{ config, lib, pkgs, host, username, fullname, ... }:
{
  imports = [
    ./packages.nix
    ./gnome.nix
    ./sound.nix
    ./printing.nix
    ./performance.nix
    ./networking.nix
    ./security.nix
    ./virtualisation.nix
    ./steam.nix
    ./containers.nix
  ];

  # ── Locale & Time ────────────────────────────────────────
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  system.stateVersion = "25.05";

  # ── Host Identity ────────────────────────────────────────
  networking.hostName = host;

  # ── Flatpak ──────────────────────────────────────────────
  services.flatpak.enable = true;

  # ── Font Rendering ───────────────────────────────────────
  fonts.enableDefaultPackages = true;
  fonts.fontDir.enable = true;
  fonts.enableGhostscriptFonts = true;

  # ── User Account ─────────────────────────────────────────
  users.users.${username} = {
    isNormalUser = true;
    description = fullname;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"             # sudo
      "networkmanager"    # network config
      "video"             # GPU/display
      "audio"             # sound devices
      "media"             # media files
      "docker"            # containers
      "libvirtd"          # VMs
      "qemu-libvirtd"     # QEMU
      "lxd"               # LXD containers
      "input"             # input devices
      "plugdev"           # USB devices
    ];
  };
  users.groups.libvirtd.members = [ username ];

  # ── Activation Scripts ───────────────────────────────────
  system.activationScripts.customTweaks.text = ''
    # Symlink bash for scripts that hardcode /bin/bash
    ln -sf /bin/sh /bin/bash

    # Citrix: disable middle-click paste, enable local special keys
    CITRIX_INI="/home/${username}/.ICAClient/All_Regions.ini"
    if [ -f "$CITRIX_INI" ]; then
      echo "Patching Citrix config..."
      ${pkgs.perl}/bin/perl -pi -e 's/MouseSendsControlV=.*$/MouseSendsControlV=false/g' "$CITRIX_INI"
      ${pkgs.perl}/bin/perl -pi -e 's/TransparentKeyPassthrough=.*$/TransparentKeyPassthrough=Local/g' "$CITRIX_INI"
    fi

    # Zoom: disable mini window when switching workspaces
    ZOOM_CONF="/home/${username}/.config/zoomus.conf"
    if [ -f "$ZOOM_CONF" ]; then
      echo "Patching Zoom config..."
      ${pkgs.perl}/bin/perl -pi -e 's/enableMiniWindow=true/enableMiniWindow=false/g' "$ZOOM_CONF"
    fi
  '';
}
