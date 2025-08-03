{delib, ...}:
delib.module {
  name = "locale";

  nixos.always = {
    i18n.defaultLocale = "en_US.UTF-8";
    time.timeZone = "America/Los_Angeles";
  };
}
