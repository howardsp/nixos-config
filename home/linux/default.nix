# home/linux/default.nix — Linux-specific Home Manager config
{ config, lib, pkgs, username, host, ... }:
{
  imports = [
    ../common
    ./emacs.nix
    ./vscode.nix
    ./gnome-settings.nix
    ./desktop-entries.nix
    ./xscreensaver.nix
  ];

  home.homeDirectory = "/home/${username}";
}
