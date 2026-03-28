# home/linux/emacs.nix — Emacs with GTK and essential packages
{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-gtk;
    extraPackages = epkgs: [
      epkgs.use-package
      epkgs.nix-mode
      epkgs.all-the-icons
    ];
  };

  home.file.".emacs.d/init.el".source = ./emacs.d/init.el;
}
