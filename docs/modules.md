# Module Options Reference

Complete reference for all available module options in this NixOS configuration.

## Desktop Environments

### GNOME (`modules.desktop.gnome`)

```nix
modules.desktop.gnome = {
  enable = true;              # Enable GNOME desktop
  extensions = true;          # Install popular extensions
  fractionalScaling = false;  # Enable fractional scaling (HiDPI)
};
```

**Included Extensions (when enabled):**
- AppIndicator Support
- Dash to Dock
- Blur my Shell
- Vitals (system monitor)
- Caffeine (prevent auto-suspend)
- Clipboard Indicator
- Just Perfection

## Development Tools

### Development Module (`modules.development`)

```nix
modules.development = {
  enable = true;
  languages = [ "python" "nodejs" "rust" "go" "java" "cpp" ];
};
```

**Supported Languages:**

- **Python**: Python 3.12, pip, virtualenv, poetry, ruff
- **Node.js**: Node 20, npm, pnpm, yarn, TypeScript
- **Rust**: rustc, cargo, rustfmt, clippy, rust-analyzer
- **Go**: go, gopls, golangci-lint
- **Java**: JDK 21, Maven, Gradle
- **C++**: gcc, clang, clang-tools, lldb, gdb

**Included Tools:**
- Git + Git LFS + GitHub CLI
- VS Code + Neovim
- Build tools (make, cmake, ninja)
- Container tools (docker-compose, podman-compose)
- Terminal (tmux, alacritty)
- API testing (Postman)
- Database tools (DBeaver)

## Gaming

### Steam (`modules.gaming.steam`)

```nix
modules.gaming.steam.enable = true;
```

Includes:
- Steam with remote play support
- Proton GE for better compatibility
- Lutris and Heroic game launchers
- MangoHud performance overlay
- GameScope compositor

### GameMode (`modules.gaming.gamemode`)

```nix
modules.gaming.gamemode.enable = true;
```

Automatically optimizes system performance when games are running.

## Virtualization

### Docker (`modules.virtualization.docker`)

```nix
modules.virtualization.docker.enable = true;
```

- Docker with rootless mode (more secure)
- Docker Compose
- LazyDocker (terminal UI)
- Automatically adds user to docker group

### QEMU/KVM (`modules.virtualization.libvirt`)

```nix
modules.virtualization.libvirt.enable = true;
```

Includes:
- QEMU/KVM with UEFI support
- virt-manager GUI
- SPICE and USB redirection
- Windows guest tools (virtio drivers)

## Common System Features

All systems automatically include:

### Security
- Sudo with wheel group
- Polkit for GUI privilege escalation
- SSH with key-only authentication
- Automatic firmware updates (fwupd)

### Services
- CUPS printing with drivers
- Avahi for network discovery
- Bluetooth support

### CLI Tools
- Modern replacements: ripgrep, fd, bat, eza, duf, bottom
- System monitoring: htop, btop
- File management: zip, unzip, p7zip
- Network tools: dnsutils, nmap

### Shell
- Zsh with starship prompt
- Command completion with nix-index
- Direnv for per-directory environments

## Home Manager Features

### Shell (Zsh)

Includes:
- Starship prompt with git integration
- Syntax highlighting and autosuggestions
- FZF fuzzy finder
- Zoxide smart directory jumping
- Direnv integration
- Vi mode

**Useful Aliases:**
```bash
rebuild    # Rebuild NixOS
update     # Update flake inputs
clean      # Garbage collect old generations
ls/ll/la   # Modern ls with eza
cat        # Better cat with bat
grep       # Better grep with ripgrep
find       # Better find with fd
```

### Git

Pre-configured with:
- Delta for better diffs
- Useful aliases (lg for graph, undo, etc.)
- GitHub CLI integration
- Reasonable defaults

### VS Code

Extensions included:
- Language support (Nix, Python, Rust, Go, C++)
- Web development (Tailwind, ESLint, Prettier)
- Git tools (GitLens, Git Graph)
- Productivity (spell checker, markdown)
- Themes (Catppuccin, Material Icons)

### Firefox

Features:
- Privacy-focused settings
- Tracking protection enabled
- Custom search engines for Nix packages and options
- Privacy extensions (uBlock Origin, Privacy Badger)
- Useful utilities (Bitwarden, SponsorBlock)

### Terminal Emulator (Alacritty)

- Catppuccin Mocha theme
- JetBrains Mono font with ligatures
- Vi mode cursor
- 10,000 line scrollback
- Smart keybindings

### GNOME Settings

Pre-configured:
- Dark theme
- 12-hour clock
- Hot corners disabled
- Battery percentage shown
- 4 static workspaces
- Useful keyboard shortcuts
- Privacy settings optimized

## Per-Host Customization

### Desktop Configuration

Optimal for powerful workstations:
- Performance CPU governor
- All development tools
- Gaming support
- Full virtualization stack

### Laptop Configuration

Battery-optimized:
- TLP power management
- Powertop enabled
- Battery charge thresholds
- Touchpad configuration
- Aggressive suspend settings
- Lighter package selection

### VM Configuration

Minimal and fast:
- No gaming or heavy tools
- SPICE and QEMU guest agents
- Basic desktop only
- Reduced services

## Customization Guide

### Adding a New Language

Edit your host's `default.nix`:

```nix
modules.development = {
  enable = true;
  languages = [ "python" "rust" ];  # Add your languages here
};
```

### Changing Desktop Environment

Replace GNOME import with another DE (when available):

```nix
imports = [
  ../modules/desktop/plasma.nix  # Instead of gnome.nix
];
```

### Adding Custom Packages

In your host's `default.nix`:

```nix
environment.systemPackages = with pkgs; [
  your-package-here
];
```

### Overriding Home Manager Settings

Create a per-host home configuration:

```nix
# In your host's default.nix
home-manager.users.howardsp = {
  # Your custom home-manager config
  programs.zsh.shellAliases = {
    myalias = "echo hello";
  };
};
```

## Advanced Configuration

### Using Unstable Packages

```nix
environment.systemPackages = [
  pkgs-unstable.some-bleeding-edge-package
];
```

### Adding System Services

```nix
services.myservice = {
  enable = true;
  # ... service configuration
};
```

### Custom Kernel Parameters

```nix
boot.kernelParams = [
  "quiet"
  "splash"
  "custom_param=value"
];
```

## Tips and Tricks

1. **Test before committing**: Use `sudo nixos-rebuild test` to try changes without making them permanent

2. **Diff generations**: Run `nvd diff /run/current-system /run/booted-system` to see what changed

3. **Rollback**: Reboot and select previous generation from boot menu if something breaks

4. **Clean up regularly**: Old generations take up space. Run `sudo nix-collect-garbage -d` monthly

5. **Check options**: Use `man configuration.nix` or search https://search.nixos.org/options

6. **Hardware-specific**: Check https://github.com/NixOS/nixos-hardware for your hardware model
