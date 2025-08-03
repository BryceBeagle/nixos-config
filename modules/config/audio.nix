{delib, ...}:
delib.module {
  name = "audio";

  nixos.always = {
    services = {
      # Enable sound.
      pipewire = {
        enable = true;

        # Use as primary audio server, in lieu of pulseaudio/jack
        audio.enable = true;
      };
    };
  };
}
