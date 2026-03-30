# home/common/shell/default.nix — Shell configuration (bash + zsh)
{ config, lib, pkgs, host, ... }:
{
  # ── Bash ─────────────────────────────────────────────────
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      export PATH=$PATH:~/workspace/scripts
      eval "$(direnv hook bash)"
      eval "$(fzf --bash)"
      fastfetch
    '';
    shellAliases = {
      fzvim = "vim $(fzf --preview='bat --color=always {}')";
      bat   = "bat --color=always";
      ll    = "ls -lptr --color";
      ls    = "ls --color";
    };
  };

  # ── Zsh ──────────────────────────────────────────────────
  home.file.".p10kconfig".source = ./p10k;

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    plugins = [{
      name = "zsh-history-substring-search";
      file = "zsh-history-substring-search.zsh";
      src = pkgs.fetchFromGitHub {
        owner = "zsh-users";
        repo = "zsh-history-substring-search";
        rev = "v1.0.2";
        sha256 = "0y8va5kc2ram38hbk2cibkk64ffrabfv1sh4xm7pjspsba9n5p1y";
      };
    }];

    sessionVariables = {
      POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD = "true";
    };

    history = {
      size = 50000;                  # bumped from 10k
      save = 50000;
      ignoreDups = true;
      ignoreAllDups = true;
      ignoreSpace = true;
      extended = true;               # timestamps in history
      share = true;                  # share across sessions
    };

    shellAliases = {
      bat       = "bat --color=always";
      ll        = "ls -lptr --color";
      ls        = "ls --color";
      nixdarwin = "nix run nix-darwin -- build --flake .#${host}";
      nixdarwin-activate = "sudo darwin-rebuild activate";
      nixlinux  = "sudo nixos-rebuild switch --flake .#$(uname -n)";
      nixclean  = "nix-collect-garbage --delete-older-than 30d --max-jobs auto";
      # Git shortcuts
      gs  = "git status";
      gd  = "git diff";
      gl  = "git log --oneline -20";
      gp  = "git push";
      ga  = "git add";
      gc  = "git commit";
      gco = "git checkout";
    };
        # was initExtra
    initContent = ''
      fastfetch
      export PATH=$PATH:~/workspace/scripts
      eval "$(direnv hook zsh)"
      eval "$(fzf --zsh)"
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      source ~/.p10kconfig
    '';
  };

  # ── Direnv ───────────────────────────────────────────────
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;        # cached nix shells
  };

  # ── FZF ──────────────────────────────────────────────────
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    defaultOptions = [
      "--height 40%"
      "--layout=reverse"
      "--border"
    ];
  };

  # ── Bat (better cat) ────────────────────────────────────
  programs.bat = {
    enable = true;
    config = {
      theme = "TwoDark";
      style = "numbers,changes,header";
    };
  };
}
