# modules/linux/ollama.nix — Ollama local LLM server
#
# Toggle per-host with `features.ollama.enable = true;`.
# SECURITY: OLLAMA_HOST=0.0.0.0 binds the API to every interface so other
# LAN devices can use it. The NixOS firewall does NOT open port 11434 here,
# so remote access additionally requires a per-host firewall rule.
{ config, lib, pkgs-unstable, ... }:
{
  options.features.ollama.enable =
    lib.mkEnableOption "OLLAMA" // { default = false; };

  config = lib.mkIf config.features.ollama.enable {

    services.ollama = {
      package = pkgs-unstable.ollama;
      enable = true;
      environmentVariables = {
        OLLAMA_REASONING_PARSER = "deepseek_r1"; 
        OLLAMA_HOST = "0.0.0.0"; # Allow access from other devices on your network
      };
    };
  };
}
