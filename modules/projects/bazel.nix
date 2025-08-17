{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "projects.bazel";

  options = delib.singleEnableOption false;

  home.ifEnabled.home.packages = with pkgs; [
    # for buildozer/buildifier
    bazel-buildtools
  ];
}
