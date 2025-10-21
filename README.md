# NixOS

```shell
$ nixos-rebuild --flake . switch
```

# nix-darwin

## Installation

First build/installation:

```shell
$ nix \
  --extra-experimental-features "nix-command flakes" \
  run nix-darwin/master#darwin-rebuild -- --flake . switch
```

## Rebuilding

```shell
$ darwin-rebuild --flake . switch
```
