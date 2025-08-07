{delib, ...}:
delib.module {
  name = "projects.exercism";

  options = delib.singleEnableOption false;

  myconfig.ifEnabled.persist.user.files = [
    # Exercism stores its API token here
    ".config/exercism/user.json"
  ];
}
