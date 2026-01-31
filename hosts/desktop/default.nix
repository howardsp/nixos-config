{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ../modules/desktop/gnome.nix
    ../modules/development
    ../modules/gaming
    ../modules/virtualization
  ];

  # Desktop-specific boot configuration
  boot = {
    # Performance governor for desktop
    kernelParams = [ "quiet" "splash" ];
    
    # Support for NTFS and exFAT (for external drives)
    supportedFilesystems = [ "ntfs" "exfat" ];
  };

  # Desktop modules configuration
  modules = {
    desktop.gnome = {
      enable = true;
      extensions = true;
      fractionalScaling = false;
    };
    
    development = {
      enable = true;
      languages = [ "python" "nodejs" "rust" "go" ];
    };
    
    gaming = {
      steam.enable = true;
      gamemode.enable = true;
    };
    
    virtualization = {
      docker.enable = true;
      libvirt.enable = true;
    };
  };

  # Additional desktop packages
  environment.systemPackages = with pkgs; [
    # Browsers
    firefox
    google-chrome
    
    # Communication
    discord
    slack
    zoom-us
    
    # Media
    vlc
    gimp
    inkscape
    
    # Office
    libreoffice-fresh
    
    # Utilities
    flameshot  # Screenshot tool
    solaar     # Logitech device manager
  ];

  # Desktop-specific services
  services = {
    # X11 configuration
    xserver = {
      enable = true;
      xkb.layout = "us";
    };
    
    # Flatpak for additional apps
    flatpak.enable = true;
  };

  # Power management (less aggressive for desktop)
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "performance";
  };

  # Hardware acceleration
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
