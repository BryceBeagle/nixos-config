{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "extras.egpu";

  options.extras.egpu = with delib; {
    enable = boolOption false;

    vendorId = noDefault (strOption null);
    deviceId = noDefault (strOption null);
  };

  myconfig.ifEnabled = {cfg, ...}: {
    # Forward the extras config to the egpu config
    egpu = {
      enable = true;

      vendorId = cfg.vendorId;
      deviceId = cfg.deviceId;
    };
  };

  nixos.ifEnabled = {
    # Helper tool to check the status of GPUs
    # Use switcherooctl to inspect
    services.switcherooControl.enable = true;
  };

  home.ifEnabled.home.packages = with pkgs; [
    intel-gpu-tools # lsgpu
    mesa-demos # glxinfo, glxgears
    pciutils # lspci
  ];
}
