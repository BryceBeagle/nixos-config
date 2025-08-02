{pkgs, ...}: {
  services.udev.packages = [pkgs.stlink];

  # TODO: Abstract away user-specific configuration
  users.users.ignormies.extraGroups = [
    # Talk to serial devices (e.g. MCUs)
    "dialout"
  ];
}
