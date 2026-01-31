{
  description = "Modern NixOS configuration with home-manager";

  inputs = {
    # Use stable channel by default
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    
    # Unstable for latest packages when needed
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    
    # Home Manager for user-level configuration
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Hardware-specific configurations
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    
    # Hyprland for modern Wayland compositor (optional)
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, nixos-hardware, ... }@inputs:
    let
      # System architecture
      system = "x86_64-linux";
      
      # Helper to create system configurations
      mkSystem = hostname: extraModules:
        nixpkgs.lib.nixosSystem {
          inherit system;
          
          specialArgs = {
            inherit inputs system hostname;
            # Expose unstable packages
            pkgs-unstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          };
          
          modules = [
            # Host-specific configuration
            ./hosts/${hostname}
            
            # Common configuration
            ./hosts/common.nix
            
            # Home Manager integration
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit inputs hostname;
                  pkgs-unstable = import nixpkgs-unstable {
                    inherit system;
                    config.allowUnfree = true;
                  };
                };
                users.howardsp = import ./home;
              };
            }
          ] ++ extraModules;
        };
    in
    {
      # NixOS configurations
      nixosConfigurations = {
        # Desktop workstation
        desktop = mkSystem "desktop" [ ];
        
        # Laptop
        laptop = mkSystem "laptop" [
          nixos-hardware.nixosModules.common-pc-laptop
          nixos-hardware.nixosModules.common-pc-laptop-ssd
        ];
        
        # Virtual machine
        vm = mkSystem "vm" [
          nixos-hardware.nixosModules.common-pc
        ];
      };

      # Development shell for working on this configuration
      devShells.${system}.default = nixpkgs.legacyPackages.${system}.mkShell {
        name = "nixos-config";
        packages = with nixpkgs.legacyPackages.${system}; [
          git
          nixfmt-rfc-style
          nil # Nix language server
          nix-tree
          nvd # Nix version diff
        ];
      };
    };
}
