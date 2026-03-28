# home/linux/xscreensaver.nix — Screen saver / lock screen
{ ... }:
{
  services.xscreensaver = {
    enable = true;
    settings = {
      timeout = 15;
      mode = "blank";
    };
  };
}
