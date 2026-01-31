{ config, lib, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    
    # Extensions
    extensions = with pkgs.vscode-extensions; [
      # Language support
      bbenoist.nix
      ms-python.python
      ms-python.vscode-pylance
      ms-vscode.cpptools
      rust-lang.rust-analyzer
      golang.go
      
      # Web development
      bradlc.vscode-tailwindcss
      dbaeumer.vscode-eslint
      esbenp.prettier-vscode
      
      # Git
      eamodio.gitlens
      mhutchie.git-graph
      
      # AI & Productivity
      anthropic.claude-vsx  # Claude AI Assistant
      streetsidesoftware.code-spell-checker
      yzhang.markdown-all-in-one
      
      # Themes
      pkief.material-icon-theme
      catppuccin.catppuccin-vsc
      
      # Tools
      ms-vscode-remote.remote-ssh
      ms-azuretools.vscode-docker
    ];
    
    # User settings
    userSettings = {
      # Editor
      "editor.fontSize" = 14;
      "editor.fontFamily" = "'JetBrains Mono', 'monospace'";
      "editor.fontLigatures" = true;
      "editor.lineNumbers" = "relative";
      "editor.rulers" = [ 80 120 ];
      "editor.minimap.enabled" = false;
      "editor.formatOnSave" = true;
      "editor.tabSize" = 4;
      "editor.insertSpaces" = true;
      "editor.wordWrap" = "on";
      "editor.cursorBlinking" = "smooth";
      "editor.cursorSmoothCaretAnimation" = "on";
      
      # Workbench
      "workbench.colorTheme" = "Catppuccin Mocha";
      "workbench.iconTheme" = "material-icon-theme";
      "workbench.startupEditor" = "none";
      
      # Files
      "files.autoSave" = "afterDelay";
      "files.autoSaveDelay" = 1000;
      "files.trimTrailingWhitespace" = true;
      "files.insertFinalNewline" = true;
      "files.exclude" = {
        "**/.git" = true;
        "**/.DS_Store" = true;
        "**/node_modules" = true;
        "**/__pycache__" = true;
        "**/.pytest_cache" = true;
      };
      
      # Terminal
      "terminal.integrated.fontSize" = 14;
      "terminal.integrated.fontFamily" = "'JetBrains Mono', 'monospace'";
      "terminal.integrated.defaultProfile.linux" = "zsh";
      
      # Git
      "git.confirmSync" = false;
      "git.autofetch" = true;
      "git.enableSmartCommit" = true;
      
      # Language-specific
      "[nix]" = {
        "editor.tabSize" = 2;
      };
      "[python]" = {
        "editor.defaultFormatter" = "ms-python.python";
        "editor.formatOnSave" = true;
      };
      "[javascript]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[typescript]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[json]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      
      # Nix
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      
      # Python
      "python.analysis.typeCheckingMode" = "basic";
      "python.linting.enabled" = true;
      
      # Claude AI Settings
      "claude.uriScheme" = "vscode";
      
      # Telemetry
      "telemetry.telemetryLevel" = "off";
    };
    
    # Keybindings
    keybindings = [
      {
        key = "ctrl+;";
        command = "workbench.action.terminal.toggleTerminal";
      }
    ];
  };
}
