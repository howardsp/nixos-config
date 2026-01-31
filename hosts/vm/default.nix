{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ../modules/desktop/gnome.nix
  ];

  # VM-specific configuration
  modules = {
    desktop.gnome = {
      enable = true;
      extensions = false;  # Keep it minimal for VM
      fractionalScaling = false;
    };
  };

  # Minimal package set for VM
  environment.systemPackages = with pkgs; [
    firefox
    vim
    git
  ];

  # Services for VM
  services = {
    xserver = {
      enable = true;
      xkb.layout = "us";
    };
    
    # SPICE agent for better VM integration
    spice-vdagentd.enable = true;
    
    # QEMU guest agent
    qemuGuest.enable = true;
  };

  # VM-specific optimizations
  boot.kernelParams = [ "quiet" ];
  
  # Disable unnecessary services
  powerManagement.enable = false;
  services.thermald.enable = false;
}
