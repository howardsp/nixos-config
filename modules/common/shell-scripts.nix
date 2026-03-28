# modules/common/shell-scripts.nix — Handy wrapper scripts
{ pkgs, ... }:
{
  environment.systemPackages = [
    # Initialize a dev project from templates
    (pkgs.writeShellScriptBin "project-init" ''
      if [ -z "$1" ]; then
        echo "Usage: project-init <template>"
        echo "Run 'project-show' to list available templates."
        exit 1
      fi
      TEMPLATE=$1
      nix flake init --template "github:howardsp/dev-templates#''${TEMPLATE}"
      echo "use flake" > .envrc
      echo "✓ Project initialized with template: $TEMPLATE"
    '')

    # List available dev templates
    (pkgs.writeShellScriptBin "project-show" ''
      nix flake show github:howardsp/dev-templates --refresh
    '')

    # Show diff between last two NixOS generations
    (pkgs.writeShellScriptBin "nixdiff" ''
      PROFILES=(/nix/var/nix/profiles/system-*-link)
      COUNT=''${#PROFILES[@]}
      if [ "$COUNT" -lt 2 ]; then
        echo "Need at least 2 generations to diff"
        exit 1
      fi
      PREV="''${PROFILES[$((COUNT-2))]}"
      CURR="''${PROFILES[$((COUNT-1))]}"
      echo "Comparing: $(basename "$PREV") → $(basename "$CURR")"
      nvd diff "$PREV" "$CURR"
    '')
  ];
}
