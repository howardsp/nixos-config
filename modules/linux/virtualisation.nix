# modules/linux/virtualisation.nix — Docker + libvirt/KVM
{ config, lib, pkgs, ... }:
{
  # ── Docker ───────────────────────────────────────────────
  virtualisation.docker = {
    enable = true;
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };

  # ── QEMU/KVM (toggled by features.qemu.enable per-host) ─
  virtualisation.libvirtd.enable = lib.mkDefault false;
  programs.virt-manager.enable = lib.mkDefault false;
  virtualisation.spiceUSBRedirection.enable = lib.mkDefault false;
}
