{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.virtualization;
in
{
  options.modules.virtualization = {
    docker = {
      enable = mkEnableOption "Docker containerization";
    };
    
    libvirt = {
      enable = mkEnableOption "QEMU/KVM virtualization with virt-manager";
    };
  };

  config = mkMerge [
    # Docker configuration
    (mkIf cfg.docker.enable {
      virtualisation.docker = {
        enable = true;
        enableOnBoot = true;
        
        # Use overlay2 storage driver
        storageDriver = "overlay2";
        
        # Rootless mode (more secure)
        rootless = {
          enable = true;
          setSocketVariable = true;
        };
      };

      # Docker utilities
      environment.systemPackages = with pkgs; [
        docker-compose
        lazydocker  # Terminal UI for Docker
      ];

      users.users.howardsp.extraGroups = [ "docker" ];
    })

    # QEMU/KVM configuration
    (mkIf cfg.libvirt.enable {
      virtualisation.libvirtd = {
        enable = true;
        
        # UEFI support
        qemu = {
          package = pkgs.qemu_kvm;
          ovmf.enable = true;
          ovmf.packages = [ pkgs.OVMFFull.fd ];
          swtpm.enable = true;
        };
      };

      # Virtual machine management
      programs.virt-manager.enable = true;

      environment.systemPackages = with pkgs; [
        virt-viewer
        spice
        spice-gtk
        spice-protocol
        win-virtio
        win-spice
      ];

      users.users.howardsp.extraGroups = [ "libvirtd" ];

      # Enable USB redirection
      virtualisation.spiceUSBRedirection.enable = true;
    })
  ];
}
