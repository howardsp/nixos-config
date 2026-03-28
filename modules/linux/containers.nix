# modules/linux/containers.nix — OCI container workloads
{ config, lib, pkgs, ... }:
{
  options.features.homeassistant.enable =
    lib.mkEnableOption "Home Assistant container" // { default = false; };

  config = lib.mkIf config.features.homeassistant.enable {
    virtualisation.oci-containers = {
      backend = "podman";
      containers.homeassistant = {
        volumes = [ "home-assistant:/config" ];
        environment.TZ = "America/New_York";
        image = "ghcr.io/home-assistant/home-assistant:stable";
        extraOptions = [
          "--network=host"
          "--device=/dev/ttyACM0:/dev/ttyACM0"
        ];
      };
    };
    networking.firewall.allowedTCPPorts = [ 8123 ];
  };
}
