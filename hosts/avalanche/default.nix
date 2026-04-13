# hosts/avalanche/default.nix — Howard's second workstation
{ config, lib, pkgs, ... }:
{
  imports = [
    ./hardware.nix
  ];

  

  # ── Kernel ───────────────────────────────────────────────
  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_6_18;
  boot.kernelModules = [ "kvm-amd" "cpufreq_performance" "v4l2loopback" ];
  boot.extraModulePackages = [ pkgs.linuxKernel.packages.linux_6_18.v4l2loopback ];

  # ── Boot ─────────────────────────────────────────────────
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # ── Performance: AMD-specific ────────────────────────────
  boot.kernelParams = [
    "zswap.enabled=1"
    "amd_pstate=active"
    "mitigations=off"
  ];
  powerManagement.cpuFreqGovernor = "performance";

  # ── Virtualisation ───────────────────────────────────────
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  networking.firewall.trustedInterfaces = [ "virbr0" ];

  
  # ── Firewall ─────────────────────────────────────────────
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 8123 24800 ];
  networking.firewall.allowedUDPPorts = [ 24800 ];
}
