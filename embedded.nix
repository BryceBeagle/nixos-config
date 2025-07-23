{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    waveforms
  ];

  services.udev.packages = with pkgs; [ 
    stlink
    adept2-runtime
  ];

  # TODO: Abstract away user-specific configuration
  users.users.ignormies.extraGroups = [
    # Talk to serial devices (e.g. MCUs)
    "dialout"
  ];
}
