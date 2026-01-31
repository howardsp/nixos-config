# Quick Start Guide

Get your new NixOS configuration up and running in minutes.

## Prerequisites

- Fresh NixOS installation (or existing system you want to reconfigure)
- This configuration repository
- Basic familiarity with terminal commands

## 5-Minute Setup

### 1. Clone This Repository

```bash
# Backup existing config if you have one
sudo mv /etc/nixos /etc/nixos.backup

# Clone this repo
git clone <your-repo-url> ~/.config/nixos

cd ~/.config/nixos
```

### 2. Choose Your Host Type

Pick the configuration that matches your hardware:

- **Desktop**: Powerful workstation `hosts/desktop/`
- **Laptop**: Portable computer `hosts/laptop/`
- **VM**: Virtual machine `hosts/vm/`

### 3. Generate Hardware Configuration

```bash
# Replace 'desktop' with your chosen host type
sudo nixos-generate-config --show-hardware-config > hosts/desktop/hardware.nix
```

### 4. Customize (Optional)

Edit `hosts/desktop/default.nix` to enable/disable features:

```nix
{
  # Uncomment and modify as needed
  modules = {
    desktop.gnome.enable = true;           # GNOME desktop
    development.enable = true;              # Dev tools
    development.languages = [ "python" ];   # Programming languages
    gaming.steam.enable = true;             # Gaming
    virtualization.docker.enable = true;    # Containers
  };
}
```

### 5. Update Personal Information

Edit `home/programs/git.nix`:

```nix
userName = "Your Name";
userEmail = "your.email@example.com";
```

### 6. Build and Switch

```bash
# First build (will take a while)
sudo nixos-rebuild switch --flake .#desktop

# Wait for it to complete...
```

### 7. Reboot

```bash
sudo reboot
```

## What You Get Out of the Box

### Desktop Environment (GNOME)
- Dark theme by default
- Popular extensions pre-installed
- Optimized settings
- Custom keybindings

### Terminal
- Zsh with Starship prompt
- Modern tools (eza, bat, ripgrep, fd)
- Syntax highlighting
- Auto-suggestions
- Smart history

### Editor
- VS Code with essential extensions
- Neovim with basic plugins
- Both configured and ready to use

### Browser
- Firefox with privacy extensions
- Tracking protection enabled
- Custom search shortcuts for Nix

### Development (if enabled)
- Git with useful aliases
- GitHub CLI
- Docker/Podman
- Your chosen programming languages

## First Steps After Login

### 1. Test Everything Works

```bash
# Check system info
fastfetch

# Test modern tools
ls          # Actually runs eza
cat README.md  # Actually runs bat
```

### 2. Install Additional Packages

```bash
# Edit your configuration
vim ~/.config/nixos/hosts/desktop/default.nix

# Add packages under environment.systemPackages
# Then rebuild:
sudo nixos-rebuild switch --flake ~/.config/nixos
```

### 3. Set Up Git

```bash
# Already configured! Just add your SSH key
ssh-keygen -t ed25519 -C "your.email@example.com"
cat ~/.ssh/id_ed25519.pub  # Add this to GitHub/GitLab
```

## Common First Tasks

### Add More Applications

Edit `hosts/desktop/default.nix`:

```nix
environment.systemPackages = with pkgs; [
  firefox      # Already included examples
  google-chrome
  
  # Add yours here:
  gimp
  inkscape
  thunderbird
];
```

Then rebuild:
```bash
sudo nixos-rebuild switch --flake ~/.config/nixos
```

### Enable More Dev Languages

Edit `hosts/desktop/default.nix`:

```nix
modules.development = {
  enable = true;
  languages = [
    "python"
    "nodejs"
    "rust"
    "go"
  ];
};
```

### Customize Shell Aliases

Edit `home/programs/zsh.nix` and add to `shellAliases`:

```nix
shellAliases = {
  # Existing aliases...
  
  # Add your own:
  myproject = "cd ~/projects/myproject";
  serve = "python -m http.server";
};
```

## Important Commands

```bash
# Rebuild system after changes
sudo nixos-rebuild switch --flake ~/.config/nixos

# Update all packages
nix flake update ~/.config/nixos
sudo nixos-rebuild switch --flake ~/.config/nixos

# Clean up old generations (frees disk space)
sudo nix-collect-garbage -d

# See what would change (without applying)
sudo nixos-rebuild build --flake ~/.config/nixos
nvd diff /run/current-system ./result

# Rollback if something breaks
# (Select previous generation at boot menu)
```

## Quick Customization Checklist

- [ ] Update git name and email
- [ ] Generate SSH key
- [ ] Set up Firefox sync
- [ ] Install additional applications
- [ ] Configure favorite apps
- [ ] Set up backup solution
- [ ] Review keybindings in GNOME
- [ ] Test all major applications

## If Something Goes Wrong

1. **System won't boot**: Select previous generation from boot menu
2. **Applications missing**: Check if they're in configuration and rebuild
3. **Settings not applying**: Make sure you ran `nixos-rebuild switch`
4. **Build errors**: See [Troubleshooting Guide](./troubleshooting.md)

## Next Steps

- Read the [Module Options](./modules.md) to see what's available
- Check out [Troubleshooting Guide](./troubleshooting.md) for common issues
- Review [Migration Guide](./migration.md) if coming from another config
- Explore `/home/programs/` to customize applications
- Join #nixos on Matrix/IRC for community help

## Tips

1. **Commit your changes**: Use git to track configuration changes
   ```bash
   git add .
   git commit -m "Added custom packages"
   ```

2. **Test before committing**: Use `sudo nixos-rebuild test` for temporary changes

3. **Keep it simple**: Start with defaults, customize gradually

4. **Document changes**: Add comments explaining why you made changes

5. **Back up**: Your configuration is in `~/.config/nixos` - back it up!

## Welcome to NixOS!

You now have a modern, maintainable NixOS configuration. Enjoy your deterministic, reproducible system!

For more help: https://nixos.org/learn.html
