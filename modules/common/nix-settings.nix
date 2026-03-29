# modules/common/nix-settings.nix — Nix daemon tuning for performance
{ lib, pkgs, ... }:
{
  nix = {
    settings = {
      # ── Performance ─────────────────────────────────────
      # Use all available cores for building
      max-jobs = "auto";
      cores = 0;    # 0 = use all available cores per build job
      sandbox = true;  # Isolate builds for reproducibility and security    
      # ── Caching ─────────────────────────────────────────
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];

      # ── Trust ───────────────────────────────────────────
      trusted-users = [ "root" "@wheel" ];
      allowed-users = [ "*" ];

      # ── Misc ────────────────────────────────────────────
      warn-dirty = false;
      keep-outputs = true;
      keep-derivations = true;
    };

    # ── Garbage Collection ──────────────────────────────────
    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };
  };
}
