# overlays/default.nix
# Collects all overlay NixOS modules.
# To add a new overlay: create <name>.nix alongside this file and import it below.
{ claude-desktop, ... }:
[
  (import ./claude-desktop.nix { inherit claude-desktop; })
]
