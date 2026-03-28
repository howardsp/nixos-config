# hosts/virtualnix/default.nix — VM test environment
{ config, lib, pkgs, ... }:
{
  imports = [
    ./hardware.nix
  ];

  # ── Feature Toggles (lightweight VM) ─────────────────────
  features.steam.enable = false;
  features.webcam.enable = false;
  features.citrix.enable = false;

  # ── Boot ─────────────────────────────────────────────────
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

  # ── SPICE Guest Agent ───────────────────────────────────
  services.spice-vdagentd.enable = true;
}
