# modules/common/packages.nix — Cross-platform packages
#
# ┌─────────────────────────────────────────────────────────┐
# │  ADD NEW PACKAGES HERE — just append to the list below  │
# │  These install on EVERY host (Linux + macOS).           │
# │  For Linux-only → modules/linux/packages.nix            │
# │  For macOS-only → modules/darwin/packages.nix           │
# └─────────────────────────────────────────────────────────┘
{ pkgs, pkgs-unstable, pkgs-llm-agents, ... }:
{
  environment.systemPackages = with pkgs; [
    # ── Shells & Prompts ────────────────────────────────
    bash                # bash shell
    zsh                 # Z shell
    zsh-powerlevel10k   # zsh theme with git/status prompt

    # ── Core CLI Tools ──────────────────────────────────
    vim                 # terminal text editor
    # neovim — installed via programs.neovim in home/common/editors/default.nix
    wget                # file downloader
    curl                # URL data transfer
    zip                 # zip compression
    unzip               # zip extraction
    htop                # interactive process viewer
    coreutils-full      # GNU core utilities (cp, mv, ls…)
    fastfetch           # system info display
    git                 # version control
    tldr                # simplified man pages

    # ── Modern CLI Replacements ─────────────────────────
    bat                 # better cat
    duf                 # better df
    dust                # better du
    fd                  # better find
    ripgrep             # better grep (searches all file types)
    choose              # better cut/awk for field selection
    sd                  # better sed
    difftastic          # diff that understands code syntax
    fzf                 # fuzzy finder
    gtop                # visual system monitor
    eza                 # better ls (colours, icons, git status)
    procs               # better ps (colour, tree view)
    zoxide              # smarter cd (learns frequent dirs)

    # ── Dev Tools ───────────────────────────────────────
    python3             # Python 3 runtime
    perl                # Perl runtime
    direnv              # per-directory environment variables
    nodejs              # JavaScript / TypeScript runtime
    go                  # Go toolchain
    shellcheck          # shell script linter
    shfmt               # shell script formatter

    # ── Networking & HTTP ───────────────────────────────
    httpie              # friendly HTTP client
    curlie              # curl with httpie UX
    dig                 # DNS lookup
    nmap                # network scanner
    wirelesstools       # wireless network utilities
    tcpdump             # packet capture
    tshark              # CLI Wireshark packet analyser
    iproute2            # network config (ip command)
    netcat-gnu          # read/write TCP/UDP connections
    mtr                 # combined ping + traceroute
    iperf3              # network bandwidth tester
    dnsutils            # DNS utilities (nslookup, etc.)
    iputils             # ping and other IP utilities
    iptables            # Linux firewall rules
    traceroute          # trace network path to host

    # ── Data Processing ─────────────────────────────────
    miller              # sed/awk/cut for CSV/JSON/etc
    jq                  # JSON processor
    yq                  # YAML processor

    # ── File Watchers & Automation ──────────────────────
    entr                # run commands on file changes

    # ── Media Processing ────────────────────────────────
    ffmpeg              # video/audio encoding and processing
    yt-dlp              # video downloader (YouTube and more)

    # ── Terminal Multiplexer ─────────────────────────────
    tmux                # terminal session/pane multiplexer

    # ── Git Extras ──────────────────────────────────────
    gh                  # GitHub CLI
    lazygit             # TUI git client

    # ── Security & Secrets ──────────────────────────────
    age                 # modern file encryption
    sops                # secrets management (pairs with age/gpg)

    # ── AI & Productivity ───────────────────────────────
    mods                            # command line AI
    pkgs-llm-agents.claude-code     # Anthropic CLI   (from https://github.com/numtide/llm-agents.nix)
    pkgs-llm-agents.opencode        # open-source coding agent
    pkgs-llm-agents.gemini-cli      # Google Gemini CLI
    pkgs-llm-agents.qwen-code       # Qwen coding agent

    # ── OCR & Image Processing ──────────────────────────
    tesseract           # OCR engine
    conjure             # image transformation (ImageMagick CLI)

    # ── Nix-Specific Tools ──────────────────────────────
    home-manager        # user environment manager
    nvd                 # nix version diff (compare generations)
    nh                  # nix helper (rebuild, clean, etc.)
    nix-output-monitor  # pretty build output
    nix-tree            # interactive nix closure explorer
    alejandra           # opinionated Nix code formatter
    deadnix             # find unused nix expressions
    statix              # Nix linter and suggestions

  ];
}
