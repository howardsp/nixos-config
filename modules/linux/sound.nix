# modules/linux/sound.nix — PipeWire audio stack (replaces PulseAudio)
{ config, pkgs, ... }:
{
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;          # realtime scheduling for audio

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;            # 32-bit app compat (Steam, Wine)
    pulse.enable = true;                 # PulseAudio compat layer
    wireplumber.enable = true;           # session manager
  };
}
