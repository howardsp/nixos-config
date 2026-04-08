# modules/darwin/homebrew.nix — Homebrew casks & Mac App Store apps
#
# ┌─────────────────────────────────────────────────────────┐
# │  ADD macOS GUI APPS HERE                                │
# │  Casks = GUI apps from Homebrew                         │
# │  Brews = CLI tools better installed via Homebrew        │
# │  masApps = Mac App Store (need app ID from `mas search`)│
# └─────────────────────────────────────────────────────────┘
{ ... }:
{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";       # Remove apps not listed here
      upgrade = true;
    };

    brews = [
      "openjdk"      
      "deskflow"
    ];

    casks = [
      # Communication
      "telegram"
      "zoom"
      "webex"

      # Browsers
      "google-chrome"
      "firefox"
      "brave-browser"
      "microsoft-edge"

      # Productivity
      "microsoft-office"
      "visual-studio-code"
      "citrix-workspace"
      "insync"
      "dropbox"
      "iterm2"
      "bitwarden"

      # System Utilities
      "unnaturalscrollwheels"
      "bettertouchtool"
      "aldente"                    # Battery management
      "topnotch"                   # Notch hider
      "karabiner-elements"         # Keyboard remapping
      "notunes"                    # Prevent Music from launching
      "monitorcontrol"             # External display brightness
    ];

    masApps = {      
      "amphetamine" = 937984704;
    };
  };
}
