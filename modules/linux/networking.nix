# modules/linux/networking.nix — NetworkManager + firewall defaults
{ config, lib, ... }:
{
  networking.networkmanager.enable = true;

  # ── Firewall ─────────────────────────────────────────────
  # Default: enabled. Per-host configs can `networking.firewall.enable = false;`
  networking.firewall = {
    enable = lib.mkDefault true;
    allowPing = true;
  };

  # ── Synergy Server (toggled per-host) ────────────────────
  networking.firewall.allowedTCPPortRanges =
    lib.mkIf config.features."synergy-server".enable [
      { from = 24800; to = 24801; }
    ];
  networking.firewall.allowedUDPPortRanges =
    lib.mkIf config.features."synergy-server".enable [
      { from = 24800; to = 24801; }
    ];

  services.synergy.server.enable = lib.mkDefault false;
}
