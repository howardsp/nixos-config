# home/linux/emacs.nix — Emacs with GTK, all packages managed by Nix
#
# All packages are declared here — never use package-install in init.el.
# Emacs customizations are written to ~/.emacs.d/custom.el (mutable),
# not to init.el (which is a read-only store symlink).
{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-gtk;
    extraPackages = epkgs: with epkgs; [
      # Core
      use-package          # declarative package config (bundled in Emacs 29+, kept for compat)

      # Languages
      nix-mode             # Nix syntax
      cmake-mode           # CMake syntax

      # UI
      all-the-icons        # icon fonts for modeline / dired
    ];
  };

  # init.el — managed by Nix (read-only symlink is fine; we never write to it)
  home.file.".emacs.d/init.el".source = ./emacs.d/init.el;
}
