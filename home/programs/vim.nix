{ config, lib, pkgs, ... }:

{
  programs.vim = {
    enable = true;
    
    settings = {
      background = "dark";
      number = true;
      relativenumber = true;
    };
    
    extraConfig = ''
      " Basic settings
      syntax on
      set encoding=utf-8
      set fileencoding=utf-8
      
      " Indentation
      set tabstop=4
      set shiftwidth=4
      set expandtab
      set smartindent
      set autoindent
      
      " Search
      set ignorecase
      set smartcase
      set incsearch
      set hlsearch
      
      " UI
      set cursorline
      set wildmenu
      set showmatch
      set laststatus=2
      
      " Performance
      set lazyredraw
      set ttyfast
      
      " Backup and swap
      set nobackup
      set nowritebackup
      set noswapfile
      
      " Mouse support
      set mouse=a
      
      " Clipboard
      set clipboard=unnamedplus
      
      " Undo
      set undofile
      set undodir=~/.vim/undo
      set undolevels=1000
      set undoreload=10000
      
      " Key mappings
      let mapleader = " "
      
      " Clear search highlighting
      nnoremap <leader><space> :nohlsearch<CR>
      
      " Split navigation
      nnoremap <C-h> <C-w>h
      nnoremap <C-j> <C-w>j
      nnoremap <C-k> <C-w>k
      nnoremap <C-l> <C-w>l
      
      " Buffer navigation
      nnoremap <leader>bn :bnext<CR>
      nnoremap <leader>bp :bprevious<CR>
      nnoremap <leader>bd :bdelete<CR>
      
      " Save and quit shortcuts
      nnoremap <leader>w :w<CR>
      nnoremap <leader>q :q<CR>
      nnoremap <leader>x :x<CR>
    '';
  };

  # Neovim as an alternative
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    
    extraConfig = ''
      set number
      set relativenumber
      set ignorecase
      set smartcase
      set clipboard+=unnamedplus
    '';
    
    plugins = with pkgs.vimPlugins; [
      # UI
      vim-airline
      vim-airline-themes
      
      # Git integration
      vim-fugitive
      vim-gitgutter
      
      # File navigation
      nerdtree
      fzf-vim
      
      # Syntax
      vim-nix
      vim-markdown
      
      # Editing
      vim-surround
      vim-commentary
      auto-pairs
    ];
  };
}
