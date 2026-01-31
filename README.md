# Modern NixOS Configuration

A clean, modular NixOS configuration supporting multiple machines with home-manager integration.

## 🎯 Design Philosophy

- **Single-user desktop focus**: Optimized for personal workstation use
- **Modular architecture**: Easy to enable/disable features per machine
- **Declarative everything**: All system state in version control
- **Modern defaults**: Current best practices and tooling

## 📁 Structure

```
.
├── flake.nix              # Main entry point
├── hosts/                 # Per-machine configurations
│   ├── desktop/          
│   ├── laptop/           
│   └── common.nix         # Shared host settings
├── modules/               # System-level modules
│   ├── desktop/           # Desktop environment configs
│   ├── hardware/          # Hardware-specific settings
│   └── services/          # System services
├── home/                  # Home-manager configurations
│   ├── programs/          # Application configs
│   ├── desktop/           # Desktop environment user settings
│   └── default.nix        # Base user configuration
└── overlays/              # Package overlays and modifications
```

## 🚀 Quick Start

### Initial Installation

1. **Clone this repository:**
   ```bash
   git clone <your-repo-url> ~/.config/nixos
   cd ~/.config/nixos
   ```

2. **Generate hardware configuration:**
   ```bash
   nixos-generate-config --show-hardware-config > hosts/<hostname>/hardware.nix
   ```

3. **Create host configuration:**
   ```bash
   cp hosts/desktop/default.nix hosts/<hostname>/default.nix
   # Edit hosts/<hostname>/default.nix to customize
   ```

4. **Build and switch:**
   ```bash
   sudo nixos-rebuild switch --flake .#<hostname>
   ```

### Daily Usage

```bash
# Update all inputs
nix flake update

# Rebuild current host
sudo nixos-rebuild switch --flake .

# Test changes without switching
sudo nixos-rebuild test --flake .

# Build specific host
sudo nixos-rebuild switch --flake .#<hostname>
```

### Cleaning Up

```bash
# Remove old generations older than 7 days
sudo nix-collect-garbage --delete-older-than 7d

# Optimize nix store
nix-store --optimize
```

## 🖥️ Supported Configurations

### Desktop Environments

- **GNOME**: Full-featured, batteries-included (default)
- **KDE Plasma**: Highly customizable Qt-based environment
- **Hyprland**: Modern Wayland compositor (experimental)

### Common Features

- ✅ Zsh with starship prompt
- ✅ Modern CLI tools (ripgrep, fd, bat, eza)
- ✅ VS Code with essential extensions
- ✅ Firefox with privacy hardening
- ✅ Automatic system updates (optional)
- ✅ Tailscale VPN integration
- ✅ Docker and podman support
- ✅ Development environments (Nix, Python, Node.js, Rust)

## 🔧 Customization

### Adding a New Machine

1. Create directory: `mkdir -p hosts/<hostname>`
2. Copy template: `cp hosts/desktop/default.nix hosts/<hostname>/default.nix`
3. Generate hardware config: `nixos-generate-config --show-hardware-config > hosts/<hostname>/hardware.nix`
4. Customize settings in `hosts/<hostname>/default.nix`
5. Add to `flake.nix`:
   ```nix
   nixosConfigurations.<hostname> = nixpkgs.lib.nixosSystem {
     # ...
   };
   ```

### Enabling/Disabling Features

Edit your host configuration (`hosts/<hostname>/default.nix`):

```nix
{
  # Desktop environment
  modules.desktop.gnome.enable = true;
  
  # Development tools
  modules.development = {
    enable = true;
    languages = [ "python" "rust" "nodejs" ];
  };
  
  # Gaming
  modules.gaming.steam.enable = true;
  
  # Virtualization
  modules.virtualization = {
    docker.enable = true;
    libvirt.enable = true;
  };
}
```

## 📚 Documentation

- [Module Options](./docs/modules.md) - All available module options
- [Home Manager](./docs/home-manager.md) - User-level configuration
- [Troubleshooting](./docs/troubleshooting.md) - Common issues and solutions
- [Migration Guide](./docs/migration.md) - Migrating from old configurations

## 🤝 Contributing

This is a personal configuration, but suggestions and improvements are welcome!

## 📝 License

MIT License - Feel free to use as a template for your own configurations.
