{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.development;
in
{
  options.modules.development = {
    enable = mkEnableOption "Development tools and environments";
    
    languages = mkOption {
      type = types.listOf (types.enum [ "python" "nodejs" "rust" "go" "java" "cpp" ]);
      default = [ ];
      description = "Programming languages to install";
    };
  };

  config = mkIf cfg.enable {
    # Base development tools
    environment.systemPackages = with pkgs; [
      # Version control
      git
      git-lfs
      gh  # GitHub CLI
      
      # Editors
      neovim
      vscode
      
      # Build tools
      gnumake
      cmake
      ninja
      
      # Container tools
      docker-compose
      podman-compose
      
      # Terminal tools
      tmux
      alacritty
      
      # API testing
      postman
      
      # Database tools
      dbeaver-bin
    ]
    # Language-specific packages
    ++ optionals (elem "python" cfg.languages) [
      python312
      python312Packages.pip
      python312Packages.virtualenv
      poetry
      ruff  # Fast Python linter
    ]
    ++ optionals (elem "nodejs" cfg.languages) [
      nodejs_20
      nodePackages.npm
      nodePackages.pnpm
      nodePackages.yarn
      nodePackages.typescript
    ]
    ++ optionals (elem "rust" cfg.languages) [
      rustc
      cargo
      rustfmt
      clippy
      rust-analyzer
    ]
    ++ optionals (elem "go" cfg.languages) [
      go
      gopls
      golangci-lint
    ]
    ++ optionals (elem "java" cfg.languages) [
      jdk21
      maven
      gradle
    ]
    ++ optionals (elem "cpp" cfg.languages) [
      gcc
      clang
      clang-tools
      lldb
      gdb
    ];

    # Development services
    services = {
      # PostgreSQL
      postgresql = mkIf (elem "python" cfg.languages || elem "nodejs" cfg.languages) {
        enable = false;  # Disabled by default, enable per-host
      };
    };

    # Shell integrations
    programs = {
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };

    # User groups for development
    users.users.howardsp.extraGroups = [ "docker" ];
  };
}
