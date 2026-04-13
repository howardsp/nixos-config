# modules/linux/containers.nix — OCI container workloads
{ config, lib, pkgs, ... }:
{
  options.features.ollama.enable =
    lib.mkEnableOption "OLLAMA" // { default = false; };

  config = lib.mkIf config.features.ollama.enable {

    services.ollama = {
      enable = true;
      environmentVariables = {
        OLLAMA_REASONING_PARSER = "deepseek_r1"; 
        OLLAMA_HOST = "0.0.0.0"; # Allow access from other devices on your network
      };
    };
  };
}
