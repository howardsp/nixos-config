{ config, lib, pkgs, ... }:

{
  imports = [
    ./git.nix
    ./zsh.nix
    ./vim.nix
    ./vscode.nix
    ./firefox.nix
    ./terminal.nix
  ];
}
