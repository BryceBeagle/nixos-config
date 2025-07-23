{
  inputs = {
    # https://discourse.nixos.org/t/differences-between-nix-channels/13998
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    impermanence.url = "github:nix-community/impermanence";

    nix-colors.url = "github:misterio77/nix-colors";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixos-hardware,
    ...
  } @ inputs: let 
    remoteNixpkgsPatches = [
      {
        meta.description = "waveforms package PR";
        url = "https://github.com/NixOS/nixpkgs/pull/394237.patch";
        sha256 = "sha256-t7LLRfio7k1D0/7mBwVooSghdZrrWLr8NjQVUHpnWnc=";
      }
    ];
    localNixpkgsPatches = [
      ./patches/adept2-runtime-udev.patch
    ];
    originPackages = inputs.nixpkgs.legacyPackages."x86_64-linux";
    nixpkgs = originPackages.applyPatches {
      name = "nixpkgs-patched";
      src = inputs.nixpkgs;
      patches = (
        map originPackages.fetchpatch remoteNixpkgsPatches
        ++ localNixpkgsPatches
      );
    };
    nixosSystem = import (nixpkgs + "/nixos/lib/eval-config.nix");
  in {
    nixosConfigurations = {
      poundcake = nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          nixos-hardware.nixosModules.framework-16-7040-amd
          ./hardware-configuration.nix
          ./configuration.nix
        ];
      };
    };
  };
}
