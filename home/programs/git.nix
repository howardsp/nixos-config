{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    
    userName = "Howard Spector";
    userEmail = "howard@example.com";  # Change this!
    
    extraConfig = {
      init.defaultBranch = "main";
      
      # Core settings
      core = {
        editor = "vim";
        autocrlf = "input";
      };
      
      # Push settings
      push = {
        default = "simple";
        autoSetupRemote = true;
      };
      
      # Pull settings
      pull.rebase = false;
      
      # Diff and merge
      diff.colorMoved = "default";
      merge.conflictstyle = "diff3";
      
      # Performance
      core.preloadindex = true;
      core.fscache = true;
      
      # UI
      color.ui = "auto";
    };
    
    # Aliases
    aliases = {
      co = "checkout";
      br = "branch";
      ci = "commit";
      st = "status";
      unstage = "reset HEAD --";
      last = "log -1 HEAD";
      lg = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      undo = "reset --soft HEAD^";
    };
    
    # Delta for better diffs
    delta = {
      enable = true;
      options = {
        navigate = true;
        line-numbers = true;
        side-by-side = true;
      };
    };
    
    # Ignore patterns
    ignores = [
      "*~"
      "*.swp"
      "*.swo"
      ".DS_Store"
      ".direnv"
      ".envrc"
      "result"
      "result-*"
    ];
  };

  # GitHub CLI
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
      editor = "vim";
    };
  };
}
