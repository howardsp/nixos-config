# home/common/default.nix — Shared Home Manager configuration
{ config, lib, pkgs, username, host, ... }:
{
  imports = [
    ./shell
    ./editors
    ./git.nix
  ];

  home.username = username;
  home.stateVersion = "25.05";
  home.enableNixpkgsReleaseCheck = false;

  programs.home-manager.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
