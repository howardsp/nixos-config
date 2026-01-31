# Troubleshooting Guide

Common issues and their solutions when using this NixOS configuration.

## Build Errors

### Error: "attribute 'X' missing"

**Problem**: A package or option doesn't exist in the version of nixpkgs you're using.

**Solution**:
```bash
# Update your flake inputs
nix flake update

# Or update just nixpkgs
nix flake lock --update-input nixpkgs
```

### Error: "infinite recursion encountered"

**Problem**: Circular dependency in your configuration.

**Solution**: Check for options that reference each other. Common causes:
- Imports that create a loop
- Options that depend on themselves

Look at the error traceback carefully to identify the cycle.

### Error: "builder for 'X' failed"

**Problem**: A package failed to build.

**Solutions**:
1. Check if the package is in cache: `nix-store --verify-path /nix/store/...`
2. Try building with more verbose output: `nixos-rebuild switch --show-trace`
3. Check if it's a known issue: https://github.com/NixOS/nixpkgs/issues
4. Try using a different version from unstable: `pkgs-unstable.packagename`

## System Won't Boot

### Stuck at boot

**Problem**: System hangs during boot.

**Solutions**:
1. Boot into previous generation from GRUB menu
2. Remove `quiet` from kernel params in `hosts/common.nix` to see boot messages
3. Check hardware configuration matches your system
4. Try removing recently added kernel modules

### Can't decrypt LUKS partition

**Problem**: Wrong password or corrupted header.

**Solutions**:
1. Try typing password slowly
2. Check if keyboard layout is correct (try US layout)
3. Boot from USB and attempt to decrypt manually
4. Check LUKS header health: `sudo cryptsetup luksDump /dev/sdXY`

## Desktop Environment Issues

### GNOME won't start

**Problem**: GDM fails to start or crashes.

**Solutions**:
```bash
# Check GDM status
sudo systemctl status gdm

# View logs
sudo journalctl -u gdm -b

# Try resetting dconf settings
dconf reset -f /
```

### Extensions not working

**Problem**: GNOME Shell extensions don't load.

**Solutions**:
1. Ensure extensions match your GNOME version
2. Restart GNOME Shell: Press `Alt+F2`, type `r`, press Enter
3. Check extension status: `gnome-extensions list`
4. Disable problematic extensions in `home/desktop/gnome.nix`

### Wayland issues

**Problem**: Applications don't work correctly under Wayland.

**Solutions**:
1. Force X11 session: Edit `/etc/gdm/custom.conf` and uncomment `WaylandEnable=false`
2. Or in your host config:
```nix
services.xserver.displayManager.gdm.wayland = false;
```

## Application Problems

### VS Code won't start

**Problem**: VS Code fails to launch or crashes.

**Solutions**:
```bash
# Run from terminal to see errors
code

# Reset VS Code settings
rm -rf ~/.config/Code/

# Check if it's a GPU issue, try software rendering
code --disable-gpu
```

### Firefox profile corrupted

**Problem**: Firefox won't start or has broken profile.

**Solutions**:
```bash
# Start Firefox profile manager
firefox -ProfileManager

# Create new profile or repair existing one
# Your bookmarks are usually safe in ~/.mozilla/
```

### Steam won't launch games

**Problem**: Games fail to start or crash immediately.

**Solutions**:
1. Enable Steam runtime: Right-click game → Properties → Force compatibility tool
2. Check Proton logs: `~/.steam/steam/logs/`
3. Try different Proton version
4. Ensure 32-bit graphics drivers are enabled (check `modules/gaming/default.nix`)

## Network Issues

### No internet connection

**Problem**: Can't connect to network.

**Solutions**:
```bash
# Check network manager
sudo systemctl status NetworkManager

# Restart network manager
sudo systemctl restart NetworkManager

# Check if interface is up
ip link show

# For WiFi, use nmtui
nmtui
```

### DNS not resolving

**Problem**: Can ping IPs but not domain names.

