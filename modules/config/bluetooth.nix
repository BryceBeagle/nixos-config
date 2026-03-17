{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "bluetooth";

  myconfig.always.impermanence.system.directories = [
    # Known devices are stored here
    "/var/lib/bluetooth/"
  ];

  home.always = {
    # Allow Bluetooth headsets to control media playback (e.g. with play/pause buttons)
    services.mpris-proxy.enable = pkgs.stdenv.hostPlatform.isLinux;
  };
}
