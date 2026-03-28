# modules/linux/steam.nix — Steam with network play support
{ config, lib, pkgs, ... }:
{
  options.features.steam.enable = lib.mkEnableOption "Steam gaming" // { default = true; };

  config = lib.mkIf config.features.steam.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };

    # 32-bit OpenGL for Steam games
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
