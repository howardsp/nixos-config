# modules/common/packages.nix — Cross-platform packages
#
# ┌─────────────────────────────────────────────────────────┐
# │  ADD NEW PACKAGES HERE — just append to the list below  │
# │  These install on EVERY host (Linux + macOS).           │
# │  For Linux-only → modules/linux/packages.nix            │
# │  For macOS-only → modules/darwin/packages.nix           │
# └─────────────────────────────────────────────────────────┘
{ pkgs, pkgs-unstable, ... }:
{
  environment.systemPackages = with pkgs; [
    # ── Shells & Prompts ────────────────────────────────
    bash
    zsh
    zsh-powerlevel10k

    # ── Core CLI Tools ──────────────────────────────────
    vim
    neovim
    wget
    curl
    zip
    unzip
    htop
    coreutils-full
    fastfetch
    git
    tldr

    # ── Modern CLI Replacements ─────────────────────────
    bat                 # better cat
    duf                 # better df
    du-dust             # better du
    fd                  # better find
    ripgrep             # better grep (rga searches all file types)
    choose              # better cut/awk basics
    sd                  # better sed
    difftastic          # diff that understands code
    fzf                 # fuzzy finder
    gtop                # visual system monitor

    # ── Dev Tools ───────────────────────────────────────
    python3
    gcc
    cmake
    perl
    direnv

    # ── Networking & HTTP ───────────────────────────────
    httpie              # friendly HTTP client
    curlie              # curl with httpie UX

    # ── Data Processing ─────────────────────────────────
    miller              # sed/awk/cut for CSV/JSON/etc
    jq                  # JSON processor
    yq                  # YAML processor

    # ── File Watchers & Automation ──────────────────────
    entr                # run commands on file changes

    # ── AI & Productivity ───────────────────────────────
    mods                # command line AI

    # ── OCR & Image Processing ──────────────────────────
    tesseract           # OCR engine
    conjure             # image transformation

    # ── Nix-Specific Tools ──────────────────────────────
    home-manager
    nvd                 # nix version diff
    nh                  # nix helper
    nix-output-monitor  # pretty build output

    # ── Synergy (KVM) ───────────────────────────────────
    synergy
  ];
}
