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

# `home-manager`-only

```shell
# Can't just use `--extra-experimental-features` for some reason because some
# subprocesses are invoked without passing along that arg.
mkdir -p ~/.config/nix/
echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf

nix run home-manager/master -- --flake . switch
```
