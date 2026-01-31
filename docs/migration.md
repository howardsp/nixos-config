# Migration Guide

Guide for migrating from your old NixOS configuration to this new structure.

## Overview of Changes

### Structure

**Old Configuration:**
```
├── flake.nix (complex helper functions)
├── flakehelper.nix
├── hosts/
│   └── hostname.nix (mixed concerns)
├── system/
│   └── default.nix (monolithic)
└── users/
    └── username-hostname.nix
```

**New Configuration:**
```
├── flake.nix (simple, clean)
├── hosts/
│   ├── common.nix (shared across hosts)
│   └── hostname/ (per-host)
│       ├── default.nix (host config)
│       └── hardware.nix (hardware only)
├── modules/ (reusable modules)
│   ├── desktop/
│   ├── development/
│   └── virtualization/
└── home/ (home-manager)
    ├── programs/ (app configs)
    └── desktop/ (DE settings)
```

### Key Improvements

1. **Modular Design**: Features are in separate, toggleable modules
2. **Clear Separation**: System vs user configuration clearly separated
3. **Modern Practices**: Uses current NixOS patterns and best practices
4. **Better Abstraction**: Options-based modules instead of imperative code
5. **Standard Home Manager**: Integrated properly with flake inputs

## Migration Steps

### 1. Backup Current System

```bash
# List current generations
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

# Note your current generation number
sudo nixos-rebuild list-generations
```

### 2. Clone New Configuration

```bash
# Backup old config
cp -r ~/.config/nixos ~/.config/nixos.old

# Clone new config
git clone <this-repo> ~/.config/nixos-new
cd ~/.config/nixos-new
```

### 3. Generate Hardware Configuration

```bash
# Generate for your current machine
sudo nixos-generate-config --show-hardware-config > hosts/$(hostname)/hardware.nix

# Create the directory first
mkdir -p hosts/$(hostname)
```

### 4. Port Your Settings

#### Host Configuration

**Old (hosts/igloo.nix):**
```nix
{
  __qemu.enable = true;
  __synergy-server.enable = true;
  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_6_18;
}
```

**New (hosts/desktop/default.nix):**
```nix
{
  imports = [
    ./hardware.nix
    ../modules/desktop/gnome.nix
    ../modules/virtualization
  ];

  modules = {
    desktop.gnome.enable = true;
    virtualization.libvirt.enable = true;
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;
}
```

#### User Configuration

**Old (users/howardsp-igloo.nix):**
```nix
{
  imports = [
    ./common.nix
    ./linux/emacs
    ./linux/gnome-settings
    ./linux/vscode
  ];
}
```

**New (home/default.nix):**
```nix
{
  imports = [
    ./programs  # Includes vscode, vim, git, etc.
    ./desktop   # Includes GNOME settings
  ];
  
  # Your custom additions here
}
```

### 5. Port Package Lists

**Old:**
```nix
environment.systemPackages = with pkgs; [
  stacer xfce.thunar rofi jdk insync syncthing
  # ... many more
];
```

**New:**

System packages in `hosts/hostname/default.nix`:
```nix
environment.systemPackages = with pkgs; [
  # Host-specific packages only
  firefox
  discord
];
```

User packages in `home/default.nix`:
```nix
home.packages = with pkgs; [
  # User-specific packages
  telegram-desktop
  obsidian
];
```

### 6. Port GNOME Settings

**Old (users/linux/gnome-settings/extensions.nix):**
```nix
dconf.settings = {
  "org/gnome/shell" = {
    enabled-extensions = [
      "dash-to-panel@jderose9.github.com"
      "arcmenu@arcmenu.com"
      # ...
    ];
  };
};
```

**New (home/desktop/gnome.nix):**

Already includes common extensions. Add your custom ones:
```nix
dconf.settings = {
  "org/gnome/shell" = {
    enabled-extensions = config.dconf.settings."org/gnome/shell".enabled-extensions ++ [
      "your-custom-extension@example.com"
    ];
  };
  
  # Your custom settings
  "org/gnome/shell/extensions/dash-to-panel" = {
    panel-positions = "{\"0\":\"TOP\"}";
  };
};
```

### 7. Test the New Configuration

```bash
# Build without switching
sudo nixos-rebuild build --flake ~/.config/nixos-new#$(hostname)

# Check what would change
nvd diff /run/current-system ./result

# Test (temporary, until reboot)
sudo nixos-rebuild test --flake ~/.config/nixos-new#$(hostname)

# If everything works, switch
sudo nixos-rebuild switch --flake ~/.config/nixos-new#$(hostname)
```

### 8. Rollback if Needed

If something goes wrong:

1. **Reboot** and select previous generation from boot menu
2. Or manually rollback:
```bash
sudo nix-env --rollback --profile /nix/var/nix/profiles/system
sudo /nix/var/nix/profiles/system/bin/switch-to-configuration switch
```

## Mapping Old Options to New

| Old Option | New Option | Location |
|------------|-----------|----------|
| `__qemu.enable` | `modules.virtualization.libvirt.enable` | `modules/virtualization/` |
| `__synergy-server.enable` | (Not yet implemented) | Add to system packages |
| `__photo.enable` | Add packages to `home.packages` | `home/default.nix` |
| `__webcam.enable` | Add packages to host | `hosts/hostname/default.nix` |
| `__browsers.enable` | Add to host packages | `hosts/hostname/default.nix` |
| `__office.enable` | Add to user packages | `home/default.nix` |
| `mySteamConfig.enable` | `modules.gaming.steam.enable` | `modules/gaming/` |

## Features Not Yet Implemented

These features from your old config need manual addition:

1. **Synergy Server/Client**: Add packages manually
2. **Insync**: Add to home packages and create autostart (see old config)
3. **Citrix**: Add to system packages in host config
4. **Custom Keybindings**: Add to `home/desktop/gnome.nix`
5. **Rofi Configuration**: Create `home/programs/rofi.nix`

### Example: Adding Synergy

**System packages:**
```nix
# In hosts/hostname/default.nix
environment.systemPackages = with pkgs; [
  synergy
];

# For server:
services.synergy.server.enable = true;
networking.firewall.allowedTCPPorts = [ 24800 ];
```

**Home autostart:**
```nix
# In home/default.nix
home.file.".config/autostart/synergy.desktop".text = ''
  [Desktop Entry]
  Type=Application
  Name=Synergy Client
  Exec=synergyc server-hostname
  X-GNOME-Autostart-enabled=true
'';
```

## Cleaning Up After Migration

Once you're confident the new config works:

```bash
# Remove old configuration
rm -rf ~/.config/nixos.old

# Clean up old generations
sudo nix-collect-garbage -d

# Optimize store
sudo nix-store --optimize
```

## Tips for Smooth Migration

1. **Don't rush**: Test each change before committing
2. **Keep old config**: Don't delete until new one is proven
3. **Document changes**: Note what you change in git commits
4. **One host at a time**: Migrate one machine fully before others
5. **Use git**: Commit after each working change

## Getting Help

If you encounter issues during migration:

1. Check the [Troubleshooting Guide](./troubleshooting.md)
2. Compare with your old config for missing pieces
3. Check NixOS Discourse for similar migrations
4. Ask in #nixos IRC/Matrix with specific errors

## Benefits of New Structure

After migration, you'll have:

- ✅ Cleaner, more maintainable code
- ✅ Easier to add/remove features
- ✅ Better separation of concerns
- ✅ Modern NixOS patterns
- ✅ Easier to share parts of config
- ✅ Simpler per-host customization
- ✅ Standard home-manager integration
