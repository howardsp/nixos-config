# hosts/igloo/default.nix — Howard's primary workstation
{ config, lib, pkgs, ... }:
{
  imports = [
    ./hardware.nix
  ];

  # ── Feature Toggles ──────────────────────────────────────
  features.qemu.enable = true;
  features.citrix.enable = false;
  features.ollama.enable = true;

  # ── Kernel ───────────────────────────────────────────────
  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_6_19;
  boot.kernelModules = [ "kvm-amd" "cpufreq_performance" "v4l2loopback" ];
  boot.extraModulePackages = [ pkgs.linuxKernel.packages.linux_6_19.v4l2loopback ];

  # ── Boot ─────────────────────────────────────────────────
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # ── Performance: AMD-specific ────────────────────────────
  boot.kernelParams = [
    "zswap.enabled=1"
    "amd_pstate=active"
    "mitigations=off"         # max perf, disable Spectre/Meltdown mitigations
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
