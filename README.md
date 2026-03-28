# Howard's Nix Configuration

Cross-platform Nix setup for NixOS (Linux) and macOS (nix-darwin) with Home Manager,
flakes, and performance-first defaults.

## Quick Start

```bash
# Linux — rebuild current host
sudo nixos-rebuild switch --flake .#$(hostname)

# macOS — rebuild current host
nix run nix-darwin -- switch --flake .#nixbookair

# Update all inputs
nix flake update

# Clean old generations (30+ days)
sudo nix-collect-garbage --delete-older-than 30d

# Diff last two generations
nixdiff
```

## Directory Structure

```
.
├── flake.nix                  # Entry point — defines all hosts
├── lib/
│   └── default.nix            # mkLinuxHost / mkDarwinHost builders
│
├── hosts/                     # Per-machine config (kernel, boot, toggles)
│   ├── igloo/
│   │   ├── default.nix        # Host config + feature toggles
│   │   └── hardware.nix       # nixos-generate-config output
│   ├── avalanche/
│   ├── virtualnix/
│   └── nixbookair/
│
├── modules/                   # System-level configuration
│   ├── common/                # ← Shared across Linux + macOS
│   │   ├── packages.nix       # ★ ADD CROSS-PLATFORM PACKAGES HERE
│   │   ├── fonts.nix
│   │   ├── nix-settings.nix
│   │   └── shell-scripts.nix
│   ├── linux/                 # ← NixOS only
│   │   ├── packages.nix       # ★ ADD LINUX-ONLY PACKAGES HERE
│   │   ├── gnome.nix
│   │   ├── performance.nix    # Kernel tuning, zram, earlyoom, sysctl
│   │   ├── security.nix
│   │   ├── sound.nix
│   │   ├── printing.nix
│   │   ├── networking.nix
│   │   ├── virtualisation.nix
│   │   ├── steam.nix
│   │   └── containers.nix
│   └── darwin/                # ← macOS only
│       ├── packages.nix       # ★ ADD macOS NIX PACKAGES HERE
│       └── homebrew.nix       # ★ ADD HOMEBREW CASKS/BREWS HERE
│
└── home/                      # User-level (Home Manager)
    ├── common/                # ← Shared across Linux + macOS
    │   ├── shell/             # bash, zsh, p10k, fzf, bat, direnv
    │   ├── editors/           # neovim
    │   └── git.nix
    ├── linux/                 # emacs, vscode, gnome-settings, rofi
    └── darwin/                # (macOS-specific HM overrides)
```

## Adding Packages

| What you want                    | Where to add it                      |
|----------------------------------|--------------------------------------|
| CLI tool for both platforms      | `modules/common/packages.nix`        |
| Linux GUI app                    | `modules/linux/packages.nix`         |
| macOS app via Nix                | `modules/darwin/packages.nix`        |
| macOS app via Homebrew Cask      | `modules/darwin/homebrew.nix`        |
| Mac App Store app                | `modules/darwin/homebrew.nix`        |
| GNOME extension                  | `modules/linux/gnome.nix`            |
| Font                             | `modules/common/fonts.nix`           |
| VS Code extension                | `home/linux/vscode.nix`              |

## Adding a New Host

### Linux
1. Create `hosts/<name>/default.nix` with boot/kernel config
2. Run `nixos-generate-config` and save as `hosts/<name>/hardware.nix`
3. Add to `flake.nix`: `<name> = lib.mkLinuxHost { host = "<name>"; };`

### macOS
1. Create `hosts/<name>/default.nix` (can be empty for defaults)
2. Add to `flake.nix`: `<name> = lib.mkDarwinHost { host = "<name>"; };`

## Feature Toggles

Per-host feature flags in `hosts/<name>/default.nix`:

```nix
features.qemu.enable = true;            # QEMU/KVM virtualisation
features.steam.enable = false;           # Steam gaming
features.synergy-server.enable = true;   # Synergy KVM server
features.homeassistant.enable = true;    # Home Assistant container
features.webcam.enable = false;          # Webcam + Zoom/Webex
features.citrix.enable = false;          # Citrix Workspace
features.office.enable = true;           # LibreOffice + OnlyOffice
features.browsers.enable = true;         # Brave, Firefox, Chrome, Edge
features.photo.enable = true;            # VLC, GIMP, Krita, etc.
```

## Performance Optimizations

The `modules/linux/performance.nix` module applies these automatically:

- **CPU**: `performance` governor, AMD P-State active mode
- **Memory**: swappiness=10, zram compressed swap (zstd, 50% RAM)
- **I/O**: mq-deadline scheduler, tmpfs on /tmp (50% RAM)
- **Network**: TCP Fast Open, enlarged buffers, MTU probing
- **OOM Protection**: earlyoom kills at 5% free RAM
- **Filesystem**: 1M inotify watches, 2M max file descriptors
- **Kernel**: Per-host `mitigations=off` for max throughput
- **Journal**: Capped at 500MB, 1 month retention
