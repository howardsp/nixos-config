# overlays/claude-desktop.nix
# Applies the claude-desktop overlay and adds the package to system packages.
{ claude-desktop }: { pkgs, ... }: {
  nixpkgs.overlays = [ claude-desktop.overlays.default ];
  environment.systemPackages = [ pkgs.claude-desktop ];
}
