{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "desktop-environment";

  options = delib.singleEnableOption true;

  nixos.ifEnabled.services = {
    displayManager.gdm.enable = true;

    xserver = {
      enable = true;

      excludePackages = [pkgs.xterm];
      # If xkbOptions are set in dconf config, they shadow this. Do not do.
      # https://discourse.nixos.org/t/setting-caps-lock-as-ctrl-not-working/11952
      xkb.options = "compose:ralt,ctrl:nocaps";
    };
  };
}
