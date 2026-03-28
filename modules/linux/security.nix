# modules/linux/security.nix — Security hardening for desktop use
{ config, lib, pkgs, ... }:
{
  # ── Sudo ─────────────────────────────────────────────────
  security.sudo = {
    enable = true;
    wheelNeedsPassword = true;
    extraConfig = ''
      Defaults timestamp_timeout=30
      Defaults passwd_tries=5
    '';
  };

  # ── Kernel Hardening ─────────────────────────────────────
  boot.kernel.sysctl = {
    "kernel.dmesg_restrict" = 1;             # Non-root can't read dmesg
    "kernel.kptr_restrict" = 1;              # Hide kernel pointers
    "net.ipv4.conf.all.rp_filter" = 1;       # Strict reverse path filtering
    "net.ipv4.conf.default.rp_filter" = 1;
    "net.ipv4.conf.all.accept_redirects" = 0;
    "net.ipv4.conf.default.accept_redirects" = 0;
    "net.ipv6.conf.all.accept_redirects" = 0;
    "net.ipv6.conf.default.accept_redirects" = 0;
  };

  # ── Automatic Security Updates ───────────────────────────
  # system.autoUpgrade is intentionally NOT enabled — we use
  # manual `nixos-rebuild switch` with flake pinning instead.

  # ── OpenSSH ──────────────────────────────────────────────
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      X11Forwarding = false;
    };
  };
}
