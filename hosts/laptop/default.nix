{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ../modules/desktop/gnome.nix
    ../modules/development
  ];

  # Laptop-specific boot configuration
  boot = {
    kernelParams = [ "quiet" "splash" "mem_sleep_default=deep" ];
  };

  # Laptop modules configuration
  modules = {
    desktop.gnome = {
      enable = true;
      extensions = true;
      fractionalScaling = true;  # Useful for high-DPI screens
    };
    
    development = {
      enable = true;
      languages = [ "python" "nodejs" ];
    };
  };

  # Laptop-friendly packages
  environment.systemPackages = with pkgs; [
    firefox
    thunderbird
    libreoffice-fresh
    
    # Battery management
    powertop
    
    # Screenshot
    flameshot
  ];

  # Laptop-specific services
  services = {
    xserver = {
      enable = true;
      xkb.layout = "us";
      
      # Touchpad support
      libinput = {
        enable = true;
        touchpad = {
          naturalScrolling = true;
          tapping = true;
          disableWhileTyping = true;
        };
      };
    };
    
    # Better power management
    thermald.enable = true;
    
    # Auto-lock on lid close
    logind = {
      lidSwitch = "suspend";
      lidSwitchExternalPower = "lock";
    };
    
    # TLP for battery optimization
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        
        START_CHARGE_THRESH_BAT0 = 75;
        STOP_CHARGE_THRESH_BAT0 = 80;
      };
    };
  };

  # Aggressive power management for laptop
  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  # Hardware acceleration
  hardware = {
    graphics = {
      enable = true;
    };
  };
}
