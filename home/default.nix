{ config, lib, pkgs, pkgs-unstable, hostname, ... }:

{
  imports = [
    ./programs
    ./desktop
  ];

  # Home Manager settings
  home = {
    username = "howardsp";
    homeDirectory = "/home/howardsp";
    stateVersion = "24.11";
    
    # Session variables
    sessionVariables = {
      EDITOR = "vim";
      VISUAL = "vim";
      BROWSER = "firefox";
    };
    
    # User packages
    packages = with pkgs; [
      # Archive tools
      unzip
      zip
      p7zip
      unrar
      
      # Network tools
      wget
      curl
      aria2
      
      # Media
      mpv
      yt-dlp
      
      # PDF tools
      zathura
      evince
      
      # Productivity
      obsidian
      
      # Communication
      telegram-desktop
    ];
  };

  # Let Home Manager manage itself
  programs.home-manager.enable = true;

  # XDG user directories
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      
      desktop = "${config.home.homeDirectory}/Desktop";
      documents = "${config.home.homeDirectory}/Documents";
      download = "${config.home.homeDirectory}/Downloads";
      music = "${config.home.homeDirectory}/Music";
      pictures = "${config.home.homeDirectory}/Pictures";
      videos = "${config.home.homeDirectory}/Videos";
      templates = "${config.home.homeDirectory}/Templates";
      publicShare = "${config.home.homeDirectory}/Public";
    };
  };

  # GTK theme
  gtk = {
    enable = true;
    
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  # Qt theme
  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "adwaita-dark";
  };
}
