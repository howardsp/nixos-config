# CashyOS Integration

This NixOS configuration now leverages **CashyOS** for performance-optimized packages and kernel.

## What is CashyOS?

CashyOS is a high-performance fork of Nixpkgs that provides:

- **Optimized Linux Kernel**: Compiled with performance-focused optimizations
- **BORE Scheduler**: Better scheduling algorithm for improved responsiveness
- **Precompiled Binaries**: Reduces compilation time for packages
- **Performance Tuning**: System-level performance optimizations

## Configuration Details

### Kernel

The configuration uses:
- **Kernel**: `linuxPackages_cachyos` from CashyOS instead of `linuxPackages_latest`
- **Scheduler**: BORE (Burst-Oriented Response Enhancer) enabled via `sched_bore=1`
- **CPU Governor**: Set to performance mode by default

### Binary Cache

Added CashyOS binary cache to speed up package downloads:
- Cache URL: `https://cachyos.org/lix`
- This provides pre-compiled packages, reducing local compilation time

## Usage

The configuration is automatically applied when building with:

```bash
# Rebuild system with CashyOS optimizations
sudo nixos-rebuild switch --flake .#hostname
```

### Using CashyOS Packages

In your Nix expressions, you can access CashyOS packages:

```nix
{ pkgs-cashyos, ... }:
{
  environment.systemPackages = with pkgs-cashyos; [
    # CashyOS optimized packages
    firefox
    chromium
  ];
}
```

## Performance Benefits

1. **Faster Boot**: Optimized kernel with BORE scheduler
2. **Better Responsiveness**: BORE scheduler reduces input latency
3. **Faster Package Downloads**: Binary cache reduces compilation
4. **System Performance**: General performance tweaks applied

## Notes

- Fallback to regular nixpkgs if CashyOS packages aren't available
- All existing configurations remain compatible
- Safe to combine with other performance tuning options

## References

- [CashyOS GitHub](https://github.com/CashyOS/nixpkgs)
- [BORE Scheduler](https://github.com/firelzrd/bore-scheduler)
