# home/darwin/default.nix — macOS-specific Home Manager config
{ config, lib, pkgs, username, host, ... }:
{
  imports = [
    ../common
  ];

  # macOS home directory convention
  # (home.homeDirectory is set automatically by nix-darwin's HM module)
}
