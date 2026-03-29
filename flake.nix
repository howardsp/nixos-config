# ╔══════════════════════════════════════════════════════════════╗
# ║  Howard's Nix Configuration — Linux & macOS                ║
# ║                                                            ║
# ║  USAGE:                                                    ║
# ║    Linux:  sudo nixos-rebuild switch --flake .#<host>      ║
# ║    macOS:  nix run nix-darwin -- switch --flake .#<host>   ║
# ║    Update: nix flake update                                ║
# ║    Clean:  sudo nix-collect-garbage -d                     ║
# ║    Diff:   nvd diff /nix/var/nix/profiles/system-*-link   ║
# ╚══════════════════════════════════════════════════════════════╝
{
  description = "Howard's cross-platform Nix configuration";

  inputs = {
    # ── Core ──────────────────────────────────────────────
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    claude-desktop.url = "github:aaddrick/claude-desktop-debian";

    # ── Home Manager ──────────────────────────────────────
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # ── macOS ─────────────────────────────────────────────
    darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    homebrew-bundle = { url = "github:homebrew/homebrew-bundle"; flake = false; };
    homebrew-core   = { url = "github:homebrew/homebrew-core";   flake = false; };
    homebrew-cask   = { url = "github:homebrew/homebrew-cask";   flake = false; };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, darwin,
              nix-homebrew, homebrew-bundle, homebrew-core, homebrew-cask, claude-desktop, ... }@inputs:
  let
    lib = import ./lib { inherit inputs nixpkgs nixpkgs-unstable home-manager darwin
                                nix-homebrew homebrew-bundle homebrew-core homebrew-cask claude-desktop; };
  in {
    # ── NixOS Hosts ───────────────────────────────────────
    nixosConfigurations = {
      igloo       = lib.mkLinuxHost { host = "igloo"; };
      avalanche   = lib.mkLinuxHost { host = "avalanche"; };
      virtualnix  = lib.mkLinuxHost { host = "virtualnix"; };
    };

    # ── macOS Hosts ───────────────────────────────────────
    darwinConfigurations = {
      nixbookair = lib.mkDarwinHost { host = "nixbookair"; };
    };
  };
}
