# home/linux/citrix.nix — Keep Citrix keyboard settings sane after each session
#
# Citrix overwrites wfclient.ini on exit, reverting KeyboardEventMode and
# KeyboardSyncMode. A systemd path unit watches the file and patches it back
# immediately after any write.
{ lib, pkgs, ... }:

let
  patchScript = pkgs.writeShellScript "citrix-wfclient-patch" ''
    ini="$HOME/.ICAClient/wfclient.ini"
    [ -f "$ini" ] || exit 0
    ${lib.getExe pkgs.gnused} -i \
      -e 's/^KeyboardEventMode\s*=.*/KeyboardEventMode = Scancode/' \
      -e 's/^KeyboardSyncMode\s*=.*/KeyboardSyncMode = Dynamic/' \
      "$ini"
  '';
in
{
  systemd.user.paths.citrix-wfclient-patch = {
    Unit.Description = "Watch Citrix wfclient.ini for changes";
    Path.PathModified = "%h/.ICAClient/wfclient.ini";
    Install.WantedBy = [ "default.target" ];
  };

  systemd.user.services.citrix-wfclient-patch = {
    Unit.Description = "Patch Citrix wfclient.ini keyboard settings";
    Service = {
      Type = "oneshot";
      ExecStart = "${patchScript}";
    };
  };

  # Also fix on every `nixos-rebuild switch` in case the file is already wrong
  home.activation.patchCitrixWfclient = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ini="$HOME/.ICAClient/wfclient.ini"
    if [ -f "$ini" ]; then
      ${pkgs.gnused}/bin/sed -i \
        -e 's/^KeyboardEventMode\s*=.*/KeyboardEventMode = Scancode/' \
        -e 's/^KeyboardSyncMode\s*=.*/KeyboardSyncMode = Dynamic/' \
        "$ini"
    fi
  '';
}
