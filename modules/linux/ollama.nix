# modules/linux/containers.nix — OCI container workloads
{ config, lib, pkgs, pkgs-unstable, pkgs-llm-agents,... }:
{
  options.features.ollama.enable =
    lib.mkEnableOption "OLLAMA" // { default = false; };

  config = lib.mkIf config.features.ollama.enable {

    services.ollama = {
      package = pkgs-llm-agents.ollama;
      enable = true;
      environmentVariables = {
        OLLAMA_REASONING_PARSER = "deepseek_r1"; 
        OLLAMA_HOST = "0.0.0.0"; # Allow access from other devices on your network
      };
    };
  };
}
