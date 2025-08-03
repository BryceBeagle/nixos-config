{delib, ...}:
delib.module {
  name = "networking";

  myconfig.always.persist.system.directories = [
    "/etc/NetworkManager/system-connections/"
  ];

  nixos.always = {myconfig, ...}: {
    networking.hostName = "poundcake";
    networking.networkmanager.enable = true;

    # Configure network settings
    users.users.${myconfig.user.username}.extraGroups = [
      "networkmanager"
    ];
  };
}
