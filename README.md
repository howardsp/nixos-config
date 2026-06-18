# Howard's Nix Configuration

Cross-platform Nix setup for NixOS (Linux) and macOS (nix-darwin) with Home Manager,
flakes, and performance-first defaults.

## Hosts

| Host         | Platform        | Role                                  | Kernel / Notes                          |
|--------------|-----------------|---------------------------------------|-----------------------------------------|
| `ruger`      | x86_64-linux    | Primary AMD workstation               | linux 7.0, QEMU/KVM, Ollama             |
| `avalanche`  | x86_64-linux    | Second AMD workstation                | linux 6.18, QEMU/KVM, Ollama            |
| `virtualnix` | x86_64-linux    | VM test environment (GRUB, SPICE)     | Lightweight — Steam/webcam/Citrix off   |
| `nixbookair` | aarch64-darwin  | MacBook Air (Apple Silicon)           | nix-darwin + Homebrew via nix-homebrew  |

## Quick Start

```bash
# Linux — rebuild current host
sudo nixos-rebuild switch --flake .#$(hostname)

# macOS — rebuild current host
sudo darwin-rebuild switch --flake .#$(hostname)

# Update all inputs
nix flake update

# Roll back if a rebuild misbehaves (Linux)
sudo nixos-rebuild switch --rollback

# Clean old generations (30+ days; also runs automatically — see nix-settings.nix)
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
│   ├── ruger/
│   │   ├── default.nix        # Host config + feature toggles
│   │   └── hardware.nix       # nixos-generate-config output
│   ├── avalanche/
│   ├── virtualnix/
│   └── nixbookair/            # Darwin host (no hardware.nix needed)
│
├── overlays/                  # Overlay modules (see "Adding Overlays")
│
├── modules/                   # System-level configuration
│   ├── common/                # ← Shared across Linux + macOS
│   │   ├── packages.nix       # ★ ADD CROSS-PLATFORM PACKAGES HERE
│   │   ├── fonts.nix
│   │   ├── nix-settings.nix   # Daemon tuning, caches, GC
│   │   └── shell-scripts.nix  # project-init, project-show, nixdiff
│   ├── linux/                 # ← NixOS only
│   │   ├── packages.nix       # ★ ADD LINUX-ONLY PACKAGES HERE (+ feature toggles)
│   │   ├── gnome.nix          # GNOME desktop, extensions, themes
│   │   ├── performance.nix    # Kernel tuning, zram, earlyoom, sysctl
│   │   ├── security.nix       # sudo, kernel hardening, OpenSSH
│   │   ├── sound.nix          # PipeWire
│   │   ├── printing.nix       # CUPS + Avahi discovery
│   │   ├── networking.nix     # NetworkManager + firewall defaults
│   │   ├── virtualisation.nix # Docker + libvirt defaults
│   │   ├── ollama.nix         # Local LLM server (features.ollama)
│   │   ├── steam.nix          # Steam (features.steam)
│   │   └── containers.nix     # Home Assistant container (features.homeassistant)
│   └── darwin/                # ← macOS only
│       ├── packages.nix       # ★ ADD macOS NIX PACKAGES HERE
│       └── homebrew.nix       # ★ ADD HOMEBREW CASKS/BREWS HERE
│
└── home/                      # User-level (Home Manager)
    ├── common/                # ← Shared across Linux + macOS
    │   ├── shell/             # bash, zsh, p10k, fzf, bat
    │   ├── editors/           # neovim
    │   └── git.nix
    ├── linux/                 # emacs, vscode, gnome-settings, rofi, direnv
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

Package sets available in modules via `specialArgs` (see `lib/default.nix`):

| Arg                | Source                          | Use for                          |
|--------------------|---------------------------------|----------------------------------|
| `pkgs`             | nixpkgs (nixos-26.05)           | default                          |
| `pkgs-unstable`    | nixos-unstable                  | newer versions (nodejs, ollama…) |
| `pkgs-2505`        | nixos-25.05                     | pinned regressions (Citrix)      |
| `pkgs-llm-agents`  | numtide/llm-agents.nix          | claude-code, opencode, etc.      |

## Adding a New Host

### Linux
1. Create `hosts/<name>/default.nix` with boot/kernel config
2. Run `nixos-generate-config` and save as `hosts/<name>/hardware.nix`
3. Add to `flake.nix`: `<name> = lib.mkLinuxHost { host = "<name>"; };`

### macOS
1. Create `hosts/<name>/default.nix` (can be empty for defaults)
2. Add to `flake.nix`: `<name> = lib.mkDarwinHost { host = "<name>"; };`

## Adding Overlays

`overlays/default.nix` imports all overlay modules and receives the flake inputs.
To add an overlay, create `overlays/my-overlay.nix` and add it to the list in
`overlays/default.nix` (see `overlays/claude-desktop.nix` for the pattern).

## Feature Toggles

Per-host feature flags, set in `hosts/<name>/default.nix`. Defaults shown:

```nix
# Defined in modules/linux/packages.nix
features.browsers.enable = true;         # Brave, Firefox, Chrome, Edge
features.office.enable = true;           # LibreOffice, OnlyOffice, Inkscape
features.photo.enable = true;            # VLC, GIMP, Krita, mpv, etc.
features.webcam.enable = true;           # Zoom/Webex, OBS, v4l2loopback tools
features.citrix.enable = true;           # Citrix Workspace (pinned to 25.05 pkgs)
features.qemu.enable = false;            # QEMU/KVM client tools (virt-manager…)

# Defined in their own modules
features.steam.enable = true;            # Steam gaming (modules/linux/steam.nix)
features.homeassistant.enable = false;   # Home Assistant container (containers.nix)
features.ollama.enable = false;          # Ollama LLM server (ollama.nix)
```

Note: `features.qemu.enable` only installs the client tools. The libvirtd
service is enabled per-host (`virtualisation.libvirtd.enable = true;`).

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

## Security Posture (summary)

See `modules/linux/security.nix` for the full picture. Highlights:

- SSH: key-only auth, no root login, no X11 forwarding
- Firewall on by default; per-host port openings (24800/24801 = Deskflow KVM)
- sysctl hardening: dmesg/kptr restricted, ICMP redirects rejected, strict rp_filter
- **Deliberate trade-off**: `mitigations=off` on `ruger`/`avalanche` disables
  Spectre/Meltdown-class CPU mitigations for performance. Do not copy this to
  any machine that runs untrusted code or is exposed to the internet.
