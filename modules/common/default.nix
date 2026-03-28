# modules/common/default.nix — Settings shared by ALL hosts (Linux + macOS)
{ config, lib, pkgs, host, username, fullname, ... }:
{
  imports = [
    ./packages.nix
    ./fonts.nix
    ./nix-settings.nix
    ./shell-scripts.nix
  ];

  # ── Flakes & Nix CLI ─────────────────────────────────────
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # ── ZSH as default shell ─────────────────────────────────
  programs.zsh.enable = true;

  # ── Editor ───────────────────────────────────────────────
  environment.variables.EDITOR = "vim";
  environment.variables.DIRENV_WARN_TIMEOUT = "5m";
}
