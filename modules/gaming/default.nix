{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.gaming;
in
{
  options.modules.gaming = {
    steam = {
      enable = mkEnableOption "Steam and gaming support";
    };
    
    gamemode = {
      enable = mkEnableOption "Feral GameMode for performance";
    };
  };

  config = mkMerge [
    # Steam configuration
    (mkIf cfg.steam.enable {
      programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
        
        # Proton GE for better compatibility
        extraCompatPackages = with pkgs; [
          proton-ge-bin
        ];
      };

      # Required packages
      environment.systemPackages = with pkgs; [
        # Steam dependencies
        steamtinkerlaunch
        
        # Game launchers
        lutris
        heroic
        
        # Tools
        mangohud  # Performance overlay
        gamescope # Gaming compositor
      ];

      # Enable 32-bit graphics drivers for Steam
      hardware.graphics.enable32Bit = true;
      hardware.pulseaudio.support32Bit = true;
    })

    # GameMode configuration
    (mkIf cfg.gamemode.enable {
      programs.gamemode = {
        enable = true;
        settings = {
          general = {
            renice = 10;
          };
          
          gpu = {
            apply_gpu_optimisations = "accept-responsibility";
            gpu_device = 0;
            amd_performance_level = "high";
          };
        };
      };
    })
  ];
}
