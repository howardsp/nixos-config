# home/common/git.nix — Git configuration
{ pkgs, fullname, ... }:
{
  programs.git = {
    enable = true;
    userName = fullname;
    # userEmail is set per-host or you can set it here:
    # userEmail = "howard@example.com";

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      core.autocrlf = "input";
      merge.conflictstyle = "diff3";
      diff.colorMoved = "default";
      rerere.enabled = true;         # remember conflict resolutions
    };

    delta = {
      enable = true;                 # fancy diff viewer
      options = {
        navigate = true;
        side-by-side = true;
        line-numbers = true;
      };
    };

    aliases = {
      st = "status";
      co = "checkout";
      br = "branch";
      lg = "log --graph --oneline --decorate -20";
      unstage = "reset HEAD --";
      last = "log -1 HEAD";
      amend = "commit --amend --no-edit";
    };
  };
}
