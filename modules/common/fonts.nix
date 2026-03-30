# modules/common/fonts.nix — Font packages for all platforms
{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    # ── Nerd Fonts (programming & terminal) ─────────────
    meslo-lgs-nf
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    nerd-fonts.hack
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term
    nerd-fonts.iosevka-term-slab
    nerd-fonts.meslo-lg
    nerd-fonts.sauce-code-pro
    nerd-fonts.dejavu-sans-mono
    nerd-fonts.droid-sans-mono
    nerd-fonts.ubuntu
    nerd-fonts.ubuntu-mono
    nerd-fonts.ubuntu-sans
    nerd-fonts.victor-mono
    nerd-fonts.zed-mono
    nerd-fonts.geist-mono
    nerd-fonts.monaspace
    nerd-fonts.caskaydia-cove
    nerd-fonts.caskaydia-mono
    nerd-fonts.inconsolata
    nerd-fonts.roboto-mono
    nerd-fonts.liberation
    nerd-fonts.symbols-only
    nerd-fonts.noto
    nerd-fonts._3270
    nerd-fonts.agave
    nerd-fonts.anonymice
    nerd-fonts.arimo
    nerd-fonts.aurulent-sans-mono
    nerd-fonts.bigblue-terminal
    nerd-fonts.bitstream-vera-sans-mono
    nerd-fonts.blex-mono
    nerd-fonts.code-new-roman
    nerd-fonts.comic-shanns-mono
    nerd-fonts.commit-mono
    nerd-fonts.cousine
    nerd-fonts.d2coding
    nerd-fonts.daddy-time-mono
    nerd-fonts.departure-mono
    nerd-fonts.envy-code-r
    nerd-fonts.fantasque-sans-mono
    nerd-fonts.go-mono
    nerd-fonts.gohufont
    nerd-fonts.hasklug
    nerd-fonts.heavy-data
    nerd-fonts.hurmit
    nerd-fonts.im-writing
    nerd-fonts.inconsolata-go
    nerd-fonts.inconsolata-lgc
    nerd-fonts.intone-mono
    nerd-fonts.lekton
    nerd-fonts.lilex
    nerd-fonts.martian-mono
    nerd-fonts.monofur
    nerd-fonts.monoid
    nerd-fonts.mononoki
    nerd-fonts.open-dyslexic
    nerd-fonts.overpass
    nerd-fonts.profont
    nerd-fonts.proggy-clean-tt
    nerd-fonts.recursive-mono
    nerd-fonts.shure-tech-mono
    nerd-fonts.space-mono
    nerd-fonts.terminess-ttf
    nerd-fonts.tinos

    # ── Standard Font Families ──────────────────────────
    liberation_ttf
    freefont_ttf
    carlito                     # Microsoft Calibri equivalent
    noto-fonts
    noto-fonts-cjk-sans         # Chinese, Japanese, Korean
    noto-fonts-color-emoji    
    fira-code
    fira-code-symbols
    fira-mono
    hack-font
    corefonts                   # Microsoft free fonts
    ubuntu-classic
    roboto
    cascadia-code
    mplus-outline-fonts.githubRelease
    open-sans
    dina-font
    proggyfonts
    emacs-all-the-icons-fonts
  ];
}
