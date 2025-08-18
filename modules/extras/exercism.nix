{delib, ...}:
delib.module {
  name = "extras.exercism";

  options = delib.singleEnableOption false;

  myconfig.ifEnabled.impermanence.user.files = [
    # Exercism stores its API token here
    ".config/exercism/user.json"
  ];
}
