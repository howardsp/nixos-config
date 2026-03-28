# home/common/editors/default.nix — Editor configurations
{ config, lib, pkgs, ... }:
{
  # ── Neovim ───────────────────────────────────────────────
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    extraConfig = ''
      set number
      set relativenumber
      set expandtab
      set tabstop=2
      set shiftwidth=2
      set smartindent
      set cursorline
      set ignorecase
      set smartcase
      set clipboard=unnamedplus
      set undofile
      set termguicolors
      set scrolloff=8
      set signcolumn=yes
      set updatetime=250
    '';
  };
}
