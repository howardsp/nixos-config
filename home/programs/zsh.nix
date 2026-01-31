{ config, lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    # History
    history = {
      size = 10000;
      save = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
      ignoreDups = true;
      ignoreSpace = true;
      share = true;
    };
    
    # Environment variables
    sessionVariables = {
      EDITOR = "vim";
      VISUAL = "vim";
    };
    
    # Shell options
    initExtra = ''
      # Case insensitive completion
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
      
      # Colored completion
      zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
      
      # VI mode
      bindkey -v
      export KEYTIMEOUT=1
      
      # Better history search
      bindkey '^R' history-incremental-search-backward
      bindkey '^[[A' history-search-backward
      bindkey '^[[B' history-search-forward
    '';
    
    # Aliases
    shellAliases = {
      # System
      rebuild = "sudo nixos-rebuild switch --flake ~/.config/nixos";
      update = "nix flake update ~/.config/nixos";
      clean = "sudo nix-collect-garbage -d";
      
      # Modern replacements
      ls = "eza --icons --group-directories-first";
      ll = "eza -l --icons --group-directories-first";
      la = "eza -la --icons --group-directories-first";
      tree = "eza --tree --icons";
      cat = "bat";
      grep = "rg";
      find = "fd";
      du = "duf";
      top = "btop";
      
      # Git shortcuts
      g = "git";
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git pull";
      
      # Shortcuts
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      
      # Safety
      cp = "cp -i";
      mv = "mv -i";
      rm = "rm -i";
    };
    
    # Plugins
    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.7.0";
          sha256 = "sha256-oQpYKBt0gmOSBgay2HgbXiDoZo5FoUKwyHN1QjyTtI4=";
        };
      }
    ];
  };

  # Starship prompt
  programs.starship = {
    enable = true;
    
    settings = {
      format = lib.concatStrings [
        "$username"
        "$hostname"
        "$directory"
        "$git_branch"
        "$git_state"
        "$git_status"
        "$cmd_duration"
        "$line_break"
        "$python"
        "$nodejs"
        "$rust"
        "$golang"
        "$nix_shell"
        "$character"
      ];
      
      directory = {
        truncation_length = 3;
        truncate_to_repo = true;
      };
      
      git_status = {
        disabled = false;
      };
      
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
      
      cmd_duration = {
        min_time = 500;
        format = "took [$duration](bold yellow)";
      };
      
      nix_shell = {
        format = "via [$symbol$state]($style) ";
        symbol = "❄️ ";
      };
    };
  };

  # Direnv integration
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  # Zoxide (smart cd)
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  # FZF
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    
    defaultCommand = "fd --type f --hidden --follow --exclude .git";
    defaultOptions = [
      "--height 40%"
      "--border"
      "--layout=reverse"
    ];
  };
}
