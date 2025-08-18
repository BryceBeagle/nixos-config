{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "extras.embedded";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {myconfig, ...}: {
    services.udev.packages = [pkgs.stlink];

    users.users.${myconfig.user.username}.extraGroups = [
      # Talk to serial devices (e.g. MCUs)
      "dialout"
    ];
  };
}