**Solutions**:
```bash
# Check DNS servers
resolvectl status

# Try Google DNS temporarily
echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf

# Make permanent in your host config:
networking.nameservers = [ "8.8.8.8" "8.8.4.4" ];
```

## Docker Issues

### Permission denied

**Problem**: Can't connect to Docker daemon.

**Solutions**:
```bash
# Ensure you're in docker group
groups

# If not, rebuild system (should be automatic):
sudo nixos-rebuild switch

# Log out and back in for group changes to take effect
```

### Container networking problems

**Problem**: Containers can't access internet or each other.

**Solutions**:
```bash
# Check Docker network
docker network ls

# Restart Docker
sudo systemctl restart docker

# If using firewall, add docker0 to trusted interfaces:
networking.firewall.trustedInterfaces = [ "docker0" ];
```

## Home Manager Issues

### Conflicting declarations

**Problem**: Error about same option being defined multiple times.

**Solution**: Check your imports. Only import each file once. Use `mkForce` to override:
```nix
programs.git.userName = lib.mkForce "New Name";
```

### Settings not applying

**Problem**: Changed settings in home.nix but nothing happens.

**Solutions**:
```bash
# Rebuild just home-manager
home-manager switch --flake .

# Or full system rebuild
sudo nixos-rebuild switch --flake .

# Check what would change
home-manager build --flake .
nix store diff-closures ~/.local/state/home-manager/gcroots/current-home ./result
```

## Performance Issues

### System is slow

**Solutions**:
1. Check CPU governor (should be "performance" for desktop):
```bash
cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
```

2. Clean up store:
```bash
sudo nix-collect-garbage -d
sudo nix-store --optimize
```

3. Check for disk space:
```bash
duf
```

4. Monitor processes:
```bash
btop
```

### High memory usage

**Solutions**:
1. Check what's using memory:
```bash
btop
```

2. Disable unused services:
```nix
services.someservice.enable = false;
```

3. Consider reducing Nix's max-jobs if compiling uses too much RAM:
```nix
nix.settings.max-jobs = 2;  # Instead of auto
```

## Common Mistakes

### 1. Forgetting to rebuild

After editing configuration, you must rebuild:
```bash
sudo nixos-rebuild switch --flake .
```

### 2. Wrong path in imports

Ensure paths are relative to the file doing the importing:
```nix
imports = [ ./modules/desktop/gnome.nix ];  # Correct
imports = [ modules/desktop/gnome.nix ];    # Wrong
```

### 3. Using wrong package set

Remember:
- `pkgs` = stable packages
- `pkgs-unstable` = bleeding edge packages

### 4. Not updating hardware.nix

After hardware changes, regenerate:
```bash
nixos-generate-config --show-hardware-config > hosts/hostname/hardware.nix
```

### 5. Forgetting to add files to git

NixOS only sees files tracked by git in your flake directory:
```bash
git add .
```

## Getting Help

### Check logs

```bash
# System logs
sudo journalctl -b              # This boot
sudo journalctl -u service-name # Specific service

# Home Manager logs
journalctl --user -b

# Nix build logs
nix log /nix/store/...-some-package
```

### Debugging builds

```bash
# Build with trace
sudo nixos-rebuild switch --show-trace

# Check what's being built
sudo nixos-rebuild build --dry-run

# See evaluation trace
nix eval --show-trace .#nixosConfigurations.hostname.config.system.build.toplevel
```

### Resources

- NixOS Manual: https://nixos.org/manual/nixos/stable/
- NixOS Wiki: https://nixos.wiki/
- Home Manager Manual: https://nix-community.github.io/home-manager/
- Search Options: https://search.nixos.org/
- Discourse Forum: https://discourse.nixos.org/
- Reddit: r/NixOS
- IRC/Matrix: #nixos on libera.chat / Matrix

### When asking for help

Include:
1. Exact error message
2. Relevant configuration
3. Output of `nixos-version`
4. What you've already tried

Don't share your entire config unless asked - focus on the specific problem.
