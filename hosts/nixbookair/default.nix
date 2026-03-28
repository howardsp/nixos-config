# hosts/nixbookair/default.nix — MacBook Air (Apple Silicon)
{ config, lib, pkgs, username, ... }:
{
  # No hardware.nix needed for Darwin — nix-darwin auto-detects.
  # All macOS system defaults are in modules/darwin/default.nix.
  # Host-specific overrides go here.

  # Example: override dock persistent-apps per machine:
  # system.defaults.dock.persistent-apps = [ ... ];
}
