{
  delib,
  inputs,
  ...
}:
delib.module {
  name = "nix";

  nixos.always.nix = {
    channel.enable = false;

    # Not sure if this is strictly required, but recommended by
    # https://github.com/nix-community/nixd/blob/main/nixd/docs/configuration.md
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];

    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      flake-registry = "";
    };
  };
}
