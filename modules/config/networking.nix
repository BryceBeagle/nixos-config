{delib, ...}:
delib.module {
  name = "networking";

  myconfig.always.persist.system.directories = [
    "/etc/NetworkManager/system-connections/"
  ];

  nixos.always = {
    networking.hostName = "poundcake";
    networking.networkmanager.enable = true;

    # Configure network settings
    users.users.ignormies.extraGroups = ["networkmanager"];
  };
}
