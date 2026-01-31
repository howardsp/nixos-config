{ config, lib, pkgs, hostname, pkgs-cashyos, ... }:

{
  # Boot configuration
  boot = {
    # Use CashyOS optimized kernel for better performance
    kernelPackages = pkgs-cashyos.linuxPackages_cachyos;
    
    # Kernel parameters for performance
    kernelParams = [
      # CPU scheduler optimizations
      "sched_bore=1"
      
      # Performance governor by default
      "cpufreq.default_governor=performance"
    ];
    
    # Bootloader configuration
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 3;
    };
    
    # Clean /tmp on boot
    tmp.cleanOnBoot = true;
  };

  # Networking
  networking = {
    hostName = hostname;
    networkmanager.enable = true;
    
    # Firewall
    firewall = {
      enable = true;
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
    };
  };

  # Timezone and locale
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Nix configuration
  nix = {
    # Enable flakes and nix-command
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      
      # Trusted users for binary cache access
      trusted-users = [ "root" "@wheel" ];
      
      # Substituters
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://cachyos.org/lix"
      ];
      
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cachyos.org:PY1r/W3XPaNG0f3G8t8s3ubgVs0sZzGrfFLTePtl76c="
      ];
    };
    
    # Automatic garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System packages available to all users
  environment.systemPackages = with pkgs; [
    # Essential tools
    vim
    wget
    curl
    git
    
    # System monitoring
    htop
    btop
    
    # File management
    unzip
    zip
    p7zip
    
    # Network tools
    dnsutils
    nmap
    
    # Build tools
    gcc
    gnumake
    
    # Modern CLI replacements
    ripgrep  # Better grep
    fd       # Better find
    bat      # Better cat
    eza      # Better ls
    duf      # Better df
    bottom   # Better top
  ];

  # Shell configuration
  programs = {
    # Zsh
    zsh.enable = true;
    
    # Command-not-found with nix-index
    command-not-found.enable = false;
    nix-index = {
      enable = true;
      enableZshIntegration = true;
    };
    
    # Direnv for per-directory environments
    direnv.enable = true;
  };

  # Security
  security = {
    # Sudo configuration
    sudo = {
      enable = true;
      wheelNeedsPassword = true;
    };
    
    # Polkit (for GUI privilege escalation)
    polkit.enable = true;
    
    # Real-time kit (for audio)
    rtkit.enable = true;
  };

  # Services
  services = {
    # SSH
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };
    
    # Printing (CUPS)
    printing = {
      enable = true;
      drivers = with pkgs; [ gutenprint hplip ];
    };
    
    # Avahi for network discovery
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    
    # Firmware updates
    fwupd.enable = true;
  };

  # Hardware
  hardware = {
    # Enable all firmware
    enableRedistributableFirmware = true;
    
    # Bluetooth
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  # User account
  users.users.howardsp = {
    isNormalUser = true;
    description = "Howard Spector";
    extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
    shell = pkgs.zsh;
  };

  # System state version (don't change after initial install)
  system.stateVersion = "24.11";
}
