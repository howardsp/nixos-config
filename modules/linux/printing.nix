# modules/linux/printing.nix — CUPS printing + network printer discovery
{ pkgs, ... }:
{
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      gutenprint
      gutenprintBin
      cnijfilter2
      canon-cups-ufr2
    ];
  };

  # Network printer auto-discovery via mDNS
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
