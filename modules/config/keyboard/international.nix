{
  delib,
  inputs,
  lib,
  ...
}:
delib.module {
  name = "keyboard";

  nixos.always = {myconfig, ...}:
    {
      console.keyMap = "us";
    }
    // lib.mkIf myconfig.desktop-environment.enable {
      # tbh, I'm not sure if this actually requires a display server to use?
      # This affects the TTYs too...
      services.xserver.xkb.options = "compose:ralt,ctrl:nocaps";
    };

  home.always = {myconfig, ...}:
    lib.mkIf myconfig.desktop-environment.gnome.enable {
      dconf.settings = with inputs.home-manager.lib.hm.gvariant; {
        "org/gnome/desktop/input-sources" = {
          sources = [(mkTuple ["xkb" "us"])];

          # This duplicates the config in `xserver.xkb.options` above due to (I think)
          # an upstream bug:
          # https://github.com/BryceBeagle/nixos-config/issues/163
          # https://discourse.nixos.org/t/suddenly-setting-caps-escape-in-xkb-settings-does-not-work-anymore/64714/6
          xkb-options = ["compose:ralt" "ctrl:nocaps"];
        };
      };
    };
}
