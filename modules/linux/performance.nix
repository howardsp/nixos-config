# modules/linux/performance.nix — System-wide performance tuning
#
# Optimized for desktop responsiveness and throughput on AMD systems.
# Hosts override kernel version and CPU-specific params in their own config.
{ config, lib, pkgs, ... }:
{
  # ── Kernel Parameters ────────────────────────────────────
  # Per-host configs set kernelPackages and CPU-specific params.
  # These are universal performance-oriented defaults.
  boot.kernel.sysctl = {
    # ── Virtual Memory ──────────────────────────────────
    "vm.swappiness" = 10;                    # Prefer RAM over swap
    "vm.vfs_cache_pressure" = 50;            # Keep dentries/inodes cached
    "vm.dirty_ratio" = 10;                   # Start writeback at 10% dirty
    "vm.dirty_background_ratio" = 5;         # Background writeback at 5%
    "vm.page-cluster" = 0;                   # Read one page at a time from swap (SSD friendly)

    # ── Network Stack ───────────────────────────────────
    "net.core.rmem_max" = 16777216;          # 16MB receive buffer
    "net.core.wmem_max" = 16777216;          # 16MB send buffer
    "net.core.netdev_max_backlog" = 5000;    # Increase packet backlog
    "net.ipv4.tcp_fastopen" = 3;             # TCP Fast Open (client + server)
    "net.ipv4.tcp_slow_start_after_idle" = 0;# Don't reset cwnd after idle
    "net.ipv4.tcp_mtu_probing" = 1;          # Enable MTU probing

    # ── File System ─────────────────────────────────────
    "fs.inotify.max_user_watches" = 1048576; # For large projects (VS Code, etc.)
    "fs.file-max" = 2097152;                 # Max open file descriptors
  };

  # ── I/O Scheduler ────────────────────────────────────────
  # Use mq-deadline for NVMe/SSD, best for desktop latency
  services.udev.extraRules = ''
    ACTION=="add|change", KERNEL=="sd[a-z]|nvme[0-9]*", ATTR{queue/scheduler}="mq-deadline"
  '';

  # ── tmpfs on /tmp ────────────────────────────────────────
  boot.tmp.useTmpfs = true;
  boot.tmp.tmpfsSize = "50%";    # Use RAM for /tmp — massive speedup for builds

  # ── zram swap (compressed RAM swap) ──────────────────────
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;          # Use up to 50% of RAM as compressed swap
  };

  # ── Earlyoom — prevent OOM lockups ───────────────────────
  services.earlyoom = {
    enable = true;
    freeMemThreshold = 5;        # Kill when < 5% RAM free
    freeSwapThreshold = 10;      # Kill when < 10% swap free
  };

  # ── Power Management defaults ────────────────────────────
  # Hosts can override cpuFreqGovernor to "performance" in their own config.
  # This sets a sane desktop default.
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";

  # ── systemd Journal ──────────────────────────────────────
  services.journald.extraConfig = ''
    SystemMaxUse=500M
    MaxRetentionSec=1month
  '';
}
