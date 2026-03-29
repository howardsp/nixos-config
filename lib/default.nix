# lib/default.nix — Host builder functions
#
# These two functions (mkLinuxHost and mkDarwinHost) are the only
# abstraction layer. Everything else is plain modules.
{ inputs, nixpkgs, nixpkgs-unstable, home-manager, darwin,
  nix-homebrew, homebrew-bundle, homebrew-core, homebrew-cask, claude-desktop, llm-agents, ... }:
let
  # Build an unstable overlay so modules can use pkgs-unstable
  mkUnstable = system: import nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };

  # Shared specialArgs passed to every module
  mkSpecialArgs = { host, username, fullname, system }: {
    inherit host username fullname;
    pkgs-unstable = mkUnstable system;
    pkgs-llm-agents = llm-agents.packages.${system};
  };

  # Shared Home Manager settings
  mkHomeManager = { host, username, fullname, system, isDarwin ? false }: {
    home-manager.useUserPackages = true;
    home-manager.useGlobalPkgs = true;
    home-manager.users.${username} = import ../home/${if isDarwin then "darwin" else "linux"} ;
    home-manager.extraSpecialArgs = mkSpecialArgs { inherit host username fullname system; };
  };
in {
  # ── NixOS Host Builder ────────────────────────────────────
  mkLinuxHost = {
    host,
    username ? "howardsp",
    fullname ? "Howard Spector",
    system   ? "x86_64-linux",
  }: nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = mkSpecialArgs { inherit host username fullname system; };
    modules = [
      # Allow unfree
      { nixpkgs.config.allowUnfree = true; }
      

      # Host-specific config (imports hardware + toggles)
      ../hosts/${host}

      # Shared system modules
      ../modules/common
      ../modules/linux

      ({ pkgs, ... }: {
                nixpkgs.overlays = [ claude-desktop.overlays.default ];
                environment.systemPackages = [ pkgs.claude-desktop ];
        })

      # Home Manager as NixOS module
      home-manager.nixosModules.home-manager
      (mkHomeManager { inherit host username fullname system; })
    ];
  };

  # ── Darwin Host Builder ───────────────────────────────────
  mkDarwinHost = {
    host,
    username ? "howardsp",
    fullname ? "Howard Spector",
    system   ? "aarch64-darwin",
  }: darwin.lib.darwinSystem {
    inherit system;
    specialArgs = mkSpecialArgs { inherit host username fullname system; };
    modules = [
      # Allow unfree
      { nixpkgs.config.allowUnfree = true; }

      # Host-specific config
      ../hosts/${host}

      # Shared system modules
      ../modules/common
      ../modules/darwin

      # Home Manager as Darwin module
      home-manager.darwinModules.home-manager
      (mkHomeManager { inherit host username fullname system; isDarwin = true; })

      # Homebrew integration
      nix-homebrew.darwinModules.nix-homebrew
      {
        nix-homebrew = {
          enable = true;
          user = username;
          taps = {
            "homebrew/homebrew-core"   = homebrew-core;
            "homebrew/homebrew-cask"   = homebrew-cask;
            "homebrew/homebrew-bundle" = homebrew-bundle;
          };
          mutableTaps = false;
          autoMigrate = true;
        };
      }
    ];
  };
}
