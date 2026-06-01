# modules/linux/networking.nix — NetworkManager + firewall defaults
{ config, lib, ... }:
{
  networking.networkmanager.enable = true;

  # ── WiFi ─────────────────────────────────────────────────
  networking.networkmanager.wifi.powersave = false;
  networking.networkmanager.settings."connection-wifi-defaults" = {
    "match-device" = "type:wifi";
    "connection.type" = "802-11-wireless";
    "802-11-wireless.band" = "a";
  };

  # ── Firewall ─────────────────────────────────────────────
  # Default: enabled. Per-host configs can `networking.firewall.enable = false;`
  networking.firewall = {
    enable = lib.mkDefault true;
    allowPing = true;
  };

  networking.firewall.allowedTCPPortRanges = [{ from = 24800; to = 24801; }];
  networking.firewall.allowedUDPPortRanges = [{ from = 24800; to = 24801; }];
  
}
