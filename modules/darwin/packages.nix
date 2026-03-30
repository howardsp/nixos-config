# modules/darwin/packages.nix — macOS-only Nix packages
#
# ┌─────────────────────────────────────────────────────────┐
# │  ADD macOS-ONLY NIX PACKAGES HERE                       │
# │  For cross-platform → modules/common/packages.nix      │
# │  For Linux-only     → modules/linux/packages.nix       │
# │  For Homebrew casks → modules/darwin/homebrew.nix      │
# └─────────────────────────────────────────────────────────┘
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    mas           # Mac App Store CLI
    qemu_full     # Virtualisation
    ruby_4_0

  ];
}
